export G_SpawnString
code
proc G_SpawnString 8 8
file "../../../code/game/g_spawn.c"
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
;21:*/
;22://
;23:
;24:#include "g_local.h"
;25:
;26:qboolean	G_SpawnString( const char *key, const char *defaultString, char **out ) {
line 29
;27:	int		i;
;28:
;29:	if ( !level.spawning ) {
ADDRGP4 level+4520
INDIRI4
CNSTI4 0
NEI4 $61
line 30
;30:		*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 32
;31://		G_Error( "G_SpawnString() called while not spawning" );
;32:	}
LABELV $61
line 34
;33:
;34:	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $67
JUMPV
LABELV $64
line 35
;35:		if ( Q_strequal( key, level.spawnVars[i][0] ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $69
line 36
;36:			*out = level.spawnVars[i][1];
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528+4
ADDP4
INDIRP4
ASGNP4
line 37
;37:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $60
JUMPV
LABELV $69
line 39
;38:		}
;39:	}
LABELV $65
line 34
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $67
ADDRLP4 0
INDIRI4
ADDRGP4 level+4524
INDIRI4
LTI4 $64
line 41
;40:
;41:	*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 42
;42:	return qfalse;
CNSTI4 0
RETI4
LABELV $60
endproc G_SpawnString 8 8
export G_SpawnFloat
proc G_SpawnFloat 16 12
line 45
;43:}
;44:
;45:qboolean	G_SpawnFloat( const char *key, const char *defaultString, float *out ) {
line 49
;46:	char		*s;
;47:	qboolean	present;
;48:
;49:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 50
;50:	*out = atof( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 51
;51:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $74
endproc G_SpawnFloat 16 12
export G_SpawnInt
proc G_SpawnInt 16 12
line 54
;52:}
;53:
;54:qboolean	G_SpawnInt( const char *key, const char *defaultString, int *out ) {
line 58
;55:	char		*s;
;56:	qboolean	present;
;57:
;58:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 59
;59:	*out = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 60
;60:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $75
endproc G_SpawnInt 16 12
export G_SpawnVector
proc G_SpawnVector 16 20
line 63
;61:}
;62:
;63:qboolean	G_SpawnVector( const char *key, const char *defaultString, float *out ) {
line 67
;64:	char		*s;
;65:	qboolean	present;
;66:
;67:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 68
;68:	sscanf( s, "%f %f %f", &out[0], &out[1], &out[2] );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 69
;69:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $76
endproc G_SpawnVector 16 20
data
export fields
align 4
LABELV fields
address $80
byte 4 524
byte 4 2
address $81
byte 4 92
byte 4 4
address $82
byte 4 540
byte 4 2
address $83
byte 4 544
byte 4 2
address $84
byte 4 528
byte 4 0
address $85
byte 4 672
byte 4 1
address $86
byte 4 648
byte 4 2
address $87
byte 4 652
byte 4 2
address $88
byte 4 636
byte 4 2
address $89
byte 4 656
byte 4 2
address $90
byte 4 804
byte 4 1
address $91
byte 4 808
byte 4 1
address $92
byte 4 760
byte 4 0
address $93
byte 4 732
byte 4 0
address $94
byte 4 0
byte 4 9
address $95
byte 4 740
byte 4 0
address $96
byte 4 116
byte 4 4
address $97
byte 4 116
byte 4 5
address $98
byte 4 660
byte 4 2
address $99
byte 4 664
byte 4 2
byte 4 0
skip 8
export SP_item_botroam
code
proc SP_item_botroam 0 0
line 196
;70:}
;71:
;72:
;73:
;74://
;75:// fields are needed for spawning from the entity string
;76://
;77:typedef enum {
;78:	F_INT, 
;79:	F_FLOAT,
;80:	F_LSTRING,			// string on disk, pointer in memory, TAG_LEVEL
;81:	F_GSTRING,			// string on disk, pointer in memory, TAG_GAME
;82:	F_VECTOR,
;83:	F_ANGLEHACK,
;84:	F_ENTITY,			// index on disk, pointer in memory
;85:	F_ITEM,				// index on disk, pointer in memory
;86:	F_CLIENT,			// index on disk, pointer in memory
;87:	F_IGNORE
;88:} fieldtype_t;
;89:
;90:typedef struct
;91:{
;92:	char	*name;
;93:	int		ofs;
;94:	fieldtype_t	type;
;95://	int		flags;
;96:} field_t;
;97:
;98:field_t fields[] = {
;99:	{"classname", FOFS(classname), F_LSTRING},
;100:	{"origin", FOFS(s.origin), F_VECTOR},
;101:	{"model", FOFS(model), F_LSTRING},
;102:	{"model2", FOFS(model2), F_LSTRING},
;103:	{"spawnflags", FOFS(spawnflags), F_INT},
;104:	{"speed", FOFS(speed), F_FLOAT},
;105:	{"target", FOFS(target), F_LSTRING},
;106:	{"targetname", FOFS(targetname), F_LSTRING},
;107:	{"message", FOFS(message), F_LSTRING},
;108:	{"team", FOFS(team), F_LSTRING},
;109:	{"wait", FOFS(wait), F_FLOAT},
;110:	{"random", FOFS(random), F_FLOAT},
;111:	{"count", FOFS(count), F_INT},
;112:	{"health", FOFS(health), F_INT},
;113:	{"light", 0, F_IGNORE},
;114:	{"dmg", FOFS(damage), F_INT},
;115:	{"angles", FOFS(s.angles), F_VECTOR},
;116:	{"angle", FOFS(s.angles), F_ANGLEHACK},
;117:	{"targetShaderName", FOFS(targetShaderName), F_LSTRING},
;118:	{"targetShaderNewName", FOFS(targetShaderNewName), F_LSTRING},
;119:
;120:	{NULL}
;121:};
;122:
;123:
;124:typedef struct {
;125:	char	*name;
;126:	void	(*spawn)(gentity_t *ent);
;127:} spawn_t;
;128:
;129:void SP_info_player_start (gentity_t *ent);
;130:void SP_info_player_deathmatch (gentity_t *ent);
;131:void SP_info_player_intermission (gentity_t *ent);
;132://standard domination:
;133:void SP_domination_point ( gentity_t *ent);
;134:
;135:void SP_info_firstplace(gentity_t *ent);
;136:void SP_info_secondplace(gentity_t *ent);
;137:void SP_info_thirdplace(gentity_t *ent);
;138:void SP_info_podium(gentity_t *ent);
;139:
;140:void SP_func_plat (gentity_t *ent);
;141:void SP_func_static (gentity_t *ent);
;142:void SP_func_rotating (gentity_t *ent);
;143:void SP_func_bobbing (gentity_t *ent);
;144:void SP_func_pendulum( gentity_t *ent );
;145:void SP_func_button (gentity_t *ent);
;146:void SP_func_door (gentity_t *ent);
;147:void SP_func_train (gentity_t *ent);
;148:void SP_func_timer (gentity_t *self);
;149:
;150:void SP_trigger_always (gentity_t *ent);
;151:void SP_trigger_multiple (gentity_t *ent);
;152:void SP_trigger_push (gentity_t *ent);
;153:void SP_trigger_teleport (gentity_t *ent);
;154:void SP_trigger_hurt (gentity_t *ent);
;155:
;156:void SP_target_remove_powerups( gentity_t *ent );
;157:void SP_target_give (gentity_t *ent);
;158:void SP_target_delay (gentity_t *ent);
;159:void SP_target_speaker (gentity_t *ent);
;160:void SP_target_print (gentity_t *ent);
;161:void SP_target_laser (gentity_t *self);
;162:void SP_target_character (gentity_t *ent);
;163:void SP_target_score( gentity_t *ent );
;164:void SP_target_teleporter( gentity_t *ent );
;165:void SP_target_relay (gentity_t *ent);
;166:void SP_target_kill (gentity_t *ent);
;167:void SP_target_position (gentity_t *ent);
;168:void SP_target_location (gentity_t *ent);
;169:void SP_target_push (gentity_t *ent);
;170:
;171:void SP_light (gentity_t *self);
;172:void SP_info_null (gentity_t *self);
;173:void SP_info_notnull (gentity_t *self);
;174:void SP_info_camp (gentity_t *self);
;175:void SP_path_corner (gentity_t *self);
;176:
;177:void SP_misc_teleporter_dest (gentity_t *self);
;178:void SP_misc_model(gentity_t *ent);
;179:void SP_misc_portal_camera(gentity_t *ent);
;180:void SP_misc_portal_surface(gentity_t *ent);
;181:
;182:void SP_shooter_rocket( gentity_t *ent );
;183:void SP_shooter_plasma( gentity_t *ent );
;184:void SP_shooter_grenade( gentity_t *ent );
;185:
;186:void SP_team_CTF_redplayer( gentity_t *ent );
;187:void SP_team_CTF_blueplayer( gentity_t *ent );
;188:
;189:void SP_team_CTF_redspawn( gentity_t *ent );
;190:void SP_team_CTF_bluespawn( gentity_t *ent );
;191:
;192:void SP_team_blueobelisk( gentity_t *ent );
;193:void SP_team_redobelisk( gentity_t *ent );
;194:void SP_team_neutralobelisk( gentity_t *ent );
;195:
;196:void SP_item_botroam( gentity_t *ent ) { }
LABELV $101
endproc SP_item_botroam 0 0
data
export spawns
align 4
LABELV spawns
address $102
address SP_info_player_start
address $103
address SP_info_player_deathmatch
address $104
address SP_info_player_intermission
address $105
address SP_info_player_deathmatch
address $106
address SP_info_player_deathmatch
address $107
address SP_info_player_deathmatch
address $108
address SP_domination_point
address $109
address SP_info_player_deathmatch
address $110
address SP_info_player_deathmatch
address $111
address SP_info_null
address $112
address SP_info_notnull
address $113
address SP_info_camp
address $114
address SP_func_plat
address $115
address SP_func_button
address $116
address SP_func_door
address $117
address SP_func_static
address $118
address SP_func_rotating
address $119
address SP_func_bobbing
address $120
address SP_func_pendulum
address $121
address SP_func_train
address $122
address SP_info_null
address $123
address SP_func_timer
address $124
address SP_trigger_always
address $125
address SP_trigger_multiple
address $126
address SP_trigger_push
address $127
address SP_trigger_teleport
address $128
address SP_trigger_hurt
address $129
address SP_target_give
address $130
address SP_target_remove_powerups
address $131
address SP_target_delay
address $132
address SP_target_speaker
address $133
address SP_target_print
address $134
address SP_target_laser
address $135
address SP_target_score
address $136
address SP_target_teleporter
address $137
address SP_target_relay
address $138
address SP_target_kill
address $139
address SP_target_position
address $140
address SP_target_location
address $141
address SP_target_push
address $94
address SP_light
address $142
address SP_path_corner
address $143
address SP_misc_teleporter_dest
address $144
address SP_misc_model
address $145
address SP_misc_portal_surface
address $146
address SP_misc_portal_camera
address $147
address SP_shooter_rocket
address $148
address SP_shooter_grenade
address $149
address SP_shooter_plasma
address $150
address SP_team_CTF_redplayer
address $151
address SP_team_CTF_blueplayer
address $152
address SP_team_CTF_redspawn
address $153
address SP_team_CTF_bluespawn
address $154
address SP_team_redobelisk
address $155
address SP_team_blueobelisk
address $156
address SP_team_neutralobelisk
address $157
address SP_item_botroam
byte 4 0
byte 4 0
export G_CallSpawn
code
proc G_CallSpawn 268 16
line 291
;197:
;198:spawn_t	spawns[] = {
;199:	// info entities don't do anything at all, but provide positional
;200:	// information for things controlled by other processes
;201:	{"info_player_start", SP_info_player_start},
;202:	{"info_player_deathmatch", SP_info_player_deathmatch},
;203:	{"info_player_intermission", SP_info_player_intermission},
;204://Double Domination player spawn:
;205:	{"info_player_dd", SP_info_player_deathmatch},
;206:	{"info_player_dd_red", SP_info_player_deathmatch},
;207:	{"info_player_dd_blue", SP_info_player_deathmatch},
;208://Standard Domination point spawn:
;209:	{"domination_point", SP_domination_point},
;210:	{"info_player_dom_red", SP_info_player_deathmatch},
;211:	{"info_player_dom_blue", SP_info_player_deathmatch},
;212:
;213:
;214:	{"info_null", SP_info_null},
;215:	{"info_notnull", SP_info_notnull},		// use target_position instead
;216:	{"info_camp", SP_info_camp},
;217:
;218:	{"func_plat", SP_func_plat},
;219:	{"func_button", SP_func_button},
;220:	{"func_door", SP_func_door},
;221:	{"func_static", SP_func_static},
;222:	{"func_rotating", SP_func_rotating},
;223:	{"func_bobbing", SP_func_bobbing},
;224:	{"func_pendulum", SP_func_pendulum},
;225:	{"func_train", SP_func_train},
;226:	{"func_group", SP_info_null},
;227:	{"func_timer", SP_func_timer},			// rename trigger_timer?
;228:
;229:	// Triggers are brush objects that cause an effect when contacted
;230:	// by a living player, usually involving firing targets.
;231:	// While almost everything could be done with
;232:	// a single trigger class and different targets, triggered effects
;233:	// could not be client side predicted (push and teleport).
;234:	{"trigger_always", SP_trigger_always},
;235:	{"trigger_multiple", SP_trigger_multiple},
;236:	{"trigger_push", SP_trigger_push},
;237:	{"trigger_teleport", SP_trigger_teleport},
;238:	{"trigger_hurt", SP_trigger_hurt},
;239:
;240:	// targets perform no action by themselves, but must be triggered
;241:	// by another entity
;242:	{"target_give", SP_target_give},
;243:	{"target_remove_powerups", SP_target_remove_powerups},
;244:	{"target_delay", SP_target_delay},
;245:	{"target_speaker", SP_target_speaker},
;246:	{"target_print", SP_target_print},
;247:	{"target_laser", SP_target_laser},
;248:	{"target_score", SP_target_score},
;249:	{"target_teleporter", SP_target_teleporter},
;250:	{"target_relay", SP_target_relay},
;251:	{"target_kill", SP_target_kill},
;252:	{"target_position", SP_target_position},
;253:	{"target_location", SP_target_location},
;254:	{"target_push", SP_target_push},
;255:
;256:	{"light", SP_light},
;257:	{"path_corner", SP_path_corner},
;258:
;259:	{"misc_teleporter_dest", SP_misc_teleporter_dest},
;260:	{"misc_model", SP_misc_model},
;261:	{"misc_portal_surface", SP_misc_portal_surface},
;262:	{"misc_portal_camera", SP_misc_portal_camera},
;263:
;264:	{"shooter_rocket", SP_shooter_rocket},
;265:	{"shooter_grenade", SP_shooter_grenade},
;266:	{"shooter_plasma", SP_shooter_plasma},
;267:
;268:	{"team_CTF_redplayer", SP_team_CTF_redplayer},
;269:	{"team_CTF_blueplayer", SP_team_CTF_blueplayer},
;270:
;271:	{"team_CTF_redspawn", SP_team_CTF_redspawn},
;272:	{"team_CTF_bluespawn", SP_team_CTF_bluespawn},
;273:
;274:	{"team_redobelisk", SP_team_redobelisk},
;275:	{"team_blueobelisk", SP_team_blueobelisk},
;276:	{"team_neutralobelisk", SP_team_neutralobelisk},
;277:
;278:	{"item_botroam", SP_item_botroam},
;279:
;280:	{NULL, 0}
;281:};
;282:
;283:/*
;284:===============
;285:G_CallSpawn
;286:
;287:Finds the spawn function for the entity and calls it,
;288:returning qfalse if not found
;289:===============
;290:*/
;291:qboolean G_CallSpawn( gentity_t *ent ) {
line 298
;292:	spawn_t	*s;
;293:	gitem_t	*item;
;294:	char cvarname[128];
;295:	char itemname[128];
;296:
;297:		//Construct a replace cvar:
;298:	Com_sprintf(cvarname, sizeof(cvarname), "replace_%s", ent->classname);
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $159
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 301
;299:
;300:		//Look an alternative item up:
;301:		trap_Cvar_VariableStringBuffer(cvarname,itemname,sizeof(itemname));
ADDRLP4 136
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 302
;302:		if(itemname[0]==0) //If nothing found use original
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $160
line 303
;303:			Com_sprintf(itemname, sizeof(itemname), "%s", ent->classname);
ADDRLP4 8
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $162
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $161
JUMPV
LABELV $160
line 305
;304:		else
;305:			G_Printf ("%s replaced by %s\n", ent->classname, itemname);
ADDRGP4 $163
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
LABELV $161
line 308
;306:
;307:
;308:	if ( itemname[0]==0) {
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $164
line 309
;309:		G_Printf ("G_CallSpawn: NULL classname\n");
ADDRGP4 $166
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 310
;310:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $158
JUMPV
LABELV $164
line 314
;311:	}
;312:
;313:	// check item spawn functions
;314:	for ( item=bg_itemlist+1 ; item->classname ; item++ ) {
ADDRLP4 4
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $170
JUMPV
LABELV $167
line 315
;315:		if ( strequals(item->classname, itemname) ) {
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $172
line 316
;316:			G_SpawnItem( ent, item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 317
;317:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $158
JUMPV
LABELV $172
line 319
;318:		}
;319:	}
LABELV $168
line 314
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $170
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $167
line 322
;320:
;321:	// check normal spawn functions
;322:	for ( s=spawns ; s->name ; s++ ) {
ADDRLP4 0
ADDRGP4 spawns
ASGNP4
ADDRGP4 $177
JUMPV
LABELV $174
line 323
;323:		if ( strequals(s->name, itemname) ) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 264
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $178
line 325
;324:			// found it
;325:			s->spawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 326
;326:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $158
JUMPV
LABELV $178
line 328
;327:		}
;328:	}
LABELV $175
line 322
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $177
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $174
line 329
;329:	G_Printf ("%s doesn't have a spawn function\n", itemname);
ADDRGP4 $180
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 330
;330:	return qfalse;
CNSTI4 0
RETI4
LABELV $158
endproc G_CallSpawn 268 16
export G_NewString
proc G_NewString 32 4
line 341
;331:}
;332:
;333:/*
;334:=============
;335:G_NewString
;336:
;337:Builds a copy of the string, translating \n to real linefeeds
;338:so message texts can be multi-line
;339:=============
;340:*/
;341:char *G_NewString( const char *string ) {
line 345
;342:	char	*newb, *new_p;
;343:	int		i,l;
;344:	
;345:	l = strlen(string) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 347
;346:	//KK-OAX Changed to Tremulous's BG_Alloc
;347:	newb = BG_Alloc( l );
ADDRLP4 4
INDIRI4
CVIU4 4
ARGU4
ADDRLP4 20
ADDRGP4 BG_Alloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 349
;348:
;349:	new_p = newb;
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 352
;350:
;351:	// turn \n into a real linefeed
;352:	for ( i=0 ; i< l ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $185
JUMPV
LABELV $182
line 353
;353:		if ((i < l-1) && (string[i] == '\\')) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $186
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $186
line 354
;354:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 355
;355:			if (string[i] == 'n') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 110
NEI4 $188
line 356
;356:				*new_p++ = '\n';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 10
ASGNI1
line 357
;357:			} else {
ADDRGP4 $187
JUMPV
LABELV $188
line 358
;358:				*new_p++ = '\\';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 92
ASGNI1
line 359
;359:			}
line 360
;360:		} else {
ADDRGP4 $187
JUMPV
LABELV $186
line 361
;361:			*new_p++ = string[i];
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 362
;362:		}
LABELV $187
line 363
;363:	}
LABELV $183
line 352
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $185
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $182
line 365
;364:	
;365:	return newb;
ADDRLP4 12
INDIRP4
RETP4
LABELV $181
endproc G_NewString 32 4
export G_ParseField
proc G_ParseField 60 20
line 379
;366:}
;367:
;368:
;369:
;370:
;371:/*
;372:===============
;373:G_ParseField
;374:
;375:Takes a key/value pair and sets the binary values
;376:in a gentity
;377:===============
;378:*/
;379:void G_ParseField( const char *key, const char *value, gentity_t *ent ) {
line 385
;380:	field_t	*f;
;381:	byte	*b;
;382:	float	v;
;383:	vec3_t	vec;
;384:
;385:	for ( f=fields ; f->name ; f++ ) {
ADDRLP4 0
ADDRGP4 fields
ASGNP4
ADDRGP4 $194
JUMPV
LABELV $191
line 386
;386:		if ( Q_strequal(f->name, key) ) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $195
line 388
;387:			// found it
;388:			b = (byte *)ent;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 390
;389:
;390:			switch( f->type ) {
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $190
ADDRLP4 28
INDIRI4
CNSTI4 9
GTI4 $190
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $210
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $210
address $206
address $207
address $200
address $190
address $201
address $208
address $190
address $190
address $190
address $190
code
LABELV $200
line 392
;391:			case F_LSTRING:
;392:				*(char **)(b+f->ofs) = G_NewString (value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_NewString
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 393
;393:				break;
ADDRGP4 $190
JUMPV
LABELV $201
line 395
;394:			case F_VECTOR:
;395:				sscanf (value, "%f %f %f", &vec[0], &vec[1], &vec[2]);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 8+4
ARGP4
ADDRLP4 8+8
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 396
;396:				((float *)(b+f->ofs))[0] = vec[0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 397
;397:				((float *)(b+f->ofs))[1] = vec[1];
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 8+4
INDIRF4
ASGNF4
line 398
;398:				((float *)(b+f->ofs))[2] = vec[2];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8+8
INDIRF4
ASGNF4
line 399
;399:				break;
ADDRGP4 $190
JUMPV
LABELV $206
line 401
;400:			case F_INT:
;401:				*(int *)(b+f->ofs) = atoi(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 402
;402:				break;
ADDRGP4 $190
JUMPV
LABELV $207
line 404
;403:			case F_FLOAT:
;404:				*(float *)(b+f->ofs) = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 405
;405:				break;
ADDRGP4 $190
JUMPV
LABELV $208
line 407
;406:			case F_ANGLEHACK:
;407:				v = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 52
INDIRF4
ASGNF4
line 408
;408:				((float *)(b+f->ofs))[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
line 409
;409:				((float *)(b+f->ofs))[1] = v;
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 410
;410:				((float *)(b+f->ofs))[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 411
;411:				break;
line 414
;412:			default:
;413:			case F_IGNORE:
;414:				break;
line 416
;415:			}
;416:			return;
ADDRGP4 $190
JUMPV
LABELV $195
line 418
;417:		}
;418:	}
LABELV $192
line 385
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $194
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $191
line 419
;419:}
LABELV $190
endproc G_ParseField 60 20
data
align 4
LABELV $212
address $213
address $214
address $215
address $89
address $216
address $217
address $218
address $219
address $220
address $216
address $221
address $222
address $223
address $224
export G_SpawnGEntityFromSpawnVars
code
proc G_SpawnGEntityFromSpawnVars 48 12
line 432
;420:
;421:
;422:
;423:
;424:/*
;425:===================
;426:G_SpawnGEntityFromSpawnVars
;427:
;428:Spawn an entity and fill in all of the level fields from
;429:level.spawnVars[], then call the class specfic spawn function
;430:===================
;431:*/
;432:void G_SpawnGEntityFromSpawnVars( void ) {
line 440
;433:	int			i;
;434:	gentity_t	*ent;
;435:	char		*s, *value, *gametypeName;
;436:	static char *gametypeNames[] = {"ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", 
;437:	"elimination", "ctf", "lms", "dd", "dom", "pos"};
;438:
;439:	// get the next free entity
;440:	ent = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 442
;441:
;442:	for ( i = 0 ; i < level.numSpawnVars ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $228
JUMPV
LABELV $225
line 443
;443:		G_ParseField( level.spawnVars[i][0], level.spawnVars[i][1], ent );
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 level+4528
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ADDRGP4 level+4528+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ParseField
CALLV
pop
line 444
;444:	}
LABELV $226
line 442
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $228
ADDRLP4 0
INDIRI4
ADDRGP4 level+4524
INDIRI4
LTI4 $225
line 447
;445:
;446:	// check for "notsingle" flag
;447:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $233
line 448
;448:		G_SpawnInt( "notsingle", "0", &i );
ADDRGP4 $236
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 449
;449:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $238
line 450
;450:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 451
;451:			return;
ADDRGP4 $211
JUMPV
LABELV $238
line 453
;452:		}
;453:	}
LABELV $233
line 455
;454:	// check for "notteam" flag
;455:	if (G_IsATeamGametype(g_gametype.integer)) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $240
line 456
;456:		G_SpawnInt( "notteam", "0", &i );
ADDRGP4 $243
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 457
;457:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $241
line 458
;458:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 459
;459:			return;
ADDRGP4 $211
JUMPV
line 461
;460:		}
;461:	} else {
LABELV $240
line 462
;462:		G_SpawnInt( "notfree", "0", &i );
ADDRGP4 $246
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 463
;463:		if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $247
line 464
;464:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 465
;465:			return;
ADDRGP4 $211
JUMPV
LABELV $247
line 467
;466:		}
;467:	}
LABELV $241
line 476
;468:
;469:#ifdef MISSIONPACK
;470:	G_SpawnInt( "notta", "0", &i );
;471:	if ( i ) {
;472:		G_FreeEntity( ent );
;473:		return;
;474:	}
;475:#else
;476:	G_SpawnInt( "notq3a", "0", &i );
ADDRGP4 $249
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 477
;477:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $250
line 478
;478:		G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 479
;479:		return;
ADDRGP4 $211
JUMPV
LABELV $250
line 483
;480:	}
;481:#endif
;482:
;483:	if( G_SpawnString( "!gametype", NULL, &value ) ) {
ADDRGP4 $254
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 28
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $252
line 484
;484:		if( g_gametype.integer >= GT_FFA && g_gametype.integer < ARRAY_LEN(gametypeNames) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $255
ADDRGP4 g_gametype+12
INDIRI4
CVIU4 4
CNSTU4 14
GEU4 $255
line 485
;485:			gametypeName = gametypeNames[g_gametype.integer];
ADDRLP4 16
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $212
ADDP4
INDIRP4
ASGNP4
line 487
;486:
;487:			s = strstr( value, gametypeName );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
line 488
;488:			if( s ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
line 489
;489:				G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 490
;490:				return;
ADDRGP4 $211
JUMPV
LABELV $260
line 492
;491:			}
;492:		}
LABELV $255
line 493
;493:	}
LABELV $252
line 495
;494:
;495:	if( G_SpawnString( "gametype", NULL, &value ) ) {
ADDRGP4 $264
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $262
line 496
;496:		if( g_gametype.integer >= GT_FFA && g_gametype.integer < ARRAY_LEN(gametypeNames) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $265
ADDRGP4 g_gametype+12
INDIRI4
CVIU4 4
CNSTU4 14
GEU4 $265
line 497
;497:			gametypeName = gametypeNames[g_gametype.integer];
ADDRLP4 16
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $212
ADDP4
INDIRP4
ASGNP4
line 499
;498:
;499:			s = strstr( value, gametypeName );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
ASGNP4
line 500
;500:			if( !s ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $270
line 501
;501:				G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 502
;502:				return;
ADDRGP4 $211
JUMPV
LABELV $270
line 504
;503:			}
;504:		}
LABELV $265
line 505
;505:	}
LABELV $262
line 508
;506:
;507:	// move editor origin to pos
;508:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 509
;509:	VectorCopy( ent->s.origin, ent->r.currentOrigin );
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 512
;510:
;511:	// if we didn't get a classname, don't bother spawning anything
;512:	if ( !G_CallSpawn( ent ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 G_CallSpawn
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $272
line 513
;513:		G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 514
;514:	}
LABELV $272
line 515
;515:}
LABELV $211
endproc G_SpawnGEntityFromSpawnVars 48 12
export G_AddSpawnVarToken
proc G_AddSpawnVarToken 16 12
line 524
;516:
;517:
;518:
;519:/*
;520:====================
;521:G_AddSpawnVarToken
;522:====================
;523:*/
;524:char *G_AddSpawnVarToken( const char *string ) {
line 528
;525:	int		l;
;526:	char	*dest;
;527:
;528:	l = strlen( string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 529
;529:	if ( level.numSpawnVarChars + l + 1 > MAX_SPAWN_VARS_CHARS ) {
ADDRGP4 level+5040
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 4096
LEI4 $275
line 530
;530:		G_Error( "G_AddSpawnVarToken: MAX_SPAWN_VARS" );
ADDRGP4 $278
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 531
;531:	}
LABELV $275
line 533
;532:
;533:	dest = level.spawnVarChars + level.numSpawnVarChars;
ADDRLP4 4
ADDRGP4 level+5040
INDIRI4
ADDRGP4 level+5044
ADDP4
ASGNP4
line 534
;534:	memcpy( dest, string, l+1 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 536
;535:
;536:	level.numSpawnVarChars += l + 1;
ADDRLP4 12
ADDRGP4 level+5040
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 538
;537:
;538:	return dest;
ADDRLP4 4
INDIRP4
RETP4
LABELV $274
endproc G_AddSpawnVarToken 16 12
export G_ParseSpawnVars
proc G_ParseSpawnVars 2072 8
line 551
;539:}
;540:
;541:/*
;542:====================
;543:G_ParseSpawnVars
;544:
;545:Parses a brace bounded set of key / value pairs out of the
;546:level's entity strings into level.spawnVars[]
;547:
;548:This does not actually spawn an entity.
;549:====================
;550:*/
;551:qboolean G_ParseSpawnVars( void ) {
line 555
;552:	char		keyname[MAX_TOKEN_CHARS];
;553:	char		com_token[MAX_TOKEN_CHARS];
;554:
;555:	level.numSpawnVars = 0;
ADDRGP4 level+4524
CNSTI4 0
ASGNI4
line 556
;556:	level.numSpawnVarChars = 0;
ADDRGP4 level+5040
CNSTI4 0
ASGNI4
line 559
;557:
;558:	// parse the opening brace
;559:	if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2048
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
NEI4 $285
line 561
;560:		// end of spawn string
;561:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $282
JUMPV
LABELV $285
line 563
;562:	}
;563:	if ( com_token[0] != '{' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $291
line 564
;564:		G_Error( "G_ParseSpawnVars: found %s when expecting {",com_token );
ADDRGP4 $289
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 565
;565:	}
ADDRGP4 $291
JUMPV
LABELV $290
line 568
;566:
;567:	// go through all the key / value pairs
;568:	while ( 1 ) {	
line 570
;569:		// parse key
;570:		if ( !trap_GetEntityToken( keyname, sizeof( keyname ) ) ) {
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2052
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
NEI4 $293
line 571
;571:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $295
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 572
;572:		}
LABELV $293
line 574
;573:
;574:		if ( keyname[0] == '}' ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $296
line 575
;575:			break;
ADDRGP4 $292
JUMPV
LABELV $296
line 579
;576:		}
;577:		
;578:		// parse value	
;579:		if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) ) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2056
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 0
NEI4 $298
line 580
;580:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $295
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 581
;581:		}
LABELV $298
line 583
;582:
;583:		if ( com_token[0] == '}' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $300
line 584
;584:			G_Error( "G_ParseSpawnVars: closing brace without data" );
ADDRGP4 $302
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 585
;585:		}
LABELV $300
line 586
;586:		if ( level.numSpawnVars == MAX_SPAWN_VARS ) {
ADDRGP4 level+4524
INDIRI4
CNSTI4 64
NEI4 $303
line 587
;587:			G_Error( "G_ParseSpawnVars: MAX_SPAWN_VARS" );
ADDRGP4 $306
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 588
;588:		}
LABELV $303
line 589
;589:		level.spawnVars[ level.numSpawnVars ][0] = G_AddSpawnVarToken( keyname );
ADDRLP4 1024
ARGP4
ADDRLP4 2060
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+4524
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528
ADDP4
ADDRLP4 2060
INDIRP4
ASGNP4
line 590
;590:		level.spawnVars[ level.numSpawnVars ][1] = G_AddSpawnVarToken( com_token );
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+4524
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+4528+4
ADDP4
ADDRLP4 2064
INDIRP4
ASGNP4
line 591
;591:		level.numSpawnVars++;
ADDRLP4 2068
ADDRGP4 level+4524
ASGNP4
ADDRLP4 2068
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 592
;592:	}
LABELV $291
line 568
ADDRGP4 $290
JUMPV
LABELV $292
line 594
;593:
;594:	return qtrue;
CNSTI4 1
RETI4
LABELV $282
endproc G_ParseSpawnVars 2072 8
export SP_worldspawn
proc SP_worldspawn 20 12
line 606
;595:}
;596:
;597:
;598:
;599:/*QUAKED worldspawn (0 0 0) ?
;600:
;601:Every map should have exactly one worldspawn.
;602:"music"		music wav file
;603:"gravity"	800 is default gravity
;604:"message"	Text to print during connection process
;605:*/
;606:void SP_worldspawn( void ) {
line 609
;607:	char	*s;
;608:
;609:	G_SpawnString( "classname", "", &s );
ADDRGP4 $80
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 610
;610:	if ( !Q_strequal( s, "worldspawn" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $315
line 611
;611:		G_Error( "SP_worldspawn: The first entity isn't 'worldspawn'" );
ADDRGP4 $318
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 612
;612:	}
LABELV $315
line 615
;613:
;614:	// make some data visible to connecting client
;615:	trap_SetConfigstring( CS_GAME_VERSION, GAME_VERSION );
CNSTI4 20
ARGI4
ADDRGP4 $319
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 617
;616:
;617:	trap_SetConfigstring( CS_LEVEL_START_TIME, va("%i", level.startTime ) );
ADDRGP4 $320
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 21
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 619
;618:
;619:	if ( *g_music.string && !Q_strequal( g_music.string, "none" ) ) {
ADDRGP4 g_music+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $322
ADDRGP4 g_music+16
ARGP4
ADDRGP4 $326
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $322
line 620
;620:		trap_SetConfigstring( CS_MUSIC, g_music.string );
CNSTI4 2
ARGI4
ADDRGP4 g_music+16
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 621
;621:	} else {
ADDRGP4 $323
JUMPV
LABELV $322
line 622
;622:		G_SpawnString( "music", "", &s );   
ADDRGP4 $328
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 623
;623:		trap_SetConfigstring( CS_MUSIC, s );
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 624
;624:	}
LABELV $323
line 626
;625:    
;626:	G_SpawnString( "message", "", &s );
ADDRGP4 $88
ARGP4
ADDRGP4 $314
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 627
;627:	trap_SetConfigstring( CS_MESSAGE, s );				// map specific message
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 629
;628:
;629:	trap_SetConfigstring( CS_MOTD, g_motd.string );		// message of the day
CNSTI4 4
ARGI4
ADDRGP4 g_motd+16
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 631
;630:
;631:	G_SpawnString( "gravity", "800", &s );
ADDRGP4 $330
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 632
;632:	trap_Cvar_Set( "g_gravity", s );
ADDRGP4 $332
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 634
;633:
;634:	G_SpawnString( "enableFS", "0", &s );
ADDRGP4 $333
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 635
;635:	trap_Cvar_Set( "g_enableFS", s );
ADDRGP4 $334
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 637
;636:
;637:	G_SpawnString( "enableDust", "0", &s );
ADDRGP4 $335
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 638
;638:	trap_Cvar_Set( "g_enableDust", s );
ADDRGP4 $336
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 640
;639:
;640:	G_SpawnString( "enableBreath", "0", &s );
ADDRGP4 $337
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 641
;641:	trap_Cvar_Set( "g_enableBreath", s );
ADDRGP4 $338
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 643
;642:
;643:	G_SpawnString( "enableQ", "0", &s );
ADDRGP4 $339
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 644
;644:	trap_Cvar_Set( "g_enableQ", s );
ADDRGP4 $340
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 646
;645:
;646:	g_entities[ENTITYNUM_WORLD].s.number = ENTITYNUM_WORLD;
ADDRGP4 g_entities+833952
CNSTI4 1022
ASGNI4
line 647
;647:	g_entities[ENTITYNUM_WORLD].r.ownerNum = ENTITYNUM_NONE;
ADDRGP4 g_entities+833952+208+304
CNSTI4 1023
ASGNI4
line 648
;648:	g_entities[ENTITYNUM_WORLD].classname = "worldspawn";
ADDRGP4 g_entities+833952+524
ADDRGP4 $317
ASGNP4
line 650
;649:
;650:	g_entities[ENTITYNUM_NONE].s.number = ENTITYNUM_NONE;
ADDRGP4 g_entities+834768
CNSTI4 1023
ASGNI4
line 651
;651:	g_entities[ENTITYNUM_NONE].r.ownerNum = ENTITYNUM_NONE;
ADDRGP4 g_entities+834768+208+304
CNSTI4 1023
ASGNI4
line 652
;652:	g_entities[ENTITYNUM_NONE].classname = "nothing";
ADDRGP4 g_entities+834768+524
ADDRGP4 $353
ASGNP4
line 655
;653:
;654:	// see if we want a warmup time
;655:	trap_SetConfigstring( CS_WARMUP, "" );
CNSTI4 5
ARGI4
ADDRGP4 $314
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 656
;656:	if ( g_restarted.integer ) {
ADDRGP4 g_restarted+12
INDIRI4
CNSTI4 0
EQI4 $354
line 657
;657:		trap_Cvar_Set( "g_restarted", "0" );
ADDRGP4 $357
ARGP4
ADDRGP4 $237
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 658
;658:		level.warmupTime = 0;
ADDRGP4 level+16
CNSTI4 0
ASGNI4
line 659
;659:	} else if ( g_doWarmup.integer ) { // Turn it on
ADDRGP4 $355
JUMPV
LABELV $354
ADDRGP4 g_doWarmup+12
INDIRI4
CNSTI4 0
EQI4 $359
line 660
;660:		level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 661
;661:		trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $320
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 662
;662:		G_LogPrintf( "Warmup:\n" );
ADDRGP4 $364
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 663
;663:	}
LABELV $359
LABELV $355
line 665
;664:
;665:}
LABELV $313
endproc SP_worldspawn 20 12
export G_SpawnEntitiesFromString
proc G_SpawnEntitiesFromString 8 4
line 675
;666:
;667:
;668:/*
;669:==============
;670:G_SpawnEntitiesFromString
;671:
;672:Parses textual entity definitions out of an entstring and spawns gentities.
;673:==============
;674:*/
;675:void G_SpawnEntitiesFromString( void ) {
line 677
;676:	// allow calls to G_Spawn*()
;677:	level.spawning = qtrue;
ADDRGP4 level+4520
CNSTI4 1
ASGNI4
line 678
;678:	level.numSpawnVars = 0;
ADDRGP4 level+4524
CNSTI4 0
ASGNI4
line 683
;679:
;680:	// the worldspawn is not an actual entity, but it still
;681:	// has a "spawn" function to perform any global setup
;682:	// needed by a level (setting configstrings or cvars, etc)
;683:	if ( !G_ParseSpawnVars() ) {
ADDRLP4 0
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $368
line 684
;684:		G_Error( "SpawnEntities: no entities" );
ADDRGP4 $370
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 685
;685:	}
LABELV $368
line 686
;686:	SP_worldspawn();
ADDRGP4 SP_worldspawn
CALLV
pop
ADDRGP4 $372
JUMPV
LABELV $371
line 689
;687:
;688:	// parse ents
;689:	while( G_ParseSpawnVars() ) {
line 690
;690:		G_SpawnGEntityFromSpawnVars();
ADDRGP4 G_SpawnGEntityFromSpawnVars
CALLV
pop
line 691
;691:	}	
LABELV $372
line 689
ADDRLP4 4
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $371
line 693
;692:
;693:	level.spawning = qfalse;			// any future calls to G_Spawn*() will be errors
ADDRGP4 level+4520
CNSTI4 0
ASGNI4
line 694
;694:}
LABELV $365
endproc G_SpawnEntitiesFromString 8 4
import SP_team_neutralobelisk
import SP_team_redobelisk
import SP_team_blueobelisk
import SP_team_CTF_bluespawn
import SP_team_CTF_redspawn
import SP_team_CTF_blueplayer
import SP_team_CTF_redplayer
import SP_shooter_grenade
import SP_shooter_plasma
import SP_shooter_rocket
import SP_misc_portal_surface
import SP_misc_portal_camera
import SP_misc_model
import SP_misc_teleporter_dest
import SP_path_corner
import SP_info_camp
import SP_info_notnull
import SP_info_null
import SP_light
import SP_target_push
import SP_target_location
import SP_target_position
import SP_target_kill
import SP_target_relay
import SP_target_teleporter
import SP_target_score
import SP_target_character
import SP_target_laser
import SP_target_print
import SP_target_speaker
import SP_target_delay
import SP_target_give
import SP_target_remove_powerups
import SP_trigger_hurt
import SP_trigger_teleport
import SP_trigger_push
import SP_trigger_multiple
import SP_trigger_always
import SP_func_timer
import SP_func_train
import SP_func_door
import SP_func_button
import SP_func_pendulum
import SP_func_bobbing
import SP_func_rotating
import SP_func_static
import SP_func_plat
import SP_info_podium
import SP_info_thirdplace
import SP_info_secondplace
import SP_info_firstplace
import SP_domination_point
import SP_info_player_intermission
import SP_info_player_deathmatch
import SP_info_player_start
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
LABELV $370
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $364
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $357
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $353
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $340
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 81
byte 1 0
align 1
LABELV $339
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 81
byte 1 0
align 1
LABELV $338
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $337
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $336
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $335
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $334
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 70
byte 1 83
byte 1 0
align 1
LABELV $333
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 70
byte 1 83
byte 1 0
align 1
LABELV $332
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $331
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $330
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $328
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $326
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $320
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $319
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 111
byte 1 97
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $318
byte 1 83
byte 1 80
byte 1 95
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 39
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 39
byte 1 0
align 1
LABELV $317
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $314
byte 1 0
align 1
LABELV $306
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $302
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $295
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 69
byte 1 79
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $289
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 0
align 1
LABELV $278
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $264
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 33
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $249
byte 1 110
byte 1 111
byte 1 116
byte 1 113
byte 1 51
byte 1 97
byte 1 0
align 1
LABELV $246
byte 1 110
byte 1 111
byte 1 116
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $243
byte 1 110
byte 1 111
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $237
byte 1 48
byte 1 0
align 1
LABELV $236
byte 1 110
byte 1 111
byte 1 116
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $224
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $222
byte 1 100
byte 1 100
byte 1 0
align 1
LABELV $221
byte 1 108
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $220
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $219
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $218
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $217
byte 1 111
byte 1 110
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $216
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $215
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $214
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $213
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $180
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 108
byte 1 108
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $163
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $162
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $159
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 95
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $157
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $156
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $155
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $154
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $153
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $152
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $151
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $150
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $149
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $148
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $147
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $146
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 0
align 1
LABELV $145
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $144
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $143
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $142
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $141
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $140
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $139
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $138
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $137
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $136
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $135
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $134
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $133
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $132
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $131
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $130
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $129
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $128
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 104
byte 1 117
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $127
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $126
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $125
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $124
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 97
byte 1 108
byte 1 119
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $123
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $122
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $121
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $120
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 101
byte 1 110
byte 1 100
byte 1 117
byte 1 108
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $119
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 98
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $118
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $117
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $116
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $115
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $114
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $113
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $112
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $111
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $110
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $109
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $108
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $107
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $106
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $105
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 100
byte 1 0
align 1
LABELV $104
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
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
LABELV $103
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $102
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $99
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 101
byte 1 119
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $98
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $97
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $96
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $95
byte 1 100
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $94
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $93
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $92
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $91
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $90
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $89
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $88
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $87
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $86
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $85
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $84
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $83
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $82
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $81
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $80
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $77
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
