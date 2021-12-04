/*
===========================================================================
Copyright (C) 2010-2011 Manuel Wiese

This file is part of AfterShock source code.

AfterShock source code is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

AfterShock source code is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AfterShock source code; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/

#include "g_local.h"

#define MAX_MAPFILE_LENGTH 32000

#define MAX_TOKENNUM 8192

typedef enum {
	TOT_LPAREN,
	TOT_RPAREN,
	TOT_WORD,
	TOT_NUMBER,
	TOT_NIL,
	TOT_MAX
} tokenType_t;

#define TOKENVALUE_SIZE 128

typedef struct {
	char value[TOKENVALUE_SIZE];
	int type;
} token_t;

token_t tokens2[MAX_TOKENNUM];

//TODO: items at first, later more stuff

char*	allowed[] = {
	// info entities don't do anything at all, but provide positional
	// information for things controlled by other processes
	"info_player_start",
	"info_player_deathmatch",
	"info_player_intermission",
//Double Domination player spawn:
	"info_player_dd",
        "info_player_dd_red",
        "info_player_dd_blue",
//Standard Domination point spawn:
	"domination_point",


	"info_null",
	"info_notnull",		// use target_position instead
	"info_camp",
	"func_plat",
	"func_button",
	"func_door",
	"func_static",
	"func_rotating",
	"func_bobbing",
	"func_pendulum",
	"func_train",
	"func_group",
	"func_timer",		// rename trigger_timer?

	// Triggers are brush objects that cause an effect when contacted
	// by a living player, usually involving firing targets.
	// While almost everything could be done with
	// a single trigger class and different targets, triggered effects
	// could not be client side predicted (push and teleport).
	"trigger_always",
	"trigger_multiple",
	"trigger_push",
	"trigger_teleport",
	"trigger_hurt",

	// targets perform no action by themselves, but must be triggered
	// by another entity
	"target_give",
	"target_remove_powerups",
	"target_delay",
	"target_speaker",
	"target_print",
	"target_laser",
	"target_score",
	"target_teleporter",
	"target_relay",
	"target_kill",
	"target_position",
	"target_location",
	"target_push",

	"light",
	"path_corner",
	"misc_teleporter_dest",
	"misc_model",
	"misc_portal_surface",
	"misc_portal_camera",

	"shooter_rocket",
	"shooter_grenade",
	"shooter_plasma",
	"team_CTF_redplayer",
	"team_CTF_blueplayer",

	"team_CTF_redspawn",
	"team_CTF_bluespawn",

	"team_redobelisk",
	"team_blueobelisk",
	"team_neutralobelisk",
	"item_botroam",

	NULL
};

qboolean G_ClassnameAllowed( char *input ){
		if ( !strcmp(input, "weapon_machinegun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_shotgun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_grenadelauncher" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_rocketlauncher" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_lightning" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_railgun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_plasmagun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_bfg" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_grapplinghook" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_nailgun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_prox_launcher" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_chaingun" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_flamethrower" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "weapon_antimatter" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_bullets" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_shells" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_grenades" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_cells" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_lightning" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_rockets" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_slugs" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_bfg" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_nails" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_mines" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_belt" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "ammo_flame" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_armor_shard" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_armor_combat" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_armor_body" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_health_small" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_health" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_health_large" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_health_mega" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_quad" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_enviro" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_haste" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_invis" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_regen" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_flight" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_scout" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_doubler" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_ammoregen" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_guard" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "holdable_teleporter" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "holdable_medkit" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "holdable_kamikaze" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "holdable_invulnerability" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_start" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_deathmatch" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_intermission" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_dd" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_dd_red" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_player_dd_blue" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "domination_point" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_null" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_notnull" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "info_camp" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_plat" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_button" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_door" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_static" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_rotating" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_bobbing" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_pendulum" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_train" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_group" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_timer" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "trigger_always" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "trigger_multiple" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "trigger_push" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "trigger_teleport" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "trigger_hurt" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_give" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_remove_powerups" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_delay" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_print" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_laser" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_score" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_cmd" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_music" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_sound" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_model" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_legs" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_head" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_teleporter" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_relay" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_kill" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_position" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_location" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "target_push" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "misc_teleporter_dest" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "misc_portal_surface" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "misc_portal_camera" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "shooter_rocket" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "shooter_grenade" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "shooter_plasma" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_CTF_redplayer" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_CTF_blueplayer" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_CTF_redspawn" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_CTF_bluespawn" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_redobelisk" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_blueobelisk" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "team_neutralobelisk" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "item_botroam" ) ) {
			return qtrue;
		}
		if ( !strcmp(input, "func_prop" ) ) {
			return qtrue;
		}
		
		if ( !strcmp(input, "team_CTF_neutralflag" ) ) {
			return qtrue;
		}

		if ( !strcmp(input, "team_CTF_blueflag" ) ) {
			return qtrue;
		}
		
		if ( !strcmp(input, "team_CTF_redflag" ) ) {
			return qtrue;
		}

	return qfalse;
}

void G_ClearEntities( void ){
	int i;
	for( i = 0; i < MAX_GENTITIES; i++ ) {
		/*if( !g_entities[i].inuse )
			continue;*/
		if( !G_ClassnameAllowed(g_entities[i].classname) )
			continue;
		g_entities[i].nextthink = 0;
		G_FreeEntity(&g_entities[i]);
		
	}
}

