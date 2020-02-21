data
export g_admin_cmds
align 4
LABELV g_admin_cmds
address $60
address G_admin_adjustban
address $61
address $62
address $63
address $64
address G_admin_admintest
address $65
address $66
address $67
address $68
address G_admin_allready
address $69
address $70
address $67
address $71
address G_admin_ban
address $61
address $72
address $73
address $74
address G_admin_cancelvote
address $75
address $76
address $67
address $77
address G_admin_disorient
address $78
address $79
address $80
address $81
address G_admin_help
address $82
address $83
address $84
address $85
address G_admin_kick
address $86
address $87
address $88
address $89
address G_admin_listadmins
address $90
address $91
address $92
address $93
address G_admin_listplayers
address $94
address $95
address $67
address $96
address G_admin_lock
address $97
address $98
address $99
address $100
address G_admin_map
address $101
address $102
address $103
address $104
address G_admin_mute
address $105
address $106
address $107
address $108
address G_admin_namelog
address $109
address $110
address $111
address $112
address G_admin_nextmap
address $113
address $114
address $67
address $115
address G_admin_orient
address $78
address $116
address $107
address $117
address G_admin_passvote
address $118
address $119
address $67
address $120
address G_admin_putteam
address $121
address $122
address $123
address $124
address G_admin_readconfig
address $125
address $126
address $67
address $127
address G_admin_rename
address $128
address $129
address $130
address $131
address G_admin_restart
address $132
address $133
address $67
address $134
address G_admin_setlevel
address $135
address $136
address $137
address $138
address G_admin_showbans
address $139
address $140
address $141
address $142
address G_admin_slap
address $143
address $144
address $145
address $146
address G_admin_spec999
address $147
address $148
address $67
address $149
address G_admin_time
address $150
address $151
address $67
address $152
address G_admin_unban
address $61
address $153
address $154
address $155
address G_admin_unlock
address $97
address $156
address $99
address $157
address G_admin_mute
address $105
address $158
address $107
address $159
address G_admin_warn
address $160
address $161
address $162
align 4
LABELV adminNumCmds
byte 4 30
align 4
LABELV admin_level_maxname
byte 4 0
export G_admin_permission
code
proc G_admin_permission 28 8
ADDRFP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
file "../../../code/game/g_admin.c"
line 254
;1:/*
;2:===========================================================================
;3:Copyright (C) 2004-2006 Tony J. White
;4:
;5:This file is part of the Open Arena source code.
;6:
;7:Originally copied from Tremulous under GPL version 2 including any later version.
;8:
;9:Several modifications, additions, and deletions were made by developers of the
;10:Open Arena source code.
;11:
;12:This shrubbot implementation is the original work of Tony J. White.
;13:
;14:Contains contributions from Wesley van Beelen, Chris Bajumpaa, Josh Menke,
;15:and Travis Maurer.
;16:
;17:The functionality of this code mimics the behaviour of the currently
;18:inactive project shrubet (http://www.etstats.com/shrubet/index.php?ver=2)
;19:by Ryan Mannion.   However, shrubet was a closed-source project and
;20:none of it's code has been copied, only it's functionality.
;21:
;22:Open Arena Source code is free software; you can redistribute it
;23:and/or modify it under the terms of the GNU General Public License as
;24:published by the Free Software Foundation; either version 2 of the License,
;25:or (at your option) any later version.
;26:
;27:Open Arena Source code is distributed in the hope that it will be
;28:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;29:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;30:GNU General Public License for more details.
;31:
;32:You should have received a copy of the GNU General Public License
;33:along with Open Arena Source code; if not, write to the Free Software
;34:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;35:===========================================================================
;36:*/
;37:/* KK-OAX TODO
;38:1. Clean up the default admin levels to include the commands which I have added
;39:3. Implement Disorientation in Code
;40:4. DEBUG, DEBUG, DEBUG
;41:*/
;42:
;43:#include "g_local.h"
;44:
;45:// big ugly global buffer for use with buffered printing of long outputs
;46:static char g_bfb[ 32000 ];
;47:
;48:// note: list ordered alphabetically
;49:g_admin_cmd_t g_admin_cmds[ ] = {
;50:	{
;51:		"adjustban", G_admin_adjustban, "b",
;52:		"change the duration or reason of a ban.  duration is specified as "
;53:		"numbers followed by units 'w' (weeks), 'd' (days), 'h' (hours) or "
;54:		"'m' (minutes), or seconds if no units are specified.  if the duration is"
;55:		" preceded by a + or -, the ban duration will be extended or shortened by"
;56:		" the specified amount",
;57:		"[^3ban#^7] (^5duration^7) (^5reason^7)"
;58:	},
;59:
;60:	{
;61:		"admintest", G_admin_admintest, "a",
;62:		"display your current admin level",
;63:		""
;64:	},
;65:
;66:	{
;67:		"allready", G_admin_allready, "y",
;68:		"makes everyone ready in intermission",
;69:		""
;70:	},
;71:
;72:	{
;73:		"ban", G_admin_ban, "b",
;74:		"ban a player by IP and GUID with an optional expiration time and reason."
;75:		" duration is specified as numbers followed by units 'w' (weeks), 'd' "
;76:		"(days), 'h' (hours) or 'm' (minutes), or seconds if no units are "
;77:		"specified",
;78:		"[^3name|slot#|IP^7] (^5duration^7) (^5reason^7)"
;79:	},
;80:
;81:	{
;82:		"cancelvote", G_admin_cancelvote, "c",
;83:		"cancel a vote taking place",
;84:		""
;85:	},
;86:	//KK-OAX
;87:	{
;88:		"disorient",	G_admin_disorient,	"d",
;89:		"disorient a player by flipping player's view and controls",
;90:		"[^3name|slot#^7] (^hreason^7)"
;91:	},
;92:	//{"fling", G_admin_fling, "d",
;93:	//  "throws the player specified",
;94:	//  "[^3name|slot#^7]"
;95:	//},
;96:
;97:	{
;98:		"help", G_admin_help, "h",
;99:		"display commands available to you or help on a specific command",
;100:		"(^5command^7)"
;101:	},
;102:
;103:	{
;104:		"kick", G_admin_kick, "k",
;105:		"kick a player with an optional reason",
;106:		"[^3name|slot#^7] (^5reason^7)"
;107:	},
;108:
;109:	{
;110:		"listadmins", G_admin_listadmins, "D",
;111:		"display a list of all server admins and their levels",
;112:		"(^5name|start admin#^7)"
;113:	},
;114:
;115:	{
;116:		"listplayers", G_admin_listplayers, "i",
;117:		"display a list of players, their client numbers and their levels",
;118:		""
;119:	},
;120:
;121:	{
;122:		"lock", G_admin_lock, "K",
;123:		"lock a team to prevent anyone from joining it",
;124:		"[^3a|h^7]"
;125:	},
;126:	//KK-OAX
;127:	{
;128:		"map", G_admin_map, "M",
;129:		"load a map",
;130:		"[^3mapname^7]"
;131:	},
;132:
;133:	{
;134:		"mute", G_admin_mute, "m",
;135:		"mute a player",
;136:		"[^3name|slot#^7]"
;137:	},
;138:
;139:	{
;140:		"namelog", G_admin_namelog, "e",
;141:		"display a list of names used by recently connected players",
;142:		"(^5name^7)"
;143:	},
;144:
;145:	{
;146:		"nextmap", G_admin_nextmap, "n",
;147:		"go to the next map in the cycle",
;148:		""
;149:	},
;150:	//KK-OAX
;151:	{
;152:		"orient",	G_admin_orient,	"d",
;153:		"orient a player after a !disorient", "[^3name|slot#^7]"
;154:	},
;155:
;156:	{
;157:		"passvote", G_admin_passvote, "V",
;158:		"pass a vote currently taking place",
;159:		""
;160:	},
;161:
;162:	{
;163:		"putteam", G_admin_putteam, "p",
;164:		"move a player to a specified team",
;165:		"[^3name|slot#^7] [^3h|a|s^7]"
;166:	},
;167:
;168:	{
;169:		"readconfig", G_admin_readconfig, "G",
;170:		"reloads the admin config file and refreshes permission flags",
;171:		""
;172:	},
;173:
;174:	{
;175:		"rename", G_admin_rename, "N",
;176:		"rename a player",
;177:		"[^3name|slot#^7] [^3new name^7]"
;178:	},
;179:
;180:	{
;181:		"restart", G_admin_restart, "r",
;182:		"restart the current map (optionally using named layout)",
;183:		""
;184:	},
;185:
;186:	{
;187:		"setlevel", G_admin_setlevel, "s",
;188:		"sets the admin level of a player",
;189:		"[^3name|slot#|admin#^7] [^3level^7]"
;190:	},
;191:
;192:	{
;193:		"showbans", G_admin_showbans, "B",
;194:		"display a (partial) list of active bans",
;195:		"(^5start at ban#^7) (^5name|IP^7)"
;196:	},
;197:	{
;198:		"slap", G_admin_slap, "S",
;199:		"Reduces the health of the selected player by the damage specified",
;200:		"[^3name|slot#] [damage] [reason]"
;201:	},
;202:
;203:	{
;204:		"spec999", G_admin_spec999, "P",
;205:		"move 999 pingers to the spectator team",
;206:		""
;207:	},
;208:
;209:	{
;210:		"time", G_admin_time, "C",
;211:		"show the current local server time",
;212:		""
;213:	},
;214:
;215:	{
;216:		"unban", G_admin_unban, "b",
;217:		"unbans a player specified by the slot as seen in showbans",
;218:		"[^3ban#^7]"
;219:	},
;220:
;221:	{
;222:		"unlock", G_admin_unlock, "K",
;223:		"unlock a locked team",
;224:		"[^3a|h^7]"
;225:	},
;226:
;227:	{
;228:		"unmute", G_admin_mute, "m",
;229:		"unmute a muted player",
;230:		"[^3name|slot#^7]"
;231:	},
;232:
;233://KK-OAX
;234:	{
;235:		"warn", G_admin_warn, "w",
;236:		"warn a player",
;237:		"[^3name|slot#^7] [reason]"
;238:	}
;239:
;240:};
;241:
;242:static int adminNumCmds = sizeof( g_admin_cmds ) / sizeof( g_admin_cmds[ 0 ] );
;243:
;244:static int admin_level_maxname = 0;
;245:g_admin_level_t *g_admin_levels[ MAX_ADMIN_LEVELS ];
;246:g_admin_admin_t *g_admin_admins[ MAX_ADMIN_ADMINS ];
;247:g_admin_ban_t *g_admin_bans[ MAX_ADMIN_BANS ];
;248:g_admin_command_t *g_admin_commands[ MAX_ADMIN_COMMANDS ];
;249:g_admin_namelog_t *g_admin_namelog[ MAX_ADMIN_NAMELOGS ];
;250://KK-OAX Load us up some warnings here....
;251:g_admin_warning_t *g_admin_warnings[ MAX_ADMIN_WARNINGS ];
;252:
;253:qboolean G_admin_permission( gentity_t *ent, char flag )
;254:{
line 256
;255:	int i;
;256:	int l = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 260
;257:	char *flags;
;258:
;259:	// console always wins
;260:	if( !ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $164
line 261
;261:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $163
JUMPV
LABELV $164
line 263
;262:
;263:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $166
line 264
;264:		if( Q_strequal( ent->client->pers.guid, g_admin_admins[ i ]->guid ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $170
line 265
;265:			flags = g_admin_admins[ i ]->flags;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRGP4 $173
JUMPV
LABELV $172
line 266
;266:			while( *flags ) {
line 267
;267:				if( *flags == flag ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $175
line 268
;268:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $163
JUMPV
LABELV $175
line 270
;269:				}
;270:				else if( *flags == '-' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $177
ADDRGP4 $180
JUMPV
LABELV $179
line 271
;271:					while( *flags++ ) {
line 272
;272:						if( *flags == flag )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $182
line 273
;273:							return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $163
JUMPV
LABELV $182
line 274
;274:						if( *flags == '+' )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 43
NEI4 $184
line 275
;275:							break;
ADDRGP4 $178
JUMPV
LABELV $184
line 276
;276:					}
LABELV $180
line 271
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
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $179
line 277
;277:				}
ADDRGP4 $178
JUMPV
LABELV $177
line 278
;278:				else if( *flags == '*' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $186
ADDRGP4 $189
JUMPV
LABELV $188
line 279
;279:					while( *flags++ ) {
line 280
;280:						if( *flags == flag )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $191
line 281
;281:							return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $163
JUMPV
LABELV $191
line 282
;282:					}
LABELV $189
line 279
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
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $188
line 286
;283:					// flags with significance only for individuals (
;284:					// like ADMF_INCOGNITO and ADMF_IMMUTABLE are NOT covered
;285:					// by the '*' wildcard.  They must be specified manually.
;286:					return ( flag != ADMF_INCOGNITO && flag != ADMF_IMMUTABLE );
ADDRLP4 24
ADDRFP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 64
EQI4 $194
ADDRLP4 24
INDIRI4
CNSTI4 33
EQI4 $194
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $194
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $195
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $163
JUMPV
LABELV $186
LABELV $178
line 288
;287:				}
;288:				flags++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 289
;289:			}
LABELV $173
line 266
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $172
line 290
;290:			l = g_admin_admins[ i ]->level;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
line 291
;291:		}
LABELV $170
line 292
;292:	}
LABELV $167
line 263
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $169
ADDRLP4 4
INDIRI4
CNSTI4 1024
GEI4 $196
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $166
LABELV $196
line 293
;293:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $200
JUMPV
LABELV $197
line 294
;294:		if( g_admin_levels[ i ]->level == l ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $201
line 295
;295:			flags = g_admin_levels[ i ]->flags;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $203
line 296
;296:			while( *flags ) {
line 297
;297:				if( *flags == flag )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $206
line 298
;298:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $163
JUMPV
LABELV $206
line 299
;299:				if( *flags == '*' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $208
ADDRGP4 $211
JUMPV
LABELV $210
line 300
;300:					while( *flags++ ) {
line 301
;301:						if( *flags == flag )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRFP4 4
INDIRI1
CVII4 1
NEI4 $213
line 302
;302:							return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $163
JUMPV
LABELV $213
line 303
;303:					}
LABELV $211
line 300
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
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $210
line 307
;304:					// flags with significance only for individuals (
;305:					// like ADMF_INCOGNITO and ADMF_IMMUTABLE are NOT covered
;306:					// by the '*' wildcard.  They must be specified manually.
;307:					return ( flag != ADMF_INCOGNITO && flag != ADMF_IMMUTABLE );
ADDRLP4 24
ADDRFP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 64
EQI4 $216
ADDRLP4 24
INDIRI4
CNSTI4 33
EQI4 $216
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $217
JUMPV
LABELV $216
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $217
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $163
JUMPV
LABELV $208
line 309
;308:				}
;309:				flags++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 310
;310:			}
LABELV $204
line 296
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $203
line 311
;311:		}
LABELV $201
line 312
;312:	}
LABELV $198
line 293
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $200
ADDRLP4 4
INDIRI4
CNSTI4 32
GEI4 $218
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $197
LABELV $218
line 313
;313:	return qfalse;
CNSTI4 0
RETI4
LABELV $163
endproc G_admin_permission 28 8
lit
align 1
LABELV $220
byte 1 0
skip 31
align 1
LABELV $221
byte 1 0
skip 31
export G_admin_name_check
code
proc G_admin_name_check 84 16
line 317
;314:}
;315:
;316:qboolean G_admin_name_check( gentity_t *ent, char *name, char *err, int len )
;317:{
line 320
;318:	int i;
;319:	gclient_t *client;
;320:	char testName[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 4
ADDRGP4 $220
INDIRB
ASGNB 32
line 321
;321:	char name2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 40
ADDRGP4 $221
INDIRB
ASGNB 32
line 323
;322:
;323:	G_SanitiseString( name, name2, sizeof( name2 ) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 325
;324:
;325:	if( Q_strequal( name2, "UnnamedPlayer" ) )
ADDRLP4 40
ARGP4
ADDRGP4 $224
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $222
line 326
;326:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $219
JUMPV
LABELV $222
line 328
;327:
;328:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $228
JUMPV
LABELV $225
line 329
;329:		client = &level.clients[ i ];
ADDRLP4 36
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 330
;330:		if( client->pers.connected == CON_DISCONNECTED )
ADDRLP4 36
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $230
line 331
;331:			continue;
ADDRGP4 $226
JUMPV
LABELV $230
line 334
;332:
;333:		// can rename ones self to the same name using different colors
;334:		if( i == ( ent - g_entities ) )
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
NEI4 $232
line 335
;335:			continue;
ADDRGP4 $226
JUMPV
LABELV $232
line 337
;336:
;337:		G_SanitiseString( client->pers.netname, testName, sizeof( testName ) );
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
line 338
;338:		if( Q_strequal( name2, testName ) ) {
ADDRLP4 40
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $234
line 339
;339:			Com_sprintf( err, len, "The name '%s^7' is already in use", name );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 $236
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 340
;340:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $219
JUMPV
LABELV $234
line 342
;341:		}
;342:	}
LABELV $226
line 328
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $228
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $225
line 344
;343:
;344:	if( !g_adminNameProtect.integer )
ADDRGP4 g_adminNameProtect+12
INDIRI4
CNSTI4 0
NEI4 $237
line 345
;345:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $219
JUMPV
LABELV $237
line 347
;346:
;347:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $240
line 348
;348:		if( g_admin_admins[ i ]->level < 1 )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
GEI4 $244
line 349
;349:			continue;
ADDRGP4 $241
JUMPV
LABELV $244
line 350
;350:		G_SanitiseString( g_admin_admins[ i ]->name, testName, sizeof( testName ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 351
;351:		if( Q_strequal( name2, testName ) && !Q_strequal( ent->client->pers.guid, g_admin_admins[ i ]->guid ) ) {
ADDRLP4 40
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $246
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $246
line 352
;352:			Com_sprintf( err, len, "The name '%s^7' belongs to an admin, "
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 $248
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 354
;353:			             "please use another name", name );
;354:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $219
JUMPV
LABELV $246
line 356
;355:		}
;356:	}
LABELV $241
line 347
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $243
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $249
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $240
LABELV $249
line 357
;357:	return qtrue;
CNSTI4 1
RETI4
LABELV $219
endproc G_admin_name_check 84 16
proc admin_higher_guid 28 8
line 361
;358:}
;359:
;360:static qboolean admin_higher_guid( char *admin_guid, char *victim_guid )
;361:{
line 363
;362:	int i;
;363:	int alevel = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 365
;364:
;365:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $254
JUMPV
LABELV $251
line 366
;366:		if( Q_strequal( admin_guid, g_admin_admins[ i ]->guid ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $255
line 367
;367:			alevel = g_admin_admins[ i ]->level;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
line 368
;368:			break;
ADDRGP4 $253
JUMPV
LABELV $255
line 370
;369:		}
;370:	}
LABELV $252
line 365
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $254
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $257
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $251
LABELV $257
LABELV $253
line 371
;371:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $261
JUMPV
LABELV $258
line 372
;372:		if( Q_strequal( victim_guid, g_admin_admins[ i ]->guid ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $262
line 373
;373:			if( alevel < g_admin_admins[ i ]->level )
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
GEI4 $264
line 374
;374:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $250
JUMPV
LABELV $264
line 375
;375:			return !strstr( g_admin_admins[ i ]->flags, va( "%c", ADMF_IMMUTABLE ) );
ADDRGP4 $266
ARGP4
CNSTI4 33
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $268
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $269
JUMPV
LABELV $268
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $269
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $250
JUMPV
LABELV $262
line 377
;376:		}
;377:	}
LABELV $259
line 371
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $261
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $270
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $258
LABELV $270
line 378
;378:	return qtrue;
CNSTI4 1
RETI4
LABELV $250
endproc admin_higher_guid 28 8
proc admin_higher 12 8
line 382
;379:}
;380:
;381:static qboolean admin_higher( gentity_t *admin, gentity_t *victim )
;382:{
line 385
;383:
;384:	// console always wins
;385:	if( !admin )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $272
line 386
;386:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $271
JUMPV
LABELV $272
line 388
;387:	// just in case
;388:	if( !victim )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $274
line 389
;389:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $271
JUMPV
LABELV $274
line 391
;390:
;391:	return admin_higher_guid( admin->client->pers.guid,
ADDRLP4 0
CNSTI4 516
ASGNI4
ADDRLP4 4
CNSTI4 912
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 admin_higher_guid
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $271
endproc admin_higher 12 8
lit
align 1
LABELV $277
byte 1 0
skip 1023
code
proc admin_writeconfig 1072 12
line 400
;392:	                          victim->client->pers.guid );
;393:}
;394:
;395://KK-OAX Moved the Read/Write int/String functions to g_fileops.c for portability
;396://across GAME
;397:
;398://KK-OAX Added Warnings
;399:static void admin_writeconfig( void )
;400:{
line 404
;401:	fileHandle_t f;
;402:	int len, i, j;
;403:	int t;
;404:	char levels[ MAX_STRING_CHARS ] = {""};
ADDRLP4 12
ADDRGP4 $277
INDIRB
ASGNB 1024
line 406
;405:
;406:	if( !g_admin.string[ 0 ] ) {
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $278
line 407
;407:		G_Printf( S_COLOR_YELLOW "WARNING: g_admin is not set. "
ADDRGP4 $281
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 409
;408:		          " configuration will not be saved to a file.\n" );
;409:		return;
ADDRGP4 $276
JUMPV
LABELV $278
line 411
;410:	}
;411:	t = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1044
INDIRI4
ASGNI4
line 412
;412:	len = trap_FS_FOpenFile( g_admin.string, &f, FS_WRITE );
ADDRGP4 g_admin+16
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 1048
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1048
INDIRI4
ASGNI4
line 413
;413:	if( len < 0 ) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
GEI4 $283
line 414
;414:		G_Printf( "admin_writeconfig: could not open g_admin file \"%s\"\n",
ADDRGP4 $285
ARGP4
ADDRGP4 g_admin+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 416
;415:		          g_admin.string );
;416:		return;
ADDRGP4 $276
JUMPV
LABELV $283
line 418
;417:	}
;418:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $290
JUMPV
LABELV $287
line 419
;419:		trap_FS_Write( "[level]\n", 8, f );
ADDRGP4 $291
ARGP4
CNSTI4 8
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 420
;420:		trap_FS_Write( "level   = ", 10, f );
ADDRGP4 $292
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 421
;421:		writeFile_int( g_admin_levels[ i ]->level, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_int
CALLV
pop
line 422
;422:		trap_FS_Write( "name    = ", 10, f );
ADDRGP4 $293
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 423
;423:		writeFile_string( g_admin_levels[ i ]->name, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 424
;424:		trap_FS_Write( "flags   = ", 10, f );
ADDRGP4 $294
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 425
;425:		writeFile_string( g_admin_levels[ i ]->flags, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 426
;426:		trap_FS_Write( "\n", 1, f );
ADDRGP4 $295
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 427
;427:	}
LABELV $288
line 418
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $290
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $287
LABELV $296
line 428
;428:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $300
JUMPV
LABELV $297
line 430
;429:		// don't write level 0 users
;430:		if( g_admin_admins[ i ]->level == 0 )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $301
line 431
;431:			continue;
ADDRGP4 $298
JUMPV
LABELV $301
line 433
;432:
;433:		trap_FS_Write( "[admin]\n", 8, f );
ADDRGP4 $303
ARGP4
CNSTI4 8
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 434
;434:		trap_FS_Write( "name    = ", 10, f );
ADDRGP4 $293
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 435
;435:		writeFile_string( g_admin_admins[ i ]->name, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 436
;436:		trap_FS_Write( "guid    = ", 10, f );
ADDRGP4 $304
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 437
;437:		writeFile_string( g_admin_admins[ i ]->guid, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 438
;438:		trap_FS_Write( "level   = ", 10, f );
ADDRGP4 $292
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 439
;439:		writeFile_int( g_admin_admins[ i ]->level, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_int
CALLV
pop
line 440
;440:		trap_FS_Write( "flags   = ", 10, f );
ADDRGP4 $294
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 441
;441:		writeFile_string( g_admin_admins[ i ]->flags, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 442
;442:		trap_FS_Write( "\n", 1, f );
ADDRGP4 $295
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 443
;443:	}
LABELV $298
line 428
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $300
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $305
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $297
LABELV $305
line 444
;444:	for( i = 0; i < MAX_ADMIN_BANS && g_admin_bans[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $306
line 447
;445:		// don't write expired bans
;446:		// if expires is 0, then it's a perm ban
;447:		if( g_admin_bans[ i ]->expires != 0 &&
ADDRLP4 1060
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $310
ADDRLP4 1060
INDIRI4
ADDRLP4 1036
INDIRI4
SUBI4
CNSTI4 1
GEI4 $310
line 449
;448:		        ( g_admin_bans[ i ]->expires - t ) < 1 )
;449:			continue;
ADDRGP4 $307
JUMPV
LABELV $310
line 451
;450:
;451:		trap_FS_Write( "[ban]\n", 6, f );
ADDRGP4 $312
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 452
;452:		trap_FS_Write( "name    = ", 10, f );
ADDRGP4 $293
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 453
;453:		writeFile_string( g_admin_bans[ i ]->name, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 454
;454:		trap_FS_Write( "guid    = ", 10, f );
ADDRGP4 $304
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 455
;455:		writeFile_string( g_admin_bans[ i ]->guid, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 456
;456:		trap_FS_Write( "ip      = ", 10, f );
ADDRGP4 $313
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 457
;457:		writeFile_string( g_admin_bans[ i ]->ip, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 458
;458:		trap_FS_Write( "reason  = ", 10, f );
ADDRGP4 $314
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 459
;459:		writeFile_string( g_admin_bans[ i ]->reason, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 460
;460:		trap_FS_Write( "made    = ", 10, f );
ADDRGP4 $315
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 461
;461:		writeFile_string( g_admin_bans[ i ]->made, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 155
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 462
;462:		trap_FS_Write( "expires = ", 10, f );
ADDRGP4 $316
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 463
;463:		writeFile_int( g_admin_bans[ i ]->expires, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_int
CALLV
pop
line 464
;464:		trap_FS_Write( "banner  = ", 10, f );
ADDRGP4 $317
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 465
;465:		writeFile_string( g_admin_bans[ i ]->banner, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 466
;466:		trap_FS_Write( "\n", 1, f );
ADDRGP4 $295
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 467
;467:	}
LABELV $307
line 444
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $309
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $318
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $306
LABELV $318
line 468
;468:	for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $322
JUMPV
LABELV $319
line 469
;469:		levels[ 0 ] = '\0';
ADDRLP4 12
CNSTI1 0
ASGNI1
line 470
;470:		trap_FS_Write( "[command]\n", 10, f );
ADDRGP4 $323
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 471
;471:		trap_FS_Write( "command = ", 10, f );
ADDRGP4 $324
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 472
;472:		writeFile_string( g_admin_commands[ i ]->command, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 473
;473:		trap_FS_Write( "exec    = ", 10, f );
ADDRGP4 $325
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 474
;474:		writeFile_string( g_admin_commands[ i ]->exec, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 475
;475:		trap_FS_Write( "desc    = ", 10, f );
ADDRGP4 $326
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 476
;476:		writeFile_string( g_admin_commands[ i ]->desc, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 477
;477:		trap_FS_Write( "levels  = ", 10, f );
ADDRGP4 $327
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 478
;478:		for( j = 0; g_admin_commands[ i ]->levels[ j ] != -1; j++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $331
JUMPV
LABELV $328
line 479
;479:			Q_strcat( levels, sizeof( levels ),
ADDRGP4 $332
ARGP4
ADDRLP4 1064
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 1064
INDIRI4
LSHI4
ADDRLP4 0
INDIRI4
ADDRLP4 1064
INDIRI4
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 481
;480:			          va( "%i ", g_admin_commands[ i ]->levels[ j ] ) );
;481:		}
LABELV $329
line 478
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $331
ADDRLP4 1064
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 1064
INDIRI4
LSHI4
ADDRLP4 0
INDIRI4
ADDRLP4 1064
INDIRI4
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $328
line 482
;482:		writeFile_string( levels, f );
ADDRLP4 12
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 483
;483:		trap_FS_Write( "\n", 1, f );
ADDRGP4 $295
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 484
;484:	}
LABELV $320
line 468
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $322
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $333
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $319
LABELV $333
line 485
;485:	for( i = 0; i < MAX_ADMIN_WARNINGS && g_admin_warnings[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $337
JUMPV
LABELV $334
line 489
;486:		// don't write expired warnings
;487:		// if expires is 0, then it's a perm warning
;488:		// it will get loaded everytime they connect!!!!
;489:		if( g_admin_warnings[ i ]->expires != 0 &&
ADDRLP4 1068
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $338
ADDRLP4 1068
INDIRI4
ADDRLP4 1036
INDIRI4
SUBI4
CNSTI4 1
GEI4 $338
line 491
;490:		        ( g_admin_warnings[ i ]->expires - t ) < 1 )
;491:			continue;
ADDRGP4 $335
JUMPV
LABELV $338
line 493
;492:
;493:		trap_FS_Write( "[warning]\n", 10, f );
ADDRGP4 $340
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 494
;494:		trap_FS_Write( "name    = ", 10, f );
ADDRGP4 $293
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 495
;495:		writeFile_string( g_admin_warnings[ i ]->name, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 496
;496:		trap_FS_Write( "guid    = ", 10, f );
ADDRGP4 $304
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 497
;497:		writeFile_string( g_admin_warnings[ i ]->guid, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 498
;498:		trap_FS_Write( "ip      = ", 10, f );
ADDRGP4 $313
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 499
;499:		writeFile_string( g_admin_warnings[ i ]->ip, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 500
;500:		trap_FS_Write( "warning = ", 10, f );
ADDRGP4 $341
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 501
;501:		writeFile_string( g_admin_warnings[ i ]->warning, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 502
;502:		trap_FS_Write( "made    = ", 10, f );
ADDRGP4 $315
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 503
;503:		writeFile_string( g_admin_warnings[ i ]->made, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 1129
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 504
;504:		trap_FS_Write( "expires = ", 10, f );
ADDRGP4 $316
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 505
;505:		writeFile_int( g_admin_warnings[ i ]->expires, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_int
CALLV
pop
line 506
;506:		trap_FS_Write( "warner  = ", 10, f );
ADDRGP4 $342
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 507
;507:		writeFile_string( g_admin_warnings[ i ]->warner, f );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 1147
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 writeFile_string
CALLV
pop
line 508
;508:		trap_FS_Write( "\n", 1, f );
ADDRGP4 $295
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 509
;509:	}
LABELV $335
line 485
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $337
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $343
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $334
LABELV $343
line 510
;510:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 511
;511:}
LABELV $276
endproc admin_writeconfig 1072 12
proc admin_default_levels 16 12
line 518
;512:
;513:
;514:// if we can't parse any levels from readconfig, set up default
;515:// ones to make new installs easier for admins
;516://KK-OAX TODO: Add all features to default levels...
;517:static void admin_default_levels( void )
;518:{
line 522
;519:	g_admin_level_t *l;
;520:	int i;
;521:
;522:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $348
JUMPV
LABELV $345
line 523
;523:		BG_Free( g_admin_levels[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 524
;524:		g_admin_levels[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
CNSTP4 0
ASGNP4
line 525
;525:	}
LABELV $346
line 522
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $348
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $349
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $345
LABELV $349
line 526
;526:	for( i = 0; i <= 5; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $350
line 527
;527:		l = BG_Alloc( sizeof( g_admin_level_t ) );
CNSTU4 100
ARGU4
ADDRLP4 12
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 528
;528:		l->level = i;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 529
;529:		*l->name = '\0';
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI1 0
ASGNI1
line 530
;530:		*l->flags = '\0';
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
CNSTI1 0
ASGNI1
line 531
;531:		g_admin_levels[ i ] = l;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 532
;532:	}
LABELV $351
line 526
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LEI4 $350
line 533
;533:	Q_strncpyz( g_admin_levels[ 0 ]->name, "^4Unknown Player",
ADDRGP4 g_admin_levels
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $354
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 535
;534:	            sizeof( l->name ) );
;535:	Q_strncpyz( g_admin_levels[ 0 ]->flags, "ahC", sizeof( l->flags ) );
ADDRGP4 g_admin_levels
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $355
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 537
;536:
;537:	Q_strncpyz( g_admin_levels[ 1 ]->name, "^5Server Regular",
ADDRGP4 g_admin_levels+4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $357
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 539
;538:	            sizeof( l->name ) );
;539:	Q_strncpyz( g_admin_levels[ 1 ]->flags, "iahC", sizeof( l->flags ) );
ADDRGP4 g_admin_levels+4
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $359
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 541
;540:
;541:	Q_strncpyz( g_admin_levels[ 2 ]->name, "^6Team Manager",
ADDRGP4 g_admin_levels+8
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $361
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 543
;542:	            sizeof( l->name ) );
;543:	Q_strncpyz( g_admin_levels[ 2 ]->flags, "iahCpPwr", sizeof( l->flags ) );
ADDRGP4 g_admin_levels+8
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $363
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 545
;544:
;545:	Q_strncpyz( g_admin_levels[ 3 ]->name, "^2Junior Admin",
ADDRGP4 g_admin_levels+12
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $365
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 547
;546:	            sizeof( l->name ) );
;547:	Q_strncpyz( g_admin_levels[ 3 ]->flags, "iahCpPwrkmfKncN?", sizeof( l->flags ) );
ADDRGP4 g_admin_levels+12
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $367
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 549
;548:
;549:	Q_strncpyz( g_admin_levels[ 4 ]->name, "^3Senior Admin",
ADDRGP4 g_admin_levels+16
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $369
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 551
;550:	            sizeof( l->name ) );
;551:	Q_strncpyz( g_admin_levels[ 4 ]->flags, "iahCpPwrkmfKncN?MVdBbeDS51", sizeof( l->flags ) );
ADDRGP4 g_admin_levels+16
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $371
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 553
;552:
;553:	Q_strncpyz( g_admin_levels[ 5 ]->name, "^1Server Operator",
ADDRGP4 g_admin_levels+20
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 $373
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 555
;554:	            sizeof( l->name ) );
;555:	Q_strncpyz( g_admin_levels[ 5 ]->flags, "*", sizeof( l->flags ) );
ADDRGP4 g_admin_levels+20
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 $375
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 556
;556:	admin_level_maxname = 15;
ADDRGP4 admin_level_maxname
CNSTI4 15
ASGNI4
line 557
;557:}
LABELV $344
endproc admin_default_levels 16 12
export G_admin_level
proc G_admin_level 8 8
line 561
;558:
;559://  return a level for a player entity.
;560:int G_admin_level( gentity_t *ent )
;561:{
line 564
;562:	int i;
;563:
;564:	if( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $377
line 565
;565:		return MAX_ADMIN_LEVELS;
CNSTI4 32
RETI4
ADDRGP4 $376
JUMPV
LABELV $377
line 568
;566:	}
;567:
;568:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $382
JUMPV
LABELV $379
line 569
;569:		if( Q_strequal( g_admin_admins[ i ]->guid, ent->client->pers.guid ) )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $383
line 570
;570:			return g_admin_admins[ i ]->level;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
RETI4
ADDRGP4 $376
JUMPV
LABELV $383
line 571
;571:	}
LABELV $380
line 568
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $382
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $385
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $379
LABELV $385
line 573
;572:
;573:	return 0;
CNSTI4 0
RETI4
LABELV $376
endproc G_admin_level 8 8
proc admin_command_permission 20 8
line 577
;574:}
;575:
;576:static qboolean admin_command_permission( gentity_t *ent, char *command )
;577:{
line 581
;578:	int i, j;
;579:	int level;
;580:
;581:	if( !ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $387
line 582
;582:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $386
JUMPV
LABELV $387
line 583
;583:	level = ent->client->pers.adminLevel;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ASGNI4
line 584
;584:	for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $392
JUMPV
LABELV $389
line 585
;585:		if( Q_strequal( command, g_admin_commands[ i ]->command ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $393
line 586
;586:			for( j = 0; g_admin_commands[ i ]->levels[ j ] != -1; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $398
JUMPV
LABELV $395
line 587
;587:				if( g_admin_commands[ i ]->levels[ j ] == level ) {
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $399
line 588
;588:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $386
JUMPV
LABELV $399
line 590
;589:				}
;590:			}
LABELV $396
line 586
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $398
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $395
line 591
;591:		}
LABELV $393
line 592
;592:	}
LABELV $390
line 584
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $392
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $401
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $389
LABELV $401
line 593
;593:	return qfalse;
CNSTI4 0
RETI4
LABELV $386
endproc admin_command_permission 20 8
proc admin_log 1512 56
line 597
;594:}
;595:
;596:static void admin_log( gentity_t *admin, char *cmd, int skiparg )
;597:{
line 605
;598:	fileHandle_t f;
;599:	int len, i, j;
;600:	char string[ MAX_STRING_CHARS ];
;601:	int min, tens, sec;
;602:	g_admin_admin_t *a;
;603:	g_admin_level_t *l;
;604:	char flags[ MAX_ADMIN_FLAGS * 2 ];
;605:	gentity_t *victim = NULL;
ADDRLP4 1172
CNSTP4 0
ASGNP4
line 609
;606:	int pids[ MAX_CLIENTS ];
;607:	char name[ MAX_NAME_LENGTH ];
;608:
;609:	if( !g_adminLog.string[ 0 ] )
ADDRGP4 g_adminLog+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $403
line 610
;610:		return;
ADDRGP4 $402
JUMPV
LABELV $403
line 613
;611:
;612:
;613:	len = trap_FS_FOpenFile( g_adminLog.string, &f, FS_APPEND );
ADDRGP4 g_adminLog+16
ARGP4
ADDRLP4 1176
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1480
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1188
ADDRLP4 1480
INDIRI4
ASGNI4
line 614
;614:	if( len < 0 ) {
ADDRLP4 1188
INDIRI4
CNSTI4 0
GEI4 $407
line 615
;615:		G_Printf( "admin_log: error could not open %s\n", g_adminLog.string );
ADDRGP4 $409
ARGP4
ADDRGP4 g_adminLog+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 616
;616:		return;
ADDRGP4 $402
JUMPV
LABELV $407
line 619
;617:	}
;618:
;619:	sec = level.time / 1000;
ADDRLP4 144
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 620
;620:	min = sec / 60;
ADDRLP4 1180
ADDRLP4 144
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 621
;621:	sec -= min * 60;
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 60
ADDRLP4 1180
INDIRI4
MULI4
SUBI4
ASGNI4
line 622
;622:	tens = sec / 10;
ADDRLP4 1184
ADDRLP4 144
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 623
;623:	sec -= tens * 10;
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 10
ADDRLP4 1184
INDIRI4
MULI4
SUBI4
ASGNI4
line 625
;624:
;625:	*flags = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 626
;626:	if( admin ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $412
line 627
;627:		for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $417
JUMPV
LABELV $414
line 628
;628:			if( Q_strequal( g_admin_admins[ i ]->guid , admin->client->pers.guid ) ) {
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 1484
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
NEI4 $418
line 630
;629:
;630:				a = g_admin_admins[ i ];
ADDRLP4 132
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ASGNP4
line 631
;631:				Q_strncpyz( flags, a->flags, sizeof( flags ) );
ADDRLP4 4
ARGP4
ADDRLP4 132
INDIRP4
CNSTI4 72
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 632
;632:				for( j = 0; j < MAX_ADMIN_LEVELS && g_admin_levels[ j ]; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $423
JUMPV
LABELV $420
line 633
;633:					if( g_admin_levels[ j ]->level == a->level ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 132
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $424
line 634
;634:						l = g_admin_levels[ j ];
ADDRLP4 136
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
ASGNP4
line 635
;635:						Q_strcat( flags, sizeof( flags ), l->flags );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 136
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 636
;636:						break;
ADDRGP4 $416
JUMPV
LABELV $424
line 638
;637:					}
;638:				}
LABELV $421
line 632
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $423
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $426
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $420
LABELV $426
line 639
;639:				break;
ADDRGP4 $416
JUMPV
LABELV $418
line 641
;640:			}
;641:		}
LABELV $415
line 627
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $417
ADDRLP4 140
INDIRI4
CNSTI4 1024
GEI4 $427
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $414
LABELV $427
LABELV $416
line 642
;642:	}
LABELV $412
line 644
;643:
;644:	if( G_SayArgc() > 1 + skiparg ) {
ADDRLP4 1484
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 1
ADDI4
LEI4 $428
line 645
;645:		G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 8
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1192
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 646
;646:		if( G_ClientNumbersFromString( name, pids, MAX_CLIENTS ) == 1 ) {
ADDRLP4 1192
ARGP4
ADDRLP4 1224
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1488
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 1488
INDIRI4
CNSTI4 1
NEI4 $430
line 647
;647:			victim = &g_entities[ pids[ 0 ] ];
ADDRLP4 1172
CNSTI4 816
ADDRLP4 1224
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 648
;648:		}
LABELV $430
line 649
;649:	}
LABELV $428
line 651
;650:
;651:	if( victim && !Q_strequal( cmd, "attempted" ) ) {
ADDRLP4 1172
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $432
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 1488
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1488
INDIRI4
CNSTI4 0
EQI4 $432
line 652
;652:		Com_sprintf( string, sizeof( string ),
ADDRFP4 8
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1504
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 148
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $435
ARGP4
ADDRLP4 1180
INDIRI4
ARGI4
ADDRLP4 1184
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $441
ADDRLP4 1492
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $442
JUMPV
LABELV $441
ADDRLP4 1492
CNSTI4 -1
ASGNI4
LABELV $442
ADDRLP4 1492
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $443
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ASGNP4
ADDRGP4 $444
JUMPV
LABELV $443
ADDRLP4 1496
ADDRGP4 $437
ASGNP4
LABELV $444
ADDRLP4 1496
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
ADDRLP4 1500
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $446
JUMPV
LABELV $445
ADDRLP4 1500
ADDRGP4 $439
ASGNP4
LABELV $446
ADDRLP4 1500
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1508
ADDRLP4 1172
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1508
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 1508
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1504
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 666
;653:		             "%3i:%i%i: %i: %s: %s: %s: %s: %s: %s: \"%s\"\n",
;654:		             min,
;655:		             tens,
;656:		             sec,
;657:		             ( admin ) ? admin->s.clientNum : -1,
;658:		             ( admin ) ? admin->client->pers.guid
;659:		             : "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
;660:		             ( admin ) ? admin->client->pers.netname : "console",
;661:		             flags,
;662:		             cmd,
;663:		             victim->client->pers.guid,
;664:		             victim->client->pers.netname,
;665:		             G_SayConcatArgs( 2 + skiparg ) );
;666:	}
ADDRGP4 $433
JUMPV
LABELV $432
line 667
;667:	else {
line 668
;668:		Com_sprintf( string, sizeof( string ),
ADDRFP4 8
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1504
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 148
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $447
ARGP4
ADDRLP4 1180
INDIRI4
ARGI4
ADDRLP4 1184
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $451
ADDRLP4 1492
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $452
JUMPV
LABELV $451
ADDRLP4 1492
CNSTI4 -1
ASGNI4
LABELV $452
ADDRLP4 1492
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $453
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ASGNP4
ADDRGP4 $454
JUMPV
LABELV $453
ADDRLP4 1496
ADDRGP4 $437
ASGNP4
LABELV $454
ADDRLP4 1496
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $455
ADDRLP4 1500
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $456
JUMPV
LABELV $455
ADDRLP4 1500
ADDRGP4 $439
ASGNP4
LABELV $456
ADDRLP4 1500
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1504
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 680
;669:		             "%3i:%i%i: %i: %s: %s: %s: %s: \"%s\"\n",
;670:		             min,
;671:		             tens,
;672:		             sec,
;673:		             ( admin ) ? admin->s.clientNum : -1,
;674:		             ( admin ) ? admin->client->pers.guid
;675:		             : "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
;676:		             ( admin ) ? admin->client->pers.netname : "console",
;677:		             flags,
;678:		             cmd,
;679:		             G_SayConcatArgs( 1 + skiparg ) );
;680:	}
LABELV $433
line 681
;681:	trap_FS_Write( string, strlen( string ), f );
ADDRLP4 148
ARGP4
ADDRLP4 1492
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 148
ARGP4
ADDRLP4 1492
INDIRI4
ARGI4
ADDRLP4 1176
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 682
;682:	trap_FS_FCloseFile( f );
ADDRLP4 1176
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 683
;683:}
LABELV $402
endproc admin_log 1512 56
lit
align 1
LABELV $458
byte 1 0
skip 31
align 1
LABELV $459
byte 1 0
skip 31
align 1
LABELV $460
byte 1 0
skip 31
code
proc admin_listadmins 164 24
line 686
;684:
;685:static int admin_listadmins( gentity_t *ent, int start, char *search )
;686:{
line 687
;687:	int drawn = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 689
;688:	char guid_stub[9];
;689:	char name[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 92
ADDRGP4 $458
INDIRB
ASGNB 32
line 690
;690:	char name2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 53
ADDRGP4 $459
INDIRB
ASGNB 32
line 691
;691:	char lname[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 12
ADDRGP4 $460
INDIRB
ASGNB 32
line 694
;692:	int i, j;
;693:	gentity_t *vic;
;694:	int l = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 695
;695:	qboolean dup = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 697
;696:
;697:	ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 700
;698:
;699:	// print out all connected players regardless of level if name searching
;700:	for( i = 0; i < level.maxclients && search[ 0 ]; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $464
JUMPV
LABELV $461
line 701
;701:		vic = &g_entities[ i ];
ADDRLP4 4
CNSTI4 816
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 703
;702:
;703:		if( !vic->client || vic->client->pers.connected != CON_CONNECTED )
ADDRLP4 132
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $468
ADDRLP4 132
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $466
LABELV $468
line 704
;704:			continue;
ADDRGP4 $462
JUMPV
LABELV $466
line 706
;705:
;706:		l = vic->client->pers.adminLevel;
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ASGNI4
line 708
;707:
;708:		G_SanitiseString( vic->client->pers.netname, name, sizeof( name ) );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 709
;709:		if( !strstr( name, search ) )
ADDRLP4 92
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $469
line 710
;710:			continue;
ADDRGP4 $462
JUMPV
LABELV $469
line 712
;711:
;712:		for( j = 0; j < 8; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $471
line 713
;713:			guid_stub[ j ] = vic->client->pers.guid[ j + 24 ];
ADDRLP4 0
INDIRI4
ADDRLP4 44
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 936
ADDP4
ADDP4
INDIRI1
ASGNI1
LABELV $472
line 712
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $471
line 714
;714:		guid_stub[ j ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 44
ADDP4
CNSTI1 0
ASGNI1
line 716
;715:
;716:		lname[ 0 ] = '\0';
ADDRLP4 12
CNSTI1 0
ASGNI1
line 717
;717:		for( j = 0; j < MAX_ADMIN_LEVELS && g_admin_levels[ j ]; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $478
JUMPV
LABELV $475
line 718
;718:			if( g_admin_levels[ j ]->level == l ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $479
line 721
;719:				int k, colorlen;
;720:
;721:				for( colorlen = k = 0; g_admin_levels[ j ]->name[ k ]; k++ )
ADDRLP4 152
CNSTI4 0
ASGNI4
ADDRLP4 144
ADDRLP4 152
INDIRI4
ASGNI4
ADDRLP4 148
ADDRLP4 152
INDIRI4
ASGNI4
ADDRGP4 $484
JUMPV
LABELV $481
line 722
;722:					if( Q_IsColorString( &g_admin_levels[ j ]->name[ k ] ) )
ADDRLP4 156
ADDRLP4 144
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $485
ADDRLP4 156
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $485
ADDRLP4 160
ADDRLP4 156
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $485
ADDRLP4 160
INDIRI4
CNSTI4 48
LTI4 $485
ADDRLP4 160
INDIRI4
CNSTI4 56
GTI4 $485
line 723
;723:						colorlen += 2;
ADDRLP4 148
ADDRLP4 148
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $485
LABELV $482
line 721
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $484
ADDRLP4 144
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $481
line 724
;724:				Com_sprintf( lname, sizeof( lname ), "%*s",
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 admin_level_maxname
INDIRI4
ADDRLP4 148
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 727
;725:				             admin_level_maxname + colorlen,
;726:				             g_admin_levels[ j ]->name );
;727:				break;
ADDRGP4 $477
JUMPV
LABELV $479
line 729
;728:			}
;729:		}
LABELV $476
line 717
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $478
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $488
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $475
LABELV $488
LABELV $477
line 730
;730:		ADMBP( va( "%4i %4i %s^7 (*%s) %s^7\n",
ADDRGP4 $489
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 736
;731:		           i,
;732:		           l,
;733:		           lname,
;734:		           guid_stub,
;735:		           vic->client->pers.netname ) );
;736:		drawn++;
ADDRLP4 128
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 737
;737:	}
LABELV $462
line 700
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $464
ADDRLP4 8
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $490
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $461
LABELV $490
line 739
;738:
;739:	for( i = start; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ] &&
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $494
JUMPV
LABELV $491
line 740
;740:	        drawn < MAX_ADMIN_LISTITEMS; i++ ) {
line 741
;741:		if( search[ 0 ] ) {
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $495
line 742
;742:			G_SanitiseString( g_admin_admins[ i ]->name, name, sizeof( name ) );
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 743
;743:			if( !strstr( name, search ) )
ADDRLP4 92
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 132
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $497
line 744
;744:				continue;
ADDRGP4 $492
JUMPV
LABELV $497
line 748
;745:
;746:			// verify we don't have the same guid/name pair in connected players
;747:			// since we don't want to draw the same player twice
;748:			dup = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 749
;749:			for( j = 0; j < level.maxclients; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $502
JUMPV
LABELV $499
line 750
;750:				vic = &g_entities[ j ];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 751
;751:				if( !vic->client || vic->client->pers.connected != CON_CONNECTED )
ADDRLP4 136
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $506
ADDRLP4 136
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $504
LABELV $506
line 752
;752:					continue;
ADDRGP4 $500
JUMPV
LABELV $504
line 753
;753:				G_SanitiseString( vic->client->pers.netname, name2, sizeof( name2 ) );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 53
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 754
;754:				if( Q_strequal( vic->client->pers.guid, g_admin_admins[ i ]->guid ) &&
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $507
ADDRLP4 53
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $507
line 755
;755:				        strstr( name2, search ) ) {
line 756
;756:					dup = qtrue;
ADDRLP4 124
CNSTI4 1
ASGNI4
line 757
;757:					break;
ADDRGP4 $501
JUMPV
LABELV $507
line 759
;758:				}
;759:			}
LABELV $500
line 749
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $502
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $499
LABELV $501
line 760
;760:			if( dup )
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $509
line 761
;761:				continue;
ADDRGP4 $492
JUMPV
LABELV $509
line 762
;762:		}
LABELV $495
line 763
;763:		for( j = 0; j < 8; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $511
line 764
;764:			guid_stub[ j ] = g_admin_admins[ i ]->guid[ j + 24 ];
ADDRLP4 0
INDIRI4
ADDRLP4 44
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ADDP4
INDIRI1
ASGNI1
LABELV $512
line 763
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $511
line 765
;765:		guid_stub[ j ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 44
ADDP4
CNSTI1 0
ASGNI1
line 767
;766:
;767:		lname[ 0 ] = '\0';
ADDRLP4 12
CNSTI1 0
ASGNI1
line 768
;768:		for( j = 0; j < MAX_ADMIN_LEVELS && g_admin_levels[ j ]; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $518
JUMPV
LABELV $515
line 769
;769:			if( g_admin_levels[ j ]->level == g_admin_admins[ i ]->level ) {
ADDRLP4 136
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 136
INDIRI4
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 136
INDIRI4
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $519
line 772
;770:				int k, colorlen;
;771:
;772:				for( colorlen = k = 0; g_admin_levels[ j ]->name[ k ]; k++ )
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 144
ADDRLP4 148
INDIRI4
ASGNI4
ADDRGP4 $524
JUMPV
LABELV $521
line 773
;773:					if( Q_IsColorString( &g_admin_levels[ j ]->name[ k ] ) )
ADDRLP4 152
ADDRLP4 140
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $525
ADDRLP4 152
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $525
ADDRLP4 156
ADDRLP4 152
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $525
ADDRLP4 156
INDIRI4
CNSTI4 48
LTI4 $525
ADDRLP4 156
INDIRI4
CNSTI4 56
GTI4 $525
line 774
;774:						colorlen += 2;
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $525
LABELV $522
line 772
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $524
ADDRLP4 140
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $521
line 775
;775:				Com_sprintf( lname, sizeof( lname ), "%*s",
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 admin_level_maxname
INDIRI4
ADDRLP4 144
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 778
;776:				             admin_level_maxname + colorlen,
;777:				             g_admin_levels[ j ]->name );
;778:				break;
ADDRGP4 $517
JUMPV
LABELV $519
line 780
;779:			}
;780:		}
LABELV $516
line 768
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $518
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $527
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $515
LABELV $527
LABELV $517
line 781
;781:		ADMBP( va( "%4i %4i %s^7 (*%s) %s^7\n",
ADDRGP4 $489
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ARGI4
ADDRLP4 144
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 787
;782:		           ( i + MAX_CLIENTS ),
;783:		           g_admin_admins[ i ]->level,
;784:		           lname,
;785:		           guid_stub,
;786:		           g_admin_admins[ i ]->name ) );
;787:		drawn++;
ADDRLP4 128
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 788
;788:	}
LABELV $492
line 740
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $494
line 739
ADDRLP4 8
INDIRI4
CNSTI4 1024
GEI4 $529
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $529
ADDRLP4 128
INDIRI4
CNSTI4 20
LTI4 $491
LABELV $529
line 789
;789:	ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 790
;790:	return drawn;
ADDRLP4 128
INDIRI4
RETI4
LABELV $457
endproc admin_listadmins 164 24
export G_admin_duration
proc G_admin_duration 4 16
line 794
;791:}
;792:
;793:void G_admin_duration( int secs, char *duration, int dursize )
;794:{
line 796
;795:
;796:	if( secs > ( 60 * 60 * 24 * 365 * 50 ) || secs < 0 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1576800000
GTI4 $533
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $531
LABELV $533
line 797
;797:		Q_strncpyz( duration, "PERMANENT", dursize );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $534
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $532
JUMPV
LABELV $531
line 798
;798:	else if( secs >= ( 60 * 60 * 24 * 365 ) )
ADDRFP4 0
INDIRI4
CNSTI4 31536000
LTI4 $535
line 799
;799:		Com_sprintf( duration, dursize, "%1.1f years",
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $537
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1274059200
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $536
JUMPV
LABELV $535
line 801
;800:		             ( secs / ( 60 * 60 * 24 * 365.0f ) ) );
;801:	else if( secs >= ( 60 * 60 * 24 * 90 ) )
ADDRFP4 0
INDIRI4
CNSTI4 7776000
LTI4 $538
line 802
;802:		Com_sprintf( duration, dursize, "%1.1f weeks",
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $540
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1226024960
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $539
JUMPV
LABELV $538
line 804
;803:		             ( secs / ( 60 * 60 * 24 * 7.0f ) ) );
;804:	else if( secs >= ( 60 * 60 * 24 ) )
ADDRFP4 0
INDIRI4
CNSTI4 86400
LTI4 $541
line 805
;805:		Com_sprintf( duration, dursize, "%1.1f days",
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $543
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1202241536
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $542
JUMPV
LABELV $541
line 807
;806:		             ( secs / ( 60 * 60 * 24.0f ) ) );
;807:	else if( secs >= ( 60 * 60 ) )
ADDRFP4 0
INDIRI4
CNSTI4 3600
LTI4 $544
line 808
;808:		Com_sprintf( duration, dursize, "%1.1f hours",
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $546
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1163984896
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $545
JUMPV
LABELV $544
line 810
;809:		             ( secs / ( 60 * 60.0f ) ) );
;810:	else if( secs >= 60 )
ADDRFP4 0
INDIRI4
CNSTI4 60
LTI4 $547
line 811
;811:		Com_sprintf( duration, dursize, "%1.1f minutes",
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $549
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1114636288
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $548
JUMPV
LABELV $547
line 814
;812:		             ( secs / 60.0f ) );
;813:	else
;814:		Com_sprintf( duration, dursize, "%i seconds", secs );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $550
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $548
LABELV $545
LABELV $542
LABELV $539
LABELV $536
LABELV $532
line 815
;815:}
LABELV $530
endproc G_admin_duration 4 16
export G_admin_ban_check
proc G_admin_ban_check 80 24
line 818
;816:
;817:qboolean G_admin_ban_check( char *userinfo, char *reason, int rlen )
;818:{
line 823
;819:	char *guid, *ip;
;820:	int i;
;821:	int t;
;822:
;823:	*reason = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 824
;824:	t = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 16
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 825
;825:	if( !*userinfo )
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $552
line 826
;826:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $551
JUMPV
LABELV $552
line 827
;827:	ip = Info_ValueForKey( userinfo, "ip" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $554
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 828
;828:	if( !*ip )
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $555
line 829
;829:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $551
JUMPV
LABELV $555
line 830
;830:	guid = Info_ValueForKey( userinfo, "cl_guid" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $557
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 831
;831:	for( i = 0; i < MAX_ADMIN_BANS && g_admin_bans[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $561
JUMPV
LABELV $558
line 833
;832:		// 0 is for perm ban
;833:		if( g_admin_bans[ i ]->expires != 0 && ( g_admin_bans[ i ]->expires - t ) < 1 ) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $562
ADDRLP4 28
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 1
GEI4 $562
line 834
;834:			continue;
ADDRGP4 $559
JUMPV
LABELV $562
line 836
;835:		}
;836:		if( strstr( ip, g_admin_bans[ i ]->ip ) ) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $564
line 838
;837:			char duration[ 32 ];
;838:			G_admin_duration( ( g_admin_bans[ i ]->expires - t ),
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRLP4 36
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 840
;839:			                  duration, sizeof( duration ) );
;840:			Com_sprintf(
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $566
ARGP4
ADDRLP4 68
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 848
;841:			    reason,
;842:			    rlen,
;843:			    "You have been banned by %s^7 reason: %s^7 expires: %s",
;844:			    g_admin_bans[ i ]->banner,
;845:			    g_admin_bans[ i ]->reason,
;846:			    duration
;847:			);
;848:			G_Printf( "Banned player tried to connect from IP %s\n", ip );
ADDRGP4 $567
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 849
;849:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $551
JUMPV
LABELV $564
line 851
;850:		}
;851:		if( *guid && Q_strequal( g_admin_bans[ i ]->guid, guid ) ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $568
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $568
line 853
;852:			char duration[ 32 ];
;853:			G_admin_duration( ( g_admin_bans[ i ]->expires - t ),
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 855
;854:			                  duration, sizeof( duration ) );
;855:			Com_sprintf(
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $566
ARGP4
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 863
;856:			    reason,
;857:			    rlen,
;858:			    "You have been banned by %s^7 reason: %s^7 expires: %s",
;859:			    g_admin_bans[ i ]->banner,
;860:			    g_admin_bans[ i ]->reason,
;861:			    duration
;862:			);
;863:			G_Printf( "Banned player tried to connect with GUID %s\n", guid );
ADDRGP4 $570
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 864
;864:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $551
JUMPV
LABELV $568
line 866
;865:		}
;866:	}
LABELV $559
line 831
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $561
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $571
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $558
LABELV $571
line 867
;867:	return qfalse;
CNSTI4 0
RETI4
LABELV $551
endproc G_admin_ban_check 80 24
export G_admin_cmd_check
proc G_admin_cmd_check 60 12
line 871
;868:}
;869:
;870:qboolean G_admin_cmd_check( gentity_t *ent, qboolean say )
;871:{
line 875
;872:	int i;
;873:	char command[ MAX_ADMIN_CMD_LEN ];
;874:	char *cmd;
;875:	int skip = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 877
;876:
;877:	command[ 0 ] = '\0';
ADDRLP4 12
CNSTI1 0
ASGNI1
line 878
;878:	G_SayArgv( 0, command, sizeof( command ) );
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 879
;879:	if( !command[ 0 ] )
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $573
line 880
;880:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $572
JUMPV
LABELV $573
line 881
;881:	if( Q_strequal( command, "say" ) ||
ADDRLP4 12
ARGP4
ADDRGP4 $577
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $579
ADDRLP4 12
ARGP4
ADDRGP4 $578
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $575
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 57
ARGI4
ADDRLP4 40
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $575
LABELV $579
line 883
;882:	        ( Q_strequal( command, "say_team" ) &&
;883:	          G_admin_permission( ent, ADMF_TEAMCHAT_CMD ) ) ) {
line 884
;884:		skip = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 885
;885:		G_SayArgv( 1, command, sizeof( command ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 886
;886:	}
LABELV $575
line 888
;887:
;888:	if( command[ 0 ] == '!' ) {
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 33
NEI4 $580
line 889
;889:		cmd = &command[ 1 ];
ADDRLP4 4
ADDRLP4 12+1
ASGNP4
line 890
;890:	}
ADDRGP4 $581
JUMPV
LABELV $580
line 891
;891:	else {
line 892
;892:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $572
JUMPV
LABELV $581
line 895
;893:	}
;894:
;895:	for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $586
JUMPV
LABELV $583
line 896
;896:		if( !Q_strequal( cmd, g_admin_commands[ i ]->command ) )
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $587
line 897
;897:			continue;
ADDRGP4 $584
JUMPV
LABELV $587
line 899
;898:
;899:		if( admin_command_permission( ent, cmd ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 admin_command_permission
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $589
line 901
;900:			// flooding say will have already been accounted for in ClientCommand
;901:			if( !say && G_FloodLimited( ent ) )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $591
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 G_FloodLimited
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $591
line 902
;902:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $591
line 903
;903:			trap_SendConsoleCommand( EXEC_APPEND, g_admin_commands[ i ]->exec );
ADDRLP4 56
CNSTI4 2
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 56
INDIRI4
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 904
;904:			admin_log( ent, cmd, skip );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 admin_log
CALLV
pop
line 905
;905:		}
ADDRGP4 $590
JUMPV
LABELV $589
line 906
;906:		else {
line 907
;907:			ADMP( va( "^3!%s: ^7permission denied\n", g_admin_commands[ i ]->command ) );
ADDRGP4 $593
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 908
;908:			admin_log( ent, "attempted", skip - 1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 admin_log
CALLV
pop
line 909
;909:		}
LABELV $590
line 910
;910:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $584
line 895
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $586
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $594
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $583
LABELV $594
line 913
;911:	}
;912:
;913:	for( i = 0; i < adminNumCmds; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $598
JUMPV
LABELV $595
line 914
;914:		if ( !Q_strequal( cmd, g_admin_cmds[ i ].keyword ) )
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $599
line 915
;915:			continue;
ADDRGP4 $596
JUMPV
LABELV $599
line 917
;916:
;917:		if ( G_admin_permission( ent, g_admin_cmds[ i ].flag[ 0 ] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 52
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $601
line 919
;918:			// flooding say will have already been accounted for in ClientCommand
;919:			if( !say && G_FloodLimited( ent ) )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $604
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 G_FloodLimited
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $604
line 920
;920:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $604
line 921
;921:			g_admin_cmds[ i ].handler( ent, skip );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+4
ADDP4
INDIRP4
CALLI4
pop
line 922
;922:			admin_log( ent, cmd, skip );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 admin_log
CALLV
pop
line 923
;923:		}
ADDRGP4 $602
JUMPV
LABELV $601
line 924
;924:		else {
line 925
;925:			ADMP( va( "^3!%s: ^7permission denied\n", g_admin_cmds[ i ].keyword ) );
ADDRGP4 $593
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 926
;926:			admin_log( ent, "attempted", skip - 1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 admin_log
CALLV
pop
line 927
;927:		}
LABELV $602
line 928
;928:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $572
JUMPV
LABELV $596
line 913
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $598
ADDRLP4 0
INDIRI4
ADDRGP4 adminNumCmds
INDIRI4
LTI4 $595
line 930
;929:	}
;930:	return qfalse;
CNSTI4 0
RETI4
LABELV $572
endproc G_admin_cmd_check 60 12
export G_admin_namelog_cleanup
proc G_admin_namelog_cleanup 8 4
line 934
;931:}
;932:
;933:void G_admin_namelog_cleanup( )
;934:{
line 937
;935:	int i;
;936:
;937:	for( i = 0; i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $611
JUMPV
LABELV $608
line 938
;938:		BG_Free( g_admin_namelog[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 939
;939:		g_admin_namelog[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
CNSTP4 0
ASGNP4
line 940
;940:	}
LABELV $609
line 937
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $611
ADDRLP4 0
INDIRI4
CNSTI4 128
GEI4 $612
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $608
LABELV $612
line 941
;941:}
LABELV $607
endproc G_admin_namelog_cleanup 8 4
export G_admin_namelog_update
proc G_admin_namelog_update 104 12
line 944
;942:
;943:void G_admin_namelog_update( gclient_t *client, qboolean disconnect )
;944:{
line 949
;945:	int i, j;
;946:	g_admin_namelog_t *namelog;
;947:	char n1[ MAX_NAME_LENGTH ];
;948:	char n2[ MAX_NAME_LENGTH ];
;949:	int clientNum = ( client - level.clients );
ADDRLP4 72
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ASGNI4
line 951
;950:
;951:	G_SanitiseString( client->pers.netname, n1, sizeof( n1 ) );
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 952
;952:	for( i = 0; i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $617
JUMPV
LABELV $614
line 953
;953:		if( disconnect && g_admin_namelog[ i ]->slot != clientNum )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $618
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $618
line 954
;954:			continue;
ADDRGP4 $615
JUMPV
LABELV $618
line 956
;955:
;956:		if( !disconnect && !( g_admin_namelog[ i ]->slot == clientNum ||
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $620
ADDRLP4 80
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $620
ADDRLP4 80
INDIRI4
CNSTI4 -1
EQI4 $620
line 957
;957:		                      g_admin_namelog[ i ]->slot == -1 ) ) {
line 958
;958:			continue;
ADDRGP4 $615
JUMPV
LABELV $620
line 961
;959:		}
;960:
;961:		if( Q_strequal( client->pers.ip, g_admin_namelog[ i ]->ip ) &&
ADDRFP4 0
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $622
ADDRFP4 0
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $622
line 962
;962:		        Q_strequal( client->pers.guid, g_admin_namelog[ i ]->guid ) ) {
line 963
;963:			for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $627
JUMPV
LABELV $624
line 964
;964:			        g_admin_namelog[ i ]->name[ j ][ 0 ]; j++ ) {
line 965
;965:				G_SanitiseString( g_admin_namelog[ i ]->name[ j ], n2, sizeof( n2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 966
;966:				if( Q_strequal( n1, n2 ) )
ADDRLP4 40
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $628
line 967
;967:					break;
ADDRGP4 $626
JUMPV
LABELV $628
line 968
;968:			}
LABELV $625
line 964
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $627
line 963
ADDRLP4 96
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
GEI4 $630
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $624
LABELV $630
LABELV $626
line 969
;969:			if( j == MAX_ADMIN_NAMELOG_NAMES )
ADDRLP4 0
INDIRI4
CNSTI4 5
NEI4 $631
line 970
;970:				j = MAX_ADMIN_NAMELOG_NAMES - 1;
ADDRLP4 0
CNSTI4 4
ASGNI4
LABELV $631
line 971
;971:			Q_strncpyz( g_admin_namelog[ i ]->name[ j ], client->pers.netname,
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 973
;972:			            sizeof( g_admin_namelog[ i ]->name[ j ] ) );
;973:			g_admin_namelog[ i ]->slot = ( disconnect ) ? -1 : clientNum;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $634
ADDRLP4 100
CNSTI4 -1
ASGNI4
ADDRGP4 $635
JUMPV
LABELV $634
ADDRLP4 100
ADDRLP4 72
INDIRI4
ASGNI4
LABELV $635
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 976
;974:
;975:			// if this player is connecting, they are no longer banned
;976:			if( !disconnect )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $613
line 977
;977:				g_admin_namelog[ i ]->banned = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 0
ASGNI4
line 979
;978:
;979:			return;
ADDRGP4 $613
JUMPV
LABELV $622
line 981
;980:		}
;981:	}
LABELV $615
line 952
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $617
ADDRLP4 4
INDIRI4
CNSTI4 128
GEI4 $638
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $614
LABELV $638
line 982
;982:	if( i >= MAX_ADMIN_NAMELOGS ) {
ADDRLP4 4
INDIRI4
CNSTI4 128
LTI4 $639
line 983
;983:		G_Printf( "G_admin_namelog_update: warning, g_admin_namelogs overflow\n" );
ADDRGP4 $641
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 984
;984:		return;
ADDRGP4 $613
JUMPV
LABELV $639
line 986
;985:	}
;986:	namelog = BG_Alloc( sizeof( g_admin_namelog_t ) );
CNSTU4 244
ARGU4
ADDRLP4 84
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 76
ADDRLP4 84
INDIRP4
ASGNP4
line 987
;987:	memset( namelog, 0, sizeof( *namelog ) );
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 988
;988:	for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 989
;989:		namelog->name[ j ][ 0 ] = '\0';
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 76
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 990
;990:	}
LABELV $643
line 988
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $642
line 991
;991:	Q_strncpyz( namelog->ip, client->pers.ip, sizeof( namelog->ip ) );
ADDRLP4 76
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 945
ADDP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 992
;992:	Q_strncpyz( namelog->guid, client->pers.guid, sizeof( namelog->guid ) );
ADDRLP4 76
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 912
ADDP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 993
;993:	Q_strncpyz( namelog->name[ 0 ], client->pers.netname, sizeof( namelog->name[ 0 ] ) );
ADDRLP4 76
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 994
;994:	namelog->slot = ( disconnect ) ? -1 : clientNum;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $647
ADDRLP4 88
CNSTI4 -1
ASGNI4
ADDRGP4 $648
JUMPV
LABELV $647
ADDRLP4 88
ADDRLP4 72
INDIRI4
ASGNI4
LABELV $648
ADDRLP4 76
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 995
;995:	g_admin_namelog[ i ] = namelog;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
ADDRLP4 76
INDIRP4
ASGNP4
line 996
;996:}
LABELV $613
endproc G_admin_namelog_update 104 12
lit
align 1
LABELV $749
byte 1 0
skip 1023
export G_admin_readconfig
code
proc G_admin_readconfig 1184 24
line 1000
;997:
;998://KK-OAX Added Parsing Warnings
;999:qboolean G_admin_readconfig( gentity_t *ent, int skiparg )
;1000:{
line 1001
;1001:	g_admin_level_t *l = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 1002
;1002:	g_admin_admin_t *a = NULL;
ADDRLP4 48
CNSTP4 0
ASGNP4
line 1003
;1003:	g_admin_ban_t *b = NULL;
ADDRLP4 56
CNSTP4 0
ASGNP4
line 1004
;1004:	g_admin_command_t *c = NULL;
ADDRLP4 68
CNSTP4 0
ASGNP4
line 1005
;1005:	g_admin_warning_t *w = NULL;
ADDRLP4 80
CNSTP4 0
ASGNP4
line 1006
;1006:	int lc = 0, ac = 0, bc = 0, cc = 0, wc = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 72
CNSTI4 0
ASGNI4
line 1014
;1007:	fileHandle_t f;
;1008:	int len;
;1009:	char *cnf, *cnf2;
;1010:	char *t;
;1011:	qboolean level_open, admin_open, ban_open, command_open, warning_open;
;1012:	int i;
;1013:
;1014:	G_admin_cleanup();
ADDRGP4 G_admin_cleanup
CALLV
pop
line 1016
;1015:
;1016:	if( !g_admin.string[ 0 ] ) {
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $650
line 1017
;1017:		ADMP( "^3!readconfig: g_admin is not set, not loading configuration "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1019
;1018:		      "from a file\n" );
;1019:		admin_default_levels();
ADDRGP4 admin_default_levels
CALLV
pop
line 1020
;1020:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $650
line 1023
;1021:	}
;1022:
;1023:	len = trap_FS_FOpenFile( g_admin.string, &f, FS_READ );
ADDRGP4 g_admin+16
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 84
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 84
INDIRI4
ASGNI4
line 1024
;1024:	if( len < 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $655
line 1025
;1025:		G_Printf( "^3!readconfig: ^7could not open admin config file %s\n",
ADDRGP4 $657
ARGP4
ADDRGP4 g_admin+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1027
;1026:		          g_admin.string );
;1027:		admin_default_levels();
ADDRGP4 admin_default_levels
CALLV
pop
line 1028
;1028:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $655
line 1030
;1029:	}
;1030:	cnf = BG_Alloc( len + 1 );
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
CVIU4 4
ARGU4
ADDRLP4 88
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 88
INDIRP4
ASGNP4
line 1031
;1031:	cnf2 = cnf;
ADDRLP4 76
ADDRLP4 12
INDIRP4
ASGNP4
line 1032
;1032:	trap_FS_Read( cnf, len, f );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1033
;1033:	*( cnf + len ) = '\0';
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1034
;1034:	trap_FS_FCloseFile( f );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1036
;1035:
;1036:	admin_level_maxname = 0;
ADDRGP4 admin_level_maxname
CNSTI4 0
ASGNI4
line 1038
;1037:
;1038:	level_open = admin_open = ban_open = command_open = warning_open = qfalse;
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 92
INDIRI4
ASGNI4
ADDRLP4 36
ADDRLP4 92
INDIRI4
ASGNI4
ADDRLP4 32
ADDRLP4 92
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 92
INDIRI4
ASGNI4
ADDRLP4 24
ADDRLP4 92
INDIRI4
ASGNI4
line 1039
;1039:	COM_BeginParseSession( g_admin.string );
ADDRGP4 g_admin+16
ARGP4
ADDRGP4 COM_BeginParseSession
CALLV
pop
ADDRGP4 $661
JUMPV
LABELV $660
line 1040
;1040:	while( 1 ) {
line 1041
;1041:		t = COM_Parse( &cnf );
ADDRLP4 12
ARGP4
ADDRLP4 96
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 96
INDIRP4
ASGNP4
line 1042
;1042:		if( !*t )
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $663
line 1043
;1043:			break;
ADDRGP4 $662
JUMPV
LABELV $663
line 1045
;1044:
;1045:		if( Q_strequal( t, "[level]" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $665
line 1046
;1046:			if( lc >= MAX_ADMIN_LEVELS )
ADDRLP4 16
INDIRI4
CNSTI4 32
LTI4 $668
line 1047
;1047:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $668
line 1048
;1048:			l = BG_Alloc( sizeof( g_admin_level_t ) );
CNSTU4 100
ARGU4
ADDRLP4 104
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 104
INDIRP4
ASGNP4
line 1049
;1049:			g_admin_levels[ lc++ ] = l;
ADDRLP4 108
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 1050
;1050:			level_open = qtrue;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 1051
;1051:			admin_open = ban_open = command_open = warning_open = qfalse;
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 112
INDIRI4
ASGNI4
ADDRLP4 36
ADDRLP4 112
INDIRI4
ASGNI4
ADDRLP4 32
ADDRLP4 112
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 112
INDIRI4
ASGNI4
line 1052
;1052:		}
ADDRGP4 $666
JUMPV
LABELV $665
line 1053
;1053:		else if( Q_strequal( t, "[admin]" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $672
ARGP4
ADDRLP4 104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $670
line 1054
;1054:			if( ac >= MAX_ADMIN_ADMINS )
ADDRLP4 44
INDIRI4
CNSTI4 1024
LTI4 $673
line 1055
;1055:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $673
line 1056
;1056:			a = BG_Alloc( sizeof( g_admin_admin_t ) );
CNSTU4 136
ARGU4
ADDRLP4 108
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 108
INDIRP4
ASGNP4
line 1057
;1057:			g_admin_admins[ ac++ ] = a;
ADDRLP4 112
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 44
ADDRLP4 112
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
ADDRLP4 48
INDIRP4
ASGNP4
line 1058
;1058:			admin_open = qtrue;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 1059
;1059:			level_open = ban_open = command_open = warning_open = qfalse;
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 116
INDIRI4
ASGNI4
ADDRLP4 36
ADDRLP4 116
INDIRI4
ASGNI4
ADDRLP4 32
ADDRLP4 116
INDIRI4
ASGNI4
ADDRLP4 24
ADDRLP4 116
INDIRI4
ASGNI4
line 1060
;1060:		}
ADDRGP4 $671
JUMPV
LABELV $670
line 1061
;1061:		else if( Q_strequal( t, "[ban]" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $677
ARGP4
ADDRLP4 108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $675
line 1062
;1062:			if( bc >= MAX_ADMIN_BANS )
ADDRLP4 52
INDIRI4
CNSTI4 1024
LTI4 $678
line 1063
;1063:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $678
line 1064
;1064:			b = BG_Alloc( sizeof( g_admin_ban_t ) );
CNSTU4 212
ARGU4
ADDRLP4 112
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 112
INDIRP4
ASGNP4
line 1065
;1065:			g_admin_bans[ bc++ ] = b;
ADDRLP4 116
ADDRLP4 52
INDIRI4
ASGNI4
ADDRLP4 52
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
ADDRLP4 56
INDIRP4
ASGNP4
line 1066
;1066:			ban_open = qtrue;
ADDRLP4 32
CNSTI4 1
ASGNI4
line 1067
;1067:			level_open = admin_open = command_open = warning_open = qfalse;
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 36
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1068
;1068:		}
ADDRGP4 $676
JUMPV
LABELV $675
line 1069
;1069:		else if( Q_strequal( t, "[command]" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $682
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $680
line 1070
;1070:			if( cc >= MAX_ADMIN_COMMANDS )
ADDRLP4 60
INDIRI4
CNSTI4 64
LTI4 $683
line 1071
;1071:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $683
line 1072
;1072:			c = BG_Alloc( sizeof( g_admin_command_t ) );
CNSTU4 268
ARGU4
ADDRLP4 116
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 116
INDIRP4
ASGNP4
line 1073
;1073:			g_admin_commands[ cc++ ] = c;
ADDRLP4 120
ADDRLP4 60
INDIRI4
ASGNI4
ADDRLP4 60
ADDRLP4 120
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
ADDRLP4 68
INDIRP4
ASGNP4
line 1074
;1074:			c->levels[ 0 ] = -1;
ADDRLP4 68
INDIRP4
CNSTI4 136
ADDP4
CNSTI4 -1
ASGNI4
line 1075
;1075:			command_open = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 1076
;1076:			level_open = admin_open = ban_open = warning_open = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
ADDRLP4 32
ADDRLP4 124
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 124
INDIRI4
ASGNI4
ADDRLP4 24
ADDRLP4 124
INDIRI4
ASGNI4
line 1077
;1077:		}
ADDRGP4 $681
JUMPV
LABELV $680
line 1078
;1078:		else if( Q_strequal( t, "[warning]" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $687
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $685
line 1079
;1079:			if( wc >= MAX_ADMIN_WARNINGS )
ADDRLP4 72
INDIRI4
CNSTI4 1024
LTI4 $688
line 1080
;1080:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $649
JUMPV
LABELV $688
line 1081
;1081:			w = BG_Alloc( sizeof( g_admin_warning_t ) );
CNSTU4 1184
ARGU4
ADDRLP4 120
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 120
INDIRP4
ASGNP4
line 1082
;1082:			g_admin_warnings[ wc++ ] = w;
ADDRLP4 124
ADDRLP4 72
INDIRI4
ASGNI4
ADDRLP4 72
ADDRLP4 124
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
ADDRLP4 80
INDIRP4
ASGNP4
line 1083
;1083:			warning_open = qtrue;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 1084
;1084:			level_open = admin_open = ban_open = command_open = qfalse;
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 36
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 32
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 24
ADDRLP4 128
INDIRI4
ASGNI4
line 1085
;1085:		}
ADDRGP4 $686
JUMPV
LABELV $685
line 1086
;1086:		else if( level_open ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $690
line 1087
;1087:			if( Q_strequal( t, "level" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $694
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $692
line 1088
;1088:				readFile_int( &cnf, &l->level );
ADDRLP4 12
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 readFile_int
CALLV
pop
line 1089
;1089:			}
ADDRGP4 $691
JUMPV
LABELV $692
line 1090
;1090:			else if( Q_strequal( t, "name" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $695
line 1091
;1091:				readFile_string( &cnf, l->name, sizeof( l->name ) );
ADDRLP4 12
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1092
;1092:			}
ADDRGP4 $691
JUMPV
LABELV $695
line 1093
;1093:			else if( Q_strequal( t, "flags" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $700
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $698
line 1094
;1094:				readFile_string( &cnf, l->flags, sizeof( l->flags ) );
ADDRLP4 12
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1095
;1095:			}
ADDRGP4 $691
JUMPV
LABELV $698
line 1096
;1096:			else {
line 1097
;1097:				COM_ParseError( "[level] unrecognized token \"%s\"", t );
ADDRGP4 $701
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1098
;1098:			}
line 1099
;1099:		}
ADDRGP4 $691
JUMPV
LABELV $690
line 1100
;1100:		else if( admin_open ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $702
line 1101
;1101:			if( Q_strequal( t, "name" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $704
line 1102
;1102:				readFile_string( &cnf, a->name, sizeof( a->name ) );
ADDRLP4 12
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 33
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1103
;1103:			}
ADDRGP4 $703
JUMPV
LABELV $704
line 1104
;1104:			else if( Q_strequal( t, "guid" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $708
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $706
line 1105
;1105:				readFile_string( &cnf, a->guid, sizeof( a->guid ) );
ADDRLP4 12
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1106
;1106:			}
ADDRGP4 $703
JUMPV
LABELV $706
line 1107
;1107:			else if( Q_strequal( t, "level" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $694
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $709
line 1108
;1108:				readFile_int( &cnf, &a->level );
ADDRLP4 12
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 readFile_int
CALLV
pop
line 1109
;1109:			}
ADDRGP4 $703
JUMPV
LABELV $709
line 1110
;1110:			else if( Q_strequal( t, "flags" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $700
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $711
line 1111
;1111:				readFile_string( &cnf, a->flags, sizeof( a->flags ) );
ADDRLP4 12
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 72
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1112
;1112:			}
ADDRGP4 $703
JUMPV
LABELV $711
line 1113
;1113:			else {
line 1114
;1114:				COM_ParseError( "[admin] unrecognized token \"%s\"", t );
ADDRGP4 $713
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1115
;1115:			}
line 1117
;1116:
;1117:		}
ADDRGP4 $703
JUMPV
LABELV $702
line 1118
;1118:		else if( ban_open ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $714
line 1119
;1119:			if( Q_strequal( t, "name" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $716
line 1120
;1120:				readFile_string( &cnf, b->name, sizeof( b->name ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1121
;1121:			}
ADDRGP4 $715
JUMPV
LABELV $716
line 1122
;1122:			else if( Q_strequal( t, "guid" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $708
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $718
line 1123
;1123:				readFile_string( &cnf, b->guid, sizeof( b->guid ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1124
;1124:			}
ADDRGP4 $715
JUMPV
LABELV $718
line 1125
;1125:			else if( Q_strequal( t, "ip" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $554
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $720
line 1126
;1126:				readFile_string( &cnf, b->ip, sizeof( b->ip ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 65
ADDP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1127
;1127:			}
ADDRGP4 $715
JUMPV
LABELV $720
line 1128
;1128:			else if( Q_strequal( t, "reason" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $724
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $722
line 1129
;1129:				readFile_string( &cnf, b->reason, sizeof( b->reason ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 105
ADDP4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1130
;1130:			}
ADDRGP4 $715
JUMPV
LABELV $722
line 1131
;1131:			else if( Q_strequal( t, "made" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $727
ARGP4
ADDRLP4 136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $725
line 1132
;1132:				readFile_string( &cnf, b->made, sizeof( b->made ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 155
ADDP4
ARGP4
CNSTI4 18
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1133
;1133:			}
ADDRGP4 $715
JUMPV
LABELV $725
line 1134
;1134:			else if( Q_strequal( t, "expires" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $730
ARGP4
ADDRLP4 140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $728
line 1135
;1135:				readFile_int( &cnf, &b->expires );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRGP4 readFile_int
CALLV
pop
line 1136
;1136:			}
ADDRGP4 $715
JUMPV
LABELV $728
line 1137
;1137:			else if( Q_strequal( t, "banner" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $733
ARGP4
ADDRLP4 144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $731
line 1138
;1138:				readFile_string( &cnf, b->banner, sizeof( b->banner ) );
ADDRLP4 12
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1139
;1139:			}
ADDRGP4 $715
JUMPV
LABELV $731
line 1140
;1140:			else {
line 1141
;1141:				COM_ParseError( "[ban] unrecognized token \"%s\"", t );
ADDRGP4 $734
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1142
;1142:			}
line 1143
;1143:		}
ADDRGP4 $715
JUMPV
LABELV $714
line 1144
;1144:		else if( command_open ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $735
line 1145
;1145:			if( Q_strequal( t, "command" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $739
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $737
line 1146
;1146:				readFile_string( &cnf, c->command, sizeof( c->command ) );
ADDRLP4 12
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1147
;1147:			}
ADDRGP4 $736
JUMPV
LABELV $737
line 1148
;1148:			else if( Q_strequal( t, "exec" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $742
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $740
line 1149
;1149:				readFile_string( &cnf, c->exec, sizeof( c->exec ) );
ADDRLP4 12
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1150
;1150:			}
ADDRGP4 $736
JUMPV
LABELV $740
line 1151
;1151:			else if( Q_strequal( t, "desc" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $745
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $743
line 1152
;1152:				readFile_string( &cnf, c->desc, sizeof( c->desc ) );
ADDRLP4 12
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1153
;1153:			}
ADDRGP4 $736
JUMPV
LABELV $743
line 1154
;1154:			else if( Q_strequal( t, "levels" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $748
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $746
line 1155
;1155:				char levels[ MAX_STRING_CHARS ] = {""};
ADDRLP4 144
ADDRGP4 $749
INDIRB
ASGNB 1024
line 1156
;1156:				char *level = levels;
ADDRLP4 140
ADDRLP4 144
ASGNP4
line 1158
;1157:				char *lp;
;1158:				int cmdlevel = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1160
;1159:
;1160:				readFile_string( &cnf, levels, sizeof( levels ) );
ADDRLP4 12
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 readFile_string
CALLV
pop
ADDRGP4 $751
JUMPV
LABELV $750
line 1161
;1161:				while( cmdlevel < MAX_ADMIN_LEVELS ) {
line 1162
;1162:					lp = COM_Parse( &level );
ADDRLP4 140
ARGP4
ADDRLP4 1172
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 1168
ADDRLP4 1172
INDIRP4
ASGNP4
line 1163
;1163:					if( !*lp )
ADDRLP4 1168
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $753
line 1164
;1164:						break;
ADDRGP4 $752
JUMPV
LABELV $753
line 1165
;1165:					c->levels[ cmdlevel++ ] = atoi( lp );
ADDRLP4 1176
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 136
ADDRLP4 1176
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1168
INDIRP4
ARGP4
ADDRLP4 1180
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 136
ADDP4
ADDP4
ADDRLP4 1180
INDIRI4
ASGNI4
line 1166
;1166:				}
LABELV $751
line 1161
ADDRLP4 136
INDIRI4
CNSTI4 32
LTI4 $750
LABELV $752
line 1168
;1167:				// ensure the list is -1 terminated
;1168:				c->levels[ cmdlevel ] = -1;
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 136
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
line 1169
;1169:			}
ADDRGP4 $736
JUMPV
LABELV $746
line 1170
;1170:			else {
line 1171
;1171:				COM_ParseError( "[command] unrecognized token \"%s\"", t );
ADDRGP4 $755
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1172
;1172:			}
line 1173
;1173:		}
ADDRGP4 $736
JUMPV
LABELV $735
line 1174
;1174:		else if( warning_open ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $756
line 1175
;1175:			if( Q_strequal( t, "name" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $758
line 1176
;1176:				readFile_string( &cnf, w->name, sizeof( w->name ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1177
;1177:			}
ADDRGP4 $757
JUMPV
LABELV $758
line 1178
;1178:			else if( Q_strequal( t, "guid" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $708
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $760
line 1179
;1179:				readFile_string( &cnf, w->guid, sizeof( w->guid ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1180
;1180:			}
ADDRGP4 $757
JUMPV
LABELV $760
line 1181
;1181:			else if( Q_strequal( t, "ip" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $554
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $762
line 1182
;1182:				readFile_string( &cnf, w->ip, sizeof( w->ip ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 65
ADDP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1183
;1183:			}
ADDRGP4 $757
JUMPV
LABELV $762
line 1184
;1184:			else if( Q_strequal( t, "warning" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $766
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $764
line 1185
;1185:				readFile_string( &cnf, w->warning, sizeof( w->warning ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 105
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1186
;1186:			}
ADDRGP4 $757
JUMPV
LABELV $764
line 1187
;1187:			else if( Q_strequal( t, "made" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $727
ARGP4
ADDRLP4 136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $767
line 1188
;1188:				readFile_string( &cnf, w->made, sizeof( w->made ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 1129
ADDP4
ARGP4
CNSTI4 18
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1189
;1189:			}
ADDRGP4 $757
JUMPV
LABELV $767
line 1190
;1190:			else if( Q_strequal( t, "expires" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $730
ARGP4
ADDRLP4 140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $769
line 1191
;1191:				readFile_int( &cnf, &w->expires );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 1180
ADDP4
ARGP4
ADDRGP4 readFile_int
CALLV
pop
line 1192
;1192:			}
ADDRGP4 $757
JUMPV
LABELV $769
line 1193
;1193:			else if( Q_strequal( t, "warner" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $773
ARGP4
ADDRLP4 144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $771
line 1194
;1194:				readFile_string( &cnf, w->warner, sizeof( w->warner ) );
ADDRLP4 12
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 1147
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 readFile_string
CALLV
pop
line 1195
;1195:			}
ADDRGP4 $757
JUMPV
LABELV $771
line 1196
;1196:			else {
line 1197
;1197:				COM_ParseError( "[warning] unrecognized token \"%s\"", t );
ADDRGP4 $774
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1198
;1198:			}
line 1199
;1199:		}
ADDRGP4 $757
JUMPV
LABELV $756
line 1200
;1200:		else {
line 1201
;1201:			COM_ParseError( "unexpected token \"%s\"", t );
ADDRGP4 $775
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 COM_ParseError
CALLV
pop
line 1202
;1202:		}
LABELV $757
LABELV $736
LABELV $715
LABELV $703
LABELV $691
LABELV $686
LABELV $681
LABELV $676
LABELV $671
LABELV $666
line 1203
;1203:	}
LABELV $661
line 1040
ADDRGP4 $660
JUMPV
LABELV $662
line 1204
;1204:	BG_Free( cnf2 );
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 1205
;1205:	ADMP( va( "^3!readconfig: ^7loaded %d levels, %d admins, %d bans, %d commands, %d warnings\n",
ADDRGP4 $776
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1207
;1206:	          lc, ac, bc, cc, wc ) );
;1207:	if( lc == 0 ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $777
line 1208
;1208:		admin_default_levels();
ADDRGP4 admin_default_levels
CALLV
pop
line 1209
;1209:	}
ADDRGP4 $778
JUMPV
LABELV $777
line 1210
;1210:	else {
line 1212
;1211:		// max printable name length for formatting
;1212:		for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $782
JUMPV
LABELV $779
line 1213
;1213:			len = Q_PrintStrlen( g_admin_levels[ i ]->name );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 100
INDIRI4
ASGNI4
line 1214
;1214:			if( len > admin_level_maxname )
ADDRLP4 8
INDIRI4
ADDRGP4 admin_level_maxname
INDIRI4
LEI4 $783
line 1215
;1215:				admin_level_maxname = len;
ADDRGP4 admin_level_maxname
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $783
line 1216
;1216:		}
LABELV $780
line 1212
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $782
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $785
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $779
LABELV $785
line 1217
;1217:	}
LABELV $778
line 1219
;1218:	// reset adminLevel
;1219:	for( i = 0; i < level.maxclients; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $789
JUMPV
LABELV $786
line 1220
;1220:		if( level.clients[ i ].pers.connected != CON_DISCONNECTED )
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $791
line 1221
;1221:			level.clients[ i ].pers.adminLevel = G_admin_level( &g_entities[ i ] );
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 G_admin_level
CALLI4
ASGNI4
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1000
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
LABELV $791
LABELV $787
line 1219
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $789
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $786
line 1222
;1222:	return qtrue;
CNSTI4 1
RETI4
LABELV $649
endproc G_admin_readconfig 1184 24
export G_admin_time
proc G_admin_time 40 16
line 1226
;1223:}
;1224:
;1225:qboolean G_admin_time( gentity_t *ent, int skiparg )
;1226:{
line 1229
;1227:	qtime_t qt;
;1228:
;1229:	trap_RealTime( &qt );
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 1230
;1230:	ADMP( va( "^3!time: ^7local time is %02i:%02i:%02i\n",
ADDRGP4 $794
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1232
;1231:	          qt.tm_hour, qt.tm_min, qt.tm_sec ) );
;1232:	return qtrue;
CNSTI4 1
RETI4
LABELV $793
endproc G_admin_time 40 16
lit
align 1
LABELV $798
byte 1 0
skip 31
align 1
LABELV $799
byte 1 0
skip 31
align 1
LABELV $800
byte 1 0
skip 31
export G_admin_setlevel
code
proc G_admin_setlevel 260 16
line 1236
;1233:}
;1234:
;1235:qboolean G_admin_setlevel( gentity_t *ent, int skiparg )
;1236:{
line 1237
;1237:	char name[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 4
ADDRGP4 $798
INDIRB
ASGNB 32
line 1239
;1238:	char lstr[ 11 ]; // 10 is max strlen() for 32-bit int
;1239:	char adminname[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 116
ADDRGP4 $799
INDIRB
ASGNB 32
line 1240
;1240:	char testname[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 69
ADDRGP4 $800
INDIRB
ASGNB 32
line 1243
;1241:	char guid[ 33 ];
;1242:	int l, i;
;1243:	gentity_t *vic = NULL;
ADDRLP4 112
CNSTP4 0
ASGNP4
line 1244
;1244:	qboolean updated = qfalse;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 1246
;1245:	g_admin_admin_t *a;
;1246:	qboolean found = qfalse;
ADDRLP4 156
CNSTI4 0
ASGNI4
line 1247
;1247:	qboolean numeric = qtrue;
ADDRLP4 148
CNSTI4 1
ASGNI4
line 1248
;1248:	int matches = 0;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 1249
;1249:	int id = -1;
ADDRLP4 160
CNSTI4 -1
ASGNI4
line 1252
;1250:
;1251:
;1252:	if( G_SayArgc() < 3 + skiparg ) {
ADDRLP4 180
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
GEI4 $801
line 1253
;1253:		ADMP( "^3!setlevel: ^7usage: !setlevel [name|slot#] [level]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $803
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1254
;1254:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $801
line 1256
;1255:	}
;1256:	G_SayArgv( 1 + skiparg, testname, sizeof( testname ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 69
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1257
;1257:	G_SayArgv( 2 + skiparg, lstr, sizeof( lstr ) );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 168
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1258
;1258:	l = atoi( lstr );
ADDRLP4 168
ARGP4
ADDRLP4 184
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 184
INDIRI4
ASGNI4
line 1259
;1259:	G_SanitiseString( testname, name, sizeof( name ) );
ADDRLP4 69
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1260
;1260:	for( i = 0; i < sizeof( name ) && name[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $807
JUMPV
LABELV $804
line 1261
;1261:		if( !isdigit( name[ i ] ) ) {
ADDRLP4 188
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 48
LTI4 $810
ADDRLP4 188
INDIRI4
CNSTI4 57
LEI4 $808
LABELV $810
line 1262
;1262:			numeric = qfalse;
ADDRLP4 148
CNSTI4 0
ASGNI4
line 1263
;1263:			break;
ADDRGP4 $806
JUMPV
LABELV $808
line 1265
;1264:		}
;1265:	}
LABELV $805
line 1260
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $807
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32
GEU4 $811
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $804
LABELV $811
LABELV $806
line 1266
;1266:	if( numeric )
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $812
line 1267
;1267:		id = atoi( name );
ADDRLP4 4
ARGP4
ADDRLP4 192
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 160
ADDRLP4 192
INDIRI4
ASGNI4
LABELV $812
line 1269
;1268:
;1269:	if( ent && l > ent->client->pers.adminLevel ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $814
ADDRLP4 104
INDIRI4
ADDRLP4 196
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
LEI4 $814
line 1270
;1270:		ADMP( "^3!setlevel: ^7you may not use !setlevel to set a level higher "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $816
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1272
;1271:		      "than your current level\n" );
;1272:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $814
line 1277
;1273:	}
;1274:
;1275:	// if admin is activated for the first time on a running server, we need
;1276:	// to ensure at least the default levels get created
;1277:	if( !ent && !g_admin_levels[ 0 ] )
ADDRLP4 200
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 200
INDIRU4
NEU4 $817
ADDRGP4 g_admin_levels
INDIRP4
CVPU4 4
ADDRLP4 200
INDIRU4
NEU4 $817
line 1278
;1278:		G_admin_readconfig(NULL, 0);
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 G_admin_readconfig
CALLI4
pop
LABELV $817
line 1280
;1279:
;1280:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $822
JUMPV
LABELV $819
line 1281
;1281:		if( g_admin_levels[ i ]->level == l ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 104
INDIRI4
NEI4 $823
line 1282
;1282:			found = qtrue;
ADDRLP4 156
CNSTI4 1
ASGNI4
line 1283
;1283:			break;
ADDRGP4 $821
JUMPV
LABELV $823
line 1285
;1284:		}
;1285:	}
LABELV $820
line 1280
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $822
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $825
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $819
LABELV $825
LABELV $821
line 1286
;1286:	if( !found ) {
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $826
line 1287
;1287:		ADMP( "^3!setlevel: ^7level is not defined\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $828
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1288
;1288:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $826
line 1291
;1289:	}
;1290:
;1291:	if( numeric && id >= 0 && id < level.maxclients )
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRI4
ADDRLP4 208
INDIRI4
EQI4 $829
ADDRLP4 160
INDIRI4
ADDRLP4 208
INDIRI4
LTI4 $829
ADDRLP4 160
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $829
line 1292
;1292:		vic = &g_entities[ id ];
ADDRLP4 112
CNSTI4 816
ADDRLP4 160
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
LABELV $829
line 1294
;1293:
;1294:	if( vic && vic->client && vic->client->pers.connected != CON_DISCONNECTED ) {
ADDRLP4 220
CNSTU4 0
ASGNU4
ADDRLP4 112
INDIRP4
CVPU4 4
ADDRLP4 220
INDIRU4
EQU4 $832
ADDRLP4 224
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 224
INDIRP4
CVPU4 4
ADDRLP4 220
INDIRU4
EQU4 $832
ADDRLP4 224
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $832
line 1295
;1295:		Q_strncpyz( adminname, vic->client->pers.netname, sizeof( adminname ) );
ADDRLP4 116
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1296
;1296:		Q_strncpyz( guid, vic->client->pers.guid, sizeof( guid ) );
ADDRLP4 36
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1297
;1297:		matches = 1;
ADDRLP4 108
CNSTI4 1
ASGNI4
line 1298
;1298:	}
ADDRGP4 $833
JUMPV
LABELV $832
line 1299
;1299:	else if( numeric && id >= MAX_CLIENTS && id < MAX_CLIENTS + MAX_ADMIN_ADMINS
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $834
ADDRLP4 160
INDIRI4
CNSTI4 64
LTI4 $834
ADDRLP4 160
INDIRI4
CNSTI4 1088
GEI4 $834
ADDRLP4 160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins-256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $834
line 1300
;1300:	         && g_admin_admins[ id - MAX_CLIENTS ] ) {
line 1301
;1301:		Q_strncpyz( adminname, g_admin_admins[ id - MAX_CLIENTS ]->name,
ADDRLP4 116
ARGP4
ADDRLP4 160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins-256
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1303
;1302:		            sizeof( adminname ) );
;1303:		Q_strncpyz( guid, g_admin_admins[ id - MAX_CLIENTS ]->guid,
ADDRLP4 36
ARGP4
ADDRLP4 160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins-256
ADDP4
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1305
;1304:		            sizeof( guid ) );
;1305:		matches = 1;
ADDRLP4 108
CNSTI4 1
ASGNI4
line 1306
;1306:	}
ADDRGP4 $835
JUMPV
LABELV $834
line 1307
;1307:	else {
line 1308
;1308:		for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ] && matches < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $842
JUMPV
LABELV $839
line 1309
;1309:			G_SanitiseString( g_admin_admins[ i ]->name, testname, sizeof( testname ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 69
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1310
;1310:			if( strstr( testname, name ) ) {
ADDRLP4 69
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 232
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 232
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $843
line 1311
;1311:				Q_strncpyz( adminname, g_admin_admins[ i ]->name, sizeof( adminname ) );
ADDRLP4 116
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1312
;1312:				Q_strncpyz( guid, g_admin_admins[ i ]->guid, sizeof( guid ) );
ADDRLP4 36
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1313
;1313:				matches++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1314
;1314:			}
LABELV $843
line 1315
;1315:		}
LABELV $840
line 1308
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $842
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $846
ADDRLP4 236
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 236
INDIRI4
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $846
ADDRLP4 108
INDIRI4
ADDRLP4 236
INDIRI4
LTI4 $839
LABELV $846
line 1316
;1316:		for( i = 0; i < level.maxclients && matches < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $850
JUMPV
LABELV $847
line 1317
;1317:			if( level.clients[ i ].pers.connected == CON_DISCONNECTED )
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $852
line 1318
;1318:				continue;
ADDRGP4 $848
JUMPV
LABELV $852
line 1319
;1319:			if( matches && Q_strequal( level.clients[ i ].pers.guid, guid ) ) {
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $854
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 0
NEI4 $854
line 1320
;1320:				vic = &g_entities[ i ];
ADDRLP4 112
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1321
;1321:				continue;
ADDRGP4 $848
JUMPV
LABELV $854
line 1323
;1322:			}
;1323:			G_SanitiseString( level.clients[ i ].pers.netname, testname,
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 69
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1325
;1324:			                  sizeof( testname ) );
;1325:			if( strstr( testname, name ) ) {
ADDRLP4 69
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 244
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 244
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $856
line 1326
;1326:				vic = &g_entities[ i ];
ADDRLP4 112
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1327
;1327:				matches++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1328
;1328:				Q_strncpyz( guid, vic->client->pers.guid, sizeof( guid ) );
ADDRLP4 36
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1329
;1329:			}
LABELV $856
line 1330
;1330:		}
LABELV $848
line 1316
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $850
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
GEI4 $858
ADDRLP4 108
INDIRI4
CNSTI4 2
LTI4 $847
LABELV $858
line 1331
;1331:		if( vic && vic->client)
ADDRLP4 244
CNSTU4 0
ASGNU4
ADDRLP4 112
INDIRP4
CVPU4 4
ADDRLP4 244
INDIRU4
EQU4 $859
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 244
INDIRU4
EQU4 $859
line 1332
;1332:			Q_strncpyz( adminname, vic->client->pers.netname, sizeof( adminname ) );
ADDRLP4 116
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $859
line 1333
;1333:	}
LABELV $835
LABELV $833
line 1335
;1334:
;1335:	if( matches == 0 ) {
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $861
line 1336
;1336:		ADMP( "^3!setlevel:^7 no match.  use !listplayers or !listadmins to "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $863
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1338
;1337:		      "find an appropriate number to use instead of name.\n" );
;1338:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $861
line 1340
;1339:	}
;1340:	if( matches > 1 ) {
ADDRLP4 108
INDIRI4
CNSTI4 1
LEI4 $864
line 1341
;1341:		ADMP( "^3!setlevel:^7 more than one match.  Use the admin number "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $866
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1343
;1342:		      "instead:\n" );
;1343:		admin_listadmins( ent, 0, name );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 admin_listadmins
CALLI4
pop
line 1344
;1344:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $864
line 1347
;1345:	}
;1346:
;1347:	if( ent && !admin_higher_guid( ent->client->pers.guid, guid ) ) {
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $867
ADDRLP4 232
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 236
ADDRGP4 admin_higher_guid
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
NEI4 $867
line 1348
;1348:		ADMP( "^3!setlevel: ^7sorry, but your intended victim has a higher"
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $869
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1350
;1349:		      " admin level than you\n" );
;1350:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $867
line 1353
;1351:	}
;1352:
;1353:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $873
JUMPV
LABELV $870
line 1354
;1354:		if( Q_strequal( g_admin_admins[ i ]->guid, guid ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 0
NEI4 $874
line 1355
;1355:			g_admin_admins[ i ]->level = l;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 1356
;1356:			Q_strncpyz( g_admin_admins[ i ]->name, adminname,
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 116
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1358
;1357:			            sizeof( g_admin_admins[ i ]->name ) );
;1358:			updated = qtrue;
ADDRLP4 152
CNSTI4 1
ASGNI4
line 1359
;1359:		}
LABELV $874
line 1360
;1360:	}
LABELV $871
line 1353
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $873
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $876
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $870
LABELV $876
line 1361
;1361:	if( !updated ) {
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $877
line 1362
;1362:		if( i == MAX_ADMIN_ADMINS ) {
ADDRLP4 0
INDIRI4
CNSTI4 1024
NEI4 $879
line 1363
;1363:			ADMP( "^3!setlevel: ^7too many admins\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $881
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1364
;1364:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $797
JUMPV
LABELV $879
line 1366
;1365:		}
;1366:		a = BG_Alloc( sizeof( g_admin_admin_t ) );
CNSTU4 136
ARGU4
ADDRLP4 244
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 164
ADDRLP4 244
INDIRP4
ASGNP4
line 1367
;1367:		a->level = l;
ADDRLP4 164
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 1368
;1368:		Q_strncpyz( a->name, adminname, sizeof( a->name ) );
ADDRLP4 164
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 116
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1369
;1369:		Q_strncpyz( a->guid, guid, sizeof( a->guid ) );
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1370
;1370:		*a->flags = '\0';
ADDRLP4 164
INDIRP4
CNSTI4 72
ADDP4
CNSTI1 0
ASGNI1
line 1371
;1371:		g_admin_admins[ i ] = a;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
ADDRLP4 164
INDIRP4
ASGNP4
line 1372
;1372:	}
LABELV $877
line 1374
;1373:
;1374:	AP( va(
ADDRGP4 $882
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $884
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $885
JUMPV
LABELV $884
ADDRLP4 244
ADDRGP4 $439
ASGNP4
LABELV $885
ADDRLP4 244
INDIRP4
ARGP4
ADDRLP4 248
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 248
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1377
;1375:	        "print \"^3!setlevel: ^7%s^7 was given level %d admin rights by %s\n\"",
;1376:	        adminname, l, ( ent ) ? ent->client->pers.netname : "console" ) );
;1377:	if( vic && vic->client )
ADDRLP4 256
CNSTU4 0
ASGNU4
ADDRLP4 112
INDIRP4
CVPU4 4
ADDRLP4 256
INDIRU4
EQU4 $886
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 256
INDIRU4
EQU4 $886
line 1378
;1378:		vic->client->pers.adminLevel = l;
ADDRLP4 112
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
LABELV $886
line 1380
;1379:
;1380:	if( !g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $888
line 1381
;1381:		ADMP( "^3!setlevel: ^7WARNING g_admin not set, not saving admin record "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $891
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
ADDRGP4 $889
JUMPV
LABELV $888
line 1384
;1382:		      "to a file\n" );
;1383:	else
;1384:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $889
line 1385
;1385:	return qtrue;
CNSTI4 1
RETI4
LABELV $797
endproc G_admin_setlevel 260 16
proc admin_create_ban 60 36
line 1394
;1386:}
;1387:
;1388:static qboolean admin_create_ban( gentity_t *ent,
;1389:                                  char *netname,
;1390:                                  char *guid,
;1391:                                  char *ip,
;1392:                                  int seconds,
;1393:                                  char *reason )
;1394:{
line 1395
;1395:	g_admin_ban_t *b = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1400
;1396:	qtime_t qt;
;1397:	int t;
;1398:	int i;
;1399:
;1400:	t = trap_RealTime( &qt );
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 1401
;1401:	b = BG_Alloc( sizeof( g_admin_ban_t ) );
CNSTU4 212
ARGU4
ADDRLP4 52
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
ASGNP4
line 1403
;1402:
;1403:	if( !b )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $893
line 1404
;1404:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $892
JUMPV
LABELV $893
line 1406
;1405:
;1406:	Q_strncpyz( b->name, netname, sizeof( b->name ) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1407
;1407:	Q_strncpyz( b->guid, guid, sizeof( b->guid ) );
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1408
;1408:	Q_strncpyz( b->ip, ip, sizeof( b->ip ) );
ADDRLP4 4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1411
;1409:
;1410:	//strftime( b->made, sizeof( b->made ), "%m/%d/%y %H:%M:%S", lt );
;1411:	Com_sprintf( b->made, sizeof( b->made ), "%02i/%02i/%02i %02i:%02i:%02i",
ADDRLP4 4
INDIRP4
CNSTI4 155
ADDP4
ARGP4
CNSTI4 18
ARGI4
ADDRGP4 $895
ARGP4
ADDRLP4 8+16
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8+12
INDIRI4
ARGI4
ADDRLP4 8+20
INDIRI4
CNSTI4 100
MODI4
ARGI4
ADDRLP4 8+8
INDIRI4
ARGI4
ADDRLP4 8+4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1415
;1412:	             qt.tm_mon + 1, qt.tm_mday, qt.tm_year % 100,
;1413:	             qt.tm_hour, qt.tm_min, qt.tm_sec );
;1414:
;1415:	if( ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $901
line 1416
;1416:		Q_strncpyz( b->banner, ent->client->pers.netname, sizeof( b->banner ) );
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $902
JUMPV
LABELV $901
line 1418
;1417:	else
;1418:		Q_strncpyz( b->banner, "console", sizeof( b->banner ) );
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 $439
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $902
line 1419
;1419:	if( !seconds )
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $903
line 1420
;1420:		b->expires = 0;
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $904
JUMPV
LABELV $903
line 1422
;1421:	else
;1422:		b->expires = t + seconds;
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 44
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
LABELV $904
line 1423
;1423:	if( !*reason )
ADDRFP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $905
line 1424
;1424:		Q_strncpyz( b->reason, "banned by admin", sizeof( b->reason ) );
ADDRLP4 4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRGP4 $907
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $906
JUMPV
LABELV $905
line 1426
;1425:	else
;1426:		Q_strncpyz( b->reason, reason, sizeof( b->reason ) );
ADDRLP4 4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $906
line 1427
;1427:	for( i = 0; i < MAX_ADMIN_BANS && g_admin_bans[ i ]; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $911
JUMPV
LABELV $908
line 1428
;1428:		;
LABELV $909
line 1427
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $911
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $912
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $908
LABELV $912
line 1429
;1429:	if( i == MAX_ADMIN_BANS ) {
ADDRLP4 0
INDIRI4
CNSTI4 1024
NEI4 $913
line 1430
;1430:		ADMP( "^3!ban: ^7too many bans\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $915
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1431
;1431:		BG_Free( b );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 1432
;1432:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $892
JUMPV
LABELV $913
line 1434
;1433:	}
;1434:	g_admin_bans[ i ] = b;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 1435
;1435:	return qtrue;
CNSTI4 1
RETI4
LABELV $892
endproc admin_create_ban 60 36
proc admin_create_warning 60 36
line 1439
;1436:}
;1437://KK-OAX Copied create_ban to get Time Stuff Right (Didn't feel like writing code to parse it)
;1438:static qboolean admin_create_warning( gentity_t *ent, char *netname, char *guid, char *ip, int seconds, char *warning )
;1439:{
line 1440
;1440:	g_admin_warning_t *w = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1445
;1441:	qtime_t qt;
;1442:	int t;
;1443:	int i;
;1444:
;1445:	t = trap_RealTime( &qt );
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 1446
;1446:	w = BG_Alloc( sizeof( g_admin_warning_t ) );
CNSTU4 1184
ARGU4
ADDRLP4 52
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
ASGNP4
line 1448
;1447:
;1448:	if( !w )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $917
line 1449
;1449:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $917
line 1451
;1450:
;1451:	Q_strncpyz( w->name, netname, sizeof( w->name ) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1452
;1452:	Q_strncpyz( w->guid, guid, sizeof( w->guid ) );
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1453
;1453:	Q_strncpyz( w->ip, ip, sizeof( w->ip ) );
ADDRLP4 4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 40
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1456
;1454:
;1455:	//strftime( b->made, sizeof( b->made ), "%m/%d/%y %H:%M:%S", lt );
;1456:	Com_sprintf( w->made, sizeof( w->made ), "%02i/%02i/%02i %02i:%02i:%02i",
ADDRLP4 4
INDIRP4
CNSTI4 1129
ADDP4
ARGP4
CNSTI4 18
ARGI4
ADDRGP4 $895
ARGP4
ADDRLP4 8+16
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8+12
INDIRI4
ARGI4
ADDRLP4 8+20
INDIRI4
CNSTI4 100
MODI4
ARGI4
ADDRLP4 8+8
INDIRI4
ARGI4
ADDRLP4 8+4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1460
;1457:	             qt.tm_mon + 1, qt.tm_mday, qt.tm_year % 100,
;1458:	             qt.tm_hour, qt.tm_min, qt.tm_sec );
;1459:
;1460:	if( ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $924
line 1461
;1461:		Q_strncpyz( w->warner, ent->client->pers.netname, sizeof( w->warner ) );
ADDRLP4 4
INDIRP4
CNSTI4 1147
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $925
JUMPV
LABELV $924
line 1463
;1462:	else
;1463:		Q_strncpyz( w->warner, "console", sizeof( w->warner ) );
ADDRLP4 4
INDIRP4
CNSTI4 1147
ADDP4
ARGP4
ADDRGP4 $439
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $925
line 1464
;1464:	if( !seconds )
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $926
line 1465
;1465:		w->expires = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1180
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $927
JUMPV
LABELV $926
line 1467
;1466:	else
;1467:		w->expires = t + seconds;
ADDRLP4 4
INDIRP4
CNSTI4 1180
ADDP4
ADDRLP4 44
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
LABELV $927
line 1468
;1468:	if( !*warning )
ADDRFP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $928
line 1469
;1469:		Q_strncpyz( w->warning, "warned by admin", sizeof( w->warning ) );
ADDRLP4 4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRGP4 $930
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $929
JUMPV
LABELV $928
line 1471
;1470:	else
;1471:		Q_strncpyz( w->warning, warning, sizeof( w->warning ) );
ADDRLP4 4
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $929
line 1472
;1472:	for( i = 0; i < MAX_ADMIN_WARNINGS && g_admin_warnings[ i ]; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $934
JUMPV
LABELV $931
line 1473
;1473:		;
LABELV $932
line 1472
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $934
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $935
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $931
LABELV $935
line 1474
;1474:	if( i == MAX_ADMIN_WARNINGS ) {
ADDRLP4 0
INDIRI4
CNSTI4 1024
NEI4 $936
line 1475
;1475:		ADMP( "^3!warn: ^7too many warnings\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $938
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1476
;1476:		BG_Free( w );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 1477
;1477:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $936
line 1479
;1478:	}
;1479:	g_admin_warnings[ i ] = w;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 1480
;1480:	return qtrue;
CNSTI4 1
RETI4
LABELV $916
endproc admin_create_warning 60 36
export G_admin_parse_time
proc G_admin_parse_time 52 0
line 1485
;1481:}
;1482:
;1483:
;1484:int G_admin_parse_time( const char *time )
;1485:{
line 1486
;1486:	int seconds = 0, num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $941
JUMPV
LABELV $940
line 1487
;1487:	while( *time ) {
line 1488
;1488:		if( !isdigit( *time ) )
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 48
LTI4 $945
ADDRLP4 8
INDIRI4
CNSTI4 57
LEI4 $947
LABELV $945
line 1489
;1489:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $939
JUMPV
LABELV $946
line 1491
;1490:		while( isdigit( *time ) )
;1491:			num = num * 10 + *time++ - '0';
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
CNSTI4 10
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ADDI4
CNSTI4 48
SUBI4
ASGNI4
LABELV $947
line 1490
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $949
ADDRLP4 16
INDIRI4
CNSTI4 57
LEI4 $946
LABELV $949
line 1493
;1492:
;1493:		if( !*time )
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $950
line 1494
;1494:			break;
ADDRGP4 $942
JUMPV
LABELV $950
line 1495
;1495:		switch( *time++ ) {
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
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
CNSTI4 109
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $958
ADDRLP4 20
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $961
LABELV $960
ADDRLP4 40
CNSTI4 100
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $956
ADDRLP4 20
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $952
LABELV $962
ADDRLP4 20
INDIRI4
CNSTI4 104
EQI4 $957
ADDRGP4 $952
JUMPV
LABELV $961
ADDRLP4 48
CNSTI4 115
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $953
ADDRLP4 20
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $952
LABELV $963
ADDRLP4 20
INDIRI4
CNSTI4 119
EQI4 $955
ADDRGP4 $952
JUMPV
LABELV $955
line 1497
;1496:		case 'w':
;1497:			num *= 7;
ADDRLP4 0
CNSTI4 7
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
LABELV $956
line 1499
;1498:		case 'd':
;1499:			num *= 24;
ADDRLP4 0
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
LABELV $957
line 1501
;1500:		case 'h':
;1501:			num *= 60;
ADDRLP4 0
CNSTI4 60
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
LABELV $958
line 1503
;1502:		case 'm':
;1503:			num *= 60;
ADDRLP4 0
CNSTI4 60
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
line 1505
;1504:		case 's':
;1505:			break;
ADDRGP4 $953
JUMPV
LABELV $952
line 1507
;1506:		default:
;1507:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $939
JUMPV
LABELV $953
line 1509
;1508:		}
;1509:		seconds += num;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1510
;1510:		num = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1511
;1511:	}
LABELV $941
line 1487
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $940
LABELV $942
line 1512
;1512:	if( num )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $964
line 1513
;1513:		seconds += num;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
LABELV $964
line 1514
;1514:	return seconds;
ADDRLP4 4
INDIRI4
RETI4
LABELV $939
endproc G_admin_parse_time 52 0
export G_admin_kick
proc G_admin_kick 1396 24
line 1518
;1515:}
;1516:
;1517:qboolean G_admin_kick( gentity_t *ent, int skiparg )
;1518:{
line 1524
;1519:	int pids[ MAX_CLIENTS ], found;
;1520:	char name[ MAX_NAME_LENGTH ], *reason, err[ MAX_STRING_CHARS ];
;1521:	int minargc;
;1522:	gentity_t *vic;
;1523:
;1524:	minargc = 3 + skiparg;
ADDRLP4 296
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 1525
;1525:	if( G_admin_permission( ent, ADMF_UNACCOUNTABLE ) )
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 1328
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
EQI4 $967
line 1526
;1526:		minargc = 2 + skiparg;
ADDRLP4 296
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $967
line 1528
;1527:
;1528:	if( G_SayArgc() < minargc ) {
ADDRLP4 1332
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
ADDRLP4 296
INDIRI4
GEI4 $969
line 1529
;1529:		ADMP( "^3!kick: ^7usage: !kick [name] [reason]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $971
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1530
;1530:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $966
JUMPV
LABELV $969
line 1532
;1531:	}
;1532:	G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1533
;1533:	reason = G_SayConcatArgs( 2 + skiparg );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1336
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1336
INDIRP4
ASGNP4
line 1534
;1534:	if( ( found = G_ClientNumbersFromString( name, pids, MAX_CLIENTS ) ) != 1 ) {
ADDRLP4 264
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1340
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 300
ADDRLP4 1340
INDIRI4
ASGNI4
ADDRLP4 1340
INDIRI4
CNSTI4 1
EQI4 $972
line 1535
;1535:		G_MatchOnePlayer( pids, found, err, sizeof( err ) );
ADDRLP4 8
ARGP4
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 304
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 1536
;1536:		ADMP( va( "^3!kick: ^7%s\n", err ) );
ADDRGP4 $974
ARGP4
ADDRLP4 304
ARGP4
ADDRLP4 1344
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1344
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1537
;1537:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $966
JUMPV
LABELV $972
line 1539
;1538:	}
;1539:	vic = &g_entities[ pids[ 0 ] ];
ADDRLP4 4
CNSTI4 816
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1540
;1540:	if( !admin_higher( ent, vic ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1344
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1344
INDIRI4
CNSTI4 0
NEI4 $975
line 1541
;1541:		ADMP( "^3!kick: ^7sorry, but your intended victim has a higher admin"
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $977
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1543
;1542:		      " level than you\n" );
;1543:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $966
JUMPV
LABELV $975
line 1545
;1544:	}
;1545:	if( vic->client->pers.localClient ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $978
line 1546
;1546:		ADMP( "^3!kick: ^7disconnecting the host would end the game\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $980
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1547
;1547:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $966
JUMPV
LABELV $978
line 1549
;1548:	}
;1549:	admin_create_ban( ent,
ADDRGP4 $981
ARGP4
ADDRGP4 g_adminTempBan+16
ARGP4
ADDRLP4 1352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1352
INDIRP4
ARGP4
ADDRLP4 1356
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1360
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1360
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1360
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 1360
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRLP4 1356
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $985
ADDRLP4 1348
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $986
JUMPV
LABELV $985
ADDRLP4 1348
ADDRGP4 $983
ASGNP4
LABELV $986
ADDRLP4 1348
INDIRP4
ARGP4
ADDRGP4 admin_create_ban
CALLI4
pop
line 1555
;1550:	                  vic->client->pers.netname,
;1551:	                  vic->client->pers.guid,
;1552:	                  vic->client->pers.ip,
;1553:	                  G_admin_parse_time( va( "1s%s", g_adminTempBan.string ) ),
;1554:	                  ( *reason ) ? reason : "kicked by admin" );
;1555:	if( g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $987
line 1556
;1556:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $987
line 1558
;1557:
;1558:	trap_SendServerCommand( pids[ 0 ],
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $994
ADDRGP4 $991
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1372
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1364
ADDRLP4 1372
INDIRP4
ASGNP4
ADDRGP4 $995
JUMPV
LABELV $994
ADDRLP4 1364
ADDRGP4 $67
ASGNP4
LABELV $995
ADDRGP4 $990
ARGP4
ADDRLP4 1364
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $996
ADDRLP4 1368
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $997
JUMPV
LABELV $996
ADDRLP4 1368
ADDRGP4 $983
ASGNP4
LABELV $997
ADDRLP4 1368
INDIRP4
ARGP4
ADDRLP4 1376
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1376
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1563
;1559:	                        va( "disconnect \"You have been kicked.\n%s^7\nreason:\n%s\"",
;1560:	                            ( ent ) ? va( "admin:\n%s", ent->client->pers.netname ) : "",
;1561:	                            ( *reason ) ? reason : "kicked by admin" ) );
;1562:
;1563:	trap_DropClient( pids[ 0 ], va( "has been kicked%s^7. reason: %s",
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1002
ADDRGP4 $999
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1388
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1380
ADDRLP4 1388
INDIRP4
ASGNP4
ADDRGP4 $1003
JUMPV
LABELV $1002
ADDRLP4 1380
ADDRGP4 $67
ASGNP4
LABELV $1003
ADDRGP4 $998
ARGP4
ADDRLP4 1380
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1004
ADDRLP4 1384
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $1005
JUMPV
LABELV $1004
ADDRLP4 1384
ADDRGP4 $983
ASGNP4
LABELV $1005
ADDRLP4 1384
INDIRP4
ARGP4
ADDRLP4 1392
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1392
INDIRP4
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 1567
;1564:	                                ( ent ) ? va( " by %s", ent->client->pers.netname ) : "",
;1565:	                                ( *reason ) ? reason : "kicked by admin" ) );
;1566:
;1567:	return qtrue;
CNSTI4 1
RETI4
LABELV $966
endproc G_admin_kick 1396 24
export G_admin_ban
proc G_admin_ban 1284 24
line 1571
;1568:}
;1569:
;1570:qboolean G_admin_ban( gentity_t *ent, int skiparg )
;1571:{
line 1578
;1572:	int seconds;
;1573:	char search[ MAX_NAME_LENGTH ];
;1574:	char secs[ MAX_TOKEN_CHARS ];
;1575:	char *reason;
;1576:	int minargc;
;1577:	char duration[ 32 ];
;1578:	int logmatch = -1, logmatches = 0;
ADDRLP4 72
CNSTI4 -1
ASGNI4
ADDRLP4 88
CNSTI4 0
ASGNI4
line 1580
;1579:	int i, j;
;1580:	qboolean exactmatch = qfalse;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 1585
;1581:	char n2[ MAX_NAME_LENGTH ];
;1582:	char s2[ MAX_NAME_LENGTH ];
;1583:	char guid_stub[ 9 ];
;1584:
;1585:	if( G_admin_permission( ent, ADMF_CAN_PERM_BAN ) &&
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1196
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
EQI4 $1007
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 1200
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
EQI4 $1007
line 1586
;1586:	        G_admin_permission( ent, ADMF_UNACCOUNTABLE ) ) {
line 1587
;1587:		minargc = 2 + skiparg;
ADDRLP4 1192
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 1588
;1588:	}
ADDRGP4 $1008
JUMPV
LABELV $1007
line 1589
;1589:	else if( G_admin_permission( ent, ADMF_CAN_PERM_BAN ) ||
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1204
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $1013
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 1208
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1212
CNSTI4 0
ASGNI4
ADDRLP4 1208
INDIRI4
ADDRLP4 1212
INDIRI4
NEI4 $1013
ADDRGP4 g_adminMaxBan+12
INDIRI4
ADDRLP4 1212
INDIRI4
EQI4 $1009
LABELV $1013
line 1591
;1590:	         G_admin_permission( ent, ADMF_UNACCOUNTABLE ) ||
;1591:	         g_adminMaxBan.integer ) {
line 1592
;1592:		minargc = 3 + skiparg;
ADDRLP4 1192
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 1593
;1593:	}
ADDRGP4 $1010
JUMPV
LABELV $1009
line 1594
;1594:	else {
line 1595
;1595:		minargc = 4 + skiparg;
ADDRLP4 1192
ADDRFP4 4
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
line 1596
;1596:	}
LABELV $1010
LABELV $1008
line 1597
;1597:	if( G_SayArgc() < minargc ) {
ADDRLP4 1216
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
ADDRLP4 1192
INDIRI4
GEI4 $1014
line 1598
;1598:		ADMP( "^3!ban: ^7usage: !ban [name|slot|ip] [duration] [reason]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1016
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1599
;1599:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1014
line 1601
;1600:	}
;1601:	G_SayArgv( 1 + skiparg, search, sizeof( search ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 92
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1602
;1602:	G_SanitiseString( search, s2, sizeof( s2 ) );
ADDRLP4 92
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1603
;1603:	G_SayArgv( 2 + skiparg, secs, sizeof( secs ) );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 168
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1605
;1604:
;1605:	seconds = G_admin_parse_time( secs );
ADDRLP4 168
ARGP4
ADDRLP4 1220
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 1220
INDIRI4
ASGNI4
line 1606
;1606:	if( seconds <= 0 ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
GTI4 $1017
line 1607
;1607:		if( g_adminMaxBan.integer && !G_admin_permission( ent, ADMF_CAN_PERM_BAN) ) {
ADDRGP4 g_adminMaxBan+12
INDIRI4
CNSTI4 0
EQI4 $1019
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1224
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $1019
line 1608
;1608:			ADMP( va( "^3!ban: ^7using your admin level's maximum ban length of %s\n",
ADDRGP4 $1022
ARGP4
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1228
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1228
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1610
;1609:			          g_adminMaxBan.string ) );
;1610:			seconds = G_admin_parse_time( g_adminMaxBan.string );
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1232
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 1232
INDIRI4
ASGNI4
line 1611
;1611:		}
ADDRGP4 $1020
JUMPV
LABELV $1019
line 1612
;1612:		else if( G_admin_permission( ent, ADMF_CAN_PERM_BAN ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1228
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
EQI4 $1025
line 1613
;1613:			seconds = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 1614
;1614:		}
ADDRGP4 $1026
JUMPV
LABELV $1025
line 1615
;1615:		else {
line 1616
;1616:			ADMP( "^3!ban: ^7you may not issue permanent bans\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1027
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1617
;1617:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1026
LABELV $1020
line 1619
;1618:		}
;1619:		reason = G_SayConcatArgs( 2 + skiparg );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1232
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 1232
INDIRP4
ASGNP4
line 1620
;1620:	}
ADDRGP4 $1018
JUMPV
LABELV $1017
line 1621
;1621:	else {
line 1622
;1622:		if( g_adminMaxBan.integer &&
ADDRGP4 g_adminMaxBan+12
INDIRI4
CNSTI4 0
EQI4 $1028
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1224
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $1028
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1228
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
ADDRLP4 1228
INDIRI4
LEI4 $1028
line 1624
;1623:		        !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) &&
;1624:		        seconds > G_admin_parse_time( g_adminMaxBan.string ) ) {
line 1625
;1625:			ADMP( va( "^3!ban: ^7ban length limited to %s for your admin level\n",
ADDRGP4 $1032
ARGP4
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1232
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1232
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1627
;1626:			          g_adminMaxBan.string ) );
;1627:			seconds = G_admin_parse_time( g_adminMaxBan.string );
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1236
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 1236
INDIRI4
ASGNI4
line 1628
;1628:		}
LABELV $1028
line 1629
;1629:		reason = G_SayConcatArgs( 3 + skiparg );
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 1232
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 1232
INDIRP4
ASGNP4
line 1630
;1630:	}
LABELV $1018
line 1632
;1631:
;1632:	for( i = 0; i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1038
JUMPV
LABELV $1035
line 1634
;1633:		// skip players in the namelog who have already been banned
;1634:		if( g_admin_namelog[ i ]->banned )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1039
line 1635
;1635:			continue;
ADDRGP4 $1036
JUMPV
LABELV $1039
line 1638
;1636:
;1637:		// skip disconnected players when banning on slot number
;1638:		if( g_admin_namelog[ i ]->slot == -1 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1041
line 1639
;1639:			continue;
ADDRGP4 $1036
JUMPV
LABELV $1041
line 1641
;1640:
;1641:		if( Q_strequal( va( "%d", g_admin_namelog[ i ]->slot ), search ) ) {
ADDRGP4 $1045
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $1043
line 1642
;1642:			logmatches = 1;
ADDRLP4 88
CNSTI4 1
ASGNI4
line 1643
;1643:			logmatch = i;
ADDRLP4 72
ADDRLP4 4
INDIRI4
ASGNI4
line 1644
;1644:			exactmatch = qtrue;
ADDRLP4 124
CNSTI4 1
ASGNI4
line 1645
;1645:			break;
ADDRGP4 $1037
JUMPV
LABELV $1043
line 1647
;1646:		}
;1647:	}
LABELV $1036
line 1632
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1038
ADDRLP4 4
INDIRI4
CNSTI4 128
GEI4 $1046
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1035
LABELV $1046
LABELV $1037
line 1649
;1648:
;1649:	for( i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1050
JUMPV
LABELV $1047
line 1651
;1650:	        !exactmatch && i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ];
;1651:	        i++ ) {
line 1653
;1652:		// skip players in the namelog who have already been banned
;1653:		if( g_admin_namelog[ i ]->banned )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1051
line 1654
;1654:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1051
line 1656
;1655:
;1656:		if( Q_strequal( g_admin_namelog[ i ]->ip, search ) ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $1053
line 1657
;1657:			logmatches = 1;
ADDRLP4 88
CNSTI4 1
ASGNI4
line 1658
;1658:			logmatch = i;
ADDRLP4 72
ADDRLP4 4
INDIRI4
ASGNI4
line 1659
;1659:			exactmatch = qtrue;
ADDRLP4 124
CNSTI4 1
ASGNI4
line 1660
;1660:			break;
ADDRGP4 $1049
JUMPV
LABELV $1053
line 1662
;1661:		}
;1662:		for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1058
JUMPV
LABELV $1055
line 1663
;1663:		        g_admin_namelog[ i ]->name[ j ][ 0 ]; j++ ) {
line 1664
;1664:			G_SanitiseString( g_admin_namelog[ i ]->name[ j ], n2, sizeof( n2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1665
;1665:			if( strstr( n2, s2 ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 1232
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1232
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1059
line 1666
;1666:				if( logmatch != i )
ADDRLP4 72
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1061
line 1667
;1667:					logmatches++;
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1061
line 1668
;1668:				logmatch = i;
ADDRLP4 72
ADDRLP4 4
INDIRI4
ASGNI4
line 1669
;1669:			}
LABELV $1059
line 1670
;1670:		}
LABELV $1056
line 1663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1058
line 1662
ADDRLP4 1236
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 1236
INDIRI4
GEI4 $1063
ADDRLP4 0
INDIRI4
ADDRLP4 1236
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1055
LABELV $1063
line 1671
;1671:	}
LABELV $1048
line 1651
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1050
line 1650
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $1065
ADDRLP4 4
INDIRI4
CNSTI4 128
GEI4 $1065
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1047
LABELV $1065
LABELV $1049
line 1673
;1672:
;1673:	if( !logmatches ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $1066
line 1674
;1674:		ADMP( "^3!ban: ^7no player found by that name, IP, or slot number\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1068
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1675
;1675:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1066
line 1677
;1676:	}
;1677:	if( logmatches > 1 ) {
ADDRLP4 88
INDIRI4
CNSTI4 1
LEI4 $1069
line 1678
;1678:		ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 1679
;1679:		ADMBP( "^3!ban: ^7multiple recent clients match name, use IP or slot#:\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1071
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 1680
;1680:		for( i = 0; i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1075
JUMPV
LABELV $1072
line 1681
;1681:			for( j = 0; j < 8; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1076
line 1682
;1682:				guid_stub[ j ] = g_admin_namelog[ i ]->guid[ j + 24 ];
ADDRLP4 0
INDIRI4
ADDRLP4 76
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 224
ADDP4
ADDP4
INDIRI1
ASGNI1
LABELV $1077
line 1681
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1076
line 1683
;1683:			guid_stub[ j ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 76
ADDP4
CNSTI1 0
ASGNI1
line 1684
;1684:			for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1083
JUMPV
LABELV $1080
line 1685
;1685:			        g_admin_namelog[ i ]->name[ j ][ 0 ]; j++ ) {
line 1686
;1686:				G_SanitiseString( g_admin_namelog[ i ]->name[ j ], n2, sizeof( n2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 1687
;1687:				if( strstr( n2, s2 ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 1236
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1084
line 1688
;1688:					if( g_admin_namelog[ i ]->slot > -1 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $1086
line 1689
;1689:						ADMBP( "^3" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1088
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
LABELV $1086
line 1690
;1690:					ADMBP( va( "%-2s (*%s) %15s ^7'%s^7'\n",
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $1092
ADDRGP4 $1045
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 1244
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1240
ADDRLP4 1244
INDIRP4
ASGNP4
ADDRGP4 $1093
JUMPV
LABELV $1092
ADDRLP4 1240
ADDRGP4 $1090
ASGNP4
LABELV $1093
ADDRGP4 $1089
ARGP4
ADDRLP4 1240
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 1248
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1248
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 1248
INDIRP4
ADDP4
ARGP4
ADDRLP4 1252
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1252
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 1696
;1691:					           ( g_admin_namelog[ i ]->slot > -1 ) ?
;1692:					           va( "%d", g_admin_namelog[ i ]->slot ) : "-",
;1693:					           guid_stub,
;1694:					           g_admin_namelog[ i ]->ip,
;1695:					           g_admin_namelog[ i ]->name[ j ] ) );
;1696:				}
LABELV $1084
line 1697
;1697:			}
LABELV $1081
line 1685
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1083
line 1684
ADDRLP4 1240
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 1240
INDIRI4
GEI4 $1094
ADDRLP4 0
INDIRI4
ADDRLP4 1240
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1080
LABELV $1094
line 1698
;1698:		}
LABELV $1073
line 1680
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1075
ADDRLP4 4
INDIRI4
CNSTI4 128
GEI4 $1095
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1072
LABELV $1095
line 1699
;1699:		ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 1700
;1700:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1069
line 1703
;1701:	}
;1702:
;1703:	if( ent && !admin_higher_guid( ent->client->pers.guid,
ADDRLP4 1232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1232
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1096
ADDRLP4 1232
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 1236
ADDRGP4 admin_higher_guid
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 0
NEI4 $1096
line 1704
;1704:	                               g_admin_namelog[ logmatch ]->guid ) ) {
line 1706
;1705:
;1706:		ADMP( "^3!ban: ^7sorry, but your intended victim has a higher admin"
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1098
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1708
;1707:		      " level than you\n" );
;1708:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1096
line 1710
;1709:	}
;1710:	if( strequals( g_admin_namelog[ logmatch ]->ip, "localhost" ) ) {
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRGP4 $1101
ARGP4
ADDRLP4 1240
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $1099
line 1711
;1711:		ADMP( "^3!ban: ^7disconnecting the host would end the game\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1102
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1712
;1712:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1099
line 1715
;1713:	}
;1714:
;1715:	G_admin_duration( ( seconds ) ? seconds : -1,
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $1104
ADDRLP4 1244
ADDRLP4 132
INDIRI4
ASGNI4
ADDRGP4 $1105
JUMPV
LABELV $1104
ADDRLP4 1244
CNSTI4 -1
ASGNI4
LABELV $1105
ADDRLP4 1244
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 1718
;1716:	                  duration, sizeof( duration ) );
;1717:
;1718:	admin_create_ban( ent,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1248
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1248
INDIRP4
ARGP4
ADDRLP4 1248
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 1248
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 admin_create_ban
CALLI4
pop
line 1724
;1719:	                  g_admin_namelog[ logmatch ]->name[ 0 ],
;1720:	                  g_admin_namelog[ logmatch ]->guid,
;1721:	                  g_admin_namelog[ logmatch ]->ip,
;1722:	                  seconds, reason );
;1723:
;1724:	g_admin_namelog[ logmatch ]->banned = qtrue;
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 240
ADDP4
CNSTI4 1
ASGNI4
line 1726
;1725:
;1726:	if( !g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1106
line 1727
;1727:		ADMP( "^3!ban: ^7WARNING g_admin not set, not saving ban to a file\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1109
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
ADDRGP4 $1107
JUMPV
LABELV $1106
line 1728
;1728:	else if(strlen(g_admin_namelog[ logmatch ]->guid)==0 || strlen(g_admin_namelog[ logmatch ]->ip) )
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 1252
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
EQI4 $1112
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 1256
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1256
INDIRI4
CNSTI4 0
EQI4 $1110
LABELV $1112
line 1729
;1729:		ADMP( "^3!ban: ^7WARNING bot or without GUID or IP cannot write to ban file\n");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1113
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
ADDRGP4 $1111
JUMPV
LABELV $1110
line 1731
;1730:	else
;1731:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $1111
LABELV $1107
line 1733
;1732:
;1733:	if( g_admin_namelog[ logmatch ]->slot == -1 ) {
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1114
line 1735
;1734:		// client is already disconnected so stop here
;1735:		AP( va( "print \"^3!ban:^7 %s^7 has been banned by %s^7, "
ADDRGP4 $1116
ARGP4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1119
ADDRLP4 1260
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1120
JUMPV
LABELV $1119
ADDRLP4 1260
ADDRGP4 $439
ASGNP4
LABELV $1120
ADDRLP4 1260
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1121
ADDRLP4 1264
ADDRLP4 128
INDIRP4
ASGNP4
ADDRGP4 $1122
JUMPV
LABELV $1121
ADDRLP4 1264
ADDRGP4 $907
ASGNP4
LABELV $1122
ADDRLP4 1264
INDIRP4
ARGP4
ADDRLP4 1268
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1268
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1741
;1736:		        "duration: %s, reason: %s\n\"",
;1737:		        g_admin_namelog[ logmatch ]->name[ 0 ],
;1738:		        ( ent ) ? ent->client->pers.netname : "console",
;1739:		        duration,
;1740:		        ( *reason ) ? reason : "banned by admin" ) );
;1741:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1006
JUMPV
LABELV $1114
line 1744
;1742:	}
;1743:
;1744:	trap_SendServerCommand( g_admin_namelog[ logmatch ]->slot,
ADDRGP4 $1123
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1126
ADDRLP4 1260
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1127
JUMPV
LABELV $1126
ADDRLP4 1260
ADDRGP4 $439
ASGNP4
LABELV $1127
ADDRLP4 1260
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1128
ADDRLP4 1264
ADDRLP4 128
INDIRP4
ASGNP4
ADDRGP4 $1129
JUMPV
LABELV $1128
ADDRLP4 1264
ADDRGP4 $907
ASGNP4
LABELV $1129
ADDRLP4 1264
INDIRP4
ARGP4
ADDRLP4 1268
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 1268
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1751
;1745:	                        va( "disconnect \"You have been banned.\n"
;1746:	                            "admin:\n%s^7\nduration:\n%s\nreason:\n%s\"",
;1747:	                            ( ent ) ? ent->client->pers.netname : "console",
;1748:	                            duration,
;1749:	                            ( *reason ) ? reason : "banned by admin" ) );
;1750:
;1751:	trap_DropClient(  g_admin_namelog[ logmatch ]->slot,
ADDRGP4 $1130
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1133
ADDRLP4 1272
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1134
JUMPV
LABELV $1133
ADDRLP4 1272
ADDRGP4 $439
ASGNP4
LABELV $1134
ADDRLP4 1272
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1135
ADDRLP4 1276
ADDRLP4 128
INDIRP4
ASGNP4
ADDRGP4 $1136
JUMPV
LABELV $1135
ADDRLP4 1276
ADDRGP4 $907
ASGNP4
LABELV $1136
ADDRLP4 1276
INDIRP4
ARGP4
ADDRLP4 1280
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 1280
INDIRP4
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 1756
;1752:	                  va( "has been banned by %s^7, duration: %s, reason: %s",
;1753:	                      ( ent ) ? ent->client->pers.netname : "console",
;1754:	                      duration,
;1755:	                      ( *reason ) ? reason : "banned by admin" ) );
;1756:	return qtrue;
CNSTI4 1
RETI4
LABELV $1006
endproc G_admin_ban 1284 24
export G_admin_unban
proc G_admin_unban 56 16
line 1760
;1757:}
;1758:
;1759:qboolean G_admin_unban( gentity_t *ent, int skiparg )
;1760:{
line 1762
;1761:	int bnum;
;1762:	int time = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 16
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 1765
;1763:	char bs[ 5 ];
;1764:
;1765:	if( G_SayArgc() < 2 + skiparg ) {
ADDRLP4 20
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1138
line 1766
;1766:		ADMP( "^3!unban: ^7usage: !unban [ban#]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1140
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1767
;1767:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1137
JUMPV
LABELV $1138
line 1769
;1768:	}
;1769:	G_SayArgv( 1 + skiparg, bs, sizeof( bs ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1770
;1770:	bnum = atoi( bs );
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 1771
;1771:	if( bnum < 1 || bnum > MAX_ADMIN_BANS || !g_admin_bans[ bnum - 1 ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1145
ADDRLP4 0
INDIRI4
CNSTI4 1024
GTI4 $1145
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1141
LABELV $1145
line 1772
;1772:		ADMP( "^3!unban: ^7invalid ban#\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1146
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1773
;1773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1137
JUMPV
LABELV $1141
line 1775
;1774:	}
;1775:	if( g_admin_bans[ bnum - 1 ]->expires == 0 &&
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1147
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 32
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $1147
line 1776
;1776:	        !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) ) {
line 1777
;1777:		ADMP( "^3!unban: ^7you cannot remove permanent bans\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1150
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1778
;1778:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1137
JUMPV
LABELV $1147
line 1780
;1779:	}
;1780:	if( g_adminMaxBan.integer &&
ADDRGP4 g_adminMaxBan+12
INDIRI4
CNSTI4 0
EQI4 $1151
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 36
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1151
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 40
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ADDRLP4 40
INDIRI4
LEI4 $1151
line 1782
;1781:	        !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) &&
;1782:	        g_admin_bans[ bnum - 1 ]->expires - time > G_admin_parse_time( g_adminMaxBan.string ) ) {
line 1783
;1783:		ADMP( va( "^3!unban: ^7your admin level cannot remove bans longer than %s\n",
ADDRGP4 $1156
ARGP4
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1785
;1784:		          g_adminMaxBan.string ) );
;1785:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1137
JUMPV
LABELV $1151
line 1787
;1786:	}
;1787:	g_admin_bans[ bnum - 1 ]->expires = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1788
;1788:	AP( va( "print \"^3!unban: ^7ban #%d for %s^7 has been removed by %s\n\"",
ADDRGP4 $1159
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1162
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1163
JUMPV
LABELV $1162
ADDRLP4 44
ADDRGP4 $439
ASGNP4
LABELV $1163
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1792
;1789:	        bnum,
;1790:	        g_admin_bans[ bnum - 1 ]->name,
;1791:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;1792:	if( g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1164
line 1793
;1793:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $1164
line 1794
;1794:	return qtrue;
CNSTI4 1
RETI4
LABELV $1137
endproc G_admin_unban 56 16
lit
align 1
LABELV $1168
byte 1 0
skip 31
export G_admin_adjustban
code
proc G_admin_adjustban 1156 36
line 1798
;1795:}
;1796:
;1797:qboolean G_admin_adjustban( gentity_t *ent, int skiparg )
;1798:{
line 1802
;1799:	int bnum;
;1800:	int length;
;1801:	int expires;
;1802:	int time = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 1088
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1088
INDIRI4
ASGNI4
line 1803
;1803:	char duration[ 32 ] = {""};
ADDRLP4 1045
ADDRGP4 $1168
INDIRB
ASGNB 32
line 1807
;1804:	char *reason;
;1805:	char bs[ 5 ];
;1806:	char secs[ MAX_TOKEN_CHARS ];
;1807:	char mode = '\0';
ADDRLP4 1044
CNSTI1 0
ASGNI1
line 1810
;1808:	g_admin_ban_t *ban;
;1809:
;1810:	if( G_SayArgc() < 3 + skiparg ) {
ADDRLP4 1092
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
GEI4 $1169
line 1811
;1811:		ADMP( "^3!adjustban: ^7usage: !adjustban [ban#] [duration] [reason]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1171
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1812
;1812:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1169
line 1814
;1813:	}
;1814:	G_SayArgv( 1 + skiparg, bs, sizeof( bs ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1077
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1815
;1815:	bnum = atoi( bs );
ADDRLP4 1077
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1096
INDIRI4
ASGNI4
line 1816
;1816:	if( bnum < 1 || bnum > MAX_ADMIN_BANS || !g_admin_bans[ bnum - 1 ] ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $1176
ADDRLP4 4
INDIRI4
CNSTI4 1024
GTI4 $1176
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1172
LABELV $1176
line 1817
;1817:		ADMP( "^3!adjustban: ^7invalid ban#\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1177
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1818
;1818:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1172
line 1820
;1819:	}
;1820:	ban = g_admin_bans[ bnum - 1 ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans-4
ADDP4
INDIRP4
ASGNP4
line 1821
;1821:	if( ban->expires == 0 && !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1179
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1104
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $1179
line 1822
;1822:		ADMP( "^3!adjustban: ^7you cannot modify permanent bans\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1181
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1823
;1823:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1179
line 1825
;1824:	}
;1825:	if( g_adminMaxBan.integer &&
ADDRGP4 g_adminMaxBan+12
INDIRI4
CNSTI4 0
EQI4 $1182
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1108
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $1182
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1112
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 1040
INDIRI4
SUBI4
ADDRLP4 1112
INDIRI4
LEI4 $1182
line 1827
;1826:	        !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) &&
;1827:	        ban->expires - time > G_admin_parse_time( g_adminMaxBan.string ) ) {
line 1828
;1828:		ADMP( va( "^3!adjustban: ^7your admin level cannot modify bans longer than %s\n",
ADDRGP4 $1186
ARGP4
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1830
;1829:		          g_adminMaxBan.string ) );
;1830:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1182
line 1832
;1831:	}
;1832:	G_SayArgv( 2 + skiparg, secs, sizeof( secs ) );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1833
;1833:	if( secs[ 0 ] == '+' || secs[ 0 ] == '-' )
ADDRLP4 1116
ADDRLP4 12
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 43
EQI4 $1190
ADDRLP4 1116
INDIRI4
CNSTI4 45
NEI4 $1188
LABELV $1190
line 1834
;1834:		mode = secs[ 0 ];
ADDRLP4 1044
ADDRLP4 12
INDIRI1
ASGNI1
LABELV $1188
line 1835
;1835:	length = G_admin_parse_time( &secs[ mode ? 1 : 0 ] );
ADDRLP4 1044
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1192
ADDRLP4 1120
CNSTI4 1
ASGNI4
ADDRGP4 $1193
JUMPV
LABELV $1192
ADDRLP4 1120
CNSTI4 0
ASGNI4
LABELV $1193
ADDRLP4 1120
INDIRI4
ADDRLP4 12
ADDP4
ARGP4
ADDRLP4 1124
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1124
INDIRI4
ASGNI4
line 1836
;1836:	if( length < 0 )
ADDRLP4 1036
INDIRI4
CNSTI4 0
GEI4 $1194
line 1837
;1837:		skiparg--;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1195
JUMPV
LABELV $1194
line 1838
;1838:	else {
line 1839
;1839:		if( length ) {
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1196
line 1840
;1840:			if( ban->expires == 0 && mode ) {
ADDRLP4 1128
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 1128
INDIRI4
NEI4 $1198
ADDRLP4 1044
INDIRI1
CVII4 1
ADDRLP4 1128
INDIRI4
EQI4 $1198
line 1841
;1841:				ADMP( "^3!adjustban: ^7new duration must be explicit\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1200
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1842
;1842:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1198
line 1844
;1843:			}
;1844:			if( mode == '+' )
ADDRLP4 1044
INDIRI1
CVII4 1
CNSTI4 43
NEI4 $1201
line 1845
;1845:				expires = ban->expires + length;
ADDRLP4 1084
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $1202
JUMPV
LABELV $1201
line 1846
;1846:			else if( mode == '-' )
ADDRLP4 1044
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $1203
line 1847
;1847:				expires = ban->expires - length;
ADDRLP4 1084
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 1036
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $1204
JUMPV
LABELV $1203
line 1849
;1848:			else
;1849:				expires = time + length;
ADDRLP4 1084
ADDRLP4 1040
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
ASGNI4
LABELV $1204
LABELV $1202
line 1850
;1850:			if( expires <= time ) {
ADDRLP4 1084
INDIRI4
ADDRLP4 1040
INDIRI4
GTI4 $1205
line 1851
;1851:				ADMP( "^3!adjustban: ^7ban duration must be positive\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1207
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1852
;1852:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1205
line 1854
;1853:			}
;1854:			if( g_adminMaxBan.integer &&
ADDRGP4 g_adminMaxBan+12
INDIRI4
CNSTI4 0
EQI4 $1197
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1132
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $1197
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1136
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
ADDRLP4 1040
INDIRI4
SUBI4
ADDRLP4 1136
INDIRI4
LEI4 $1197
line 1856
;1855:			        !G_admin_permission( ent, ADMF_CAN_PERM_BAN ) &&
;1856:			        expires - time > G_admin_parse_time( g_adminMaxBan.string ) ) {
line 1857
;1857:				ADMP( va( "^3!adjustban: ^7ban length is limited to %s for your admin level\n",
ADDRGP4 $1212
ARGP4
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1859
;1858:				          g_adminMaxBan.string ) );
;1859:				length = G_admin_parse_time( g_adminMaxBan.string );
ADDRGP4 g_adminMaxBan+16
ARGP4
ADDRLP4 1144
ADDRGP4 G_admin_parse_time
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1144
INDIRI4
ASGNI4
line 1860
;1860:				expires = time + length;
ADDRLP4 1084
ADDRLP4 1040
INDIRI4
ADDRLP4 1036
INDIRI4
ADDI4
ASGNI4
line 1861
;1861:			}
line 1862
;1862:		}
ADDRGP4 $1197
JUMPV
LABELV $1196
line 1863
;1863:		else if( G_admin_permission( ent, ADMF_CAN_PERM_BAN ) )
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 1128
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
EQI4 $1215
line 1864
;1864:			expires = 0;
ADDRLP4 1084
CNSTI4 0
ASGNI4
ADDRGP4 $1216
JUMPV
LABELV $1215
line 1865
;1865:		else {
line 1866
;1866:			ADMP( "^3!adjustban: ^7ban duration must be positive\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1207
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1867
;1867:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1167
JUMPV
LABELV $1216
LABELV $1197
line 1870
;1868:		}
;1869:
;1870:		ban->expires = expires;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1871
;1871:		G_admin_duration( ( expires ) ? expires - time : -1, duration,
ADDRLP4 1084
INDIRI4
CNSTI4 0
EQI4 $1218
ADDRLP4 1132
ADDRLP4 1084
INDIRI4
ADDRLP4 1040
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $1219
JUMPV
LABELV $1218
ADDRLP4 1132
CNSTI4 -1
ASGNI4
LABELV $1219
ADDRLP4 1132
INDIRI4
ARGI4
ADDRLP4 1045
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 1873
;1872:		                  sizeof( duration ) );
;1873:	}
LABELV $1195
line 1874
;1874:	reason = G_SayConcatArgs( 3 + skiparg );
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 1128
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1128
INDIRP4
ASGNP4
line 1875
;1875:	if( *reason )
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1220
line 1876
;1876:		Q_strncpyz( ban->reason, reason, sizeof( ban->reason ) );
ADDRLP4 0
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $1220
line 1877
;1877:	AP( va( "print \"^3!adjustban: ^7ban #%d for %s^7 has been updated by %s^7 "
ADDRGP4 $1222
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1230
ADDRLP4 1132
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1231
JUMPV
LABELV $1230
ADDRLP4 1132
ADDRGP4 $439
ASGNP4
LABELV $1231
ADDRLP4 1132
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
CNSTI4 0
LTI4 $1232
ADDRLP4 1136
ADDRGP4 $1224
ASGNP4
ADDRGP4 $1233
JUMPV
LABELV $1232
ADDRLP4 1136
ADDRGP4 $67
ASGNP4
LABELV $1233
ADDRLP4 1136
INDIRP4
ARGP4
ADDRLP4 1045
ARGP4
ADDRLP4 1148
CNSTI4 0
ASGNI4
ADDRLP4 1036
INDIRI4
ADDRLP4 1148
INDIRI4
LTI4 $1234
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 1148
INDIRI4
EQI4 $1234
ADDRLP4 1140
ADDRGP4 $1226
ASGNP4
ADDRGP4 $1235
JUMPV
LABELV $1234
ADDRLP4 1140
ADDRGP4 $67
ASGNP4
LABELV $1235
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1236
ADDRLP4 1144
ADDRGP4 $1228
ASGNP4
ADDRGP4 $1237
JUMPV
LABELV $1236
ADDRLP4 1144
ADDRGP4 $67
ASGNP4
LABELV $1237
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1152
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1152
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1887
;1878:	        "%s%s%s%s%s\n\"",
;1879:	        bnum,
;1880:	        ban->name,
;1881:	        ( ent ) ? ent->client->pers.netname : "console",
;1882:	        ( length >= 0 ) ? "duration: " : "",
;1883:	        duration,
;1884:	        ( length >= 0 && *reason ) ? ", " : "",
;1885:	        ( *reason ) ? "reason: " : "",
;1886:	        reason ) );
;1887:	if( ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1238
line 1888
;1888:		Q_strncpyz( ban->banner, ent->client->pers.netname, sizeof( ban->banner ) );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $1238
line 1889
;1889:	if( g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1240
line 1890
;1890:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $1240
line 1891
;1891:	return qtrue;
CNSTI4 1
RETI4
LABELV $1167
endproc G_admin_adjustban 1156 36
export G_admin_putteam
proc G_admin_putteam 1384 16
line 1895
;1892:}
;1893:
;1894:qboolean G_admin_putteam( gentity_t *ent, int skiparg )
;1895:{
line 1900
;1896:	int pids[ MAX_CLIENTS ], found;
;1897:	//KK-OAPub Changed Team Name Length so "Spectator" doesn't crash Game
;1898:	char name[ MAX_NAME_LENGTH ], team[ MAX_NAME_LENGTH ], err[ MAX_STRING_CHARS ];
;1899:	gentity_t *vic;
;1900:	team_t teamnum = TEAM_NONE;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 1902
;1901:
;1902:	G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1903
;1903:	G_SayArgv( 2 + skiparg, team, sizeof( team ) );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1904
;1904:	if( G_SayArgc() < 3 + skiparg ) {
ADDRLP4 1356
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1356
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
GEI4 $1244
line 1905
;1905:		ADMP( "^3!putteam: ^7usage: !putteam [name] [h|a|s]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1246
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1906
;1906:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1243
JUMPV
LABELV $1244
line 1909
;1907:	}
;1908:
;1909:	if( ( found = G_ClientNumbersFromString( name, pids, MAX_CLIENTS ) ) != 1 ) {
ADDRLP4 296
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1360
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 328
ADDRLP4 1360
INDIRI4
ASGNI4
ADDRLP4 1360
INDIRI4
CNSTI4 1
EQI4 $1247
line 1910
;1910:		G_MatchOnePlayer( pids, found, err, sizeof( err ) );
ADDRLP4 40
ARGP4
ADDRLP4 328
INDIRI4
ARGI4
ADDRLP4 332
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 1911
;1911:		ADMP( va( "^3!putteam: ^7%s\n", err ) );
ADDRGP4 $1249
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 1364
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1364
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1912
;1912:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1243
JUMPV
LABELV $1247
line 1914
;1913:	}
;1914:	if( !admin_higher( ent, &g_entities[ pids[ 0 ] ] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 816
ADDRLP4 40
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 1364
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1364
INDIRI4
CNSTI4 0
NEI4 $1250
line 1915
;1915:		ADMP( "^3!putteam: ^7sorry, but your intended victim has a higher "
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1252
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1917
;1916:		      " admin level than you\n" );
;1917:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1243
JUMPV
LABELV $1250
line 1919
;1918:	}
;1919:	vic = &g_entities[ pids[ 0 ] ];
ADDRLP4 36
CNSTI4 816
ADDRLP4 40
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1920
;1920:	teamnum = G_TeamFromString( team );
ADDRLP4 4
ARGP4
ADDRLP4 1368
ADDRGP4 G_TeamFromString
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1368
INDIRI4
ASGNI4
line 1921
;1921:	if( teamnum == TEAM_NUM_TEAMS ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1253
line 1922
;1922:		ADMP( va( "^3!putteam: ^7unknown team %s\n", team ) );
ADDRGP4 $1255
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1372
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1372
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1923
;1923:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1243
JUMPV
LABELV $1253
line 1925
;1924:	}
;1925:	if( vic->client->sess.sessionTeam == teamnum )
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1256
line 1926
;1926:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1243
JUMPV
LABELV $1256
line 1928
;1927:
;1928:	SetTeam( vic, team );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 1930
;1929:
;1930:	AP( va( "print \"^3!putteam: ^7%s^7 put %s^7 on to the %s team\n\"",
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1376
ADDRGP4 BG_TeamName
CALLP4
ASGNP4
ADDRGP4 $1258
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1260
ADDRLP4 1372
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1261
JUMPV
LABELV $1260
ADDRLP4 1372
ADDRGP4 $439
ASGNP4
LABELV $1261
ADDRLP4 1372
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1376
INDIRP4
ARGP4
ADDRLP4 1380
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1380
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1933
;1931:	        ( ent ) ? ent->client->pers.netname : "console",
;1932:	        vic->client->pers.netname, BG_TeamName( teamnum ) ) );
;1933:	return qtrue;
CNSTI4 1
RETI4
LABELV $1243
endproc G_admin_putteam 1384 16
export G_admin_map
proc G_admin_map 88 12
line 1939
;1934:}
;1935:
;1936://KK-Fixed!!!!
;1937://KK-Removed Layouts from The command
;1938:qboolean G_admin_map( gentity_t *ent, int skiparg )
;1939:{
line 1942
;1940:	char map[ MAX_QPATH ];
;1941:
;1942:	if( G_SayArgc( ) < 2 + skiparg ) {
ADDRLP4 64
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1263
line 1943
;1943:		ADMP( "^3!map: ^7usage: !map [map] (layout)\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1265
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1944
;1944:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1262
JUMPV
LABELV $1263
line 1947
;1945:	}
;1946:
;1947:	G_SayArgv( skiparg + 1, map, sizeof( map ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1949
;1948:
;1949:	if( !trap_FS_FOpenFile( va( "maps/%s.bsp", map ), NULL, FS_READ ) ) {
ADDRGP4 $1268
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $1266
line 1950
;1950:		ADMP( va( "^3!map: ^7invalid map name '%s'\n", map ) );
ADDRGP4 $1269
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1951
;1951:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1262
JUMPV
LABELV $1266
line 1954
;1952:	}
;1953:
;1954:	trap_SendConsoleCommand( EXEC_APPEND, va( "map %s", map ) );
ADDRGP4 $1270
ARGP4
ADDRLP4 0
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
line 1955
;1955:	level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1956
;1956:	AP( va( "print \"^3!map: ^7map '%s' started by %s\n\"", map,
ADDRGP4 $1272
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1274
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1275
JUMPV
LABELV $1274
ADDRLP4 80
ADDRGP4 $439
ASGNP4
LABELV $1275
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1958
;1957:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;1958:	return qtrue;
CNSTI4 1
RETI4
LABELV $1262
endproc G_admin_map 88 12
export G_admin_mute
proc G_admin_mute 1368 16
line 1962
;1959:}
;1960:
;1961:qboolean G_admin_mute( gentity_t *ent, int skiparg )
;1962:{
line 1968
;1963:	int pids[ MAX_CLIENTS ], found;
;1964:	char name[ MAX_NAME_LENGTH ], err[ MAX_STRING_CHARS ];
;1965:	char command[ MAX_ADMIN_CMD_LEN ], *cmd;
;1966:	gentity_t *vic;
;1967:
;1968:	G_SayArgv( skiparg, command, sizeof( command ) );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1969
;1969:	cmd = command;
ADDRLP4 0
ADDRLP4 296
ASGNP4
line 1970
;1970:	if( *cmd == '!' )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 33
NEI4 $1277
line 1971
;1971:		cmd++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1277
line 1972
;1972:	if( G_SayArgc() < 2 + skiparg ) {
ADDRLP4 1344
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1344
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1279
line 1973
;1973:		ADMP( va( "^3!%s: ^7usage: !%s [name|slot#]\n", cmd, cmd ) );
ADDRGP4 $1281
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1352
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1352
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1974
;1974:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1279
line 1976
;1975:	}
;1976:	G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 1977
;1977:	if( ( found = G_ClientNumbersFromString( name, pids, MAX_CLIENTS ) ) != 1 ) {
ADDRLP4 264
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1348
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 1348
INDIRI4
ASGNI4
ADDRLP4 1348
INDIRI4
CNSTI4 1
EQI4 $1282
line 1978
;1978:		G_MatchOnePlayer( pids, found, err, sizeof( err ) );
ADDRLP4 4
ARGP4
ADDRLP4 316
INDIRI4
ARGI4
ADDRLP4 320
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 1979
;1979:		ADMP( va( "^3!%s: ^7%s\n", cmd, err ) );
ADDRGP4 $1284
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 320
ARGP4
ADDRLP4 1352
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1352
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1980
;1980:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1282
line 1982
;1981:	}
;1982:	if( !admin_higher( ent, &g_entities[ pids[ 0 ] ] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 1352
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1352
INDIRI4
CNSTI4 0
NEI4 $1285
line 1983
;1983:		ADMP( va( "^3!%s: ^7sorry, but your intended victim has a higher admin"
ADDRGP4 $1287
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1356
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1356
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1985
;1984:		          " level than you\n", cmd ) );
;1985:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1285
line 1987
;1986:	}
;1987:	vic = &g_entities[ pids[ 0 ] ];
ADDRLP4 260
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1988
;1988:	if( vic->client->pers.muted == qtrue ) {
ADDRLP4 260
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1288
line 1989
;1989:		if( Q_strequal( cmd, "mute" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $104
ARGP4
ADDRLP4 1356
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1356
INDIRI4
CNSTI4 0
NEI4 $1290
line 1990
;1990:			ADMP( "^3!mute: ^7player is already muted\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 1991
;1991:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1290
line 1993
;1992:		}
;1993:		vic->client->pers.muted = qfalse;
ADDRLP4 260
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 1994
;1994:		CPx( pids[ 0 ], "cp \"^1You have been unmuted\"" );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $1293
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1995
;1995:		AP( va( "print \"^3!unmute: ^7%s^7 has been unmuted by %s\n\"",
ADDRGP4 $1294
ARGP4
ADDRLP4 260
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1296
ADDRLP4 1360
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1297
JUMPV
LABELV $1296
ADDRLP4 1360
ADDRGP4 $439
ASGNP4
LABELV $1297
ADDRLP4 1360
INDIRP4
ARGP4
ADDRLP4 1364
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1364
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1998
;1996:		        vic->client->pers.netname,
;1997:		        ( ent ) ? ent->client->pers.netname : "console" ) );
;1998:	}
ADDRGP4 $1289
JUMPV
LABELV $1288
line 1999
;1999:	else {
line 2000
;2000:		if( Q_strequal( cmd, "unmute" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $157
ARGP4
ADDRLP4 1356
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1356
INDIRI4
CNSTI4 0
NEI4 $1298
line 2001
;2001:			ADMP( "^3!unmute: ^7player is not currently muted\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1300
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2002
;2002:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1276
JUMPV
LABELV $1298
line 2004
;2003:		}
;2004:		vic->client->pers.muted = qtrue;
ADDRLP4 260
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 1
ASGNI4
line 2005
;2005:		CPx( pids[ 0 ], "cp \"^1You've been muted\"" );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $1301
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2006
;2006:		AP( va( "print \"^3!mute: ^7%s^7 has been muted by ^7%s\n\"",
ADDRGP4 $1302
ARGP4
ADDRLP4 260
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1304
ADDRLP4 1360
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1305
JUMPV
LABELV $1304
ADDRLP4 1360
ADDRGP4 $439
ASGNP4
LABELV $1305
ADDRLP4 1360
INDIRP4
ARGP4
ADDRLP4 1364
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1364
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2009
;2007:		        vic->client->pers.netname,
;2008:		        ( ent ) ? ent->client->pers.netname : "console" ) );
;2009:	}
LABELV $1289
line 2010
;2010:	return qtrue;
CNSTI4 1
RETI4
LABELV $1276
endproc G_admin_mute 1368 16
lit
align 1
LABELV $1307
byte 1 0
skip 31
align 1
LABELV $1308
byte 1 0
skip 31
export G_admin_listadmins
code
proc G_admin_listadmins 116 16
line 2016
;2011:}
;2012:
;2013:
;2014:
;2015:qboolean G_admin_listadmins( gentity_t *ent, int skiparg )
;2016:{
line 2017
;2017:	int i, found = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 2018
;2018:	char search[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 48
ADDRGP4 $1307
INDIRB
ASGNB 32
line 2019
;2019:	char s[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 4
ADDRGP4 $1308
INDIRB
ASGNB 32
line 2020
;2020:	int start = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 2021
;2021:	qboolean numeric = qtrue;
ADDRLP4 44
CNSTI4 1
ASGNI4
line 2022
;2022:	int drawn = 0;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 2024
;2023:
;2024:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1312
JUMPV
LABELV $1309
line 2025
;2025:		if( g_admin_admins[ i ]->level == 0 )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1313
line 2026
;2026:			continue;
ADDRGP4 $1310
JUMPV
LABELV $1313
line 2027
;2027:		found++;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2028
;2028:	}
LABELV $1310
line 2024
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1312
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1315
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1309
LABELV $1315
line 2029
;2029:	if( !found ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1316
line 2030
;2030:		ADMP( "^3!listadmins: ^7no admins defined\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1318
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2031
;2031:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1306
JUMPV
LABELV $1316
line 2034
;2032:	}
;2033:
;2034:	if( G_SayArgc() == 2 + skiparg ) {
ADDRLP4 88
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
NEI4 $1319
line 2035
;2035:		G_SayArgv( 1 + skiparg, s, sizeof( s ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2036
;2036:		for( i = 0; i < sizeof( s ) && s[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1324
JUMPV
LABELV $1321
line 2037
;2037:			if( isdigit( s[ i ] ) )
ADDRLP4 92
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 48
LTI4 $1325
ADDRLP4 92
INDIRI4
CNSTI4 57
GTI4 $1325
line 2038
;2038:				continue;
ADDRGP4 $1322
JUMPV
LABELV $1325
line 2039
;2039:			numeric = qfalse;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 2040
;2040:		}
LABELV $1322
line 2036
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1324
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32
GEU4 $1327
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1321
LABELV $1327
line 2041
;2041:		if( numeric ) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1328
line 2042
;2042:			start = atoi( s );
ADDRLP4 4
ARGP4
ADDRLP4 96
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 96
INDIRI4
ASGNI4
line 2043
;2043:			if( start > 0 )
ADDRLP4 40
INDIRI4
CNSTI4 0
LEI4 $1330
line 2044
;2044:				start -= 1;
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1329
JUMPV
LABELV $1330
line 2045
;2045:			else if( start < 0 )
ADDRLP4 40
INDIRI4
CNSTI4 0
GEI4 $1329
line 2046
;2046:				start = found + start;
ADDRLP4 40
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ASGNI4
line 2047
;2047:		}
ADDRGP4 $1329
JUMPV
LABELV $1328
line 2049
;2048:		else
;2049:			G_SanitiseString( s, search, sizeof( search ) );
ADDRLP4 4
ARGP4
ADDRLP4 48
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
LABELV $1329
line 2050
;2050:	}
LABELV $1319
line 2052
;2051:
;2052:	if( start >= found || start < 0 )
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
GEI4 $1336
ADDRLP4 40
INDIRI4
CNSTI4 0
GEI4 $1334
LABELV $1336
line 2053
;2053:		start = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
LABELV $1334
line 2055
;2054:
;2055:	if( start >= found ) {
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $1337
line 2056
;2056:		ADMP( va( "^3!listadmins: ^7listing %d admins\n", found ) );
ADDRGP4 $1339
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2057
;2057:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1306
JUMPV
LABELV $1337
line 2060
;2058:	}
;2059:
;2060:	drawn = admin_listadmins( ent, start, search );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 96
ADDRGP4 admin_listadmins
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 96
INDIRI4
ASGNI4
line 2062
;2061:
;2062:	if( search[ 0 ] ) {
ADDRLP4 48
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1340
line 2063
;2063:		ADMP( va( "^3!listadmins:^7 found %d admins matching '%s^7'\n",
ADDRGP4 $1342
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2065
;2064:		          drawn, search ) );
;2065:	}
ADDRGP4 $1341
JUMPV
LABELV $1340
line 2066
;2066:	else {
line 2067
;2067:		ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2068
;2068:		ADMBP( va( "^3!listadmins:^7 showing admin %d - %d of %d.  ",
ADDRGP4 $1343
ARGP4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1346
ADDRLP4 100
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1347
JUMPV
LABELV $1346
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $1347
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 20
ADDI4
ADDRLP4 36
INDIRI4
LEI4 $1348
ADDRLP4 104
ADDRLP4 36
INDIRI4
ASGNI4
ADDRGP4 $1349
JUMPV
LABELV $1348
ADDRLP4 104
ADDRLP4 40
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
LABELV $1349
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2073
;2069:		           ( found ) ? ( start + 1 ) : 0,
;2070:		           ( ( start + MAX_ADMIN_LISTITEMS ) > found ) ?
;2071:		           found : ( start + MAX_ADMIN_LISTITEMS ),
;2072:		           found ) );
;2073:		if( ( start + MAX_ADMIN_LISTITEMS ) < found ) {
ADDRLP4 40
INDIRI4
CNSTI4 20
ADDI4
ADDRLP4 36
INDIRI4
GEI4 $1350
line 2074
;2074:			ADMBP( va( "run '!listadmins %d' to see more",
ADDRGP4 $1352
ARGP4
ADDRLP4 40
INDIRI4
CNSTI4 20
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2076
;2075:			           ( start + MAX_ADMIN_LISTITEMS + 1 ) ) );
;2076:		}
LABELV $1350
line 2077
;2077:		ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2078
;2078:		ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2079
;2079:	}
LABELV $1341
line 2080
;2080:	return qtrue;
CNSTI4 1
RETI4
LABELV $1306
endproc G_admin_listadmins 116 16
lit
align 1
LABELV $1354
byte 1 0
skip 31
align 1
LABELV $1355
byte 1 0
skip 31
align 1
LABELV $1356
byte 1 0
skip 31
export G_admin_listplayers
code
proc G_admin_listplayers 196 48
line 2085
;2081:}
;2082:
;2083:
;2084:qboolean G_admin_listplayers( gentity_t *ent, int skiparg )
;2085:{
line 2089
;2086:	int i, j;
;2087:	gclient_t *p;
;2088:	char c[ 3 ], t[ 2 ]; // color and team letter
;2089:	char n[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 92
ADDRGP4 $1354
INDIRB
ASGNB 32
line 2090
;2090:	char n2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 124
ADDRGP4 $1355
INDIRB
ASGNB 32
line 2091
;2091:	char n3[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 12
ADDRGP4 $1356
INDIRB
ASGNB 32
line 2097
;2092:	char lname[ MAX_NAME_LENGTH ];
;2093:	char guid_stub[ 9 ];
;2094:	char muted[ 2 ];
;2095:	int l;
;2096:
;2097:	ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2098
;2098:	ADMBP( va( "^3!listplayers: ^7%d players connected:\n",
ADDRGP4 $1357
ARGP4
ADDRGP4 level+72
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2100
;2099:	           level.numConnectedClients ) );
;2100:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRGP4 $1362
JUMPV
LABELV $1359
line 2101
;2101:		p = &level.clients[ i ];
ADDRLP4 4
CNSTI4 2116
ADDRLP4 88
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 2102
;2102:		Q_strncpyz( t, "S", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $143
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2103
;2103:		Q_strncpyz( c, S_COLOR_YELLOW, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1088
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2104
;2104:		if( p->sess.sessionTeam == TEAM_BLUE ) {
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1364
line 2105
;2105:			Q_strncpyz( t, "B", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $139
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2106
;2106:			Q_strncpyz( c, S_COLOR_BLUE, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1366
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2107
;2107:		}
ADDRGP4 $1365
JUMPV
LABELV $1364
line 2108
;2108:		else if( p->sess.sessionTeam == TEAM_RED ) {
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1367
line 2109
;2109:			Q_strncpyz( t, "R", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $1369
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2110
;2110:			Q_strncpyz( c, S_COLOR_RED, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1370
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2111
;2111:		}
ADDRGP4 $1368
JUMPV
LABELV $1367
line 2112
;2112:		else if( p->sess.sessionTeam == TEAM_FREE ) {
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1371
line 2113
;2113:			Q_strncpyz( t, "F", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $1373
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2114
;2114:			Q_strncpyz( c, S_COLOR_GREEN, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1374
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2115
;2115:		}
ADDRGP4 $1372
JUMPV
LABELV $1371
line 2116
;2116:		else if( p->sess.sessionTeam == TEAM_NONE ) {
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1375
line 2117
;2117:			Q_strncpyz( t, "S", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $143
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2118
;2118:			Q_strncpyz( c, S_COLOR_WHITE, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1377
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2119
;2119:		}
LABELV $1375
LABELV $1372
LABELV $1368
LABELV $1365
line 2120
;2120:		if( p->pers.connected == CON_CONNECTING ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1378
line 2121
;2121:			Q_strncpyz( t, "C", sizeof( t ) );
ADDRLP4 159
ARGP4
ADDRGP4 $150
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2122
;2122:			Q_strncpyz( c, S_COLOR_CYAN, sizeof( c ) );
ADDRLP4 156
ARGP4
ADDRGP4 $1380
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2123
;2123:		}
ADDRGP4 $1379
JUMPV
LABELV $1378
line 2124
;2124:		else if( p->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1381
line 2125
;2125:			continue;
ADDRGP4 $1360
JUMPV
LABELV $1381
LABELV $1379
line 2128
;2126:		}
;2127:
;2128:		for( j = 0; j < 8; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1383
line 2129
;2129:			guid_stub[ j ] = p->pers.guid[ j + 24 ];
ADDRLP4 0
INDIRI4
ADDRLP4 76
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 936
ADDP4
ADDP4
INDIRI1
ASGNI1
LABELV $1384
line 2128
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1383
line 2130
;2130:		guid_stub[ j ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 76
ADDP4
CNSTI1 0
ASGNI1
line 2132
;2131:
;2132:		muted[ 0 ] = '\0';
ADDRLP4 161
CNSTI1 0
ASGNI1
line 2133
;2133:		if( p->pers.muted ) {
ADDRLP4 4
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1387
line 2134
;2134:			Q_strncpyz( muted, "M", sizeof( muted ) );
ADDRLP4 161
ARGP4
ADDRGP4 $101
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2135
;2135:		}
LABELV $1387
line 2138
;2136:		//Put DisOriented Junk Here!!!
;2137:
;2138:		l = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2139
;2139:		G_SanitiseString( p->pers.netname, n2, sizeof( n2 ) );
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 124
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2140
;2140:		n[ 0 ] = '\0';
ADDRLP4 92
CNSTI1 0
ASGNI1
line 2141
;2141:		for( j = 0; j < MAX_ADMIN_ADMINS && g_admin_admins[ j ]; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1392
JUMPV
LABELV $1389
line 2142
;2142:			if( Q_strequal( g_admin_admins[ j ]->guid, p->pers.guid ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $1393
line 2144
;2143:				// don't gather aka or level info if the admin is incognito
;2144:				if( ent && G_admin_permission( &g_entities[ i ], ADMF_INCOGNITO ) ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1395
CNSTI4 816
ADDRLP4 88
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 176
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1395
line 2145
;2145:					break;
ADDRGP4 $1391
JUMPV
LABELV $1395
line 2147
;2146:				}
;2147:				l = g_admin_admins[ j ]->level;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
line 2148
;2148:				G_SanitiseString( g_admin_admins[ j ]->name, n3, sizeof( n3 ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2149
;2149:				if ( !Q_strequal( n2, n3 ) ) {
ADDRLP4 124
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $1391
line 2150
;2150:					Q_strncpyz( n, g_admin_admins[ j ]->name, sizeof( n ) );
ADDRLP4 92
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 33
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2151
;2151:				}
line 2152
;2152:				break;
ADDRGP4 $1391
JUMPV
LABELV $1393
line 2154
;2153:			}
;2154:		}
LABELV $1390
line 2141
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1392
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1399
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1389
LABELV $1399
LABELV $1391
line 2155
;2155:		lname[ 0 ] = '\0';
ADDRLP4 44
CNSTI1 0
ASGNI1
line 2156
;2156:		for( j = 0; j < MAX_ADMIN_LEVELS && g_admin_levels[ j ]; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1403
JUMPV
LABELV $1400
line 2157
;2157:			if( g_admin_levels[ j ]->level == l ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1404
line 2160
;2158:				int k, colorlen;
;2159:
;2160:				for( colorlen = k = 0; g_admin_levels[ j ]->name[ k ]; k++ )
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRGP4 $1409
JUMPV
LABELV $1406
line 2161
;2161:					if( Q_IsColorString( &g_admin_levels[ j ]->name[ k ] ) )
ADDRLP4 188
ADDRLP4 176
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1410
ADDRLP4 188
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $1410
ADDRLP4 192
ADDRLP4 188
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $1410
ADDRLP4 192
INDIRI4
CNSTI4 48
LTI4 $1410
ADDRLP4 192
INDIRI4
CNSTI4 56
GTI4 $1410
line 2162
;2162:						colorlen += 2;
ADDRLP4 180
ADDRLP4 180
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $1410
LABELV $1407
line 2160
ADDRLP4 176
ADDRLP4 176
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1409
ADDRLP4 176
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1406
line 2163
;2163:				Com_sprintf( lname, sizeof( lname ), "%*s",
ADDRLP4 44
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 admin_level_maxname
INDIRI4
ADDRLP4 180
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2166
;2164:				             admin_level_maxname + colorlen,
;2165:				             g_admin_levels[ j ]->name );
;2166:				break;
ADDRGP4 $1402
JUMPV
LABELV $1404
line 2168
;2167:			}
;2168:		}
LABELV $1401
line 2156
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1403
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $1412
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1400
LABELV $1412
LABELV $1402
line 2170
;2169:
;2170:		ADMBP( va( "%2i %s%s^7 %-2i %s^7 (*%s) ^1%1s^7 %s^7 %s%s^7%s\n",
ADDRGP4 $1413
ARGP4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 156
ARGP4
ADDRLP4 159
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 161
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 92
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1418
ADDRLP4 180
ADDRGP4 $1414
ASGNP4
ADDRGP4 $1419
JUMPV
LABELV $1418
ADDRLP4 180
ADDRGP4 $67
ASGNP4
LABELV $1419
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 92
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1420
ADDRLP4 184
ADDRGP4 $1416
ASGNP4
ADDRGP4 $1421
JUMPV
LABELV $1420
ADDRLP4 184
ADDRGP4 $67
ASGNP4
LABELV $1421
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2182
;2171:		           i,
;2172:		           c,
;2173:		           t,
;2174:		           l,
;2175:		           lname,
;2176:		           guid_stub,
;2177:		           muted,
;2178:		           p->pers.netname,
;2179:		           ( *n ) ? "(a.k.a. " : "",
;2180:		           n,
;2181:		           ( *n ) ? ")" : "" ) );
;2182:	}
LABELV $1360
line 2100
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1362
ADDRLP4 88
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1359
line 2183
;2183:	ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2184
;2184:	return qtrue;
CNSTI4 1
RETI4
LABELV $1353
endproc G_admin_listplayers 196 48
lit
align 1
LABELV $1423
byte 1 0
skip 31
align 1
LABELV $1424
byte 1 0
skip 63
align 1
LABELV $1425
byte 1 0
skip 63
align 1
LABELV $1426
byte 1 0
skip 31
export G_admin_showbans
code
proc G_admin_showbans 368 32
line 2188
;2185:}
;2186:
;2187:qboolean G_admin_showbans( gentity_t *ent, int skiparg )
;2188:{
line 2189
;2189:	int i, found = 0;
ADDRLP4 292
CNSTI4 0
ASGNI4
line 2190
;2190:	int max = -1, count;
ADDRLP4 112
CNSTI4 -1
ASGNI4
line 2193
;2191:	int t;
;2192:	char duration[ 32 ];
;2193:	int max_name = 1, max_banner = 1, colorlen;
ADDRLP4 276
CNSTI4 1
ASGNI4
ADDRLP4 280
CNSTI4 1
ASGNI4
line 2196
;2194:	int len;
;2195:	int secs;
;2196:	int start = 0;
ADDRLP4 296
CNSTI4 0
ASGNI4
line 2197
;2197:	char filter[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 116
ADDRGP4 $1423
INDIRB
ASGNB 32
line 2201
;2198:	char date[ 11 ];
;2199:	char *made;
;2200:	int j, k;
;2201:	char n1[ MAX_NAME_LENGTH * 2 ] = {""};
ADDRLP4 32
ADDRGP4 $1424
INDIRB
ASGNB 64
line 2202
;2202:	char n2[ MAX_NAME_LENGTH * 2 ] = {""};
ADDRLP4 180
ADDRGP4 $1425
INDIRB
ASGNB 64
line 2203
;2203:	qboolean numeric = qtrue;
ADDRLP4 300
CNSTI4 1
ASGNI4
line 2204
;2204:	char *ip_match = NULL;
ADDRLP4 104
CNSTP4 0
ASGNP4
line 2205
;2205:	int ip_match_len = 0;
ADDRLP4 284
CNSTI4 0
ASGNI4
line 2206
;2206:	char name_match[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 148
ADDRGP4 $1426
INDIRB
ASGNB 32
line 2208
;2207:
;2208:	t = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 304
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 304
INDIRI4
ASGNI4
line 2210
;2209:
;2210:	for( i = 0; i < MAX_ADMIN_BANS && g_admin_bans[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1430
JUMPV
LABELV $1427
line 2211
;2211:		if( g_admin_bans[ i ]->expires != 0 &&
ADDRLP4 308
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1431
ADDRLP4 308
INDIRI4
ADDRLP4 108
INDIRI4
SUBI4
CNSTI4 1
GEI4 $1431
line 2212
;2212:		        ( g_admin_bans[ i ]->expires - t ) < 1 ) {
line 2213
;2213:			continue;
ADDRGP4 $1428
JUMPV
LABELV $1431
line 2215
;2214:		}
;2215:		found++;
ADDRLP4 292
ADDRLP4 292
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2216
;2216:		max = i;
ADDRLP4 112
ADDRLP4 0
INDIRI4
ASGNI4
line 2217
;2217:	}
LABELV $1428
line 2210
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1430
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1433
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1427
LABELV $1433
line 2219
;2218:
;2219:	if( max < 0 ) {
ADDRLP4 112
INDIRI4
CNSTI4 0
GEI4 $1434
line 2220
;2220:		ADMP( "^3!showbans: ^7no bans to display\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1436
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2221
;2221:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1422
JUMPV
LABELV $1434
line 2224
;2222:	}
;2223:
;2224:	if( G_SayArgc() >= 2 + skiparg ) {
ADDRLP4 312
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1437
line 2225
;2225:		G_SayArgv( 1 + skiparg, filter, sizeof( filter ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 116
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2226
;2226:		if( G_SayArgc() >= 3 + skiparg ) {
ADDRLP4 316
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
LTI4 $1439
line 2227
;2227:			start = atoi( filter );
ADDRLP4 116
ARGP4
ADDRLP4 320
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 320
INDIRI4
ASGNI4
line 2228
;2228:			G_SayArgv( 2 + skiparg, filter, sizeof( filter ) );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2229
;2229:		}
LABELV $1439
line 2230
;2230:		for( i = 0; i < sizeof( filter ) && filter[ i ] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1444
JUMPV
LABELV $1441
line 2231
;2231:			if( !isdigit( filter[ i ] ) &&
ADDRLP4 320
ADDRLP4 0
INDIRI4
ADDRLP4 116
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 48
LTI4 $1447
ADDRLP4 320
INDIRI4
CNSTI4 57
LEI4 $1445
LABELV $1447
ADDRLP4 324
ADDRLP4 0
INDIRI4
ADDRLP4 116
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 46
EQI4 $1445
ADDRLP4 324
INDIRI4
CNSTI4 45
EQI4 $1445
line 2232
;2232:			        filter[ i ] != '.' && filter[ i ] != '-' ) {
line 2233
;2233:				numeric = qfalse;
ADDRLP4 300
CNSTI4 0
ASGNI4
line 2234
;2234:				break;
ADDRGP4 $1443
JUMPV
LABELV $1445
line 2236
;2235:			}
;2236:		}
LABELV $1442
line 2230
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1444
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 32
GEU4 $1448
ADDRLP4 0
INDIRI4
ADDRLP4 116
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1441
LABELV $1448
LABELV $1443
line 2237
;2237:		if( !numeric ) {
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $1449
line 2238
;2238:			G_SanitiseString( filter, name_match, sizeof( name_match ) );
ADDRLP4 116
ARGP4
ADDRLP4 148
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2239
;2239:		}
ADDRGP4 $1450
JUMPV
LABELV $1449
line 2240
;2240:		else if( strchr( filter, '.' ) ) {
ADDRLP4 116
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 324
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 324
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1451
line 2241
;2241:			ip_match = filter;
ADDRLP4 104
ADDRLP4 116
ASGNP4
line 2242
;2242:			ip_match_len = strlen(ip_match);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 328
INDIRI4
ASGNI4
line 2243
;2243:		}
ADDRGP4 $1452
JUMPV
LABELV $1451
line 2244
;2244:		else {
line 2245
;2245:			start = atoi( filter );
ADDRLP4 116
ARGP4
ADDRLP4 328
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 328
INDIRI4
ASGNI4
line 2246
;2246:			filter[ 0 ] = '\0';
ADDRLP4 116
CNSTI1 0
ASGNI1
line 2247
;2247:		}
LABELV $1452
LABELV $1450
line 2249
;2248:		// showbans 1 means start with ban 0
;2249:		if( start > 0 )
ADDRLP4 296
INDIRI4
CNSTI4 0
LEI4 $1453
line 2250
;2250:			start--;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1454
JUMPV
LABELV $1453
line 2251
;2251:		else if( start < 0 ) {
ADDRLP4 296
INDIRI4
CNSTI4 0
GEI4 $1455
line 2252
;2252:			for( i = max, count = 0; i >= 0 && count < -start; i-- )
ADDRLP4 0
ADDRLP4 112
INDIRI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $1460
JUMPV
LABELV $1457
line 2253
;2253:				if( g_admin_bans[ i ]->expires == 0 ||
ADDRLP4 328
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRLP4 328
INDIRI4
ADDRLP4 332
INDIRI4
EQI4 $1463
ADDRLP4 328
INDIRI4
ADDRLP4 108
INDIRI4
SUBI4
ADDRLP4 332
INDIRI4
LEI4 $1461
LABELV $1463
line 2255
;2254:				        ( g_admin_bans[ i ]->expires - t ) > 0 )
;2255:					count++;
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1461
LABELV $1458
line 2252
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1460
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1464
ADDRLP4 100
INDIRI4
ADDRLP4 296
INDIRI4
NEGI4
LTI4 $1457
LABELV $1464
line 2256
;2256:			start = i + 1;
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2257
;2257:		}
LABELV $1455
LABELV $1454
line 2258
;2258:	}
LABELV $1437
line 2260
;2259:
;2260:	if( start < 0 )
ADDRLP4 296
INDIRI4
CNSTI4 0
GEI4 $1465
line 2261
;2261:		start = 0;
ADDRLP4 296
CNSTI4 0
ASGNI4
LABELV $1465
line 2263
;2262:
;2263:	if( start > max ) {
ADDRLP4 296
INDIRI4
ADDRLP4 112
INDIRI4
LEI4 $1467
line 2264
;2264:		ADMP( va( "^3!showbans: ^7%d is the last valid ban\n", max + 1 ) );
ADDRGP4 $1469
ARGP4
ADDRLP4 112
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 316
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 316
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2265
;2265:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1422
JUMPV
LABELV $1467
line 2268
;2266:	}
;2267:
;2268:	for( i = start, count = 0; i <= max && count < MAX_ADMIN_SHOWBANS; i++ ) {
ADDRLP4 0
ADDRLP4 296
INDIRI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $1473
JUMPV
LABELV $1470
line 2269
;2269:		if( g_admin_bans[ i ]->expires != 0 &&
ADDRLP4 316
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $1474
ADDRLP4 316
INDIRI4
ADDRLP4 108
INDIRI4
SUBI4
CNSTI4 1
GEI4 $1474
line 2271
;2270:		        ( g_admin_bans[ i ]->expires - t ) < 1 )
;2271:			continue;
ADDRGP4 $1471
JUMPV
LABELV $1474
line 2273
;2272:
;2273:		if( name_match[ 0 ] ) {
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1476
line 2274
;2274:			G_SanitiseString( g_admin_bans[ i ]->name, n1, sizeof( n1 ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2275
;2275:			if( !strstr( n1, name_match) )
ADDRLP4 32
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 320
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 320
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1478
line 2276
;2276:				continue;
ADDRGP4 $1471
JUMPV
LABELV $1478
line 2277
;2277:		}
LABELV $1476
line 2278
;2278:		if( ip_match &&
ADDRLP4 104
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1480
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 324
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1480
line 2280
;2279:		        Q_strncmp( ip_match, g_admin_bans[ i ]->ip, ip_match_len ) )
;2280:			continue;
ADDRGP4 $1471
JUMPV
LABELV $1480
line 2282
;2281:
;2282:		count++;
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2284
;2283:
;2284:		len = Q_PrintStrlen( g_admin_bans[ i ]->name );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRLP4 328
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 328
INDIRI4
ASGNI4
line 2285
;2285:		if( len > max_name )
ADDRLP4 96
INDIRI4
ADDRLP4 276
INDIRI4
LEI4 $1482
line 2286
;2286:			max_name = len;
ADDRLP4 276
ADDRLP4 96
INDIRI4
ASGNI4
LABELV $1482
line 2287
;2287:		len = Q_PrintStrlen( g_admin_bans[ i ]->banner );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 332
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 332
INDIRI4
ASGNI4
line 2288
;2288:		if( len > max_banner )
ADDRLP4 96
INDIRI4
ADDRLP4 280
INDIRI4
LEI4 $1484
line 2289
;2289:			max_banner = len;
ADDRLP4 280
ADDRLP4 96
INDIRI4
ASGNI4
LABELV $1484
line 2290
;2290:	}
LABELV $1471
line 2268
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1473
ADDRLP4 0
INDIRI4
ADDRLP4 112
INDIRI4
GTI4 $1486
ADDRLP4 100
INDIRI4
CNSTI4 10
LTI4 $1470
LABELV $1486
line 2292
;2291:
;2292:	ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2293
;2293:	for( i = start, count = 0; i <= max && count < MAX_ADMIN_SHOWBANS; i++ ) {
ADDRLP4 0
ADDRLP4 296
INDIRI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $1490
JUMPV
LABELV $1487
line 2294
;2294:		if( g_admin_bans[ i ]->expires != 0 &&
ADDRLP4 316
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
EQI4 $1491
ADDRLP4 316
INDIRI4
ADDRLP4 108
INDIRI4
SUBI4
CNSTI4 1
GEI4 $1491
line 2296
;2295:		        ( g_admin_bans[ i ]->expires - t ) < 1 )
;2296:			continue;
ADDRGP4 $1488
JUMPV
LABELV $1491
line 2298
;2297:
;2298:		if( name_match[ 0 ] ) {
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1493
line 2299
;2299:			G_SanitiseString( g_admin_bans[ i ]->name, n1, sizeof( n1 ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2300
;2300:			if( !strstr( n1, name_match) )
ADDRLP4 32
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 320
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 320
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1495
line 2301
;2301:				continue;
ADDRGP4 $1488
JUMPV
LABELV $1495
line 2302
;2302:		}
LABELV $1493
line 2303
;2303:		if( ip_match &&
ADDRLP4 104
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1497
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 324
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
EQI4 $1497
line 2305
;2304:		        Q_strncmp( ip_match, g_admin_bans[ i ]->ip, ip_match_len ) )
;2305:			continue;
ADDRGP4 $1488
JUMPV
LABELV $1497
line 2307
;2306:
;2307:		count++;
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2310
;2308:
;2309:		// only print out the the date part of made
;2310:		date[ 0 ] = '\0';
ADDRLP4 16
CNSTI1 0
ASGNI1
line 2311
;2311:		made = g_admin_bans[ i ]->made;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 155
ADDP4
ASGNP4
line 2312
;2312:		for( j = 0; made && *made; j++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1502
JUMPV
LABELV $1499
line 2313
;2313:			if( ( j + 1 ) >= sizeof( date ) )
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
CVIU4 4
CNSTU4 11
LTU4 $1503
line 2314
;2314:				break;
ADDRGP4 $1501
JUMPV
LABELV $1503
line 2315
;2315:			if( *made == ' ' )
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $1505
line 2316
;2316:				break;
ADDRGP4 $1501
JUMPV
LABELV $1505
line 2317
;2317:			date[ j ] = *made;
ADDRLP4 12
INDIRI4
ADDRLP4 16
ADDP4
ADDRLP4 8
INDIRP4
INDIRI1
ASGNI1
line 2318
;2318:			date[ j + 1 ] = '\0';
ADDRLP4 12
INDIRI4
ADDRLP4 16+1
ADDP4
CNSTI1 0
ASGNI1
line 2319
;2319:			made++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2320
;2320:		}
LABELV $1500
line 2312
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1502
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1508
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1499
LABELV $1508
LABELV $1501
line 2322
;2321:
;2322:		secs = ( g_admin_bans[ i ]->expires - t );
ADDRLP4 288
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
SUBI4
ASGNI4
line 2323
;2323:		G_admin_duration( secs, duration, sizeof( duration ) );
ADDRLP4 288
INDIRI4
ARGI4
ADDRLP4 244
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 2325
;2324:
;2325:		for( colorlen = k = 0; g_admin_bans[ i ]->name[ k ]; k++ )
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRLP4 332
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 332
INDIRI4
ASGNI4
ADDRGP4 $1512
JUMPV
LABELV $1509
line 2326
;2326:			if( Q_IsColorString( &g_admin_bans[ i ]->name[ k ] ) )
ADDRLP4 336
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 336
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1513
ADDRLP4 336
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $1513
ADDRLP4 340
ADDRLP4 336
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $1513
ADDRLP4 340
INDIRI4
CNSTI4 48
LTI4 $1513
ADDRLP4 340
INDIRI4
CNSTI4 56
GTI4 $1513
line 2327
;2327:				colorlen += 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $1513
LABELV $1510
line 2325
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1512
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1509
line 2328
;2328:		Com_sprintf( n1, sizeof( n1 ), "%*s", max_name + colorlen,
ADDRLP4 32
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $487
ARGP4
ADDRLP4 276
INDIRI4
ADDRLP4 28
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2331
;2329:		             g_admin_bans[ i ]->name );
;2330:
;2331:		for( colorlen = k = 0; g_admin_bans[ i ]->banner[ k ]; k++ )
ADDRLP4 344
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRLP4 344
INDIRI4
ASGNI4
ADDRLP4 28
ADDRLP4 344
INDIRI4
ASGNI4
ADDRGP4 $1518
JUMPV
LABELV $1515
line 2332
;2332:			if( Q_IsColorString( &g_admin_bans[ i ]->banner[ k ] ) )
ADDRLP4 348
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 180
ADDP4
ADDP4
ASGNP4
ADDRLP4 348
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1519
ADDRLP4 348
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $1519
ADDRLP4 352
ADDRLP4 348
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $1519
ADDRLP4 352
INDIRI4
CNSTI4 48
LTI4 $1519
ADDRLP4 352
INDIRI4
CNSTI4 56
GTI4 $1519
line 2333
;2333:				colorlen += 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $1519
LABELV $1516
line 2331
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1518
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 180
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1515
line 2334
;2334:		Com_sprintf( n2, sizeof( n2 ), "%*s", max_banner + colorlen,
ADDRLP4 180
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $487
ARGP4
ADDRLP4 280
INDIRI4
ADDRLP4 28
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 2337
;2335:		             g_admin_bans[ i ]->banner );
;2336:
;2337:		ADMBP( va( "%4i %s^7 %-15s %-8s %s^7 %-10s\n     \\__ %s\n",
ADDRGP4 $1521
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ARGP4
ADDRLP4 360
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 180
ARGP4
ADDRLP4 244
ARGP4
ADDRLP4 360
INDIRP4
CNSTI4 105
ADDP4
ARGP4
ADDRLP4 364
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 364
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2345
;2338:		           ( i + 1 ),
;2339:		           n1,
;2340:		           g_admin_bans[ i ]->ip,
;2341:		           date,
;2342:		           n2,
;2343:		           duration,
;2344:		           g_admin_bans[ i ]->reason ) );
;2345:	}
LABELV $1488
line 2293
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1490
ADDRLP4 0
INDIRI4
ADDRLP4 112
INDIRI4
GTI4 $1522
ADDRLP4 100
INDIRI4
CNSTI4 10
LTI4 $1487
LABELV $1522
line 2347
;2346:
;2347:	if( name_match[ 0 ] || ip_match ) {
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1525
ADDRLP4 104
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1523
LABELV $1525
line 2348
;2348:		ADMBP( va( "^3!showbans:^7 found %d matching bans by %s.  ",
ADDRGP4 $1526
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 104
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1529
ADDRLP4 316
ADDRGP4 $1527
ASGNP4
ADDRGP4 $1530
JUMPV
LABELV $1529
ADDRLP4 316
ADDRGP4 $697
ASGNP4
LABELV $1530
ADDRLP4 316
INDIRP4
ARGP4
ADDRLP4 320
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 320
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2351
;2349:		           count,
;2350:		           ( ip_match ) ? "IP" : "name" ) );
;2351:	}
ADDRGP4 $1524
JUMPV
LABELV $1523
line 2352
;2352:	else {
line 2353
;2353:		ADMBP( va( "^3!showbans:^7 showing bans %d - %d of %d (%d total).",
ADDRGP4 $1531
ARGP4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1533
ADDRLP4 316
ADDRLP4 296
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $1534
JUMPV
LABELV $1533
ADDRLP4 316
CNSTI4 0
ASGNI4
LABELV $1534
ADDRLP4 316
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 292
INDIRI4
ARGI4
ADDRLP4 320
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 320
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2358
;2354:		           ( found ) ? ( start + 1 ) : 0,
;2355:		           i,
;2356:		           max + 1,
;2357:		           found ) );
;2358:	}
LABELV $1524
line 2360
;2359:
;2360:	if( i <= max )
ADDRLP4 0
INDIRI4
ADDRLP4 112
INDIRI4
GTI4 $1535
line 2361
;2361:		ADMBP( va( "  run !showbans %d%s%s to see more",
ADDRGP4 $1537
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 116
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1541
ADDRLP4 316
ADDRGP4 $1538
ASGNP4
ADDRGP4 $1542
JUMPV
LABELV $1541
ADDRLP4 316
ADDRGP4 $67
ASGNP4
LABELV $1542
ADDRLP4 316
INDIRP4
ARGP4
ADDRLP4 116
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1543
ADDRLP4 320
ADDRLP4 116
ASGNP4
ADDRGP4 $1544
JUMPV
LABELV $1543
ADDRLP4 320
ADDRGP4 $67
ASGNP4
LABELV $1544
ADDRLP4 320
INDIRP4
ARGP4
ADDRLP4 324
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 324
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
LABELV $1535
line 2365
;2362:		           i + 1,
;2363:		           ( filter[ 0 ] ) ? " " : "",
;2364:		           ( filter[ 0 ] ) ? filter : "" ) );
;2365:	ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2366
;2366:	ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2367
;2367:	return qtrue;
CNSTI4 1
RETI4
LABELV $1422
endproc G_admin_showbans 368 32
export G_admin_help
proc G_admin_help 64 12
line 2371
;2368:}
;2369:
;2370:qboolean G_admin_help( gentity_t *ent, int skiparg )
;2371:{
line 2374
;2372:	int i;
;2373:
;2374:	if( G_SayArgc() < 2 + skiparg ) {
ADDRLP4 4
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1546
line 2375
;2375:		int j = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2376
;2376:		int count = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2378
;2377:
;2378:		ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2379
;2379:		for( i = 0; i < adminNumCmds; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1551
JUMPV
LABELV $1548
line 2380
;2380:			if( G_admin_permission( ent, g_admin_cmds[ i ].flag[ 0 ] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1552
line 2381
;2381:				ADMBP( va( "^3!%-12s", g_admin_cmds[ i ].keyword ) );
ADDRGP4 $1555
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2382
;2382:				j++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2383
;2383:				count++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2384
;2384:			}
LABELV $1552
line 2386
;2385:			// show 6 commands per line
;2386:			if( j == 6 ) {
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $1556
line 2387
;2387:				ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2388
;2388:				j = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2389
;2389:			}
LABELV $1556
line 2390
;2390:		}
LABELV $1549
line 2379
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1551
ADDRLP4 0
INDIRI4
ADDRGP4 adminNumCmds
INDIRI4
LTI4 $1548
line 2391
;2391:		for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1561
JUMPV
LABELV $1558
line 2392
;2392:			if( ! admin_command_permission( ent, g_admin_commands[ i ]->command ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 admin_command_permission
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1562
line 2393
;2393:				continue;
ADDRGP4 $1559
JUMPV
LABELV $1562
line 2394
;2394:			ADMBP( va( "^3!%-12s", g_admin_commands[ i ]->command ) );
ADDRGP4 $1555
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2395
;2395:			j++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2396
;2396:			count++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2398
;2397:			// show 6 commands per line
;2398:			if( j == 6 ) {
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $1564
line 2399
;2399:				ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2400
;2400:				j = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2401
;2401:			}
LABELV $1564
line 2402
;2402:		}
LABELV $1559
line 2391
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1561
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $1566
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1558
LABELV $1566
line 2403
;2403:		if( count )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1567
line 2404
;2404:			ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
LABELV $1567
line 2405
;2405:		ADMBP( va( "^3!help: ^7%i available commands\n", count ) );
ADDRGP4 $1569
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2406
;2406:		ADMBP( "run !help [^3command^7] for help with a specific command.\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1570
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2407
;2407:		ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2409
;2408:
;2409:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1545
JUMPV
LABELV $1546
line 2411
;2410:	}
;2411:	else {
line 2416
;2412:		//!help param
;2413:		char param[ MAX_ADMIN_CMD_LEN ];
;2414:		char *cmd;
;2415:
;2416:		G_SayArgv( 1 + skiparg, param, sizeof( param ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2417
;2417:		cmd = ( param[0] == '!' ) ? &param[1] : &param[0];
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 33
NEI4 $1573
ADDRLP4 32
ADDRLP4 12+1
ASGNP4
ADDRGP4 $1574
JUMPV
LABELV $1573
ADDRLP4 32
ADDRLP4 12
ASGNP4
LABELV $1574
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 2418
;2418:		ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2419
;2419:		for( i = 0; i < adminNumCmds; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1578
JUMPV
LABELV $1575
line 2420
;2420:			if( Q_strequal( cmd, g_admin_cmds[ i ].keyword ) ) {
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1579
line 2421
;2421:				if( !G_admin_permission( ent, g_admin_cmds[ i ].flag[ 0 ] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 40
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $1581
line 2422
;2422:					ADMBP( va( "^3!help: ^7you do not have permission to use '%s'\n",
ADDRGP4 $1584
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2424
;2423:					           g_admin_cmds[ i ].keyword ) );
;2424:					ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2425
;2425:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1545
JUMPV
LABELV $1581
line 2427
;2426:				}
;2427:				ADMBP( va( "^3!help: ^7help for '!%s':\n",
ADDRGP4 $1585
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2429
;2428:				           g_admin_cmds[ i ].keyword ) );
;2429:				ADMBP( va( " ^3Function: ^7%s\n", g_admin_cmds[ i ].function ) );
ADDRGP4 $1586
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2430
;2430:				ADMBP( va( " ^3Syntax: ^7!%s %s\n", g_admin_cmds[ i ].keyword,
ADDRGP4 $1588
ARGP4
ADDRLP4 52
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRGP4 g_admin_cmds
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ADDRGP4 g_admin_cmds+16
ADDP4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2432
;2431:				           g_admin_cmds[ i ].syntax ) );
;2432:				ADMBP( va( " ^3Flag: ^7'%c'\n", g_admin_cmds[ i ].flag[ 0 ] ) );
ADDRGP4 $1590
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_admin_cmds+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2433
;2433:				ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2434
;2434:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1545
JUMPV
LABELV $1579
line 2436
;2435:			}
;2436:		}
LABELV $1576
line 2419
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1578
ADDRLP4 0
INDIRI4
ADDRGP4 adminNumCmds
INDIRI4
LTI4 $1575
line 2437
;2437:		for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1595
JUMPV
LABELV $1592
line 2438
;2438:			if( Q_strequal( cmd, g_admin_commands[ i ]->command ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1596
line 2439
;2439:				if( !admin_command_permission( ent, g_admin_commands[ i ]->command ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 admin_command_permission
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $1598
line 2440
;2440:					ADMBP( va( "^3!help: ^7you do not have permission to use '%s'\n",
ADDRGP4 $1584
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2442
;2441:					           g_admin_commands[ i ]->command ) );
;2442:					ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2443
;2443:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1545
JUMPV
LABELV $1598
line 2445
;2444:				}
;2445:				ADMBP( va( "^3!help: ^7help for '%s':\n",
ADDRGP4 $1600
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2447
;2446:				           g_admin_commands[ i ]->command ) );
;2447:				ADMBP( va( " ^3Description: ^7%s\n", g_admin_commands[ i ]->desc ) );
ADDRGP4 $1601
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2448
;2448:				ADMBP( va( " ^3Syntax: ^7!%s\n", g_admin_commands[ i ]->command ) );
ADDRGP4 $1602
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2449
;2449:				ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2450
;2450:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1545
JUMPV
LABELV $1596
line 2452
;2451:			}
;2452:		}
LABELV $1593
line 2437
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1595
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $1603
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1592
LABELV $1603
line 2453
;2453:		ADMBP( va( "^3!help: ^7no help found for '%s'\n", cmd ) );
ADDRGP4 $1604
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2454
;2454:		ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2455
;2455:		return qfalse;
CNSTI4 0
RETI4
LABELV $1545
endproc G_admin_help 64 12
export G_admin_admintest
proc G_admin_admintest 40 24
line 2460
;2456:	}
;2457:}
;2458:
;2459:qboolean G_admin_admintest( gentity_t *ent, int skiparg )
;2460:{
line 2461
;2461:	int i, l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2462
;2462:	qboolean found = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2463
;2463:	qboolean lname = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2465
;2464:
;2465:	if( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1606
line 2466
;2466:		ADMP( "^3!admintest: ^7you are on the console.\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1608
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2467
;2467:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1605
JUMPV
LABELV $1606
line 2469
;2468:	}
;2469:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1612
JUMPV
LABELV $1609
line 2470
;2470:		if( Q_strequal( g_admin_admins[ i ]->guid, ent->client->pers.guid ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1613
line 2471
;2471:			found = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2472
;2472:			break;
ADDRGP4 $1611
JUMPV
LABELV $1613
line 2474
;2473:		}
;2474:	}
LABELV $1610
line 2469
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1612
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1615
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1609
LABELV $1615
LABELV $1611
line 2476
;2475:
;2476:	if (!found || i == MAX_ADMIN_ADMINS) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1618
ADDRLP4 0
INDIRI4
CNSTI4 1024
NEI4 $1616
LABELV $1618
line 2478
;2477:		//The i == MAX_ADMIN_ADMINS check makes it easier for static analysers to rationate about the code
;2478:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1605
JUMPV
LABELV $1616
line 2480
;2479:	}
;2480:	l = g_admin_admins[ i ]->level;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
line 2481
;2481:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1622
JUMPV
LABELV $1619
line 2482
;2482:		if( g_admin_levels[ i ]->level != l )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1623
line 2483
;2483:			continue;
ADDRGP4 $1620
JUMPV
LABELV $1623
line 2484
;2484:		if( *g_admin_levels[ i ]->name ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1625
line 2485
;2485:			lname = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2486
;2486:			break;
ADDRGP4 $1621
JUMPV
LABELV $1625
line 2488
;2487:		}
;2488:	}
LABELV $1620
line 2481
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1622
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $1627
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1619
LABELV $1627
LABELV $1621
line 2489
;2489:	if (i >= MAX_ADMIN_LEVELS) {
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $1628
line 2490
;2490:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1605
JUMPV
LABELV $1628
line 2492
;2491:	}
;2492:	AP( va( "print \"^3!admintest: ^7%s^7 is a level %d admin %s%s^7%s\n\"",
ADDRGP4 $1630
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1635
ADDRLP4 24
ADDRGP4 $1631
ASGNP4
ADDRGP4 $1636
JUMPV
LABELV $1635
ADDRLP4 24
ADDRGP4 $67
ASGNP4
LABELV $1636
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1637
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRGP4 $1638
JUMPV
LABELV $1637
ADDRLP4 28
ADDRGP4 $67
ASGNP4
LABELV $1638
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1639
ADDRLP4 32
ADDRGP4 $1416
ASGNP4
ADDRGP4 $1640
JUMPV
LABELV $1639
ADDRLP4 32
ADDRGP4 $67
ASGNP4
LABELV $1640
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2498
;2493:	        ent->client->pers.netname,
;2494:	        l,
;2495:	        ( lname ) ? "(" : "",
;2496:	        ( lname ) ? g_admin_levels[ i ]->name : "",
;2497:	        ( lname ) ? ")" : "" ) );
;2498:	return qtrue;
CNSTI4 1
RETI4
LABELV $1605
endproc G_admin_admintest 40 24
export G_admin_allready
proc G_admin_allready 16 8
line 2502
;2499:}
;2500:
;2501:qboolean G_admin_allready( gentity_t *ent, int skiparg )
;2502:{
line 2503
;2503:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2506
;2504:	gclient_t *cl;
;2505:
;2506:	if( !level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
NEI4 $1642
line 2507
;2507:		ADMP( "^3!allready: ^7this command is only valid during intermission\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1645
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2508
;2508:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1641
JUMPV
LABELV $1642
line 2511
;2509:	}
;2510:
;2511:	for( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1649
JUMPV
LABELV $1646
line 2512
;2512:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 2513
;2513:		if( cl->pers.connected != CON_CONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1651
line 2514
;2514:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1651
line 2516
;2515:
;2516:		if( cl->sess.sessionTeam == TEAM_NONE )
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1653
line 2517
;2517:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1653
line 2519
;2518:
;2519:		cl->readyToExit = 1;
ADDRLP4 0
INDIRP4
CNSTI4 1052
ADDP4
CNSTI4 1
ASGNI4
line 2520
;2520:	}
LABELV $1647
line 2511
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1649
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $1646
line 2521
;2521:	AP( va( "print \"^3!allready:^7 %s^7 says everyone is READY now\n\"",
ADDRGP4 $1655
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1657
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1658
JUMPV
LABELV $1657
ADDRLP4 8
ADDRGP4 $439
ASGNP4
LABELV $1658
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2523
;2522:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2523:	return qtrue;
CNSTI4 1
RETI4
LABELV $1641
endproc G_admin_allready 16 8
export G_admin_cancelvote
proc G_admin_cancelvote 12 8
line 2527
;2524:}
;2525:
;2526:qboolean G_admin_cancelvote( gentity_t *ent, int skiparg )
;2527:{
line 2529
;2528:
;2529:	if(!level.voteTime && !level.teamVoteTime[ 0 ] && !level.teamVoteTime[ 1 ] ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 level+2404
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1660
ADDRGP4 level+4480
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1660
ADDRGP4 level+4480+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1660
line 2530
;2530:		ADMP( "^3!cancelvote: ^7no vote in progress\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1666
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2531
;2531:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1659
JUMPV
LABELV $1660
line 2533
;2532:	}
;2533:	level.voteNo = level.numConnectedClients;
ADDRGP4 level+2416
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2534
;2534:	level.voteYes = 0;
ADDRGP4 level+2412
CNSTI4 0
ASGNI4
line 2535
;2535:	CheckVote( );
ADDRGP4 CheckVote
CALLV
pop
line 2536
;2536:	level.teamVoteNo[ 0 ] = level.numConnectedClients;
ADDRGP4 level+4496
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2537
;2537:	level.teamVoteYes[ 0 ] = 0;
ADDRGP4 level+4488
CNSTI4 0
ASGNI4
line 2538
;2538:	CheckTeamVote( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2539
;2539:	level.teamVoteNo[ 1 ] = level.numConnectedClients;
ADDRGP4 level+4496+4
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2540
;2540:	level.teamVoteYes[ 1 ] = 0;
ADDRGP4 level+4488+4
CNSTI4 0
ASGNI4
line 2541
;2541:	CheckTeamVote( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2542
;2542:	AP( va( "print \"^3!cancelvote: ^7%s^7 decided that everyone voted No\n\"",
ADDRGP4 $1678
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1680
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1681
JUMPV
LABELV $1680
ADDRLP4 4
ADDRGP4 $439
ASGNP4
LABELV $1681
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
line 2544
;2543:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2544:	return qtrue;
CNSTI4 1
RETI4
LABELV $1659
endproc G_admin_cancelvote 12 8
export G_admin_passvote
proc G_admin_passvote 12 8
line 2548
;2545:}
;2546:
;2547:qboolean G_admin_passvote( gentity_t *ent, int skiparg )
;2548:{
line 2549
;2549:	if(!level.voteTime && !level.teamVoteTime[ 0 ] && !level.teamVoteTime[ 1 ] ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 level+2404
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1683
ADDRGP4 level+4480
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1683
ADDRGP4 level+4480+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1683
line 2550
;2550:		ADMP( "^3!passvote: ^7no vote in progress\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1689
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2551
;2551:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1682
JUMPV
LABELV $1683
line 2553
;2552:	}
;2553:	level.voteYes = level.numConnectedClients;
ADDRGP4 level+2412
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2554
;2554:	level.voteNo = 0;
ADDRGP4 level+2416
CNSTI4 0
ASGNI4
line 2555
;2555:	CheckVote( );
ADDRGP4 CheckVote
CALLV
pop
line 2556
;2556:	level.teamVoteYes[ 0 ] = level.numConnectedClients;
ADDRGP4 level+4488
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2557
;2557:	level.teamVoteNo[ 0 ] = 0;
ADDRGP4 level+4496
CNSTI4 0
ASGNI4
line 2558
;2558:	CheckTeamVote( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2559
;2559:	level.teamVoteYes[ 1 ] = level.numConnectedClients;
ADDRGP4 level+4488+4
ADDRGP4 level+72
INDIRI4
ASGNI4
line 2560
;2560:	level.teamVoteNo[ 1 ] = 0;
ADDRGP4 level+4496+4
CNSTI4 0
ASGNI4
line 2561
;2561:	CheckTeamVote( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2562
;2562:	AP( va( "print \"^3!passvote: ^7%s^7 decided that everyone voted Yes\n\"",
ADDRGP4 $1701
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1703
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1704
JUMPV
LABELV $1703
ADDRLP4 4
ADDRGP4 $439
ASGNP4
LABELV $1704
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
line 2564
;2563:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2564:	return qtrue;
CNSTI4 1
RETI4
LABELV $1682
endproc G_admin_passvote 12 8
export G_admin_spec999
proc G_admin_spec999 16 12
line 2568
;2565:}
;2566:
;2567:qboolean G_admin_spec999( gentity_t *ent, int skiparg )
;2568:{
line 2572
;2569:	int i;
;2570:	gentity_t *vic;
;2571:
;2572:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1709
JUMPV
LABELV $1706
line 2573
;2573:		vic = &g_entities[ i ];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2574
;2574:		if( !vic->client )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1711
line 2575
;2575:			continue;
ADDRGP4 $1707
JUMPV
LABELV $1711
line 2576
;2576:		if( vic->client->pers.connected != CON_CONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1713
line 2577
;2577:			continue;
ADDRGP4 $1707
JUMPV
LABELV $1713
line 2578
;2578:		if( vic->client->sess.sessionTeam == TEAM_NONE )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1715
line 2579
;2579:			continue;
ADDRGP4 $1707
JUMPV
LABELV $1715
line 2580
;2580:		if( vic->client->ps.ping == 999 ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
NEI4 $1717
line 2581
;2581:			SetTeam( vic, "spectator" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1719
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 2582
;2582:			AP( va( "print \"^3!spec999: ^7%s^7 moved ^7%s^7 to spectators\n\"",
ADDRGP4 $1720
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1722
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1723
JUMPV
LABELV $1722
ADDRLP4 8
ADDRGP4 $439
ASGNP4
LABELV $1723
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2585
;2583:			        ( ent ) ? ent->client->pers.netname : "console",
;2584:			        vic->client->pers.netname ) );
;2585:		}
LABELV $1717
line 2586
;2586:	}
LABELV $1707
line 2572
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1709
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1706
line 2587
;2587:	return qtrue;
CNSTI4 1
RETI4
LABELV $1705
endproc G_admin_spec999 16 12
export G_admin_rename
proc G_admin_rename 2448 16
line 2591
;2588:}
;2589:
;2590:qboolean G_admin_rename( gentity_t *ent, int skiparg )
;2591:{
line 2599
;2592:	int pids[ MAX_CLIENTS ], found;
;2593:	char name[ MAX_NAME_LENGTH ];
;2594:	char newname[ MAX_NAME_LENGTH ];
;2595:	char oldname[ MAX_NAME_LENGTH ];
;2596:	char err[ MAX_STRING_CHARS ];
;2597:	char userinfo[ MAX_INFO_STRING ];
;2598:	char *s;
;2599:	gentity_t *victim = NULL;
ADDRLP4 2340
CNSTP4 0
ASGNP4
line 2601
;2600:
;2601:	if( G_SayArgc() < 3 + skiparg ) {
ADDRLP4 2412
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 2412
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
GEI4 $1725
line 2602
;2602:		ADMP( "^3!rename: ^7usage: !rename [name] [newname]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1727
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2603
;2603:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1724
JUMPV
LABELV $1725
line 2605
;2604:	}
;2605:	G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 2344
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2606
;2606:	s = G_SayConcatArgs( 2 + skiparg );
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 2416
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 2336
ADDRLP4 2416
INDIRP4
ASGNP4
line 2607
;2607:	Q_strncpyz( newname, s, sizeof( newname ) );
ADDRLP4 256
ARGP4
ADDRLP4 2336
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2608
;2608:	if( ( found = G_ClientNumbersFromString( name, pids, MAX_CLIENTS ) ) != 1 ) {
ADDRLP4 2344
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 2420
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 2408
ADDRLP4 2420
INDIRI4
ASGNI4
ADDRLP4 2420
INDIRI4
CNSTI4 1
EQI4 $1728
line 2609
;2609:		G_MatchOnePlayer( pids, found, err, sizeof( err ) );
ADDRLP4 0
ARGP4
ADDRLP4 2408
INDIRI4
ARGI4
ADDRLP4 1312
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 2610
;2610:		ADMP( va( "^3!rename: ^7%s\n", err ) );
ADDRGP4 $1730
ARGP4
ADDRLP4 1312
ARGP4
ADDRLP4 2424
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2424
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2611
;2611:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1724
JUMPV
LABELV $1728
line 2613
;2612:	}
;2613:	victim = &g_entities[ pids[ 0 ] ];
ADDRLP4 2340
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2614
;2614:	if( !admin_higher( ent, victim ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2340
INDIRP4
ARGP4
ADDRLP4 2424
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 2424
INDIRI4
CNSTI4 0
NEI4 $1731
line 2615
;2615:		ADMP( "^3!rename: ^7sorry, but your intended victim has a higher admin"
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1733
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2617
;2616:		      " level than you\n" );
;2617:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1724
JUMPV
LABELV $1731
line 2619
;2618:	}
;2619:	if( !G_admin_name_check( victim, newname, err, sizeof( err ) ) ) {
ADDRLP4 2340
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 1312
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2428
ADDRGP4 G_admin_name_check
CALLI4
ASGNI4
ADDRLP4 2428
INDIRI4
CNSTI4 0
NEI4 $1734
line 2620
;2620:		ADMP( va( "^3!rename: ^7%s\n", err ) );
ADDRGP4 $1730
ARGP4
ADDRLP4 1312
ARGP4
ADDRLP4 2432
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 2432
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2621
;2621:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1724
JUMPV
LABELV $1734
line 2625
;2622:	}
;2623:
;2624:	//KK-OAX Since NameChanges are not going to be implemented just yet...let's ignore this.
;2625:	level.clients[ pids[ 0 ] ].pers.nameChanges--;
ADDRLP4 2432
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1016
ADDP4
ASGNP4
ADDRLP4 2432
INDIRP4
ADDRLP4 2432
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2626
;2626:	level.clients[ pids[ 0 ] ].pers.nameChangeTime = 0;
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1012
ADDP4
CNSTI4 0
ASGNI4
line 2628
;2627:
;2628:	trap_GetUserinfo( pids[ 0 ], userinfo, sizeof( userinfo ) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 2629
;2629:	s = Info_ValueForKey( userinfo, "name" );
ADDRLP4 288
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 2436
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2336
ADDRLP4 2436
INDIRP4
ASGNP4
line 2630
;2630:	Q_strncpyz( oldname, s, sizeof( oldname ) );
ADDRLP4 2376
ARGP4
ADDRLP4 2336
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2631
;2631:	Info_SetValueForKey( userinfo, "name", newname );
ADDRLP4 288
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 2632
;2632:	trap_SetUserinfo( pids[ 0 ], userinfo );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 288
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 2633
;2633:	ClientUserinfoChanged( pids[ 0 ] );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 2634
;2634:	AP( va( "print \"^3!rename: ^7%s^7 has been renamed to %s^7 by %s\n\"",
ADDRGP4 $1736
ARGP4
ADDRLP4 2376
ARGP4
ADDRLP4 256
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1738
ADDRLP4 2440
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1739
JUMPV
LABELV $1738
ADDRLP4 2440
ADDRGP4 $439
ASGNP4
LABELV $1739
ADDRLP4 2440
INDIRP4
ARGP4
ADDRLP4 2444
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 2444
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2638
;2635:	        oldname,
;2636:	        newname,
;2637:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2638:	return qtrue;
CNSTI4 1
RETI4
LABELV $1724
endproc G_admin_rename 2448 16
lit
align 1
LABELV $1741
byte 1 0
skip 255
export G_admin_restart
code
proc G_admin_restart 324 12
line 2643
;2639:}
;2640:
;2641://KK-Will Fix this For OAPub
;2642:qboolean G_admin_restart( gentity_t *ent, int skiparg )
;2643:{
line 2644
;2644:	char layout[ MAX_CVAR_VALUE_STRING ] = { "" };
ADDRLP4 0
ADDRGP4 $1741
INDIRB
ASGNB 256
line 2646
;2645:
;2646:	if( G_SayArgc( ) > 1 + skiparg ) {
ADDRLP4 256
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
LEI4 $1742
line 2649
;2647:		char map[ MAX_QPATH ];
;2648:
;2649:		trap_Cvar_VariableStringBuffer( "mapname", map, sizeof( map ) );
ADDRGP4 $1744
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2650
;2650:		G_SayArgv( skiparg + 1, layout, sizeof( layout ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2652
;2651:
;2652:	}
LABELV $1742
line 2654
;2653:
;2654:	trap_SendConsoleCommand( EXEC_APPEND, "map_restart" );
CNSTI4 2
ARGI4
ADDRGP4 $1745
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2655
;2655:	AP( va( "print \"^3!restart: ^7map restarted by %s \n\"",
ADDRGP4 $1746
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1748
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1749
JUMPV
LABELV $1748
ADDRLP4 260
ADDRGP4 $439
ASGNP4
LABELV $1749
ADDRLP4 260
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2657
;2656:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2657:	return qtrue;
CNSTI4 1
RETI4
LABELV $1740
endproc G_admin_restart 324 12
export G_admin_nextmap
proc G_admin_nextmap 16 8
line 2661
;2658:}
;2659:
;2660:qboolean G_admin_nextmap( gentity_t *ent, int skiparg )
;2661:{
line 2662
;2662:	AP( va( "print \"^3!nextmap: ^7%s^7 decided to load the next map\n\"",
ADDRGP4 $1751
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1753
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1754
JUMPV
LABELV $1753
ADDRLP4 0
ADDRGP4 $439
ASGNP4
LABELV $1754
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
line 2666
;2663:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2664:	//level.lastWin = TEAM_NONE;
;2665:	//trap_SetConfigstring( CS_WINNER, "NextMap" );
;2666:	LogExit( va( "nextmap was run by %s", ( ent ) ? ent->client->pers.netname : "console" ) );
ADDRGP4 $1755
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1757
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1758
JUMPV
LABELV $1757
ADDRLP4 8
ADDRGP4 $439
ASGNP4
LABELV $1758
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 2667
;2667:	return qtrue;
CNSTI4 1
RETI4
LABELV $1750
endproc G_admin_nextmap 16 8
lit
align 1
LABELV $1760
byte 1 0
skip 31
align 1
LABELV $1761
byte 1 0
skip 31
align 1
LABELV $1762
byte 1 0
skip 31
export G_admin_namelog
code
proc G_admin_namelog 152 16
line 2671
;2668:}
;2669:
;2670:qboolean G_admin_namelog( gentity_t *ent, int skiparg )
;2671:{
line 2673
;2672:	int i, j;
;2673:	char search[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 88
ADDRGP4 $1760
INDIRB
ASGNB 32
line 2674
;2674:	char s2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 49
ADDRGP4 $1761
INDIRB
ASGNB 32
line 2675
;2675:	char n2[ MAX_NAME_LENGTH ] = {""};
ADDRLP4 8
ADDRGP4 $1762
INDIRB
ASGNB 32
line 2677
;2676:	char guid_stub[ 9 ];
;2677:	qboolean found = qfalse;
ADDRLP4 84
CNSTI4 0
ASGNI4
line 2678
;2678:	int printed = 0;
ADDRLP4 120
CNSTI4 0
ASGNI4
line 2680
;2679:
;2680:	if( G_SayArgc() > 1 + skiparg ) {
ADDRLP4 124
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
LEI4 $1763
line 2681
;2681:		G_SayArgv( 1 + skiparg, search, sizeof( search ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 88
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2682
;2682:		G_SanitiseString( search, s2, sizeof( s2 ) );
ADDRLP4 88
ARGP4
ADDRLP4 49
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2683
;2683:	}
LABELV $1763
line 2684
;2684:	ADMBP_begin();
ADDRGP4 G_admin_buffer_begin
CALLV
pop
line 2685
;2685:	for( i = 0; i < MAX_ADMIN_NAMELOGS && g_admin_namelog[ i ]; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1768
JUMPV
LABELV $1765
line 2686
;2686:		if( search[ 0 ] ) {
ADDRLP4 88
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1769
line 2687
;2687:			found = qfalse;
ADDRLP4 84
CNSTI4 0
ASGNI4
line 2688
;2688:			for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1774
JUMPV
LABELV $1771
line 2689
;2689:			        g_admin_namelog[ i ]->name[ j ][ 0 ]; j++ ) {
line 2690
;2690:				G_SanitiseString( g_admin_namelog[ i ]->name[ j ], n2, sizeof( n2 ) );
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 2691
;2691:				if( strstr( n2, s2 ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 49
ARGP4
ADDRLP4 128
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1775
line 2692
;2692:					found = qtrue;
ADDRLP4 84
CNSTI4 1
ASGNI4
line 2693
;2693:					break;
ADDRGP4 $1773
JUMPV
LABELV $1775
line 2695
;2694:				}
;2695:			}
LABELV $1772
line 2689
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1774
line 2688
ADDRLP4 132
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $1777
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1771
LABELV $1777
LABELV $1773
line 2696
;2696:			if( !found )
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $1778
line 2697
;2697:				continue;
ADDRGP4 $1766
JUMPV
LABELV $1778
line 2698
;2698:		}
LABELV $1769
line 2699
;2699:		printed++;
ADDRLP4 120
ADDRLP4 120
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2700
;2700:		for( j = 0; j < 8; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1780
line 2701
;2701:			guid_stub[ j ] = g_admin_namelog[ i ]->guid[ j + 24 ];
ADDRLP4 0
INDIRI4
ADDRLP4 40
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 224
ADDP4
ADDP4
INDIRI1
ASGNI1
LABELV $1781
line 2700
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1780
line 2702
;2702:		guid_stub[ j ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 40
ADDP4
CNSTI1 0
ASGNI1
line 2703
;2703:		if( g_admin_namelog[ i ]->slot > -1 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $1784
line 2704
;2704:			ADMBP( "^3" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1088
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
LABELV $1784
line 2705
;2705:		ADMBP( va( "%-2s (*%s) %15s^7",
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 -1
LEI4 $1788
ADDRGP4 $1045
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 132
ADDRLP4 136
INDIRP4
ASGNP4
ADDRGP4 $1789
JUMPV
LABELV $1788
ADDRLP4 132
ADDRGP4 $1090
ASGNP4
LABELV $1789
ADDRGP4 $1786
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 140
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2709
;2706:		           ( g_admin_namelog[ i ]->slot > -1 ) ?
;2707:		           va( "%d", g_admin_namelog[ i ]->slot ) : "-",
;2708:		           guid_stub, g_admin_namelog[ i ]->ip ) );
;2709:		for( j = 0; j < MAX_ADMIN_NAMELOG_NAMES &&
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1793
JUMPV
LABELV $1790
line 2710
;2710:		        g_admin_namelog[ i ]->name[ j ][ 0 ]; j++ ) {
line 2711
;2711:			ADMBP( va( " '%s^7'", g_admin_namelog[ i ]->name[ j ] ) );
ADDRGP4 $1794
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
ARGP4
ADDRLP4 144
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2712
;2712:		}
LABELV $1791
line 2710
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1793
line 2709
ADDRLP4 148
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 148
INDIRI4
GEI4 $1795
ADDRLP4 0
INDIRI4
ADDRLP4 148
INDIRI4
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1790
LABELV $1795
line 2713
;2713:		ADMBP( "\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2714
;2714:	}
LABELV $1766
line 2685
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1768
ADDRLP4 4
INDIRI4
CNSTI4 128
GEI4 $1796
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_namelog
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1765
LABELV $1796
line 2715
;2715:	ADMBP( va( "^3!namelog:^7 %d recent clients found\n", printed ) );
ADDRGP4 $1797
ARGP4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_print
CALLV
pop
line 2716
;2716:	ADMBP_end();
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_admin_buffer_end
CALLV
pop
line 2717
;2717:	return qtrue;
CNSTI4 1
RETI4
LABELV $1759
endproc G_admin_namelog 152 16
lit
align 1
LABELV $1799
byte 1 0
skip 1
export G_admin_lock
code
proc G_admin_lock 28 12
line 2721
;2718:}
;2719:
;2720:qboolean G_admin_lock( gentity_t *ent, int skiparg )
;2721:{
line 2722
;2722:	char teamName[2] = {""};
ADDRLP4 0
ADDRGP4 $1799
INDIRB
ASGNB 2
line 2725
;2723:	team_t team;
;2724:
;2725:	if( G_SayArgc() < 2 + skiparg ) {
ADDRLP4 8
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1800
line 2726
;2726:		ADMP( "^3!lock: ^7usage: !lock [r|b|f]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1802
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2727
;2727:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1798
JUMPV
LABELV $1800
line 2729
;2728:	}
;2729:	G_SayArgv( 1 + skiparg, teamName, sizeof( teamName ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2730
;2730:	team = G_TeamFromString( teamName );
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 G_TeamFromString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2732
;2731:
;2732:	if( team == TEAM_RED ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1803
line 2733
;2733:		if( level.RedTeamLocked ) {
ADDRGP4 level+9464
INDIRI4
CNSTI4 0
EQI4 $1805
line 2734
;2734:			ADMP( "^3!lock: ^7the Red team is already locked\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1808
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2735
;2735:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1798
JUMPV
LABELV $1805
line 2737
;2736:		}
;2737:		level.RedTeamLocked = qtrue;
ADDRGP4 level+9464
CNSTI4 1
ASGNI4
line 2738
;2738:	}
ADDRGP4 $1804
JUMPV
LABELV $1803
line 2739
;2739:	else if( team == TEAM_BLUE ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $1810
line 2740
;2740:		if( level.BlueTeamLocked ) {
ADDRGP4 level+9468
INDIRI4
CNSTI4 0
EQI4 $1812
line 2741
;2741:			ADMP( "^3!lock: ^7the Blue team is already locked\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1815
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2742
;2742:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1798
JUMPV
LABELV $1812
line 2744
;2743:		}
;2744:		level.BlueTeamLocked = qtrue;
ADDRGP4 level+9468
CNSTI4 1
ASGNI4
line 2745
;2745:	}
ADDRGP4 $1811
JUMPV
LABELV $1810
line 2746
;2746:	else if(team == TEAM_FREE ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1817
line 2747
;2747:		if( level.FFALocked ) {
ADDRGP4 level+9472
INDIRI4
CNSTI4 0
EQI4 $1819
line 2748
;2748:			ADMP( "^3!lock: ^7DeathMatch is already Locked!!!\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1822
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2749
;2749:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1798
JUMPV
LABELV $1819
line 2751
;2750:		}
;2751:		level.FFALocked = qtrue;
ADDRGP4 level+9472
CNSTI4 1
ASGNI4
line 2752
;2752:	}
ADDRGP4 $1818
JUMPV
LABELV $1817
line 2753
;2753:	else {
line 2754
;2754:		ADMP( va( "^3!lock: ^7invalid team\"%c\"\n", teamName[0] ) );
ADDRGP4 $1824
ARGP4
ADDRLP4 0
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2755
;2755:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1798
JUMPV
LABELV $1818
LABELV $1811
LABELV $1804
line 2758
;2756:	}
;2757:
;2758:	AP( va( "print \"^3!lock: ^7the %s team has been locked by %s\n\"",
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 BG_TeamName
CALLP4
ASGNP4
ADDRGP4 $1825
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1827
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1828
JUMPV
LABELV $1827
ADDRLP4 16
ADDRGP4 $439
ASGNP4
LABELV $1828
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2761
;2759:	        BG_TeamName( team ),
;2760:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2761:	return qtrue;
CNSTI4 1
RETI4
LABELV $1798
endproc G_admin_lock 28 12
lit
align 1
LABELV $1830
byte 1 0
skip 1
export G_admin_unlock
code
proc G_admin_unlock 28 12
line 2765
;2762:}
;2763:
;2764:qboolean G_admin_unlock( gentity_t *ent, int skiparg )
;2765:{
line 2766
;2766:	char teamName[2] = {""};
ADDRLP4 0
ADDRGP4 $1830
INDIRB
ASGNB 2
line 2769
;2767:	team_t team;
;2768:
;2769:	if( G_SayArgc() < 2 + skiparg ) {
ADDRLP4 8
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1831
line 2770
;2770:		ADMP( "^3!unlock: ^7usage: !unlock [r|b|f]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1833
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2771
;2771:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1831
line 2773
;2772:	}
;2773:	G_SayArgv( 1 + skiparg, teamName, sizeof( teamName ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2774
;2774:	team = G_TeamFromString( teamName );
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 G_TeamFromString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2776
;2775:
;2776:	if( team == TEAM_RED ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1834
line 2777
;2777:		if( !level.RedTeamLocked ) {
ADDRGP4 level+9464
INDIRI4
CNSTI4 0
NEI4 $1836
line 2778
;2778:			ADMP( "^3!unlock: ^7the Red team is not currently locked\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1839
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2779
;2779:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1836
line 2781
;2780:		}
;2781:		level.RedTeamLocked = qfalse;
ADDRGP4 level+9464
CNSTI4 0
ASGNI4
line 2782
;2782:	}
ADDRGP4 $1835
JUMPV
LABELV $1834
line 2783
;2783:	else if( team == TEAM_BLUE ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $1841
line 2784
;2784:		if( !level.BlueTeamLocked ) {
ADDRGP4 level+9468
INDIRI4
CNSTI4 0
NEI4 $1843
line 2785
;2785:			ADMP( "^3!unlock: ^7the Blue team is not currently locked\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1846
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2786
;2786:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1843
line 2788
;2787:		}
;2788:		level.BlueTeamLocked = qfalse;
ADDRGP4 level+9468
CNSTI4 0
ASGNI4
line 2789
;2789:	}
ADDRGP4 $1842
JUMPV
LABELV $1841
line 2790
;2790:	else if( team == TEAM_FREE ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1848
line 2791
;2791:		if( !level.FFALocked ) {
ADDRGP4 level+9472
INDIRI4
CNSTI4 0
NEI4 $1850
line 2792
;2792:			ADMP( "^!unlock: ^7Deathmatch is not currently Locked!!!\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1853
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2793
;2793:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1850
line 2795
;2794:		}
;2795:		level.FFALocked = qfalse;
ADDRGP4 level+9472
CNSTI4 0
ASGNI4
line 2796
;2796:	}
ADDRGP4 $1849
JUMPV
LABELV $1848
line 2797
;2797:	else {
line 2798
;2798:		ADMP( va( "^3!unlock: ^7invalid team\"%c\"\n", teamName[0] ) );
ADDRGP4 $1855
ARGP4
ADDRLP4 0
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2799
;2799:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1849
LABELV $1842
LABELV $1835
line 2801
;2800:	}
;2801:	AP( va( "print \"^3!unlock: ^7the %s team has been unlocked by %s\n\"",
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 BG_TeamName
CALLP4
ASGNP4
ADDRGP4 $1856
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1858
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1859
JUMPV
LABELV $1858
ADDRLP4 16
ADDRGP4 $439
ASGNP4
LABELV $1859
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2804
;2802:	        BG_TeamName( team ),
;2803:	        ( ent ) ? ent->client->pers.netname : "console" ) );
;2804:	return qtrue;
CNSTI4 1
RETI4
LABELV $1829
endproc G_admin_unlock 28 12
export G_admin_disorient
proc G_admin_disorient 1364 16
line 2808
;2805:}
;2806://KK-OAX Begin Addition
;2807:qboolean G_admin_disorient(gentity_t *ent, int skiparg)
;2808:{
line 2814
;2809:	int pids[MAX_CLIENTS], found;
;2810:	char name[MAX_NAME_LENGTH], err[MAX_STRING_CHARS];
;2811:	char *reason;
;2812:	gentity_t *vic;
;2813:
;2814:	if(G_SayArgc() < 2+skiparg) {
ADDRLP4 1324
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1861
line 2815
;2815:		ADMP("^/disorient usage: ^7!disorient [name|slot#] [reason]");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1863
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2816
;2816:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1860
JUMPV
LABELV $1861
line 2818
;2817:	}
;2818:	G_SayArgv(1+skiparg, name, sizeof(name));
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2819
;2819:	reason = G_SayConcatArgs(2+skiparg);
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1328
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1328
INDIRP4
ASGNP4
line 2821
;2820:
;2821:	if((found = G_ClientNumbersFromString(name, pids, MAX_CLIENTS)) != 1) {
ADDRLP4 264
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1332
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 1332
INDIRI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 1
EQI4 $1864
line 2822
;2822:		G_MatchOnePlayer(pids, found, err, sizeof(err));
ADDRLP4 8
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRLP4 300
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 2823
;2823:		ADMP(va("^/disorient: ^7%s", err));
ADDRGP4 $1866
ARGP4
ADDRLP4 300
ARGP4
ADDRLP4 1336
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1336
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2824
;2824:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1860
JUMPV
LABELV $1864
line 2826
;2825:	}
;2826:	vic = &g_entities[pids[0]];
ADDRLP4 0
CNSTI4 816
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2827
;2827:	if(!admin_higher(ent, vic)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1336
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1336
INDIRI4
CNSTI4 0
NEI4 $1867
line 2828
;2828:		ADMP("^/disorient: ^7sorry, but your intended victim has a higher admin level than you do");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1869
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2829
;2829:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1860
JUMPV
LABELV $1867
line 2832
;2830:	}
;2831:
;2832:	if(!(vic->client->sess.sessionTeam == TEAM_RED ||
ADDRLP4 1340
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1340
INDIRI4
CNSTI4 1
EQI4 $1870
ADDRLP4 1340
INDIRI4
CNSTI4 2
EQI4 $1870
ADDRLP4 1340
INDIRI4
CNSTI4 0
EQI4 $1870
line 2834
;2833:	        vic->client->sess.sessionTeam == TEAM_BLUE ||
;2834:	        vic->client->sess.sessionTeam == TEAM_FREE )) {
line 2835
;2835:		ADMP("^/disorient: ^7player must be on a team");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1872
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2836
;2836:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1860
JUMPV
LABELV $1870
line 2838
;2837:	}
;2838:	if(vic->client->pers.disoriented) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1873
line 2839
;2839:		ADMP(va("^/disorient: ^7%s^7 is already disoriented",
ADDRGP4 $1875
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1344
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1344
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2841
;2840:		        vic->client->pers.netname));
;2841:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1860
JUMPV
LABELV $1873
line 2843
;2842:	}
;2843:	vic->client->pers.disoriented = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 1
ASGNI4
line 2844
;2844:	AP(va("chat \"^/disorient: ^7%s ^7is disoriented\" -1",
ADDRGP4 $1876
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1344
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1344
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2847
;2845:	      vic->client->pers.netname));
;2846:
;2847:	CPx(pids[0], va("cp \"%s ^7disoriented you%s%s\"",
ADDRGP4 $1877
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1883
ADDRLP4 1348
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1884
JUMPV
LABELV $1883
ADDRLP4 1348
ADDRGP4 $1878
ASGNP4
LABELV $1884
ADDRLP4 1348
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1885
ADDRLP4 1352
ADDRGP4 $1880
ASGNP4
ADDRGP4 $1886
JUMPV
LABELV $1885
ADDRLP4 1352
ADDRGP4 $67
ASGNP4
LABELV $1886
ADDRLP4 1352
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1887
ADDRLP4 1356
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $1888
JUMPV
LABELV $1887
ADDRLP4 1356
ADDRGP4 $67
ASGNP4
LABELV $1888
ADDRLP4 1356
INDIRP4
ARGP4
ADDRLP4 1360
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1360
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2851
;2848:	                (ent?ent->client->pers.netname:"^3SERVER CONSOLE"),
;2849:	                (*reason) ? " because:\n" : "",
;2850:	                (*reason) ? reason : ""));
;2851:	return qtrue;
CNSTI4 1
RETI4
LABELV $1860
endproc G_admin_disorient 1364 16
export G_admin_orient
proc G_admin_orient 1340 16
line 2854
;2852:}
;2853:qboolean G_admin_orient(gentity_t *ent, int skiparg)
;2854:{
line 2859
;2855:	int pids[MAX_CLIENTS], found;
;2856:	char name[MAX_NAME_LENGTH], err[MAX_STRING_CHARS];
;2857:	gentity_t *vic;
;2858:
;2859:	if(G_SayArgc() < 2+skiparg) {
ADDRLP4 1320
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1890
line 2860
;2860:		ADMP("^/orient usage: ^7!orient [name|slot#]");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1892
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2861
;2861:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1889
JUMPV
LABELV $1890
line 2863
;2862:	}
;2863:	G_SayArgv(1+skiparg, name, sizeof(name));
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2865
;2864:	//Fix
;2865:	if((found = G_ClientNumbersFromString(name, pids, MAX_CLIENTS)) != 1) {
ADDRLP4 260
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1324
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 292
ADDRLP4 1324
INDIRI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 1
EQI4 $1893
line 2866
;2866:		G_MatchOnePlayer(pids, found, err, sizeof(err));
ADDRLP4 4
ARGP4
ADDRLP4 292
INDIRI4
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 2867
;2867:		ADMP(va("^/orient: ^7%s", err));
ADDRGP4 $1895
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 1328
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2868
;2868:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1889
JUMPV
LABELV $1893
line 2870
;2869:	}
;2870:	vic = &g_entities[pids[0]];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2872
;2871:
;2872:	if(!vic->client->pers.disoriented) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1896
line 2873
;2873:		ADMP(va("^/orient: ^7%s^7 is not currently disoriented",
ADDRGP4 $1898
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1328
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2875
;2874:		        vic->client->pers.netname));
;2875:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1889
JUMPV
LABELV $1896
line 2877
;2876:	}
;2877:	vic->client->pers.disoriented = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 0
ASGNI4
line 2878
;2878:	AP(va("chat \"^/orient: ^7%s ^7is no longer disoriented\" -1",
ADDRGP4 $1899
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1328
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2881
;2879:	      vic->client->pers.netname));
;2880:
;2881:	CPx(pids[0], va("cp \"%s ^7oriented you\"",
ADDRGP4 $1900
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1902
ADDRLP4 1332
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1903
JUMPV
LABELV $1902
ADDRLP4 1332
ADDRGP4 $1878
ASGNP4
LABELV $1903
ADDRLP4 1332
INDIRP4
ARGP4
ADDRLP4 1336
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1336
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2883
;2882:	                (ent?ent->client->pers.netname:"^3SERVER CONSOLE")));
;2883:	return qtrue;
CNSTI4 1
RETI4
LABELV $1889
endproc G_admin_orient 1340 16
export G_admin_slap
proc G_admin_slap 1380 32
line 2887
;2884:}
;2885:
;2886:qboolean G_admin_slap( gentity_t *ent, int skiparg )
;2887:{
line 2897
;2888:	int pids[MAX_CLIENTS], found, dmg;
;2889:	char name[MAX_NAME_LENGTH], err[MAX_STRING_CHARS];
;2890:	char *reason;
;2891:	char damage[4];
;2892:	gentity_t *vic;
;2893:	int soundIndex;
;2894:
;2895:	//KK-Too many Parameters Check removed.  It'll truncate the reason message.
;2896:
;2897:	if(G_SayArgc() < 2+skiparg) {
ADDRLP4 1336
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1336
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
GEI4 $1905
line 2898
;2898:		ADMP("^/slap usage: ^7!slap [name|slot#] [reason] [damage]");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1907
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2899
;2899:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1904
JUMPV
LABELV $1905
line 2902
;2900:	}
;2901:
;2902:	G_SayArgv(1+skiparg, name, sizeof(name));
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 268
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2903
;2903:	G_SayArgv(2+skiparg, damage, sizeof(damage));
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 300
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 2905
;2904:
;2905:	dmg = atoi(damage);
ADDRLP4 300
ARGP4
ADDRLP4 1340
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1340
INDIRI4
ASGNI4
line 2906
;2906:	if(!dmg) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1908
line 2907
;2907:		dmg = 25;
ADDRLP4 4
CNSTI4 25
ASGNI4
line 2908
;2908:		reason = G_SayConcatArgs(2+skiparg);
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1344
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1344
INDIRP4
ASGNP4
line 2909
;2909:	}
ADDRGP4 $1909
JUMPV
LABELV $1908
line 2910
;2910:	else {
line 2911
;2911:		reason = G_SayConcatArgs(3+skiparg);
ADDRFP4 4
INDIRI4
CNSTI4 3
ADDI4
ARGI4
ADDRLP4 1344
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1344
INDIRP4
ASGNP4
line 2912
;2912:	}
LABELV $1909
line 2914
;2913:
;2914:	if((found = G_ClientNumbersFromString(name, pids, MAX_CLIENTS)) != 1) {
ADDRLP4 268
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1344
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 308
ADDRLP4 1344
INDIRI4
ASGNI4
ADDRLP4 1344
INDIRI4
CNSTI4 1
EQI4 $1910
line 2915
;2915:		G_MatchOnePlayer(pids, found, err, sizeof(err));
ADDRLP4 12
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 2916
;2916:		ADMP(va("^/slap: ^7%s", err));
ADDRGP4 $1912
ARGP4
ADDRLP4 312
ARGP4
ADDRLP4 1348
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1348
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2917
;2917:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1904
JUMPV
LABELV $1910
line 2920
;2918:	}
;2919:
;2920:	vic = &g_entities[pids[0]];
ADDRLP4 0
CNSTI4 816
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2921
;2921:	if(!admin_higher(ent, vic)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1348
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1348
INDIRI4
CNSTI4 0
NEI4 $1913
line 2922
;2922:		ADMP("^/slap: ^7sorry, but your intended victim has a higher admin level than you do");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1915
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2923
;2923:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1904
JUMPV
LABELV $1913
line 2926
;2924:	}
;2925:
;2926:	if(!(vic->client->sess.sessionTeam == TEAM_RED ||
ADDRLP4 1352
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1352
INDIRI4
CNSTI4 1
EQI4 $1916
ADDRLP4 1352
INDIRI4
CNSTI4 2
EQI4 $1916
ADDRLP4 1352
INDIRI4
CNSTI4 0
EQI4 $1916
line 2928
;2927:	        vic->client->sess.sessionTeam == TEAM_BLUE ||
;2928:	        vic->client->sess.sessionTeam == TEAM_FREE )) {
line 2929
;2929:		ADMP("^/slap: ^7player must be in the game!");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1918
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 2930
;2930:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1904
JUMPV
LABELV $1916
line 2933
;2931:	}
;2932:	//Player Not Alive
;2933:	if( vic->health < 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $1919
line 2935
;2934:		//Is Their Body Alive?
;2935:		if(vic->s.eType != ET_INVISIBLE) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
EQI4 $1921
line 2937
;2936:			//Make 'em a Bloody mess
;2937:			G_Damage(vic, NULL, NULL, NULL, NULL, 500, 0, MOD_UNKNOWN);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1356
CNSTP4 0
ASGNP4
ADDRLP4 1356
INDIRP4
ARGP4
ADDRLP4 1356
INDIRP4
ARGP4
ADDRLP4 1360
CNSTP4 0
ASGNP4
ADDRLP4 1360
INDIRP4
ARGP4
ADDRLP4 1360
INDIRP4
ARGP4
CNSTI4 500
ARGI4
ADDRLP4 1364
CNSTI4 0
ASGNI4
ADDRLP4 1364
INDIRI4
ARGI4
ADDRLP4 1364
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 2938
;2938:		}
LABELV $1921
line 2940
;2939:		//Force Their Butt to Respawn
;2940:		ClientSpawn( vic );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 2941
;2941:	}
LABELV $1919
line 2943
;2942:	// Will the Slap Kill them? (Obviously false if we Respawned 'em)
;2943:	if(!(vic->health > dmg )) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
GTI4 $1923
line 2944
;2944:		vic->health = 1;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 1
ASGNI4
line 2945
;2945:	}
ADDRGP4 $1924
JUMPV
LABELV $1923
line 2946
;2946:	else { //If it won't kill em...Do the full Damage
line 2947
;2947:		vic->health -= dmg;
ADDRLP4 1356
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 1356
INDIRP4
ADDRLP4 1356
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2948
;2948:	}
LABELV $1924
line 2951
;2949:
;2950:	//KK-OAX Play them the slap sound
;2951:	soundIndex = G_SoundIndex("sound/admin/slap.wav");
ADDRGP4 $1925
ARGP4
ADDRLP4 1356
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 1356
INDIRI4
ASGNI4
line 2952
;2952:	G_Sound(vic, CHAN_VOICE, soundIndex );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 304
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 2955
;2953:
;2954:	//Print it to everybody
;2955:	AP(va("chat \"^/slap: ^7%s ^7was slapped\" -1", vic->client->pers.netname));
ADDRGP4 $1926
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1360
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1360
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2957
;2956:	//CenterPrint it to the Person Being Slapped
;2957:	CPx(pids[0], va("cp \"%s ^7slapped you%s%s\"",
ADDRGP4 $1927
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1931
ADDRLP4 1364
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1932
JUMPV
LABELV $1931
ADDRLP4 1364
ADDRGP4 $1878
ASGNP4
LABELV $1932
ADDRLP4 1364
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1933
ADDRLP4 1368
ADDRGP4 $1880
ASGNP4
ADDRGP4 $1934
JUMPV
LABELV $1933
ADDRLP4 1368
ADDRGP4 $67
ASGNP4
LABELV $1934
ADDRLP4 1368
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1935
ADDRLP4 1372
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1936
JUMPV
LABELV $1935
ADDRLP4 1372
ADDRGP4 $67
ASGNP4
LABELV $1936
ADDRLP4 1372
INDIRP4
ARGP4
ADDRLP4 1376
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 1376
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 2961
;2958:	                (ent?ent->client->pers.netname:"^3SERVER CONSOLE"),
;2959:	                (*reason) ? " because:\n" : "",
;2960:	                (*reason) ? reason : ""));
;2961:	return qtrue;
CNSTI4 1
RETI4
LABELV $1904
endproc G_admin_slap 1380 32
export G_admin_warn_check
proc G_admin_warn_check 32 8
line 2967
;2962:}
;2963:
;2964:
;2965://Called Each Time a Warning is Created
;2966:int G_admin_warn_check( gentity_t *ent )
;2967:{
line 2971
;2968:	char *ip, *guid;
;2969:	int i;
;2970:	int t;
;2971:	int numWarnings = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2973
;2972:
;2973:	t = trap_RealTime( NULL );
CNSTP4 0
ARGP4
ADDRLP4 20
ADDRGP4 trap_RealTime
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 2975
;2974:
;2975:	ip   = ent->client->pers.ip;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 945
ADDP4
ASGNP4
line 2978
;2976:
;2977:	//We Don't Want to Count Warnings for the LocalHost
;2978:	if( !*ip )
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1938
line 2979
;2979:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1937
JUMPV
LABELV $1938
line 2981
;2980:
;2981:	guid = ent->client->pers.guid;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 912
ADDP4
ASGNP4
line 2984
;2982:
;2983:	//Just to make sure...Don't want to crash...Will Figure something better out later
;2984:	if( !*guid )
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1940
line 2985
;2985:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1937
JUMPV
LABELV $1940
line 2988
;2986:
;2987:	//For Each Warning, up to the max number of warnings
;2988:	for( i = 0; i < MAX_ADMIN_WARNINGS && g_admin_warnings[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1945
JUMPV
LABELV $1942
line 2990
;2989:		// Ignore Expired Warnings
;2990:		if( ( g_admin_warnings[ i ]->expires - t ) < 1 )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 1
GEI4 $1946
line 2991
;2991:			continue;
ADDRGP4 $1943
JUMPV
LABELV $1946
line 2993
;2992:		//If a warning matches their IP or GUID
;2993:		if( strstr( ip, g_admin_warnings[ i ]->ip ) || strstr( guid, g_admin_warnings[ i ]->guid )) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 65
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1950
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1948
LABELV $1950
line 2994
;2994:			numWarnings++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2995
;2995:		}
LABELV $1948
line 2996
;2996:	}
LABELV $1943
line 2988
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1945
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $1951
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_warnings
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1942
LABELV $1951
line 2998
;2997:	//If we get here, return the number of warnings;
;2998:	return numWarnings;
ADDRLP4 16
INDIRI4
RETI4
LABELV $1937
endproc G_admin_warn_check 32 8
export G_admin_warn
proc G_admin_warn 1460 24
line 3003
;2999:}
;3000:
;3001:
;3002:qboolean G_admin_warn( gentity_t *ent, int skiparg )
;3003:{
line 3015
;3004:	int pids[MAX_CLIENTS], found;
;3005:	int seconds;
;3006:	char name[ MAX_NAME_LENGTH ], err[MAX_STRING_CHARS];
;3007:	char *reason;
;3008:	int minargc;
;3009:	char duration[ 32 ];
;3010:	char s2[ MAX_NAME_LENGTH ];
;3011:	gentity_t *vic;
;3012:	int totalWarnings;
;3013:	int soundIndex;
;3014:
;3015:	if( G_admin_permission( ent, ADMF_UNACCOUNTABLE ) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 1404
ADDRGP4 G_admin_permission
CALLI4
ASGNI4
ADDRLP4 1404
INDIRI4
CNSTI4 0
EQI4 $1953
line 3016
;3016:		minargc = 1 + skiparg;
ADDRLP4 300
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3017
;3017:	}
ADDRGP4 $1954
JUMPV
LABELV $1953
line 3018
;3018:	else {
line 3019
;3019:		minargc = 2 + skiparg;
ADDRLP4 300
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 3020
;3020:	}
LABELV $1954
line 3022
;3021:
;3022:	if( G_SayArgc() < minargc ) {
ADDRLP4 1408
ADDRGP4 G_SayArgc
CALLI4
ASGNI4
ADDRLP4 1408
INDIRI4
ADDRLP4 300
INDIRI4
GEI4 $1955
line 3023
;3023:		ADMP( "^3!warn: ^7usage: !warn [name|slot|ip] [reason]\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1957
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 3024
;3024:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1955
line 3027
;3025:	}
;3026:
;3027:	G_SayArgv( 1 + skiparg, name, sizeof( name ) );
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SayArgv
CALLI4
pop
line 3028
;3028:	G_SanitiseString( name, s2, sizeof( s2 ) );
ADDRLP4 12
ARGP4
ADDRLP4 336
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_SanitiseString
CALLV
pop
line 3029
;3029:	reason = G_SayConcatArgs(2+skiparg);
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 1412
ADDRGP4 G_SayConcatArgs
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1412
INDIRP4
ASGNP4
line 3031
;3030:
;3031:	seconds = g_warningExpire.integer;
ADDRLP4 4
ADDRGP4 g_warningExpire+12
INDIRI4
ASGNI4
line 3033
;3032:
;3033:	if((found = G_ClientNumbersFromString(name, pids, MAX_CLIENTS)) != 1) {
ADDRLP4 12
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1416
ADDRGP4 G_ClientNumbersFromString
CALLI4
ASGNI4
ADDRLP4 372
ADDRLP4 1416
INDIRI4
ASGNI4
ADDRLP4 1416
INDIRI4
CNSTI4 1
EQI4 $1959
line 3034
;3034:		G_MatchOnePlayer(pids, found, err, sizeof(err));
ADDRLP4 44
ARGP4
ADDRLP4 372
INDIRI4
ARGI4
ADDRLP4 376
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_MatchOnePlayer
CALLV
pop
line 3035
;3035:		ADMP(va("^/warn: ^7%s", err));
ADDRGP4 $1961
ARGP4
ADDRLP4 376
ARGP4
ADDRLP4 1420
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1420
INDIRP4
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 3036
;3036:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1959
line 3039
;3037:	}
;3038:
;3039:	vic = &g_entities[pids[0]];
ADDRLP4 0
CNSTI4 816
ADDRLP4 44
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3040
;3040:	if(!admin_higher(ent, vic)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1420
ADDRGP4 admin_higher
CALLI4
ASGNI4
ADDRLP4 1420
INDIRI4
CNSTI4 0
NEI4 $1962
line 3041
;3041:		ADMP("^/slap: ^7sorry, but your intended victim has a higher admin level than you do");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1915
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 3042
;3042:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1962
line 3045
;3043:	}
;3044:
;3045:	G_admin_duration( ( seconds ) ? seconds : -1,
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1965
ADDRLP4 1424
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $1966
JUMPV
LABELV $1965
ADDRLP4 1424
CNSTI4 -1
ASGNI4
LABELV $1966
ADDRLP4 1424
INDIRI4
ARGI4
ADDRLP4 304
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 G_admin_duration
CALLV
pop
line 3048
;3046:	                  duration, sizeof( duration ) );
;3047:
;3048:	admin_create_warning( ent,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1428
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1428
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1428
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 1428
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 admin_create_warning
CALLI4
pop
line 3054
;3049:	                      vic->client->pers.netname,
;3050:	                      vic->client->pers.guid,
;3051:	                      vic->client->pers.ip,
;3052:	                      seconds, reason );
;3053:
;3054:	if( !g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1967
line 3055
;3055:		ADMP( "^3!warn: ^7WARNING g_admin not set, not saving warning to a file\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1970
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
ADDRGP4 $1968
JUMPV
LABELV $1967
line 3057
;3056:	else
;3057:		admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $1968
line 3060
;3058:
;3059:	//KK, Use The Check Warnings Deal Here
;3060:	totalWarnings = G_admin_warn_check( vic );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1432
ADDRGP4 G_admin_warn_check
CALLI4
ASGNI4
ADDRLP4 1400
ADDRLP4 1432
INDIRI4
ASGNI4
line 3063
;3061:
;3062:	// Play the whistle
;3063:	soundIndex = G_SoundIndex("sound/admin/whistle.wav");
ADDRGP4 $1971
ARGP4
ADDRLP4 1436
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 368
ADDRLP4 1436
INDIRI4
ASGNI4
line 3064
;3064:	G_GlobalSound( soundIndex );
ADDRLP4 368
INDIRI4
ARGI4
ADDRGP4 G_GlobalSound
CALLV
pop
line 3067
;3065:
;3066:	//First Check to make sure g_maxWarnings isn't a Null Value
;3067:	if( g_maxWarnings.integer ) {
ADDRGP4 g_maxWarnings+12
INDIRI4
CNSTI4 0
EQI4 $1972
line 3069
;3068:		//If they have gone over the max number of warnings...
;3069:		if( totalWarnings >= g_maxWarnings.integer ) {
ADDRLP4 1400
INDIRI4
ADDRGP4 g_maxWarnings+12
INDIRI4
LTI4 $1975
line 3071
;3070:			//Give them The Boot till the Warning Expires
;3071:			admin_create_ban( ent,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1440
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1440
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1440
INDIRP4
CNSTI4 912
ADDP4
ARGP4
ADDRLP4 1440
INDIRP4
CNSTI4 945
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $1978
ARGP4
ADDRGP4 admin_create_ban
CALLI4
pop
line 3078
;3072:			                  vic->client->pers.netname,
;3073:			                  vic->client->pers.guid,
;3074:			                  vic->client->pers.ip,
;3075:			                  seconds,
;3076:			                  "Too Many Warnings" );
;3077:
;3078:			if( g_admin.string[ 0 ] )
ADDRGP4 g_admin+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1979
line 3079
;3079:				admin_writeconfig();
ADDRGP4 admin_writeconfig
CALLV
pop
LABELV $1979
line 3081
;3080:
;3081:			trap_SendServerCommand( pids[ 0 ],
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1984
ADDRGP4 $991
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1448
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1444
ADDRLP4 1448
INDIRP4
ASGNP4
ADDRGP4 $1985
JUMPV
LABELV $1984
ADDRLP4 1444
ADDRGP4 $1982
ASGNP4
LABELV $1985
ADDRGP4 $990
ARGP4
ADDRLP4 1444
INDIRP4
ARGP4
ADDRGP4 $1978
ARGP4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 3086
;3082:			                        va( "disconnect \"You have been kicked.\n%s^7\nreason:\n%s\"",
;3083:			                            ( ent ) ? va( "admin:\n%s", ent->client->pers.netname ) : "SERVER",
;3084:			                            "Too Many Warnings" ) );
;3085:
;3086:			trap_DropClient( pids[ 0 ], va( "has been kicked%s^7. reason: %s",
ADDRGP4 $998
ARGP4
ADDRGP4 $1986
ARGP4
ADDRGP4 $1978
ARGP4
ADDRLP4 1456
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 1456
INDIRP4
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 3089
;3087:			                                "Auto-Admin System",
;3088:			                                "Too Many Warnings" ) );
;3089:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1975
line 3091
;3090:		}
;3091:		else {
line 3094
;3092:
;3093:			//Print it to everybody
;3094:			AP(va("chat \"^/warn: ^7%s ^7was warned\" -1", vic->client->pers.netname));
ADDRGP4 $1987
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1440
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1440
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 3096
;3095:			//CenterPrint it to the Person Being Slapped
;3096:			CPx(pids[0], va("cp \"%s ^7warned you%s%s\"",
ADDRGP4 $1988
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1992
ADDRLP4 1444
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $1993
JUMPV
LABELV $1992
ADDRLP4 1444
ADDRGP4 $1878
ASGNP4
LABELV $1993
ADDRLP4 1444
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1994
ADDRLP4 1448
ADDRGP4 $1880
ASGNP4
ADDRGP4 $1995
JUMPV
LABELV $1994
ADDRLP4 1448
ADDRGP4 $67
ASGNP4
LABELV $1995
ADDRLP4 1448
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1996
ADDRLP4 1452
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1997
JUMPV
LABELV $1996
ADDRLP4 1452
ADDRGP4 $67
ASGNP4
LABELV $1997
ADDRLP4 1452
INDIRP4
ARGP4
ADDRLP4 1456
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 1456
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 3100
;3097:			                (ent?ent->client->pers.netname:"^3SERVER CONSOLE"),
;3098:			                (*reason) ? " because:\n" : "",
;3099:			                (*reason) ? reason : ""));
;3100:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1952
JUMPV
LABELV $1972
line 3103
;3101:		}
;3102:	}
;3103:	else { //KK-OAX g_maxWarnings is null or 0
line 3104
;3104:		AP(va("chat \"^/warn: ^7%s ^7was warned\" -1", vic->client->pers.netname));
ADDRGP4 $1987
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 1440
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1440
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 3106
;3105:		//CenterPrint it to the Person Being Slapped
;3106:		CPx(pids[0], va("cp \"%s ^7warned you%s%s\"",
ADDRGP4 $1988
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2001
ADDRLP4 1444
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
ADDRGP4 $2002
JUMPV
LABELV $2001
ADDRLP4 1444
ADDRGP4 $1878
ASGNP4
LABELV $2002
ADDRLP4 1444
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2003
ADDRLP4 1448
ADDRGP4 $1880
ASGNP4
ADDRGP4 $2004
JUMPV
LABELV $2003
ADDRLP4 1448
ADDRGP4 $67
ASGNP4
LABELV $2004
ADDRLP4 1448
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2005
ADDRLP4 1452
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $2006
JUMPV
LABELV $2005
ADDRLP4 1452
ADDRGP4 $67
ASGNP4
LABELV $2006
ADDRLP4 1452
INDIRP4
ARGP4
ADDRLP4 1456
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 1456
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 3110
;3107:		                (ent?ent->client->pers.netname:"^3SERVER CONSOLE"),
;3108:		                (*reason) ? " because:\n" : "",
;3109:		                (*reason) ? reason : ""));
;3110:		return qtrue;
CNSTI4 1
RETI4
LABELV $1952
endproc G_admin_warn 1460 24
export G_admin_print
proc G_admin_print 1032 12
line 3126
;3111:	}
;3112:
;3113:}
;3114:
;3115://KK-OAX End Additions
;3116:
;3117:/*
;3118:================
;3119: G_admin_print
;3120:
;3121: This function facilitates the ADMP define.  ADMP() is similar to CP except
;3122: that it prints the message to the server console if ent is not defined.
;3123:================
;3124:*/
;3125:void G_admin_print( gentity_t *ent, char *m )
;3126:{
line 3127
;3127:	if( ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2008
line 3128
;3128:		trap_SendServerCommand( ent - level.gentities, va( "print \"%s\"", m ) );
ADDRGP4 $2011
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level+4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
ADDRGP4 $2009
JUMPV
LABELV $2008
line 3129
;3129:	else {
line 3131
;3130:		char m2[ MAX_STRING_CHARS ];
;3131:		if( !trap_Cvar_VariableIntegerValue( "com_ansiColor" ) ) {
ADDRGP4 $2014
ARGP4
ADDRLP4 1028
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $2012
line 3132
;3132:			G_DecolorString( m, m2, sizeof( m2 ) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 G_DecolorString
CALLV
pop
line 3133
;3133:			trap_Printf( m2 );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 3134
;3134:		}
ADDRGP4 $2013
JUMPV
LABELV $2012
line 3136
;3135:		else
;3136:			trap_Printf( m );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
LABELV $2013
line 3137
;3137:	}
LABELV $2009
line 3138
;3138:}
LABELV $2007
endproc G_admin_print 1032 12
export G_admin_buffer_begin
proc G_admin_buffer_begin 0 0
line 3141
;3139:
;3140:void G_admin_buffer_begin()
;3141:{
line 3142
;3142:	g_bfb[ 0 ] = '\0';
ADDRGP4 g_bfb
CNSTI1 0
ASGNI1
line 3143
;3143:}
LABELV $2015
endproc G_admin_buffer_begin 0 0
export G_admin_buffer_end
proc G_admin_buffer_end 0 8
line 3146
;3144:
;3145:void G_admin_buffer_end( gentity_t *ent )
;3146:{
line 3147
;3147:	ADMP( g_bfb );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 g_bfb
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 3148
;3148:}
LABELV $2016
endproc G_admin_buffer_end 0 8
export G_admin_buffer_print
proc G_admin_buffer_print 8 12
line 3151
;3149:
;3150:void G_admin_buffer_print( gentity_t *ent, char *m )
;3151:{
line 3153
;3152:	// 1022 - strlen("print 64 \"\"") - 1
;3153:	if( strlen( m ) + strlen( g_bfb ) >= 1009 ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 g_bfb
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
CNSTI4 1009
LTI4 $2018
line 3154
;3154:		ADMP( g_bfb );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 g_bfb
ARGP4
ADDRGP4 G_admin_print
CALLV
pop
line 3155
;3155:		g_bfb[ 0 ] = '\0';
ADDRGP4 g_bfb
CNSTI1 0
ASGNI1
line 3156
;3156:	}
LABELV $2018
line 3157
;3157:	Q_strcat( g_bfb, sizeof( g_bfb ), m );
ADDRGP4 g_bfb
ARGP4
CNSTI4 32000
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3158
;3158:}
LABELV $2017
endproc G_admin_buffer_print 8 12
export G_admin_cleanup
proc G_admin_cleanup 20 4
line 3162
;3159:
;3160:
;3161:void G_admin_cleanup()
;3162:{
line 3163
;3163:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3165
;3164:
;3165:	for( i = 0; i < MAX_ADMIN_LEVELS && g_admin_levels[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2024
JUMPV
LABELV $2021
line 3166
;3166:		BG_Free( g_admin_levels[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 3167
;3167:		g_admin_levels[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
CNSTP4 0
ASGNP4
line 3168
;3168:	}
LABELV $2022
line 3165
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2024
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $2025
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_levels
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2021
LABELV $2025
line 3169
;3169:	for( i = 0; i < MAX_ADMIN_ADMINS && g_admin_admins[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2029
JUMPV
LABELV $2026
line 3170
;3170:		BG_Free( g_admin_admins[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 3171
;3171:		g_admin_admins[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
CNSTP4 0
ASGNP4
line 3172
;3172:	}
LABELV $2027
line 3169
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2029
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $2030
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_admins
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2026
LABELV $2030
line 3173
;3173:	for( i = 0; i < MAX_ADMIN_BANS && g_admin_bans[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2034
JUMPV
LABELV $2031
line 3174
;3174:		BG_Free( g_admin_bans[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 3175
;3175:		g_admin_bans[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
CNSTP4 0
ASGNP4
line 3176
;3176:	}
LABELV $2032
line 3173
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2034
ADDRLP4 0
INDIRI4
CNSTI4 1024
GEI4 $2035
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_bans
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2031
LABELV $2035
line 3177
;3177:	for( i = 0; i < MAX_ADMIN_COMMANDS && g_admin_commands[ i ]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2039
JUMPV
LABELV $2036
line 3178
;3178:		BG_Free( g_admin_commands[ i ] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_Free
CALLV
pop
line 3179
;3179:		g_admin_commands[ i ] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
CNSTP4 0
ASGNP4
line 3180
;3180:	}
LABELV $2037
line 3177
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2039
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $2040
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_admin_commands
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2036
LABELV $2040
line 3181
;3181:}
LABELV $2020
endproc G_admin_cleanup 20 4
bss
export g_admin_warnings
align 4
LABELV g_admin_warnings
skip 4096
export g_admin_namelog
align 4
LABELV g_admin_namelog
skip 512
export g_admin_commands
align 4
LABELV g_admin_commands
skip 256
export g_admin_bans
align 4
LABELV g_admin_bans
skip 4096
export g_admin_admins
align 4
LABELV g_admin_admins
skip 4096
export g_admin_levels
align 4
LABELV g_admin_levels
skip 128
align 1
LABELV g_bfb
skip 32000
import G_IsARoundBasedGametype
import G_UsesTheWhiteFlag
import G_UsesTeamFlags
import G_IsATeamGametype
import monster_die
import MapInfoPrint
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
LABELV $2014
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2011
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $1988
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $1987
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 47
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 34
byte 1 32
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1986
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 45
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 83
byte 1 121
byte 1 115
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $1982
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $1978
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $1971
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 47
byte 1 119
byte 1 104
byte 1 105
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1970
byte 1 94
byte 1 51
byte 1 33
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1961
byte 1 94
byte 1 47
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1957
byte 1 94
byte 1 51
byte 1 33
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 124
byte 1 105
byte 1 112
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1927
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $1926
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 34
byte 1 32
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1925
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1918
byte 1 94
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $1915
byte 1 94
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 111
byte 1 0
align 1
LABELV $1912
byte 1 94
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1907
byte 1 94
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 32
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 33
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 32
byte 1 91
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 93
byte 1 0
align 1
LABELV $1900
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 34
byte 1 0
align 1
LABELV $1899
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 47
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 34
byte 1 32
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1898
byte 1 94
byte 1 47
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1895
byte 1 94
byte 1 47
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1892
byte 1 94
byte 1 47
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 33
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 0
align 1
LABELV $1880
byte 1 32
byte 1 98
byte 1 101
byte 1 99
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1878
byte 1 94
byte 1 51
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 32
byte 1 67
byte 1 79
byte 1 78
byte 1 83
byte 1 79
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $1877
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $1876
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 34
byte 1 32
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1875
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1872
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1869
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 111
byte 1 0
align 1
LABELV $1866
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1863
byte 1 94
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 33
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $1856
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
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
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1855
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
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
byte 1 34
byte 1 37
byte 1 99
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $1853
byte 1 94
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 76
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 33
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1846
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1839
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1833
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 91
byte 1 114
byte 1 124
byte 1 98
byte 1 124
byte 1 102
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1825
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
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
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1824
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
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
byte 1 34
byte 1 37
byte 1 99
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $1822
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 76
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 33
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1815
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1808
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1802
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 91
byte 1 114
byte 1 124
byte 1 98
byte 1 124
byte 1 102
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1797
byte 1 94
byte 1 51
byte 1 33
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 111
byte 1 103
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1794
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 0
align 1
LABELV $1786
byte 1 37
byte 1 45
byte 1 50
byte 1 115
byte 1 32
byte 1 40
byte 1 42
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 37
byte 1 49
byte 1 53
byte 1 115
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $1755
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1751
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1746
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1745
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1744
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1736
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1733
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $1730
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1727
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 32
byte 1 91
byte 1 110
byte 1 101
byte 1 119
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1720
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 57
byte 1 57
byte 1 57
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1719
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
LABELV $1701
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 89
byte 1 101
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1689
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1678
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 78
byte 1 111
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1666
byte 1 94
byte 1 51
byte 1 33
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1655
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 108
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 115
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 82
byte 1 69
byte 1 65
byte 1 68
byte 1 89
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1645
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 108
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1631
byte 1 40
byte 1 0
align 1
LABELV $1630
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1608
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1604
byte 1 94
byte 1 51
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1602
byte 1 32
byte 1 94
byte 1 51
byte 1 83
byte 1 121
byte 1 110
byte 1 116
byte 1 97
byte 1 120
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 33
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1601
byte 1 32
byte 1 94
byte 1 51
byte 1 68
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1600
byte 1 94
byte 1 51
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1590
byte 1 32
byte 1 94
byte 1 51
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 39
byte 1 37
byte 1 99
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1588
byte 1 32
byte 1 94
byte 1 51
byte 1 83
byte 1 121
byte 1 110
byte 1 116
byte 1 97
byte 1 120
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 33
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1586
byte 1 32
byte 1 94
byte 1 51
byte 1 70
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1585
byte 1 94
byte 1 51
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 33
byte 1 37
byte 1 115
byte 1 39
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1584
byte 1 94
byte 1 51
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1570
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 91
byte 1 94
byte 1 51
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
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
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1569
byte 1 94
byte 1 51
byte 1 33
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 105
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
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1555
byte 1 94
byte 1 51
byte 1 33
byte 1 37
byte 1 45
byte 1 49
byte 1 50
byte 1 115
byte 1 0
align 1
LABELV $1538
byte 1 32
byte 1 0
align 1
LABELV $1537
byte 1 32
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 33
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1531
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 45
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 116
byte 1 97
byte 1 108
byte 1 41
byte 1 46
byte 1 0
align 1
LABELV $1527
byte 1 73
byte 1 80
byte 1 0
align 1
LABELV $1526
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1521
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 53
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 56
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 48
byte 1 115
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 92
byte 1 95
byte 1 95
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1469
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1436
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $1416
byte 1 41
byte 1 0
align 1
LABELV $1414
byte 1 40
byte 1 97
byte 1 46
byte 1 107
byte 1 46
byte 1 97
byte 1 46
byte 1 32
byte 1 0
align 1
LABELV $1413
byte 1 37
byte 1 50
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 40
byte 1 42
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 94
byte 1 49
byte 1 37
byte 1 49
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1380
byte 1 94
byte 1 53
byte 1 0
align 1
LABELV $1377
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $1374
byte 1 94
byte 1 50
byte 1 0
align 1
LABELV $1373
byte 1 70
byte 1 0
align 1
LABELV $1370
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $1369
byte 1 82
byte 1 0
align 1
LABELV $1366
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $1357
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
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
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1352
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 39
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 39
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1343
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 45
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1342
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1339
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1318
byte 1 94
byte 1 51
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
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
LABELV $1302
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1301
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 49
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 34
byte 1 0
align 1
LABELV $1300
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1294
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1293
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 49
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 34
byte 1 0
align 1
LABELV $1292
byte 1 94
byte 1 51
byte 1 33
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1287
byte 1 94
byte 1 51
byte 1 33
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $1284
byte 1 94
byte 1 51
byte 1 33
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1281
byte 1 94
byte 1 51
byte 1 33
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 37
byte 1 115
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1272
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 109
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1270
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1269
byte 1 94
byte 1 51
byte 1 33
byte 1 109
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1268
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $1265
byte 1 94
byte 1 51
byte 1 33
byte 1 109
byte 1 97
byte 1 112
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 91
byte 1 109
byte 1 97
byte 1 112
byte 1 93
byte 1 32
byte 1 40
byte 1 108
byte 1 97
byte 1 121
byte 1 111
byte 1 117
byte 1 116
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $1258
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1255
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1252
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $1249
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1246
byte 1 94
byte 1 51
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 32
byte 1 91
byte 1 104
byte 1 124
byte 1 97
byte 1 124
byte 1 115
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1228
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $1226
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $1224
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $1222
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1212
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $1207
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1200
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1186
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 105
byte 1 102
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1181
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 105
byte 1 102
byte 1 121
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 97
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1177
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 10
byte 1 0
align 1
LABELV $1171
byte 1 94
byte 1 51
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 91
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 93
byte 1 32
byte 1 91
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1159
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 35
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1156
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1150
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 97
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1146
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 10
byte 1 0
align 1
LABELV $1140
byte 1 94
byte 1 51
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 91
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $1130
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 44
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1123
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 10
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $1116
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 44
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1113
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 73
byte 1 80
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1109
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1102
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 119
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1101
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1098
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $1090
byte 1 45
byte 1 0
align 1
LABELV $1089
byte 1 37
byte 1 45
byte 1 50
byte 1 115
byte 1 32
byte 1 40
byte 1 42
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 37
byte 1 49
byte 1 53
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 39
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $1088
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $1071
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 44
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 73
byte 1 80
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $1068
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 110
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
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
byte 1 44
byte 1 32
byte 1 73
byte 1 80
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $1045
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1032
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $1027
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 97
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 115
byte 1 117
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 97
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1022
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1016
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 124
byte 1 105
byte 1 112
byte 1 93
byte 1 32
byte 1 91
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $999
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $998
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 46
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $991
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $990
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 10
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $983
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $981
byte 1 49
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $980
byte 1 94
byte 1 51
byte 1 33
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 119
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $977
byte 1 94
byte 1 51
byte 1 33
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $974
byte 1 94
byte 1 51
byte 1 33
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $971
byte 1 94
byte 1 51
byte 1 33
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $938
byte 1 94
byte 1 51
byte 1 33
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $930
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $915
byte 1 94
byte 1 51
byte 1 33
byte 1 98
byte 1 97
byte 1 110
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $907
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $895
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 47
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 47
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 32
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $891
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $882
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $881
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $869
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 115
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
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $866
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 94
byte 1 55
byte 1 32
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
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 46
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 100
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $863
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 94
byte 1 55
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 46
byte 1 32
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 33
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 114
byte 1 105
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $828
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 105
byte 1 115
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
LABELV $816
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 97
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $803
byte 1 94
byte 1 51
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 33
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 91
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 32
byte 1 91
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $794
byte 1 94
byte 1 51
byte 1 33
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $776
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $775
byte 1 117
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
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $774
byte 1 91
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $773
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $766
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $755
byte 1 91
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $748
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $745
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $742
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $739
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $734
byte 1 91
byte 1 98
byte 1 97
byte 1 110
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $733
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $730
byte 1 101
byte 1 120
byte 1 112
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $727
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $724
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $713
byte 1 91
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $708
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $701
byte 1 91
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 93
byte 1 32
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $700
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $697
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $694
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $687
byte 1 91
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 93
byte 1 0
align 1
LABELV $682
byte 1 91
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 93
byte 1 0
align 1
LABELV $677
byte 1 91
byte 1 98
byte 1 97
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $672
byte 1 91
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $667
byte 1 91
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 93
byte 1 0
align 1
LABELV $657
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $653
byte 1 94
byte 1 51
byte 1 33
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $641
byte 1 71
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 111
byte 1 103
byte 1 95
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 44
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 111
byte 1 103
byte 1 115
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 10
byte 1 0
align 1
LABELV $593
byte 1 94
byte 1 51
byte 1 33
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $578
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
LABELV $577
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $570
byte 1 66
byte 1 97
byte 1 110
byte 1 110
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
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $567
byte 1 66
byte 1 97
byte 1 110
byte 1 110
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
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 73
byte 1 80
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $566
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $557
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $554
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $550
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $549
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $546
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 104
byte 1 111
byte 1 117
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $543
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $540
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 119
byte 1 101
byte 1 101
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $537
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 121
byte 1 101
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $534
byte 1 80
byte 1 69
byte 1 82
byte 1 77
byte 1 65
byte 1 78
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $489
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 40
byte 1 42
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $487
byte 1 37
byte 1 42
byte 1 115
byte 1 0
align 1
LABELV $447
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $437
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 88
byte 1 0
align 1
LABELV $435
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $434
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $409
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $375
byte 1 42
byte 1 0
align 1
LABELV $373
byte 1 94
byte 1 49
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 79
byte 1 112
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $371
byte 1 105
byte 1 97
byte 1 104
byte 1 67
byte 1 112
byte 1 80
byte 1 119
byte 1 114
byte 1 107
byte 1 109
byte 1 102
byte 1 75
byte 1 110
byte 1 99
byte 1 78
byte 1 63
byte 1 77
byte 1 86
byte 1 100
byte 1 66
byte 1 98
byte 1 101
byte 1 68
byte 1 83
byte 1 53
byte 1 49
byte 1 0
align 1
LABELV $369
byte 1 94
byte 1 51
byte 1 83
byte 1 101
byte 1 110
byte 1 105
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $367
byte 1 105
byte 1 97
byte 1 104
byte 1 67
byte 1 112
byte 1 80
byte 1 119
byte 1 114
byte 1 107
byte 1 109
byte 1 102
byte 1 75
byte 1 110
byte 1 99
byte 1 78
byte 1 63
byte 1 0
align 1
LABELV $365
byte 1 94
byte 1 50
byte 1 74
byte 1 117
byte 1 110
byte 1 105
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $363
byte 1 105
byte 1 97
byte 1 104
byte 1 67
byte 1 112
byte 1 80
byte 1 119
byte 1 114
byte 1 0
align 1
LABELV $361
byte 1 94
byte 1 54
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 97
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $359
byte 1 105
byte 1 97
byte 1 104
byte 1 67
byte 1 0
align 1
LABELV $357
byte 1 94
byte 1 53
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 103
byte 1 117
byte 1 108
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $355
byte 1 97
byte 1 104
byte 1 67
byte 1 0
align 1
LABELV $354
byte 1 94
byte 1 52
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $342
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $341
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $340
byte 1 91
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $332
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $327
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $326
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $325
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $324
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $323
byte 1 91
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $317
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $316
byte 1 101
byte 1 120
byte 1 112
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $315
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $314
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $313
byte 1 105
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $312
byte 1 91
byte 1 98
byte 1 97
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $304
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $303
byte 1 91
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 10
byte 1 0
align 1
LABELV $294
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $293
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $292
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 32
byte 1 32
byte 1 61
byte 1 32
byte 1 0
align 1
LABELV $291
byte 1 91
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $285
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 95
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 58
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $281
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 32
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $266
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $248
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 32
byte 1 98
byte 1 101
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 44
byte 1 32
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $236
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $224
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
LABELV $162
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $161
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $160
byte 1 119
byte 1 0
align 1
LABELV $159
byte 1 119
byte 1 97
byte 1 114
byte 1 110
byte 1 0
align 1
LABELV $158
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 117
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
byte 1 0
align 1
LABELV $157
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $156
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $155
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $154
byte 1 91
byte 1 94
byte 1 51
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $153
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
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
byte 1 32
byte 1 98
byte 1 121
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
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $152
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $151
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 67
byte 1 0
align 1
LABELV $149
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $148
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 57
byte 1 57
byte 1 57
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $147
byte 1 80
byte 1 0
align 1
LABELV $146
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 57
byte 1 57
byte 1 57
byte 1 0
align 1
LABELV $145
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 93
byte 1 32
byte 1 91
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 93
byte 1 32
byte 1 91
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $144
byte 1 82
byte 1 101
byte 1 100
byte 1 117
byte 1 99
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 108
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
byte 1 101
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
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
byte 1 0
align 1
LABELV $143
byte 1 83
byte 1 0
align 1
LABELV $142
byte 1 115
byte 1 108
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $141
byte 1 40
byte 1 94
byte 1 53
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 94
byte 1 55
byte 1 41
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 73
byte 1 80
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $140
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 40
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 41
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $139
byte 1 66
byte 1 0
align 1
LABELV $138
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 98
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $137
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 124
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 91
byte 1 94
byte 1 51
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 0
align 1
LABELV $134
byte 1 115
byte 1 101
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $133
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 40
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 108
byte 1 97
byte 1 121
byte 1 111
byte 1 117
byte 1 116
byte 1 41
byte 1 0
align 1
LABELV $132
byte 1 114
byte 1 0
align 1
LABELV $131
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $130
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $129
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $128
byte 1 78
byte 1 0
align 1
LABELV $127
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $126
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 71
byte 1 0
align 1
LABELV $124
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 0
align 1
LABELV $123
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 91
byte 1 94
byte 1 51
byte 1 104
byte 1 124
byte 1 97
byte 1 124
byte 1 115
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $122
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
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
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $121
byte 1 112
byte 1 0
align 1
LABELV $120
byte 1 112
byte 1 117
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $119
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $118
byte 1 86
byte 1 0
align 1
LABELV $117
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $116
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 32
byte 1 33
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $114
byte 1 103
byte 1 111
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $113
byte 1 110
byte 1 0
align 1
LABELV $112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $111
byte 1 40
byte 1 94
byte 1 53
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $110
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 108
byte 1 121
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
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $107
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $106
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $105
byte 1 109
byte 1 0
align 1
LABELV $104
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 91
byte 1 94
byte 1 51
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $102
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $101
byte 1 77
byte 1 0
align 1
LABELV $100
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $99
byte 1 91
byte 1 94
byte 1 51
byte 1 97
byte 1 124
byte 1 104
byte 1 94
byte 1 55
byte 1 93
byte 1 0
align 1
LABELV $98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $97
byte 1 75
byte 1 0
align 1
LABELV $96
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $95
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $94
byte 1 105
byte 1 0
align 1
LABELV $93
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $92
byte 1 40
byte 1 94
byte 1 53
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 35
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $91
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
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
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $90
byte 1 68
byte 1 0
align 1
LABELV $89
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $88
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $87
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $86
byte 1 107
byte 1 0
align 1
LABELV $85
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $84
byte 1 40
byte 1 94
byte 1 53
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $83
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
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
byte 1 116
byte 1 111
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
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
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $82
byte 1 104
byte 1 0
align 1
LABELV $81
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $80
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 40
byte 1 94
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $79
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
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
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 39
byte 1 115
byte 1 32
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $78
byte 1 100
byte 1 0
align 1
LABELV $77
byte 1 100
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $76
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $75
byte 1 99
byte 1 0
align 1
LABELV $74
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $73
byte 1 91
byte 1 94
byte 1 51
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 124
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 35
byte 1 124
byte 1 73
byte 1 80
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $72
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 97
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
byte 1 73
byte 1 80
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 85
byte 1 73
byte 1 68
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 105
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 46
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
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
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 39
byte 1 119
byte 1 39
byte 1 32
byte 1 40
byte 1 119
byte 1 101
byte 1 101
byte 1 107
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 39
byte 1 100
byte 1 39
byte 1 32
byte 1 40
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 39
byte 1 104
byte 1 39
byte 1 32
byte 1 40
byte 1 104
byte 1 111
byte 1 117
byte 1 114
byte 1 115
byte 1 41
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 109
byte 1 39
byte 1 32
byte 1 40
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 97
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
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $71
byte 1 98
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $70
byte 1 109
byte 1 97
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $69
byte 1 121
byte 1 0
align 1
LABELV $68
byte 1 97
byte 1 108
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $67
byte 1 0
align 1
LABELV $66
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $65
byte 1 97
byte 1 0
align 1
LABELV $64
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $63
byte 1 91
byte 1 94
byte 1 51
byte 1 98
byte 1 97
byte 1 110
byte 1 35
byte 1 94
byte 1 55
byte 1 93
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 32
byte 1 40
byte 1 94
byte 1 53
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $62
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 46
byte 1 32
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
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
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 39
byte 1 119
byte 1 39
byte 1 32
byte 1 40
byte 1 119
byte 1 101
byte 1 101
byte 1 107
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 39
byte 1 100
byte 1 39
byte 1 32
byte 1 40
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 39
byte 1 104
byte 1 39
byte 1 32
byte 1 40
byte 1 104
byte 1 111
byte 1 117
byte 1 114
byte 1 115
byte 1 41
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 39
byte 1 109
byte 1 39
byte 1 32
byte 1 40
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 41
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 97
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
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 43
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 45
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 100
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 116
byte 1 104
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
byte 1 32
byte 1 97
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $61
byte 1 98
byte 1 0
align 1
LABELV $60
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 0