void G_AddEntity( char* classname, vec3_t origin, int spawnflags, float wait, float random ){
	gentity_t *ent;
	ent = G_Spawn();
	ent->classname = classname;
	ent->spawnflags = spawnflags;
	ent->random = random;
	ent->wait = wait;
	
	VectorCopy( origin, ent->s.origin );
	VectorCopy( ent->s.origin, ent->s.pos.trBase );
	VectorCopy( ent->s.origin, ent->r.currentOrigin );
	
	// if we didn't get a classname, don't bother spawning anything
	if ( !G_CallSpawn( ent ) ) {
		G_FreeEntity( ent );
	}
}

static int G_setTokens2( char* in, char* out, int start ){
	int i = 0;
	while ( in[ start + i ] != ' ' ){
		if( in[ start + i ] == '\0' ){
			out[i] = in[start+1];
			return MAX_MAPFILE_LENGTH;
		}
		out[i] = in[start+i];
		i++;
	}
	out[i] = '\0';
	return start+i+1;
}

static int G_setTokenType2( char* value ){
	int count = 0;
	qboolean lpar= qfalse,rpar= qfalse,number= qfalse, character = qfalse;
	
	while( value[count] != '\0' ){
		if( value[count] == '{' )
			lpar = qtrue;
		else if( value[count] == '}' )
			rpar = qtrue;
		else if( value[count] >= '0' && value[count] <= '9' )
			number = qtrue;
		else if( ( value[count] >= 'a' && value[count] <= 'z' ) || ( value[count] >= 'A' && value[count] <= 'Z' ) )
			character = qtrue;
		count++;
	}
	
	if( lpar && !( rpar || number || character ) )
		return TOT_LPAREN;
	else if( rpar && !( lpar || number || character ) )
		return TOT_RPAREN;
	else if( number && !( lpar || rpar || character ) )
		return TOT_NUMBER;
	else if( character && !( lpar || rpar ) )
		return TOT_WORD;
	else
		return TOT_NIL;
}

static int G_FindNextToken2( char *find, token_t *in, int start ){
	int i;
	int cmp;
	
	for( i = start; i < MAX_TOKENNUM; i++ ){
		cmp= strcmp( in[i].value, find );
		if( cmp == 0 )
			return i;
	}
	return -1;
}

static qboolean G_AbeforeB2( char *A, char *B, token_t *in, int start ){
	int a = G_FindNextToken2( A, in, start );
	int b = G_FindNextToken2( B, in, start );
	
	if( b == -1 && a != -1 )
		return qtrue;
	if( a == -1 && b != -1 )
		return qfalse;
	if( a < b )
		return qtrue;
	else
		return qfalse;
}

//
// fields are needed for spawning from the entity string
//
typedef enum {
	F_INT, 
	F_FLOAT,
	F_LSTRING,			// string on disk, pointer in memory, TAG_LEVEL
	F_GSTRING,			// string on disk, pointer in memory, TAG_GAME
	F_VECTOR,
	F_ANGLEHACK,
	F_ENTITY,			// index on disk, pointer in memory
	F_ITEM,				// index on disk, pointer in memory
	F_CLIENT,			// index on disk, pointer in memory
	F_IGNORE
} fieldtypeCopy_t;

typedef struct
{
	char	*name;
	int		ofs;
	fieldtypeCopy_t	type;
	int		flags;
} fieldCopy_t;

fieldCopy_t fieldsCopy[] = {
	{"classname", FOFS(classname), F_LSTRING},
	{"origin", FOFS(s.origin), F_VECTOR},
	{"model", FOFS(model), F_LSTRING},
	{"model2", FOFS(model2), F_LSTRING},
	{"spawnflags", FOFS(spawnflags), F_INT},
	{"speed", FOFS(speed), F_FLOAT},
	{"target", FOFS(target), F_LSTRING},
	{"targetname", FOFS(targetname), F_LSTRING},
	{"message", FOFS(message), F_LSTRING},
	{"team", FOFS(team), F_LSTRING},
	{"noise", FOFS(noise_index), F_LSTRING},
	{"wait", FOFS(wait), F_FLOAT},
	{"random", FOFS(random), F_FLOAT},
	{"count", FOFS(count), F_INT},
	{"health", FOFS(health), F_INT},
	{"light", 0, F_IGNORE},
	{"dmg", FOFS(damage), F_INT},
	{"angles", FOFS(s.angles), F_VECTOR},
	{"angle", FOFS(s.angles), F_ANGLEHACK},
	{"lip", FOFS(lip), F_FLOAT},
	{"height", FOFS(height), F_FLOAT},
	{"phase", FOFS(phase), F_FLOAT},
	{"targetShaderName", FOFS(targetShaderName), F_LSTRING},
	{"targetShaderNewName", FOFS(targetShaderNewName), F_LSTRING},

	{NULL}
};

char *G_ClearString( char *input ){
	if( input[0] == '"' ){
		input[0] = '\0';
		input++;
	}
	if( input[strlen(input)-1] == '"' ){
		input[strlen(input)-1] = '\0';
	}
	return input;
}

static void G_LoadMapfileEntity( token_t *in, int min, int max ){
	int i;
	char *buf;
	vec3_t	vec;
	
	fieldCopy_t *field;
	byte	*b;
	
	gentity_t *ent;
	ent = G_Spawn();
	
	b = (byte *)ent;
	
	for( i = min; i <= max ; i++ ) {
		for( field = fieldsCopy; field->name; field++ ){
			if( !strcmp(va("\"%s\"",field->name), in[i].value ) ) {
				switch( field->type ) {
				  case F_LSTRING:
					*(char **)(b+field->ofs) = G_NewString(G_ClearString(in[i+1].value));
					break;
				  case F_VECTOR:
					buf = in[i+1].value;
					strcat(buf, " ");
					strcat(buf, in[i+2].value);
					strcat(buf, " ");
					strcat(buf, in[i+3].value);
					sscanf (G_ClearString(buf), "%f %f %f", &vec[0], &vec[1], &vec[2]);
					((float *)(b+field->ofs))[0] = vec[0];
					((float *)(b+field->ofs))[1] = vec[1];
					((float *)(b+field->ofs))[2] = vec[2];
					break;
				  case F_INT:
					*(int *)(b+field->ofs) = atoi(G_ClearString(in[i+1].value));
					break;
				  case F_FLOAT:
					*(float *)(b+field->ofs) = atof(G_ClearString(in[i+1].value));
					break;
				  case F_ANGLEHACK:
					buf = in[i+1].value;
					strcat(buf, in[i+2].value);
					strcat(buf, in[i+3].value);
					sscanf (G_ClearString(buf), "%f %f %f", &vec[0], &vec[1], &vec[2]);
					((float *)(b+field->ofs))[0] = vec[0];
					((float *)(b+field->ofs))[1] = vec[1];
					((float *)(b+field->ofs))[2] = vec[2];
					break;
				  default:
				  case F_IGNORE:
					break;
				}
				break;
			}
		}
	}
	
	if ( !G_CallSpawn( ent ) ) {
		G_FreeEntity( ent );
	}
}

void G_LoadMapfile( char *filename ){
	char buffer[MAX_MAPFILE_LENGTH];
	qboolean lastSpace = qtrue;
	qboolean pgbreak = qfalse;
	int i = 0;
	int charCount = 0;
	int tokenNum = 0;
	int maxTokennum;
	int lpar, rpar;
	int len;
	fileHandle_t	f;
	
	len = trap_FS_FOpenFile ( filename, &f, FS_READ );
	
	if ( !f ) {
		G_Printf( "%s",va( S_COLOR_YELLOW "mapfile not found: %s\n", filename ) );	
		return;
	}

	if ( len >= MAX_MAPFILE_LENGTH ) {
		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MAPFILE_LENGTH ) );
		trap_FS_FCloseFile( f );
		return;
	}
//	ClearRegisteredItems();
//	G_ClearEntities();

	trap_FS_Read( buffer, len, f );
	buffer[len] = 0;
	trap_FS_FCloseFile( f );
	
	COM_Compress(buffer);
	
	for ( i = 0; i < MAX_MAPFILE_LENGTH; i++ ){
		
		//Filter comments( start at # and end at break )
		if( buffer[i] == '#' ){
			while( i < MAX_MAPFILE_LENGTH && !pgbreak ){
				if( buffer[i] == '\n' || buffer[i] == '\r' )
					pgbreak = qtrue;
				i++;
			}
			pgbreak = qfalse;
			lastSpace = qtrue;
			//continue;
		}
		
		if( SkippedChar( buffer[i] ) ){
			if( !lastSpace ){
				buffer[charCount] = ' ';
				charCount++;
				lastSpace = qtrue;
			}
			continue;
		}
		
		lastSpace = qfalse;
		buffer[charCount] = buffer[i];
		charCount++;
	}
	
	i = 0;
	while( i < MAX_MAPFILE_LENGTH && tokenNum < MAX_TOKENNUM){
		i = G_setTokens2( buffer, tokens2[tokenNum].value, i);
		tokens2[tokenNum].type = G_setTokenType2( tokens2[tokenNum].value );
		tokenNum++;
	}
	maxTokennum = tokenNum;
	
	G_Printf("Mapfile parser found %i tokens\n", maxTokennum );
	
	for( tokenNum = 0; tokenNum < maxTokennum; tokenNum++ ){
			if( strcmp( tokens2[tokenNum].value, "{" ) == 0 ){
				//CG_Printf("lpar found\n");
				lpar = tokenNum;
				if( G_AbeforeB2((char*)"{",(char*)"}", tokens2, tokenNum+2)){
					G_Printf("error: \"}\" expected at %s\n", tokens2[tokenNum].value);
					break;
				}
				//CG_Printf("debug abeforeb\n");
				rpar = G_FindNextToken2((char*)"}", tokens2, tokenNum+2 );
				//CG_Printf("debug findnexttoken\n");
				if( rpar != -1 ){
					G_LoadMapfileEntity(tokens2, lpar+1, rpar-1);
					//G_setHudElement(i, tokens, lpar+1, rpar-1);
					tokenNum = rpar;
				}	
			}	
	}
	SaveRegisteredItems();
	
}

void G_LoadMapfilec( char *filename ){
	char buffer[MAX_MAPFILE_LENGTH];
	qboolean lastSpace = qtrue;
	qboolean pgbreak = qfalse;
	int i = 0;
	int charCount = 0;
	int tokenNum = 0;
	int maxTokennum;
	int lpar, rpar;
	int len;
	fileHandle_t	f;
	
	len = trap_FS_FOpenFile ( filename, &f, FS_READ );
	
	if ( !f ) {
		G_Printf( "%s",va( S_COLOR_YELLOW "mapfile not found: %s\n", filename ) );	
		return;
	}

	if ( len >= MAX_MAPFILE_LENGTH ) {
		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MAPFILE_LENGTH ) );
		trap_FS_FCloseFile( f );
		return;
	}
	ClearRegisteredItems();
	G_ClearEntities();

	trap_FS_Read( buffer, len, f );
	buffer[len] = 0;
	trap_FS_FCloseFile( f );
	
	COM_Compress(buffer);
	
	for ( i = 0; i < MAX_MAPFILE_LENGTH; i++ ){
		
		//Filter comments( start at # and end at break )
		if( buffer[i] == '#' ){
			while( i < MAX_MAPFILE_LENGTH && !pgbreak ){
				if( buffer[i] == '\n' || buffer[i] == '\r' )
					pgbreak = qtrue;
				i++;
			}
			pgbreak = qfalse;
			lastSpace = qtrue;
			//continue;
		}
		
		if( SkippedChar( buffer[i] ) ){
			if( !lastSpace ){
				buffer[charCount] = ' ';
				charCount++;
				lastSpace = qtrue;
			}
			continue;
		}
		
		lastSpace = qfalse;
		buffer[charCount] = buffer[i];
		charCount++;
	}
	
	i = 0;
	while( i < MAX_MAPFILE_LENGTH && tokenNum < MAX_TOKENNUM){
		i = G_setTokens2( buffer, tokens2[tokenNum].value, i);
		tokens2[tokenNum].type = G_setTokenType2( tokens2[tokenNum].value );
		tokenNum++;
	}
	maxTokennum = tokenNum;
	
	G_Printf("Mapfile parser found %i tokens\n", maxTokennum );
	
	for( tokenNum = 0; tokenNum < maxTokennum; tokenNum++ ){
			if( strcmp( tokens2[tokenNum].value, "{" ) == 0 ){
				//CG_Printf("lpar found\n");
				lpar = tokenNum;
				if( G_AbeforeB2((char*)"{",(char*)"}", tokens2, tokenNum+2)){
					G_Printf("error: \"}\" expected at %s\n", tokens2[tokenNum].value);
					break;
				}
				//CG_Printf("debug abeforeb\n");
				rpar = G_FindNextToken2((char*)"}", tokens2, tokenNum+2 );
				//CG_Printf("debug findnexttoken\n");
				if( rpar != -1 ){
					G_LoadMapfileEntity(tokens2, lpar+1, rpar-1);
					//G_setHudElement(i, tokens, lpar+1, rpar-1);
					tokenNum = rpar;
				}	
			}	
	}
	SaveRegisteredItems();
	
}

void G_LoadMapfile_f( void ) {
	char buf[MAX_QPATH];
	char mapname[64];
	
	if ( trap_Argc() < 2 ) {
                G_Printf("Usage:  loadmapfile <filename>\n");
		return;
	}
	
	trap_Argv( 1, buf, sizeof( buf ) );
	
	G_LoadMapfile(buf);
	trap_Cvar_Set("mapfile",buf);
	trap_Cvar_VariableStringBuffer("mapname", mapname, sizeof(mapname));
	trap_Cvar_Set("lastmap",mapname);
}

void G_LoadMapfilec_f( void ) {
	char buf[MAX_QPATH];
	char mapname[64];
	
	if ( trap_Argc() < 2 ) {
                G_Printf("Usage:  loadmapfile <filename>\n");
		return;
	}
	
	trap_Argv( 1, buf, sizeof( buf ) );
	
	G_LoadMapfilec(buf);
	trap_Cvar_Set("mapfile",buf);
	trap_Cvar_VariableStringBuffer("mapname", mapname, sizeof(mapname));
	trap_Cvar_Set("lastmap",mapname);
}

void G_WriteMapfile_f( void ) {
	int i;
	fileHandle_t f;
	char *string;
	char buf[MAX_QPATH];
	fieldCopy_t *field;
	byte	*b;
	
	if ( trap_Argc() < 2 ) {
                G_Printf("Usage:  writemapfile <filename>\n");
		return;
	}
	
	trap_Argv( 1, buf, sizeof( buf ) );
	
	trap_FS_FOpenFile(va("%s", buf ),&f,FS_WRITE);
	
	for( i = 0; i < MAX_GENTITIES; i++ ){
	  
		if( !g_entities[i].inuse )
			continue;
		
		if( !G_ClassnameAllowed(g_entities[i].classname) )
			continue;
		b = (byte *) &g_entities[i];
		
		string = va("{\n");
		trap_FS_Write(string, strlen(string), f);
		
		for( field=fieldsCopy; field->name; field++ ){
			switch( field->type ) {
			case F_LSTRING:
				if( *(char **)(b+field->ofs) ){
					string = va("   \"%s\"   \"%s\"\n", field->name, *(char **)(b+field->ofs) );
					trap_FS_Write(string, strlen(string), f);
				}
				break;
			case F_VECTOR:
				if( (((float *)(b+field->ofs))[0] && ((float *)(b+field->ofs))[1] && ((float *)(b+field->ofs))[2]) || !strcmp(field->name,"origin") ){
					string = va("   \"%s\"   \"%f %f %f\"\n", field->name, ((float *)(b+field->ofs))[0], ((float *)(b+field->ofs))[1], ((float *)(b+field->ofs))[2] );
					trap_FS_Write(string, strlen(string), f);
				}
				break;
			case F_INT:
				if( *(int *)(b+field->ofs) ){
					string = va("   \"%s\"   \"%i\"\n", field->name, *(int *)(b+field->ofs) );
					trap_FS_Write(string, strlen(string), f);
				}
				break;
			case F_FLOAT:
				if( *(float *)(b+field->ofs) ){
					string = va("   \"%s\"   \"%f\"\n", field->name, *(float *)(b+field->ofs) );
					trap_FS_Write(string, strlen(string), f);
				}
				break;
			case F_ANGLEHACK:
				if( ((float *)(b+field->ofs))[0] && ((float *)(b+field->ofs))[1] && ((float *)(b+field->ofs))[2] ){
					string = va("   \"%s\"   \"%f %f %f\"\n", field->name, ((float *)(b+field->ofs))[0], ((float *)(b+field->ofs))[1], ((float *)(b+field->ofs))[2] );
					trap_FS_Write(string, strlen(string), f);
				}
				break;
			default:
			case F_IGNORE:
				break;
			}
		}
		string = va("}\n\n");
		trap_FS_Write(string, strlen(string), f);
	}
	trap_FS_FCloseFile(f);
}
