/*
=============================================================================

START SERVER GLOBAL DATA USED BY UI AND SCRIPT *****

=============================================================================
*/

/*
The work contained within this file is software written by various
copyright holders.  The initial contributor, Id Software holds all
copyright over their software.  However, software used and written by
and for UI Enhanced has copyrights held by the initial author of the
software.

The changes written by and for UI Enhanced are contained alongside the
original work from Id Software for convenience and ease of interoperability.

For the code contained herein that was written by Id Software, see
the license agreement on their original archive for restrictions and
limitations.

The UI Enhanced copyright owner permit free reuse of his code contained
herein, as long as the following terms are met:

----------------------------------------------------------------------
1) Credit is given in a place where users of the mod may read
   it. (Title screen, credit screen or README will do).  The
   recommended format is: "First, Last, alias, email"

2) There are no attempts to misrepresent the public as to who made the
   alterations.  The UI Enhanced copyright owner does not give permission
   for others to release software under the UI Enhanced name.
----------------------------------------------------------------------

Ian Jefferies   - HypoThermia ( uie@planetquake.com )
http://www.planetquake.com/uie
*/

#include "ui_local.h"

#include "ui_startserver.h"


//
// global data
//

scriptdata_t s_scriptdata;


// map game type to internal flags
int gametype_remap[NUM_GAMETYPES] = {GT_FFA, GT_TOURNAMENT, GT_TEAM, GT_CTF};	// matches gametype_items
int gametype_remap2[MAX_GAME_TYPE] = {0, 1, 0, 2, 3};

// order must mach that of gametype_remap[]
char* gametype_cvar_base[NUM_GAMETYPES] = {
	"uie_ffa_%s",
	"uie_tourney_%s",
	"uie_team_%s",
	"uie_ctf_%s"
};




const char* idmap_list[] = {
	// deathmatch
	"q3dm0","q3dm1","q3dm2","q3dm3","q3dm4",
	"q3dm5","q3dm6","q3dm7","q3dm8","q3dm9",
	"q3dm10","q3dm11","q3dm12","q3dm13","q3dm14",
	"q3dm15","q3dm16","q3dm17","q3dm18","q3dm19",

	// tourney
	"q3tourney1","q3tourney2","q3tourney3",
	"q3tourney4","q3tourney5","q3tourney6",

	// ctf
	"q3ctf1","q3ctf2","q3ctf3","q3ctf4",
	"q3tourney6_ctf",

	// 3-wave ctf
	"q3wctf1","q3wctf2","q3wctf3",

	// pro-maps
	"pro-q3dm6", "pro-q3dm13", "pro-q3tourney2", "pro-q3tourney4",
	0
};




const char *gametype_items[NUM_GAMETYPES + 1] = {
	"Free For All",
	"Tournament",
	"Team Deathmatch",
	"Capture the Flag",
	0
};




//
// individual items
// Must be in ITEM_* numerical order
//
itemnode_t server_itemlist[ITEM_COUNT] = {
	// weapon
	{ ITEMGROUP_WEAPON, ITEM_MGUN, 		"weapon_machinegun", 	"mg"},
	{ ITEMGROUP_WEAPON, ITEM_SHOTGUN, 	"weapon_shotgun", 		"sg"},
	{ ITEMGROUP_WEAPON, ITEM_GRENADE, 	"weapon_grenadelauncher", "gl"},
	{ ITEMGROUP_WEAPON, ITEM_ROCKET, 	"weapon_rocketlauncher", "rl"},
	{ ITEMGROUP_WEAPON, ITEM_PLASMA, 	"weapon_plasmagun", 	"pg"},
	{ ITEMGROUP_WEAPON, ITEM_LIGHTNING, "weapon_lightning", 	"lg"},
	{ ITEMGROUP_WEAPON, ITEM_RAIL, 		"weapon_railgun", 		"rg"},
	{ ITEMGROUP_WEAPON, ITEM_BFG, 		"weapon_bfg", 			"bfg"},

	// ammo
	{ ITEMGROUP_AMMO, ITEM_MGUN_AMMO, 	"ammo_bullets", 		"amg"},
	{ ITEMGROUP_AMMO, ITEM_SHOTGUN_AMMO, "ammo_shells", 		"asg"},
	{ ITEMGROUP_AMMO, ITEM_GRENADE_AMMO, "ammo_grenades", 		"agl"},
	{ ITEMGROUP_AMMO, ITEM_ROCKET_AMMO, "ammo_rockets", 		"arl"},
	{ ITEMGROUP_AMMO, ITEM_PLASMA_AMMO, "ammo_cells", 			"apg"},
	{ ITEMGROUP_AMMO, ITEM_LIGHTNING_AMMO, "ammo_lightning", 	"alg"},
	{ ITEMGROUP_AMMO, ITEM_RAIL_AMMO, 	"ammo_slugs", 			"arg"},
	{ ITEMGROUP_AMMO, ITEM_BFG_AMMO, 	"ammo_bfg", 			"abfg"},

	// health
	{ ITEMGROUP_HEALTH, ITEM_MEGA,		"item_health_mega",		"mega"},
	{ ITEMGROUP_HEALTH, ITEM_HEALTH_SMALL, "item_health_small",	"hs"},

	{ ITEMGROUP_HEALTH, ITEM_HEALTH_MEDIUM, "item_health", 		"hm"},
	{ ITEMGROUP_HEALTH, ITEM_HEALTH_LARGE, "item_health_large",	"hl"},

	// armour
	{ ITEMGROUP_ARMOUR, ITEM_ARMOUR_RED,	"item_armor_body",		"ar"},
	{ ITEMGROUP_ARMOUR, ITEM_ARMOUR_YELLOW, "item_armor_combat",	"ay"},

	{ ITEMGROUP_ARMOUR, ITEM_ARMOUR_SHARD, "item_armor_shard",	"as"},

	// powerups
	{ ITEMGROUP_POWERUPS, ITEM_QUAD,		"item_quad",			"quad"},
	{ ITEMGROUP_POWERUPS, ITEM_REGEN,		"item_regen",			"reg"},
	{ ITEMGROUP_POWERUPS, ITEM_HASTE,		"item_haste",			"hst"},

	{ ITEMGROUP_POWERUPS, ITEM_BATTLESUIT,	"item_enviro",			"bs"},
	{ ITEMGROUP_POWERUPS, ITEM_INVISIBLE, 	"item_invis",			"inv"},
	{ ITEMGROUP_POWERUPS, ITEM_FLIGHT,		"item_flight",			"flt"},

	// items
	{ ITEMGROUP_HOLDABLE,	ITEM_MEDKIT, 		"holdable_medkit",		"mk"},
	{ ITEMGROUP_HOLDABLE,	ITEM_TELEPORTER,	"holdable_teleporter",	"tel"}
};




/*
==========================================================================

DATA ARCHIVE

==========================================================================
*/


// Some of these vars are legacy cvars that were previously stored in q3config.cfg.
// In order to load them into memory for porting over to the new data format
// we need to "register" them and load their current values

// This porting process should be done only once, assuming we installed over
// a previous version of UIE


// Default values for cvars that we haven't yet created

// On startup we load from uieSkirmish.dat, check for new vars from this list,
// and add them into data storage.





typedef struct {
	char		*cvarName;
	char		*defaultString;
} uie_cvarTable_t;


uie_cvarTable_t uie_cvarTable[] = {
	{ "uie_gametype", "0" },
	{ "uie_pure", "1" },
	{ "uie_dedicated", "0" },
	{ "uie_inactivity", "90" },
	{ "uie_config_showid", "0" },
	{ "uie_pmove_fixed", "1" },
	{ "uie_pmove_msec", "8" },
	{ "uie_smoothclients", "1" },
	{ "uie_syncclients", "0" },
	{ "uie_allowmaxrate", "0" },
	{ "uie_maxrate", "0" },
	{ "uie_allowdownload", "0" },
	{ "uie_allowpass", "0" },
	{ "uie_password", "" },
	{ "uie_allowvote", "0" },
	{ "uie_minPing", "0" },
	{ "uie_maxPing", "0" },
	{ "uie_allowMinPing", "0" },
	{ "uie_allowMaxPing", "0" },
	{ "uie_preventConfigBug", "0" },
	{ "uie_gravity", "800" },
	{ "uie_knockback", "1000" },
	{ "uie_quadfactor", "3" },
	{ "uie_netport", "27960" },
	{ "uie_svfps", "20" },
	{ "uie_allowprivateclients", "0" },
	{ "uie_privateclients", "0" },
	{ "uie_privatepassword", "" },
	{ "uie_punkbuster", "0" },
	{ "uie_strictAuth", "1" },
   { "uie_lanForceRate", "1" },

	{ "uie_ffa_fragtype", "0" },
	{ "uie_ffa_timetype", "0" },
	{ "uie_ffa_customfraglimits", "" },
	{ "uie_ffa_customtimelimits", "" },
	{ "uie_ffa_maplist", "" },
	{ "uie_ffa_maplistexclude", "" },
	{ "uie_ffa_MapRepeat", "1" },
	{ "uie_ffa_MapSource", "0" },
	{ "uie_ffa_RandomMapCount", "5" },
	{ "uie_ffa_RandomMapType", "0" },
	{ "uie_ffa_slottype", "" },
	{ "uie_ffa_botname", "" },
	{ "uie_ffa_botexclude", "" },
	{ "uie_ffa_botskill", "" },
	{ "uie_ffa_BotSelection", "0" },
	{ "uie_ffa_BotCount", "4" },
	{ "uie_ffa_BotChange", "0" },
	{ "uie_ffa_OpenSlotCount", "0" },
	{ "uie_ffa_BotSkillType", "0" },
	{ "uie_ffa_BotSkillValue", "0" },
	{ "uie_ffa_BotSkillBias", "0" },
	{ "uie_ffa_PlayerJoinAs", "0" },
	{ "uie_ffa_hostname", "UIE Deathmatch server" },
	{ "uie_ffa_ForceRespawn", "30" },
	{ "uie_ffa_itemGroups", "" },
	{ "uie_ffa_itemsHidden", "" },
	{ "uie_ffa_WarmUp", "20" },
	{ "uie_ffa_doWarmUp", "0" },
	{ "uie_ffa_fraglimit", "30" },
	{ "uie_ffa_timelimit", "20" },
	{ "uie_ffa_weaponrespawn", "5" },

	{ "uie_tourney_fragtype", "0" },
	{ "uie_tourney_timetype", "0" },
	{ "uie_tourney_customfraglimits", "" },
	{ "uie_tourney_customtimelimits", "" },
	{ "uie_tourney_maplist", "" },
	{ "uie_tourney_maplistexclude", "" },
	{ "uie_tourney_MapRepeat", "1" },
	{ "uie_tourney_MapSource", "0" },
	{ "uie_tourney_RandomMapCount", "5" },
	{ "uie_tourney_RandomMapType", "0" },
	{ "uie_tourney_slottype", "" },
	{ "uie_tourney_botname", "" },
	{ "uie_tourney_botexclude", "" },
	{ "uie_tourney_botskill", "" },
	{ "uie_tourney_BotSelection", "0" },
	{ "uie_tourney_BotCount", "4" },
	{ "uie_tourney_BotChange", "0" },
	{ "uie_tourney_OpenSlotCount", "0" },
	{ "uie_tourney_BotSkillType", "0" },
	{ "uie_tourney_BotSkillValue", "0" },
	{ "uie_tourney_BotSkillBias", "0" },
	{ "uie_tourney_PlayerJoinAs", "0" },
	{ "uie_tourney_hostname", "UIE Tournament server" },
	{ "uie_tourney_ForceRespawn", "30" },
	{ "uie_tourney_itemGroups", "" },
	{ "uie_tourney_itemsHidden", "" },
	{ "uie_tourney_WarmUp", "20" },
	{ "uie_tourney_doWarmUp", "1" },
	{ "uie_tourney_fraglimit", "0" },
	{ "uie_tourney_timelimit", "15" },
	{ "uie_tourney_weaponrespawn", "5" },

	{ "uie_team_fragtype", "0" },
	{ "uie_team_timetype", "0" },
	{ "uie_team_customfraglimits", "" },
	{ "uie_team_customtimelimits", "" },
	{ "uie_team_maplist", "" },
	{ "uie_team_maplistexclude", "" },
	{ "uie_team_MapRepeat", "1" },
	{ "uie_team_MapSource", "0" },
	{ "uie_team_RandomMapCount", "5" },
	{ "uie_team_RandomMapType", "0" },
	{ "uie_team_slottype", "" },
	{ "uie_team_botname", "" },
	{ "uie_team_botexclude", "" },
	{ "uie_team_botexclude", "" },
	{ "uie_team_botskill", "" },
	{ "uie_team_BotSelection", "0" },
	{ "uie_team_BotCount", "4" },
	{ "uie_team_BotChange", "0" },
	{ "uie_team_OpenSlotCount", "0" },
	{ "uie_team_BotSkillType", "0" },
	{ "uie_team_BotSkillValue", "0" },
	{ "uie_team_BotSkillBias", "0" },
	{ "uie_team_PlayerJoinAs", "0" },
	{ "uie_team_TeamSwapped", "0" },
	{ "uie_team_hostname", "UIE Team Deathmatch server" },
	{ "uie_team_ForceRespawn", "30" },
	{ "uie_team_AutoJoin", "0" },
	{ "uie_team_TeamBalance", "0" },
	{ "uie_team_itemGroups", "" },
	{ "uie_team_itemsHidden", "" },
	{ "uie_team_WarmUp", "20" },
	{ "uie_team_doWarmUp", "0" },
	{ "uie_team_friendly", "0" },
	{ "uie_team_fraglimit", "0" },
	{ "uie_team_timelimit", "20" },
	{ "uie_team_weaponrespawn", "30" },

	{ "uie_ctf_capturetype", "0" },
	{ "uie_ctf_timetype", "0" },
	{ "uie_ctf_customcapturelimits", "" },
	{ "uie_ctf_customtimelimits", "" },
	{ "uie_ctf_maplist", "" },
	{ "uie_ctf_maplistexclude", "" },
	{ "uie_ctf_MapRepeat", "1" },
	{ "uie_ctf_MapSource", "0" },
	{ "uie_ctf_RandomMapCount", "5" },
	{ "uie_ctf_RandomMapType", "0" },
	{ "uie_ctf_slottype", "" },
	{ "uie_ctf_botname", "" },
	{ "uie_ctf_botskill", "" },
	{ "uie_ctf_BotSelection", "0" },
	{ "uie_ctf_BotCount", "4" },
	{ "uie_ctf_BotChange", "0" },
	{ "uie_ctf_OpenSlotCount", "0" },
	{ "uie_ctf_BotSkillType", "0" },
	{ "uie_ctf_BotSkillValue", "0" },
	{ "uie_ctf_BotSkillBias", "0" },
	{ "uie_ctf_PlayerJoinAs", "0" },
	{ "uie_ctf_TeamSwapped", "0" },
	{ "uie_ctf_hostname", "UIE CTF server" },
	{ "uie_ctf_ForceRespawn", "30" },
	{ "uie_ctf_AutoJoin", "0" },
	{ "uie_ctf_TeamBalance", "0" },
	{ "uie_ctf_itemGroups", "" },
	{ "uie_ctf_itemsHidden", "" },
	{ "uie_ctf_WarmUp", "20" },
	{ "uie_ctf_doWarmUp", "0" },
	{ "uie_ctf_friendly", "0" },
	{ "uie_ctf_capturelimit", "0" },
	{ "uie_ctf_timelimit", "20" },
	{ "uie_ctf_weaponrespawn", "5" }
};


static const int uie_cvarTableSize = sizeof(uie_cvarTable)/sizeof(uie_cvarTable[0]);


typedef struct {
	const char* from;
	const char* to;
	const char* init;
} uieCvarConversion_t;




// list of cvars that we need to convert to our "unified" data type
const uieCvarConversion_t uie_cvarImport[] = {
	{ "ui_ffa_fraglimit", "uie_ffa_fraglimit", "0" },
	{ "ui_ffa_timelimit", "uie_ffa_timelimit", "0" },

	{ "ui_tourney_fraglimit", "uie_tourney_fraglimit", "0" },
	{ "ui_tourney_timelimit", "uie_tourney_timelimit", "0" },

	{ "ui_team_friendly", "uie_team_friendly", "0" },
	{ "ui_team_fraglimit", "uie_team_fraglimit", "0" },
	{ "ui_team_timelimit", "uie_team_timelimit", "0" },

	{ "ui_ctf_friendly", "uie_ctf_friendly", "0" },
	{ "ui_ctf_capturelimit", "uie_ctf_capturelimit", "0" },
	{ "ui_ctf_timelimit", "uie_ctf_timelimit", "0" },

	{ "g_weaponrespawn", "uie_ffa_weaponrespawn", "5" },
	{ "g_weaponrespawn", "uie_tourney_weaponrespawn", "5" },
	{ "g_weaponTeamrespawn", "uie_team_weaponrespawn", "30" },
	{ "g_weaponrespawn", "uie_ctf_weaponrespawn", "5" }
};


const int uie_cvarImportSize = sizeof(uie_cvarImport)/sizeof(uie_cvarImport[0]);



#define MAX_CVAR_DATA (24*1024)
#define UIE_SKIRMISH_DATAFILE "uieSkirmish.dat"

static qboolean skirmishCvarLoaded = qfalse;
static char skirmishCvarData[MAX_CVAR_DATA];






/*
=================
UIE_ConvertOldCvar
=================
*/
void UIE_ConvertOldCvar( char* cvar, int size)
{
	int i;

	for (i = 0; i < uie_cvarImportSize; i++) {
		if (!Q_stricmp(cvar, uie_cvarImport[i].from)) {
			Q_strncpyz(cvar, uie_cvarImport[i].to, size);

			if (uis.debug)
				Com_Printf("Cvar converted: %s\n", cvar);
			return;
		}
	}
}




/*
=================
UIE_SkirmishCvarExists
=================
*/
qboolean UIE_SkirmishCvarExists( char* base, const char* var_name)
{
	int i;
	char name[64];

	if (!var_name || !*var_name)
		return qfalse;

	if (base) {
		Q_strncpyz(name, va(base, var_name), 64);
	}
	else {
		Q_strncpyz(name, var_name, 64);
	}

	for (i = 0; i < uie_cvarTableSize; i++) {
		if (!Q_stricmp(uie_cvarTable[i].cvarName, name))
			return qtrue;
	}

	return qfalse;
}




/*
=================
UIE_GetSkirmishCvar
=================
*/
qboolean UIE_GetSkirmishCvar( char* base, const char* var_name, char* buffer, int buflen )
{
	char *p, *pnext;
	int len;
	char *str, *str2;
	char name[64];

	if (!var_name || !*var_name || !buffer)
		return qfalse;

	if (!skirmishCvarLoaded)
		UIE_StartServer_LoadSkirmishCvars();

	if (base) {
		Q_strncpyz(name, va(base, var_name), 64);
	}
	else {
		Q_strncpyz(name, var_name, 64);
	}

	len = strlen(name) + 1;
	p = skirmishCvarData;
	while (*p) {
		pnext = p + strlen(p) + 1;
		if (!Q_stricmp(name, COM_Parse(&p))) {
			break;
		}

		p = pnext;
	}

	buffer[0] = '\0';
	if (!*p) {
//		Com_Printf("Cvar not found: %s\n",name);
		return qfalse;
	}

	// return string inside quotes
	Q_strncpyz(buffer, COM_Parse(&p), buflen);

	return qtrue;
}




/*
=================
UIE_GetSkirmishCvarInt
=================
*/
int UIE_GetSkirmishCvarInt( char* base, const char* name )
{
	char buf[32];

	UIE_GetSkirmishCvar(base, name, buf, 32);
	return atoi(buf);
}




/*
=================
UIE_GetSkirmishCvarIntClamp
=================
*/
int UIE_GetSkirmishCvarIntClamp( int min, int max, char* base, const char* name )
{
	int value;
	char buf[32];

	UIE_GetSkirmishCvar(base, name, buf, 32);

	value = atoi(buf);
	if (value < min)
		value = min;
	if (value > max)
		value = max;

	return value;
}





/*
=================
UIE_SetSkirmishCvar
=================
*/
void UIE_SetSkirmishCvar( char* base, const char* var_name, const char* string )
{
	char *p;
	char *old;
	char *newstr;
	int len, next, lenmove, oldlen, addlen;
	char name[64];

	if (!var_name || !*var_name || !string)
		return;

	if (base) {
		Q_strncpyz(name, va(base, var_name), 64);
	}
	else {
		Q_strncpyz(name, var_name, 64);
	}

	len = strlen(name)+1;
	p = skirmishCvarData;
	old = NULL;

	// do search
	while (*p) {
		next = strlen(p)+1;
		// prevent premature termination on longer name string
		if (!old && (next > len) && p[len - 1] == ' ' && Q_stricmpn(p, name, len - 1) == 0) {
			old = p;
		}

		p += next;
	}

	// delete old entry
	if (old) {
		oldlen = strlen(old) + 1;
		lenmove = p -(old + oldlen) + 1;
		memmove(old, old + oldlen, lenmove);

		p -= oldlen;
	}

	// check for overflow - bad news
	newstr = va("%s \"%s\"", name, string);
	addlen = strlen(newstr) + 1;
	if (p - skirmishCvarData + addlen >= MAX_CVAR_DATA) {
		Com_Printf("Skirmish Cvar overflow, cvar %s lost\n", name);
		return;
	}

	// add to end, keeping \0\0 integrity
	Q_strncpyz(p, newstr, addlen);
	p[addlen] = '\0';

//	Com_Printf("Cvar wrote: %s\n", newstr);
}




/*
=================
UIE_SetSkirmishCvarInt
=================
*/
void UIE_SetSkirmishCvarInt( char* base, const char* name, int value)
{
	char buf[32];

	Q_strncpyz(buf, va("%i", value), 32);
	UIE_SetSkirmishCvar(base, name, buf);
}



/*
=================
UIE_StartServer_MergeSkirmishCvars

Convert from text format to internal NUL buffer terminated

May have been edited by a program that changes line terminator formats
so we attempt to recover from this
=================
*/
static void UIE_StartServer_MergeSkirmishCvars( char* cvarList )
{
	char *p;
	char varname[MAX_TOKEN_CHARS];
	char* data;

	p = cvarList;

	while (*p) {
		Q_strncpyz( &varname[0], COM_Parse(&p), MAX_TOKEN_CHARS);
		if (!varname[0])
			break;

		data = COM_Parse(&p);

		UIE_SetSkirmishCvar(NULL, varname, data);

	};
}



/*
=================
UIE_StartServer_SaveSkirmishCvars
=================
*/
void UIE_StartServer_SaveSkirmishCvars( void )
{
	char *p;
	fileHandle_t file;
	int len;

	p = skirmishCvarData;
	while (*p) {
		p+= strlen(p);
		*p++ = '\r';
	}

	len = strlen(skirmishCvarData);
	trap_FS_FOpenFile(UIE_SKIRMISH_DATAFILE, &file, FS_WRITE);
	trap_FS_Write(skirmishCvarData, len, file);
	trap_FS_FCloseFile(file);

	p = skirmishCvarData;
	while (*p) {
		if (*p == '\r')
			*p = '\0';
		p++;
	}

//	Com_Printf("Wrote %s, %i bytes\n", UIE_SKIRMISH_DATAFILE, len);
}



/*
=================
UIE_StartServer_LoadSkirmishCvars
=================
*/
void UIE_StartServer_LoadSkirmishCvars( void )
{
	int i;
	vmCvar_t cvar;
	fileHandle_t file;
	int len;
	char newCvars[MAX_CVAR_DATA];

	memset(skirmishCvarData, 1, MAX_CVAR_DATA);
	skirmishCvarLoaded = qfalse;
	skirmishCvarData[0] = '\0';

	// load from cvars in memory or default values on list.
	// The flags marked here don't override the existing ARCHIVE flag,
	// which is set when the cvar is loaded from q3config.cfg
	for (i = 0; i < uie_cvarTableSize; i++) {
		trap_Cvar_Register(&cvar, uie_cvarTable[i].cvarName, uie_cvarTable[i].defaultString, CVAR_TEMP|CVAR_USER_CREATED);
		UIE_SetSkirmishCvar(NULL, uie_cvarTable[i].cvarName, cvar.string);
	}

	// now override cvars that we need to import
	for (i = 0; i < uie_cvarImportSize; i++) {
		trap_Cvar_Register(&cvar, uie_cvarImport[i].from, uie_cvarImport[i].init, CVAR_TEMP|CVAR_USER_CREATED);
		UIE_SetSkirmishCvar(NULL, uie_cvarImport[i].to, cvar.string);
	}

	skirmishCvarLoaded = qtrue;

	// load cvars from file, and merge them with this prepared list
	len = trap_FS_FOpenFile(UIE_SKIRMISH_DATAFILE, &file, FS_READ);

	if (!(len < MAX_CVAR_DATA - 1)) {
		Com_Printf(UIE_SKIRMISH_DATAFILE" is too large, skirmish reset to default.\n");
		trap_FS_FCloseFile(file);
		return;
	}
	else if (len <= 0) {
		Com_Printf(UIE_SKIRMISH_DATAFILE" doesn't exist, imported default cvars.\n");
		trap_FS_FCloseFile(file);
		return;
	}

	trap_FS_Read(newCvars, len, file);
	trap_FS_FCloseFile(file);

	newCvars[len] = '\0';
	skirmishCvarLoaded = qtrue;

	UIE_StartServer_MergeSkirmishCvars(newCvars);
	UIE_StartServer_SaveSkirmishCvars();
}





/*
==========================================================================

MISC FUNCTIONS

==========================================================================
*/



/*
=================
UIE_StartServer_RegisterDisableCvars
=================
*/
void UIE_StartServer_RegisterDisableCvars(qboolean init)
{
	int i;
	char* disable;

	for (i = 0; i < ITEM_COUNT; i++)
	{
		disable = va("disable_%s", server_itemlist[i].mapitem);
		if (init)
			trap_Cvar_Register(NULL, disable, "0", 0);
		else
			trap_Cvar_Set(disable, "0");
	}
}



/*
=================
StartServer_CanFight
=================
*/
qboolean StartServer_CanFight(void)
{
   int bot_count = 0;

   // number of maps
	if (StartServer_IsRandomGeneratedMapList(s_scriptdata.map.listSource)) {
		if (s_scriptdata.map.SourceCount == 0)
			return qfalse;
	}
	else {
		if (s_scriptdata.map.num_maps == 0)
			return qfalse;
	}

   // number of bots
   if (s_scriptdata.bot.typeSelect == BOTTYPE_SELECTARENASCRIPT) {
      if (StartServer_ValidBotCount() == 0) {
         return qfalse;
      }
   }

	return qtrue;
}



/*
=================
UI_SaveMultiArray
=================
*/
void UI_SaveMultiArray(char* base, const char* key, String_Callback callback, int count, int size, char newnull)
{
	char buf[MAX_STRING_CHARS];
	int i, last;
	char* arraychar;

	if (size * count >= MAX_STRING_CHARS)
	{
		trap_Error( "size*step >= MAX_STRING_CHARS" );
		return;
	}

	last = 0;
	for (i = 0; i < count; i++)
	{
		arraychar = callback(i);
		Q_strncpyz(&buf[last], arraychar, size);
		last += strlen(arraychar);
		buf[last++] = newnull;
	}

	buf[last] = '\0';
	UIE_SetSkirmishCvar( base, key, buf );
}



/*
=================
UI_LoadMultiArray
=================
*/
void UI_LoadMultiArray(char* base, const char* key, String_Callback callback, int count, int size, char newnull)
{
	char buf[MAX_STRING_CHARS];
	char* arraychar;
	int len, i, c;

	UIE_GetSkirmishCvar( base, key, buf, MAX_STRING_CHARS);

	len = strlen(buf);
	for (i = 0; i < len; i++)
		if (buf[i] == newnull)
			buf[i] = '\0';

	i = 0;
	c = 0;
	while (i < len && c < count)
	{
		arraychar = callback(c);
		Q_strncpyz(arraychar, &buf[i], size);
		i += strlen( &buf[i] ) + 1;

		c++;
	}

	// clear remaining elements
	while (c < count)
	{
		arraychar = callback(c);
		memset(arraychar, 0, size);
		c++;
	}
}



/*
==========================================================================

LOADING AND SAVING OF MAP SCRIPT DATA

==========================================================================
*/



// additional map type strings are set in ui_startserver_custommaps.c
const char* randommaptype_items[MAP_RND_MAX + MAX_MAPTYPES + 1] = {
	"(Any)", // MAP_RND_ANY
	"(Id only)", // MAP_RND_ID
	"(NonId only)", // MAP_RND_NONID
	"(Bias Id)", // MAP_RND_BIASID
	"(Bias NonId)", // MAP_RND_BIASNONID
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0
};





/*
=================
StartServer_IsIdMap
=================
*/
qboolean StartServer_IsIdMap(const char* mapname)
{
	const char* const *ptr;

	// check list of idmaps
	ptr = idmap_list;
	while (*ptr) {
		if (!Q_stricmp(*ptr, mapname))
		{
			return qtrue;
		}
		ptr++;
	}

	return qfalse;
}





/*
=================
StartServer_IsRandomGeneratedMapList

Map generation will be from a list of randomly selected map names,
not a user list of map name
=================
*/
qboolean StartServer_IsRandomGeneratedMapList( int type )
{
	if (type == MAP_MS_RANDOM || type == MAP_MS_RANDOMEXCLUDE)
		return qtrue;
	return qfalse;
}





/*
=================
StartServer_MapPageCount
=================
*/
int StartServer_MapPageCount(void)
{
	int count;

	count = 1 + ( s_scriptdata.map.num_maps / NUMMAPS_PERPAGE );
	if (count > MAX_MAPPAGES)
		count = MAX_MAPPAGES;
	return count;
}



/*
=================
StartServer_RangeClipMapIndex
=================
*/
int StartServer_RangeClipMapIndex(int index)
{
	if (index < 0)
		return 0;

	if (index > s_scriptdata.map.num_maps )
		index = s_scriptdata.map.num_maps;

	if (index == MAX_NUMMAPS)
		return MAX_NUMMAPS - 1;

	return index;
}






/*
=================
SSMP_ShortName_Callback
=================
*/
static char* SSMP_ShortName_Callback(int index)
{
	return s_scriptdata.map.data[index].shortName;
}



/*
=================
SSMP_FragLimit_Callback
=================
*/
static char* SSMP_FragLimit_Callback(int index)
{
	return s_scriptdata.map.data[index].fragLimit;
}


/*
=================
SSMP_TimeLimit_Callback
=================
*/
static char* SSMP_TimeLimit_Callback(int index)
{
	return s_scriptdata.map.data[index].timeLimit;
}




/*
=================
StartServer_MapPage_LoadMapList

must be called after s_scriptdata.map.type has been set
=================
*/
void StartServer_LoadMapList(void)
{
	char* s;
	char* ml;

	ml = "maplist";
	if (s_scriptdata.map.listSource == MAP_MS_RANDOMEXCLUDE)
		ml = "maplistexclude";

	s = gametype_cvar_base[gametype_remap2[s_scriptdata.gametype]];
	UI_LoadMultiArray(s, ml, SSMP_ShortName_Callback, MAX_NUMMAPS, SHORTMAP_BUFFER, ';');
}




/*
=================
StartServer_SwapMaps
=================
*/
qboolean StartServer_SwapMaps(int from, int to)
{
	static mapdata_t tmp;

	if (from < 0 || to < 0 || from == to)
		return qfalse;

	if (from >= s_scriptdata.map.num_maps || to >= s_scriptdata.map.num_maps)
		return qfalse;

	memcpy(&tmp, &s_scriptdata.map.data[from], sizeof (mapdata_t));
	memcpy(&s_scriptdata.map.data[from], &s_scriptdata.map.data[to], sizeof (mapdata_t));
	memcpy(&s_scriptdata.map.data[to], &tmp, sizeof (mapdata_t));

	return qtrue;
}





/*
=================
StartServer_StoreMap

Places map data into the array, overwriting a previous entry
=================
*/
void StartServer_StoreMap(int pos, int arena)
{
	const char* info;
	char* shortname;
	char* longname;
	int len;
	int base;

	pos = StartServer_RangeClipMapIndex(pos);
	info = UI_GetArenaInfoByNumber(arena);

	shortname = Info_ValueForKey(info, "map");
	len = strlen(shortname) + 1;
	Q_strncpyz(s_scriptdata.map.data[pos].shortName, shortname, len);

	longname = Info_ValueForKey(info, "longname");
	if (!longname || !*longname)
		longname = shortname;

	len = strlen(longname) + 1;
	Q_strncpyz(s_scriptdata.map.data[pos].longName, longname, len);

	// increase map count if we put map into a previously empty slot
	// set frag/time limits too
	if (pos == s_scriptdata.map.num_maps) {
		s_scriptdata.map.num_maps++;
		Q_strncpyz(s_scriptdata.map.data[pos].fragLimit, va("%i", s_scriptdata.map.fragLimit), MAX_LIMIT_BUF);
		Q_strncpyz(s_scriptdata.map.data[pos].timeLimit, va("%i", s_scriptdata.map.timeLimit), MAX_LIMIT_BUF);
	}
}



/*
=================
StartServer_InsertMap

Creates an empty slot for map data to be added
=================
*/
void StartServer_InsertMap(int pos, int arena)
{
	int last;
	int i;

	// drop any maps that try to overflow
	if (pos > MAX_NUMMAPS - 1)
		return;

	pos = StartServer_RangeClipMapIndex(pos);

	// quietly drop last map on list if we are inserting earlier
	last = s_scriptdata.map.num_maps - 1;
	if (last == MAX_NUMMAPS - 1 )
		last--;
	else
		s_scriptdata.map.num_maps++;

	// move maps up one slot
	for (i = last; i >= pos; i--)
		memcpy(&s_scriptdata.map.data[i+1], &s_scriptdata.map.data[i], sizeof(mapdata_t));

	StartServer_StoreMap(pos, arena);
	Q_strncpyz(s_scriptdata.map.data[pos].fragLimit, va("%i", s_scriptdata.map.fragLimit), MAX_LIMIT_BUF);
	Q_strncpyz(s_scriptdata.map.data[pos].timeLimit, va("%i", s_scriptdata.map.timeLimit), MAX_LIMIT_BUF);
}



/*
=================
StartServer_DeleteMap
=================
*/
void StartServer_DeleteMap(int index)
{
	int lines;
	int i;

	if (index < 0 || index >= MAX_NUMMAPS)
		return;

	lines = (MAX_NUMMAPS - index - 1);
	if (lines) {
		for (i =0 ; i < lines; i++)
			memcpy(&s_scriptdata.map.data[index + i], &s_scriptdata.map.data[index + i + 1], sizeof(mapdata_t));
	}

	// zero final element only
	memset(&s_scriptdata.map.data[MAX_NUMMAPS - 1], 0, sizeof(mapdata_t));

	if (index < s_scriptdata.map.num_maps)
		s_scriptdata.map.num_maps--;
}






/*
=================
StartServer_RefreshMapNames
=================
*/
void StartServer_RefreshMapNames(void)
{
	int i, j, count;
	const char	*info;
	char* arena_mapname;

	i = 0;
	count = UI_GetNumArenas();
	while (i < MAX_NUMMAPS && s_scriptdata.map.data[i].shortName[0]) {
		for( j = 0; j < count; j++ ) {
			info = UI_GetArenaInfoByNumber( j );

			if (!info)
				continue;

			arena_mapname = Info_ValueForKey( info, "map");
			if (!arena_mapname || arena_mapname[0] == '\0') {
				continue;
			}

			if (!Q_stricmp(s_scriptdata.map.data[i].shortName, arena_mapname))
			{
				Q_strncpyz( s_scriptdata.map.data[i].longName, Info_ValueForKey( info, "longname"), LONGMAP_BUFFER);
				break;
			}
		}
		// map not found, quietly delete it from list
		if (j == count) {
			StartServer_DeleteMap(i);
			continue;
		}

		i++;
	}

	s_scriptdata.map.num_maps = i;
}




/*
=================
StartServer_GetArenaFragLimit
=================
*/
static const char* StartServer_GetArenaFragLimit( int map )
{
	static char fraglimit[16];
	const char* info;
	const char* infofrag;

	info = UI_GetArenaInfoByMap(s_scriptdata.map.data[map].shortName);
	infofrag = Info_ValueForKey(info, "fraglimit");

	if (infofrag[0]) {
		Q_strncpyz(fraglimit, infofrag, 16);
	}
	else {
		Q_strncpyz(fraglimit, va("%i", s_scriptdata.map.fragLimit), 16);
	}
		
	return fraglimit;
}




/*
=================
StartServer_MapDoAction
=================
*/
void StartServer_MapDoAction( int src, int dest, int page, int selected )
{
	int i;
	int pageindex;
	const char* fragsrc;
	const char* timesrc;

	pageindex = page * NUMMAPS_PERPAGE;

	//
	// actions using src
	//

	if (src == MAP_CF_CLEARALL)
	{
		while (s_scriptdata.map.num_maps)
		{
			StartServer_DeleteMap(0);
		}
		return;
	}

	if (src == MAP_CF_CLEARPAGE)
	{
		for (i = 0; i < NUMMAPS_PERPAGE; i++)
			StartServer_DeleteMap(pageindex);
		return;
	}

	//
	// actions that combine src and dest
	//

	if (src == MAP_CF_ARENASCRIPT) {
		switch (dest) {
			case MAP_CT_SELECTED:
				if (selected >= 0) {
					fragsrc = StartServer_GetArenaFragLimit(pageindex + selected);
					Q_strncpyz(s_scriptdata.map.data[pageindex + selected].fragLimit, fragsrc, MAX_LIMIT_BUF);
				}
				break;

			case MAP_CT_PAGE:
				for (i = 0; i < NUMMAPS_PERPAGE; i++) {
					fragsrc = StartServer_GetArenaFragLimit(pageindex + i);
					Q_strncpyz(s_scriptdata.map.data[pageindex + i].fragLimit, fragsrc, MAX_LIMIT_BUF);
				}
				break;

			case MAP_CT_ALL:
				for (i = 0; i < s_scriptdata.map.num_maps; i++) {
					fragsrc = StartServer_GetArenaFragLimit(i);
					Q_strncpyz(s_scriptdata.map.data[i].fragLimit, fragsrc, MAX_LIMIT_BUF);
				}

				break;
		}
		return;
	}

	// there's some overlap between the copying of time and frag limits
	// "flow through" from the time to the frag code is expected
	// ANY OTHER CUSTOM VALUES SHOULD APPEAR BEFORE THIS CODE

	// copy time
	timesrc = va("%i", s_scriptdata.map.timeLimit);
	if (src != MAP_CF_FRAG) {
		switch (dest) {
			case MAP_CT_SELECTED:
				if (selected >= 0)
					Q_strncpyz(s_scriptdata.map.data[pageindex + selected].timeLimit, timesrc, MAX_LIMIT_BUF);
				break;
			case MAP_CT_PAGE:
				for (i = 0; i < NUMMAPS_PERPAGE; i++)
					Q_strncpyz(s_scriptdata.map.data[pageindex + i].timeLimit, timesrc, MAX_LIMIT_BUF);
				break;
			case MAP_CT_ALL:
				for (i = 0; i < s_scriptdata.map.num_maps; i++)
					Q_strncpyz(s_scriptdata.map.data[i].timeLimit, timesrc, MAX_LIMIT_BUF);

				break;
		}
	}


	// copy frags/caps
	fragsrc = va("%i", s_scriptdata.map.fragLimit);
	if (src != MAP_CF_TIME) {
		switch (dest) {
			case MAP_CT_SELECTED:
				if (selected >= 0)
					Q_strncpyz(s_scriptdata.map.data[pageindex + selected].fragLimit, fragsrc, MAX_LIMIT_BUF);
				break;
			case MAP_CT_PAGE:
				for (i = 0; i < NUMMAPS_PERPAGE; i++)
					Q_strncpyz(s_scriptdata.map.data[pageindex + i].fragLimit, fragsrc, MAX_LIMIT_BUF);
				break;
			case MAP_CT_ALL:
				for (i = 0; i < s_scriptdata.map.num_maps; i++)
					Q_strncpyz(s_scriptdata.map.data[i].fragLimit, fragsrc, MAX_LIMIT_BUF);
				break;
		}
	}
}





/*
=================
StartServer_BuildMapDistribution
=================
*/
static void StartServer_BuildMapDistribution(void)
{
	int i, j, count, maptype, gametype;
	const char	*info;
	char* arena_mapname;
	int matchbits, gamebits;

	// set zero
	for (i = 0; i < MAX_GAME_TYPE; i++)
		for (j = 0; j < MAX_MAP_GROUP; j++)
			s_scriptdata.map.TypeCount[i][j] = 0;

	count = UI_GetNumArenas();
	for( i = 0; i < count; i++ ) {
		info = UI_GetArenaInfoByNumber( i );

		if (!info)
			continue;

		arena_mapname = Info_ValueForKey( info, "map");
		if (!arena_mapname || arena_mapname[0] == '\0') {
			continue;
		}

		if (StartServer_IsIdMap(arena_mapname))
			maptype = MAP_GROUP_ID;
		else
			maptype = MAP_GROUP_NONID;

		gamebits = GametypeBits( Info_ValueForKey( info, "type") );
		for (j = 0; j < NUM_GAMETYPES; j++)
		{
			gametype = gametype_remap[j];
			matchbits = 1 << gametype;
			if( gametype == GT_FFA ) {
				matchbits |= ( 1 << GT_SINGLE_PLAYER );
			}

			if (matchbits & gamebits)
				s_scriptdata.map.TypeCount[ gametype_remap2[gametype] ][maptype]++;
		}
	}
}


/*
=================
StartServer_SaveMapList
=================
*/
void StartServer_SaveMapList(void)
{
	char* s;
	char* s1;

	s1 = "maplist";
	if (s_scriptdata.map.listSource == MAP_MS_RANDOMEXCLUDE)
		s1 = "maplistexclude";

	s = gametype_cvar_base[gametype_remap2[s_scriptdata.gametype]];
	UI_SaveMultiArray(s, s1, SSMP_ShortName_Callback, MAX_NUMMAPS, SHORTMAP_BUFFER, ';');
}








/*
=================
StartServer_LoadMapScriptData

Loads map specific gametype data
=================
*/
static void StartServer_LoadMapScriptData(void)
{
	char buf[64];
	int i, index, num, max;
	char* s;
	char *f, *f2;

	index = 0;
	f = "customfraglimits";
	f2 = "fragtype";

	s = gametype_cvar_base[gametype_remap2[s_scriptdata.gametype]];

	if (s_scriptdata.gametype >= GT_CTF) {
		s_scriptdata.map.fragLimit = UIE_GetSkirmishCvarIntClamp(0, 999, s, "capturelimit");
		f = "customcapturelimits";
		f2 = "capturetype";
	}
	else {
		s_scriptdata.map.fragLimit = UIE_GetSkirmishCvarIntClamp(0, 99, s, "fraglimit");
	}

	s_scriptdata.map.timeLimit = UIE_GetSkirmishCvarIntClamp(0, 999, s, "timelimit");

	// load custom frag/time values
	UI_LoadMultiArray(s, f, SSMP_FragLimit_Callback, MAX_NUMMAPS, MAX_LIMIT_BUF, ';');
	UI_LoadMultiArray(s, "customtimelimits", SSMP_TimeLimit_Callback, MAX_NUMMAPS, MAX_LIMIT_BUF, ';');

	// load type of frag/time value used to start game (none, default, custom)
	s_scriptdata.map.fragLimitType = UIE_GetSkirmishCvarIntClamp(0, 2, s, f2 );
	s_scriptdata.map.timeLimitType = UIE_GetSkirmishCvarIntClamp(0, 2, s, "timetype" );

	// load map source and repeat info
	s_scriptdata.map.Repeat = UIE_GetSkirmishCvarIntClamp(0, 1, s, "MapRepeat");
	s_scriptdata.map.listSource = UIE_GetSkirmishCvarIntClamp(0, MAP_MS_MAX - 1, s, "MapSource");

	// load maps
	// must be after s_scriptdata.map.type is set
	StartServer_LoadMapList();

	s_scriptdata.map.Repeat = UIE_GetSkirmishCvarIntClamp(0, 1, s, "MapRepeat");
	s_scriptdata.map.SourceCount = UIE_GetSkirmishCvarIntClamp(2, 99, s, "RandomMapCount");

	UIE_GetSkirmishCvar( s, "RandomMapType", buf, 64);
	s_scriptdata.map.SourceType = (int)Com_Clamp(0, MAP_RND_MAX - 1, atoi(buf));	// non-numerical values give zero

	max = StartServer_NumCustomMapTypes();
	for (i = 0; i < max; i++)
	{
		if (!Q_stricmp(buf, randommaptype_items[MAP_RND_MAX + i]))
		{
			s_scriptdata.map.SourceType = MAP_RND_MAX + i;
			break;
		}
	}

	// validate each of the map names
	StartServer_RefreshMapNames();
}



/*
=================
StartServer_SaveMapScriptData

Saves map specific gametype data
=================
*/
static void StartServer_SaveMapScriptData(void)
{
	int type;
	char* s;
	char *f, *f2;

	s = gametype_cvar_base[gametype_remap2[s_scriptdata.gametype]];
	f = "customfraglimits";
	f2 = "fragtype";

	UIE_SetSkirmishCvarInt( s, "timelimit", s_scriptdata.map.timeLimit);
	if (s_scriptdata.gametype >= GT_CTF) {
		UIE_SetSkirmishCvarInt( s, "capturelimit", s_scriptdata.map.fragLimit);
		f = "customcapturelimits";
		f2 = "capturetype";
	}
	else {
		UIE_SetSkirmishCvarInt( s, "fraglimit", s_scriptdata.map.fragLimit);
	}

	StartServer_SaveMapList();

	UIE_SetSkirmishCvarInt( s, "MapSource", s_scriptdata.map.listSource);

	// save custom frag/time values
	UI_SaveMultiArray(s, f, SSMP_FragLimit_Callback, MAX_NUMMAPS, MAX_LIMIT_BUF, ';');
	UI_SaveMultiArray(s, "customtimelimits", SSMP_TimeLimit_Callback, MAX_NUMMAPS, MAX_LIMIT_BUF, ';');

	// save type of frag/time value used to start game (none, default, custom)
	UIE_SetSkirmishCvarInt( s,f2, s_scriptdata.map.fragLimitType);
	UIE_SetSkirmishCvarInt( s,"timetype", s_scriptdata.map.timeLimitType);

	// save map source and repeat info
	UIE_SetSkirmishCvarInt( s, "MapRepeat", s_scriptdata.map.Repeat);
	UIE_SetSkirmishCvarInt( s, "RandomMapCount", s_scriptdata.map.SourceCount);

	type = s_scriptdata.map.SourceType;
	if (type < MAP_RND_MAX)
		UIE_SetSkirmishCvarInt( s, "RandomMapType", type);
	else
		UIE_SetSkirmishCvar( s, "RandomMapType", randommaptype_items[type]);
}















/*
==========================================================================

LOADING AND SAVING OF BOT SCRIPT DATA

==========================================================================
*/

#define BOT_TMPBUFFER 4

static char botskill_tmpbuffer[PLAYER_SLOTS][BOT_TMPBUFFER];	// tmp used to load/save bot skill values




/*
=================
StartServer_IsBotArenaScript
=================
*/
qboolean StartServer_IsBotArenaScript(int type)
{
	if (type == BOTTYPE_ARENASCRIPT || type == BOTTYPE_RANDOMARENASCRIPT ||
         type == BOTTYPE_SELECTARENASCRIPT)
		return qtrue;

	return qfalse;
}


/*
=================
StartServer_IsRandomBotExclude
=================
*/
qboolean StartServer_IsRandomBotExclude(int type)
{
	if (type == BOTTYPE_RANDOMEXCLUDE || type == BOTTYPE_RANDOMARENASCRIPT)
		return qtrue;

	return qfalse;
}




/*
=================
StartServer_IsRandomBotList
=================
*/
qboolean StartServer_IsRandomBotList( int type )
{
	if (type == BOTTYPE_RANDOM || type == BOTTYPE_RANDOMEXCLUDE || type == BOTTYPE_RANDOMARENASCRIPT)
		return qtrue;
	return qfalse;
}







/*
=================
StartServer_SetBotSkillValue
=================
*/
static void StartServer_SetBotSkillValue(botskill_t* b, int value)
{
	value = (int)Com_Clamp(0 , 999, value);
	b->value = (int)Com_Clamp(0, 4, (value / 100) % 10);
	b->low = (int)Com_Clamp(0, 4, (value / 10) % 10);
	b->high = (int)Com_Clamp(0, 4, value % 10);
}



/*
=================
StartServer_SetBotSkillRangeType

Assumes s_scriptdata.bot.typeSelect is already initialized
=================
*/
void StartServer_SetBotSkillRangeType(int skill)
{
	int i;
	qboolean qbool;

	// wrap skill early if selecting from random
	if ((StartServer_IsRandomBotList(s_scriptdata.bot.typeSelect) || StartServer_IsBotArenaScript(s_scriptdata.bot.typeSelect)) 
		&& skill >= BOTSKILL_CUSTOMSINGLE)
	{
		skill = BOTSKILL_SAME;
	}

	s_scriptdata.bot.skillType = skill;
	if (skill == BOTSKILL_SAME || skill == BOTSKILL_CUSTOMSINGLE) {
		qbool = qfalse;
	}
	else {
		qbool = qtrue;
	}

	s_scriptdata.bot.globalSkill.range = qbool;
	for (i = 0; i < PLAYER_SLOTS; i++)
		s_scriptdata.bot.skill[i].range = qbool;
}


/*
=================
SSBP_BotName_Callback
=================
*/
static char* SSBP_BotName_Callback(int index)
{
	return s_scriptdata.bot.name[index];
}



/*
=================
SSBP_BotBuffer_Callback
=================
*/
static char* SSBP_BotBuffer_Callback(int index)
{
	return botskill_tmpbuffer[index];
}




/*
=================
StartServer_ValidBotCount
=================
*/
int StartServer_ValidBotCount( void )
{
   int count = 0;
   int i;

   for (i = 0; i < PLAYER_SLOTS; i++) {
      if (s_scriptdata.bot.slotType[i] != SLOTTYPE_BOT) {
         continue;
      }
      if (s_scriptdata.bot.name[i][0] == '\0') {
         continue;
      }
      count++;
   }

   return count;
}



/*
=================
StartServer_BotOnSelectionList
=================
*/
qboolean StartServer_BotOnSelectionList( const char *checkName )
{
	int i;

	for (i = 0 ; i < PLAYER_SLOTS; i++) {
		if (s_scriptdata.bot.slotType[i] != SLOTTYPE_BOT)
			continue;

		if (Q_stricmp(checkName, s_scriptdata.bot.name[i]) == 0)
			return qtrue;
	}

	return qfalse;
}





/*
=================
StartServer_DeleteBotSlot
=================
*/
qboolean StartServer_DeleteBotSlot(int index)
{
	int i, count, last;

	if (index < 0 || index >= PLAYER_SLOTS)
		return qfalse;

	// number of slots to move
	count = PLAYER_SLOTS - index - 1;
	if (s_scriptdata.gametype >= GT_TEAM && !StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect) && index < PLAYER_SLOTS_PERCOL) {
		count -= PLAYER_SLOTS_PERCOL;
	}

	if (count) {
		for (i = index; i < index + count; i++) {
			memcpy(s_scriptdata.bot.name[i], s_scriptdata.bot.name[i + 1], MAX_NAME_LENGTH);
			memcpy(&s_scriptdata.bot.skill[i], &s_scriptdata.bot.skill[i + 1], sizeof(botskill_t));
			s_scriptdata.bot.slotType[i] = s_scriptdata.bot.slotType[i + 1];
		}
	}

	// zero last slot
	last = index + count;
	memset(s_scriptdata.bot.name[last], 0, MAX_NAME_LENGTH);
	s_scriptdata.bot.skill[last].value = 0;
	s_scriptdata.bot.skill[last].low = 0;
	s_scriptdata.bot.skill[last].high = 0;

	s_scriptdata.bot.slotType[last] = SLOTTYPE_EMPTY;

	return qtrue;
}



/*
=================
StartServer_InsertBotSlot
=================
*/
qboolean StartServer_InsertBotSlot(int index)
{
	int i, count;

	if (index < 0 || index >= PLAYER_SLOTS)
		return qfalse;

	// number of slots to move
	count = PLAYER_SLOTS - index - 1;
	if (s_scriptdata.gametype >= GT_TEAM && index < PLAYER_SLOTS_PERCOL) {
		count -= PLAYER_SLOTS_PERCOL;
	}

	if (count) {
		for (i = index + count - 1 ; i >= index; i--) {
			// memcpy causes problems when copying "up", so move one entry at a time
			// write this before discovering memmove!
			memcpy(s_scriptdata.bot.name[i + 1], s_scriptdata.bot.name[i], MAX_NAME_LENGTH);
			memcpy(&s_scriptdata.bot.skill[i + 1], &s_scriptdata.bot.skill[i], sizeof(botskill_t));
			s_scriptdata.bot.slotType[i + 1] = s_scriptdata.bot.slotType[i];
		}
	}

	memset(s_scriptdata.bot.name[index], 0, MAX_NAME_LENGTH);
	s_scriptdata.bot.skill[index].value = 0;
	s_scriptdata.bot.skill[index].low = 0;
	s_scriptdata.bot.skill[index].high = 0;

	s_scriptdata.bot.slotType[index] = SLOTTYPE_EMPTY;

	return qtrue;
}



/*
=================
StartServer_SetNamedBot
=================
*/
void StartServer_SetNamedBot(int index, char* name)
{
	qboolean init;

	if (index < 0 || index >= PLAYER_SLOTS || !name)
		return;

	if (s_scriptdata.bot.name[index][0] == '\0') {
		s_scriptdata.bot.skill[index] = s_scriptdata.bot.globalSkill;
	}

	Q_strncpyz(s_scriptdata.bot.name[index], name, MAX_NAME_LENGTH);
	s_scriptdata.bot.slotType[index] = SLOTTYPE_BOT;
}



/*
=================
StartServer_InsertNamedBot
=================
*/
void StartServer_InsertNamedBot(int index, char* name)
{
	if (index < 0 || index >= PLAYER_SLOTS || !name)
		return;

	StartServer_InsertBotSlot(index);
	StartServer_SetNamedBot(index, name);
}



/*
=================
StartServer_SlotTeam
=================
*/
int StartServer_SlotTeam(int index)
{
	if (index < 0)
		return SLOTTEAM_INVALID;

	if (s_scriptdata.gametype >= GT_TEAM) {
		if (index < PLAYER_SLOTS_PERCOL)
			return SLOTTEAM_ONE;
		if (index < PLAYER_SLOTS)
			return SLOTTEAM_TWO;
	}
	else {
		if (index < PLAYER_SLOTS)
			return SLOTTEAM_NONE;
	}

	return SLOTTEAM_INVALID;
}




/*
=================
StartServer_MoveBotToOtherTeam
=================
*/
void StartServer_MoveBotToOtherTeam(int selected)
{
	int i, firstopen, dest, max, start;

	if (selected < 0 || selected >= PLAYER_SLOTS)
		return;

	if (s_scriptdata.bot.slotType[selected] != SLOTTYPE_BOT)
		return;

	// try to find an empty slot first
	firstopen = -1;
	max = PLAYER_SLOTS_PERCOL;
	start = 0;
	if (selected < PLAYER_SLOTS_PERCOL) {
		max = PLAYER_SLOTS;
		start = PLAYER_SLOTS_PERCOL;
	}

	dest = -1;
	for (i = start; i < max ; i++)
	{
		if (firstopen == -1 && s_scriptdata.bot.slotType[i] == SLOTTYPE_OPEN)
			firstopen = i;

		if (s_scriptdata.bot.slotType[i] == SLOTTYPE_EMPTY) {
			dest = i;
			break;
		}
	}

	// use openslot if we have no free ones
	if (dest == -1) {
		if (firstopen == -1)
			return;
		dest = firstopen;
	}

	
	// copy over details
	Q_strncpyz(s_scriptdata.bot.name[dest], s_scriptdata.bot.name[selected], MAX_NAME_LENGTH);

	s_scriptdata.bot.slotType[dest] = s_scriptdata.bot.slotType[selected];

	s_scriptdata.bot.skill[dest].value = s_scriptdata.bot.skill[selected].value;
	s_scriptdata.bot.skill[dest].high= s_scriptdata.bot.skill[selected].high;
	s_scriptdata.bot.skill[dest].low = s_scriptdata.bot.skill[selected].low;

	StartServer_DeleteBotSlot(selected);
}



/*
=================
StartServer_BotNameDrawn
=================
*/
void StartServer_BotNameDrawn(int index, qboolean drawn)
{
	s_scriptdata.bot.drawName[index] = drawn;
}



/*
=================
StartServer_BotDoAction
=================
*/
void StartServer_DoBotAction(int action, int selected)
{
	int i;
	int count, index, open, slot, bots_done;

	switch (action) {
		case BOT_CT_CLEARALL:
			for (i = 0; i < PLAYER_SLOTS; i++) {
				if (s_scriptdata.bot.slotType[i] == SLOTTYPE_BOT || s_scriptdata.bot.slotType[i] == SLOTTYPE_OPEN)
				{
					s_scriptdata.bot.slotType[i] = SLOTTYPE_EMPTY;
					StartServer_BotNameDrawn(i, qfalse);
					memset(s_scriptdata.bot.name[i], 0, MAX_NAME_LENGTH);
				}
			}
			break;
		case BOT_CT_INDIV_SELECTED:
			if (selected >=0) {
				s_scriptdata.bot.skill[selected].value = s_scriptdata.bot.globalSkill.value;
			}
			break;
		case BOT_CT_RANGE_SELECTED:
			if (selected >=0) {
				s_scriptdata.bot.skill[selected].low = s_scriptdata.bot.globalSkill.low;
				s_scriptdata.bot.skill[selected].high = s_scriptdata.bot.globalSkill.high;
			}
			break;
		case BOT_CT_INDIV_ALL:
			for (i = 0; i < PLAYER_SLOTS; i++) {
				s_scriptdata.bot.skill[i].value = s_scriptdata.bot.globalSkill.value;
			}
			break;
		case BOT_CT_RANGE_ALL:
			for (i = 0; i < PLAYER_SLOTS; i++) {
				s_scriptdata.bot.skill[i].low = s_scriptdata.bot.globalSkill.low;
				s_scriptdata.bot.skill[i].high = s_scriptdata.bot.globalSkill.high;
			}
			break;

		case BOT_CT_NEATEN:

			// perform two passes when we have a team arrangement
			// once on each column, treated separately
			bots_done = 0;
			do {
				open = 0;
				count = PLAYER_SLOTS;
				index = bots_done;
				if (s_scriptdata.gametype >= GT_TEAM && !StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect)) {
					count = PLAYER_SLOTS_PERCOL;
				}

				// compact all the bots, counting the open slots
				while (count > 0) {
					slot = s_scriptdata.bot.slotType[index];
					if (slot == SLOTTYPE_OPEN)
						open++;

					if (slot == SLOTTYPE_BOT || slot == SLOTTYPE_HUMAN)
						index++;
					else
						StartServer_DeleteBotSlot(index);

					count--;
					bots_done++;
				}

				// place all the open slots
				for (i = 0; i < open; i++) {
					s_scriptdata.bot.slotType[index] = SLOTTYPE_OPEN;
					index++;
				}
			} while (bots_done < PLAYER_SLOTS);

			break;
	}
}



/*
=================
StartServer_ValidateBotSlotCount
=================
*/
void StartServer_ValidateBotSlotCount(int bots, int open)
{
	if (bots < 0)
		bots = 0;

	if (open < 0)
		open = 0;

	if (bots > MAX_CLIENTS - 1)
		bots = MAX_CLIENTS - 1;

	if (open > MAX_CLIENTS - 1)
		open = MAX_CLIENTS - 1;

	// sacrifice open slots for bots
	if (bots + open > MAX_CLIENTS - 1)
		open = MAX_CLIENTS - bots - 1;

	s_scriptdata.bot.numberBots = bots;
	s_scriptdata.bot.numberOpen = open;	
}



/*
=================
StartServer_AdjustBotSelectionFromGametype

wraps the bot.typeSelect safely, based on the current gametype
=================
*/
static void StartServer_AdjustBotSelectionFromGametype(void)
{
	if (s_scriptdata.gametype >= GT_TEAM && StartServer_IsBotArenaScript(s_scriptdata.bot.typeSelect))
		s_scriptdata.bot.typeSelect = BOTTYPE_SELECT;
}



/*
=================
StartServer_LoadBotNameList
=================
*/
void StartServer_LoadBotNameList(int type)
{
	char* s;
	char* s1;
	int i;

	s_scriptdata.bot.typeSelect = type;
	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	memset(&s_scriptdata.bot.name, 0, PLAYER_SLOTS*MAX_NAME_LENGTH);

	for (i = 0 ; i < PLAYER_SLOTS; i++) {
		s_scriptdata.bot.slotType[i] = SLOTTYPE_EMPTY;
		StartServer_SetBotSkillValue(&s_scriptdata.bot.skill[i], 0 );
	}

    StartServer_AdjustBotSelectionFromGametype();

	// check if we need to load any bot data at all
	if (s_scriptdata.bot.typeSelect == BOTTYPE_ARENASCRIPT)
		return;

	// find the right type of bot data to load
	if (StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect)) {
		s1 = "botexclude";
	}
	else {
		s1 = "botname";
	}	

    // do the load
	UI_LoadMultiArray( s, s1, SSBP_BotName_Callback, PLAYER_SLOTS, MAX_NAME_LENGTH, ';' );

	if (StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect))
	{
		for ( i = 0 ; i < PLAYER_SLOTS; i++) {
			if (s_scriptdata.bot.name[i][0])
				s_scriptdata.bot.slotType[i] = SLOTTYPE_BOT;
			else
				s_scriptdata.bot.slotType[i] = SLOTTYPE_EMPTY;
			StartServer_SetBotSkillValue(&s_scriptdata.bot.skill[i], 0 );
		}
	}
	else
	{
		UI_LoadMultiArray( s, "slottype", SSBP_BotBuffer_Callback, PLAYER_SLOTS, BOT_TMPBUFFER, ';' );
		for ( i = 0 ; i < PLAYER_SLOTS; i++) {
			s_scriptdata.bot.slotType[i] = (int)Com_Clamp(0, SLOTTYPE_COUNT, atoi(botskill_tmpbuffer[i]));
		}

		UI_LoadMultiArray( s, "botskill", SSBP_BotBuffer_Callback, PLAYER_SLOTS, BOT_TMPBUFFER, ';' );
		for ( i = 0 ; i < PLAYER_SLOTS; i++) {
			StartServer_SetBotSkillValue(&s_scriptdata.bot.skill[i], atoi(botskill_tmpbuffer[i]) );
		}

		if (!s_scriptdata.bot.joinAs)
			s_scriptdata.bot.slotType[0] = SLOTTYPE_HUMAN;
	}

	// set any slot other that first as non-human
	// (only tampering should cause this)
	for ( i = 1; i < PLAYER_SLOTS; i++ ) {
		if (s_scriptdata.bot.slotType[i] == SLOTTYPE_HUMAN) {
			s_scriptdata.bot.slotType[i] = SLOTTYPE_OPEN;
		}
	}
}



/*
=================
StartServer_SaveBotNameList
=================
*/
void StartServer_SaveBotNameList(void)
{
	char* s;
	char* s1;
	int i;
	botskill_t* b;
	qboolean exclude;

	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	if (StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect)) {
		exclude = qtrue;
		s1 = "botexclude";
	}
	else
	{
		exclude = qfalse;
		s1 = "botname";
	}

	UI_SaveMultiArray( s, s1, SSBP_BotName_Callback, PLAYER_SLOTS, MAX_NAME_LENGTH, ';' );

	if (!exclude)
	{
		for ( i = 0 ; i < PLAYER_SLOTS; i++) {
			Q_strncpyz( botskill_tmpbuffer[i], va("%i", s_scriptdata.bot.slotType[i]), BOT_TMPBUFFER);
		}
		UI_SaveMultiArray( s, "slottype", SSBP_BotBuffer_Callback, PLAYER_SLOTS, BOT_TMPBUFFER, ';' );

		for ( i = 0 ; i < PLAYER_SLOTS; i++) {
			b = &s_scriptdata.bot.skill[i];
			Q_strncpyz( botskill_tmpbuffer[i], va("%i%i%i", b->value, b->low, b->high), BOT_TMPBUFFER);
		}
		UI_SaveMultiArray( s, "botskill", SSBP_BotBuffer_Callback, PLAYER_SLOTS, BOT_TMPBUFFER, ';' );
	}
}





/*
=================
StartServer_LoadBotScriptData

Loads bot specific gametype data
=================
*/
void StartServer_LoadBotScriptData(void)
{
	char* s;
	int i, value, max;
	botskill_t* b;

	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	//
	// load state values
	//

	// join game as
	s_scriptdata.bot.joinAs = UIE_GetSkirmishCvarIntClamp(0, 1, s, "PlayerJoinAs");

	// skill selection method for bots
	// assumes BotSelection method is already set in Start_Server_LoadBotNameList()
	StartServer_SetBotSkillRangeType(UIE_GetSkirmishCvarIntClamp(0, BOTSKILL_COUNT, s, "BotSkillType"));

	// number of bots if randomly generated
	s_scriptdata.bot.numberBots = UIE_GetSkirmishCvarIntClamp(0, 99, s, "BotCount");

	// frequency of bot changing on maps
	s_scriptdata.bot.changeBots = UIE_GetSkirmishCvarIntClamp(0, BOTCHANGE_COUNT, s, "BotChange");

	// number of open slots if bots are randomly selected
	s_scriptdata.bot.numberOpen = UIE_GetSkirmishCvarIntClamp(0, 99, s, "OpenSlotCount");

	// skill range values
	StartServer_SetBotSkillValue(&s_scriptdata.bot.globalSkill, UIE_GetSkirmishCvarInt(s, "BotSkillValue"));

	// skill bias
	s_scriptdata.bot.skillBias = UIE_GetSkirmishCvarIntClamp(0, SKILLBIAS_COUNT, s, "BotSkillBias");

	// swap teams
	if (s_scriptdata.gametype >= GT_TEAM) {
		s_scriptdata.bot.teamSwapped = UIE_GetSkirmishCvarIntClamp(0, 1, s, "TeamSwapped");
	}

	// load bot stats
	// requires bot.joinAs to be set
	StartServer_LoadBotNameList(UIE_GetSkirmishCvarIntClamp(0, BOTTYPE_MAX, s, "BotSelection"));
}




/*
=================
StartServer_SaveBotScriptData

Saves bot specific gametype data
=================
*/
static void StartServer_SaveBotScriptData(void)
{
	char* s;
	int i, value;
	botskill_t* b;

	//
	// save state values
	//

	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	// method of selecting bots
	UIE_SetSkirmishCvarInt(s, "BotSelection", s_scriptdata.bot.typeSelect);

	// number of bots if randomly generated
	UIE_SetSkirmishCvarInt(s, "BotCount", s_scriptdata.bot.numberBots);

	// frequency of bot changing on maps
	UIE_SetSkirmishCvarInt(s, "BotChange", s_scriptdata.bot.changeBots);

	// number of open slots if bots are randomly selected
	UIE_SetSkirmishCvarInt(s, "OpenSlotCount", s_scriptdata.bot.numberOpen);

	// skill selection method for bots
	UIE_SetSkirmishCvarInt(s, "BotSkillType", s_scriptdata.bot.skillType);

	// skill range values
	b = &s_scriptdata.bot.globalSkill;
	value = (b->value * 100) +  (b->low * 10) + b->high;
	UIE_SetSkirmishCvarInt(s, "BotSkillValue", value);

	// skill bias
	UIE_SetSkirmishCvarInt(s, "BotSkillBias", s_scriptdata.bot.skillBias);

	// join game as
	UIE_SetSkirmishCvarInt(s, "PlayerJoinAs", s_scriptdata.bot.joinAs);

	// swap teams
	if (s_scriptdata.gametype >= GT_TEAM)
		UIE_SetSkirmishCvarInt(s, "TeamSwapped", s_scriptdata.bot.teamSwapped);

	//
	// bots
	//

	// save bot stats
	StartServer_SaveBotNameList();
}



/*
==========================================================================

LOADING AND SAVING OF ITEM SCRIPT DATA

==========================================================================
*/



/*
=================
StartServer_LoadItemScriptData

Loads item specific gametype data
=================
*/
void StartServer_LoadDisabledItems(void)
{
	char* s;
	char buffer[256];
	char* ptr, *ptr_last;
	int i;

	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	// load the group on/off/custom values
	memset(buffer,0,sizeof(buffer));
	UIE_GetSkirmishCvar(s, "itemGroups", buffer, 256);
	ptr = buffer;
	for (i = 0; i < ITEMGROUP_COUNT; i++)
	{
		if (*ptr) {
			s_scriptdata.item.groupstate[i] = (int)Com_Clamp(0, ALLGROUPS_HIDDEN, *ptr - '0');
			ptr++;
		}
		else {
			s_scriptdata.item.groupstate[i] = ALLGROUPS_ENABLED;
		}
	}

	// load individual item values
	// we only load a list of items that are "off"
	// no assumption about order is made
	for (i = 0; i < ITEM_COUNT; i++)
	{
		s_scriptdata.item.enabled[i] = qtrue;
	}

	memset(buffer, 0, sizeof(buffer));
	UIE_GetSkirmishCvar(s, "itemsHidden", buffer, 256);
	ptr = buffer;
	while (*ptr) {
		ptr_last = strchr(ptr, '\\');

		if (!ptr_last)
			break;

		*ptr_last = '\0';
		for (i = 0; i < ITEM_COUNT; i++) {
			if (!Q_stricmp(ptr, server_itemlist[i].shortitem))
			{
				s_scriptdata.item.enabled[i] = qfalse;
				break;
			}

		}

		// move to next char
		ptr = ptr_last + 1;
	}
}



/*
=================
StartServer_LoadItemScriptData

Loads item specific gametype data
=================
*/
static void StartServer_LoadItemScriptData(void)
{
	StartServer_LoadDisabledItems();
}



/*
=================
StartServer_SaveItemScriptData

Saves item specific gametype data
=================
*/
static void StartServer_SaveItemScriptData(void)
{
	char* s;
	char buffer[256];
	int i;

	s = gametype_cvar_base[ gametype_remap2[s_scriptdata.gametype] ];

	// save the group values
	for (i = 0; i < ITEMGROUP_COUNT; i++)
	{
		buffer[i] = '0' + s_scriptdata.item.groupstate[i];
	}
	buffer[ITEMGROUP_COUNT] = '\0';

	UIE_SetSkirmishCvar(s, "itemGroups", buffer);

	// save individual item values
	// we only save a list of items that are "off"
	// always terminate with a slash
	buffer[0] = '\0';
	for (i = 0; i < ITEM_COUNT; i++)
	{
		if (!s_scriptdata.item.enabled[i]) {
			Q_strcat(buffer, 256, va("%s\\", server_itemlist[i].shortitem));
		}
	}
	UIE_SetSkirmishCvar(s, "itemsHidden", buffer);
}




/*
==========================================================================

LOADING AND SAVING OF SERVER SCRIPT DATA

==========================================================================
*/



/*
=================
StartServer_LoadServerScriptData

Loads server specific gametype data
=================
*/
static void StartServer_LoadServerScriptData(void)
{
	char* s, *t;
	int value, gametype;

	s_scriptdata.server.pure = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_pure" );
	s_scriptdata.server.pmove_fixed = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_pmove_fixed" );
	s_scriptdata.server.pmove_msec = UIE_GetSkirmishCvarIntClamp(0, 999, NULL, "uie_pmove_msec" );

	s_scriptdata.server.smoothclients = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_smoothclients" );
	s_scriptdata.server.syncClients = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_syncclients" );

	s_scriptdata.server.minPing = UIE_GetSkirmishCvarIntClamp(0, 999, NULL, "uie_minping" );
	s_scriptdata.server.maxPing = UIE_GetSkirmishCvarIntClamp(0, 999, NULL, "uie_maxping" );
	s_scriptdata.server.allowMinPing = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowMinPing" );
	s_scriptdata.server.allowMaxPing = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowMaxPing" );

	s_scriptdata.server.allowmaxrate = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowmaxrate" );
	s_scriptdata.server.maxrate = UIE_GetSkirmishCvarIntClamp(0, 99999, NULL, "uie_maxrate" );

	s_scriptdata.server.allowdownload = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowdownload" );
	s_scriptdata.server.allowvote = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowvote" );
	s_scriptdata.server.allowpass = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_allowpass" );

	s_scriptdata.server.gravity = UIE_GetSkirmishCvarIntClamp(20, 10000, NULL, "uie_gravity" );
	s_scriptdata.server.knockback = UIE_GetSkirmishCvarIntClamp(0, 99999, NULL, "uie_knockback" );
	s_scriptdata.server.quadfactor = UIE_GetSkirmishCvarIntClamp(0, 15, NULL, "uie_quadfactor" );
	s_scriptdata.server.netport = UIE_GetSkirmishCvarIntClamp(1024, 65535, NULL, "uie_netport" );
	s_scriptdata.server.sv_fps = UIE_GetSkirmishCvarIntClamp(0, 160, NULL, "uie_svfps" );

	UIE_GetSkirmishCvar(NULL, "uie_password",s_scriptdata.server.password, MAX_PASSWORD_LENGTH);

	s_scriptdata.server.allowPrivateClients = UIE_GetSkirmishCvarIntClamp(0, 32, NULL, "uie_allowprivateclients" );
	s_scriptdata.server.privateClients = UIE_GetSkirmishCvarIntClamp(0, 32, NULL, "uie_privateclients" );
	UIE_GetSkirmishCvar(NULL, "uie_privatepassword",s_scriptdata.server.privatePassword, MAX_PASSWORD_LENGTH);

	s_scriptdata.server.preventConfigBug = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_preventConfigBug");

	if (s_scriptdata.multiplayer) {
		s_scriptdata.server.dedicatedServer = UIE_GetSkirmishCvarIntClamp(0, SRVDED_INTERNET, NULL, "uie_dedicated" );
		s_scriptdata.server.inactivityTime = UIE_GetSkirmishCvarIntClamp(0, 999, NULL, "uie_inactivity" );

		s_scriptdata.server.punkbuster = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_punkbuster" );
		s_scriptdata.server.strictAuth = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_strictAuth" );
		s_scriptdata.server.lanForceRate = UIE_GetSkirmishCvarIntClamp(0, 1, NULL, "uie_lanForceRate" );
	}
	else {
		s_scriptdata.server.dedicatedServer = SRVDED_OFF;
		s_scriptdata.server.inactivityTime = 0;

		s_scriptdata.server.punkbuster = 0;
		s_scriptdata.server.strictAuth = 0;
		s_scriptdata.server.lanForceRate = 0;
	}

	//
	// gametype specific values
	//

	gametype = s_scriptdata.gametype;
	s = gametype_cvar_base[ gametype_remap2[gametype] ];

	// reset server text control
	UIE_GetSkirmishCvar( s, "hostname", s_scriptdata.server.hostname, MAX_HOSTNAME_LENGTH );

	s_scriptdata.server.forceRespawn = UIE_GetSkirmishCvarIntClamp(0, 999, s, "ForceRespawn" );
	s_scriptdata.server.allowWarmup = UIE_GetSkirmishCvarIntClamp(0, 1, s, "doWarmUp" );
	s_scriptdata.server.warmupTime = UIE_GetSkirmishCvarIntClamp(0, 999, s, "WarmUp" );
	s_scriptdata.server.weaponrespawn = UIE_GetSkirmishCvarIntClamp(0, 9999, s, "weaponrespawn" );

	if (gametype >= GT_TEAM) {
		t = 0;
		if (gametype == GT_TEAM)
			t = "ui_team_friendly";
		else if (gametype == GT_CTF)
			t = "ui_ctf_friendly";

		if (t)
			s_scriptdata.server.friendlyFire = (int)Com_Clamp(0, 1, trap_Cvar_VariableValue(t));

		s_scriptdata.server.autoJoin = UIE_GetSkirmishCvarIntClamp(0, 1, s, "AutoJoin" );
		s_scriptdata.server.teamBalance = UIE_GetSkirmishCvarIntClamp(0, 1, s, "TeamBalance" );
	}
	else {
		s_scriptdata.server.autoJoin = 0;
		s_scriptdata.server.teamBalance = 0;
		s_scriptdata.server.friendlyFire = 0;
	}
}



/*
=================
StartServer_SaveServerScriptData

Saves server specific gametype data
=================
*/
static void StartServer_SaveServerScriptData(void)
{
	char* s;
	int friendly, gametype;

	UIE_SetSkirmishCvarInt( NULL, "uie_pure", s_scriptdata.server.pure);

	UIE_SetSkirmishCvarInt( NULL, "uie_pmove_fixed", s_scriptdata.server.pmove_fixed);
	UIE_SetSkirmishCvarInt( NULL, "uie_pmove_msec", s_scriptdata.server.pmove_msec);
	UIE_SetSkirmishCvarInt( NULL, "uie_smoothclients", s_scriptdata.server.smoothclients);

	UIE_SetSkirmishCvarInt( NULL, "uie_syncclients", s_scriptdata.server.syncClients);

	UIE_SetSkirmishCvarInt( NULL, "uie_minping", s_scriptdata.server.minPing);
	UIE_SetSkirmishCvarInt( NULL, "uie_maxping", s_scriptdata.server.maxPing);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowMinPing", s_scriptdata.server.allowMinPing);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowMaxPing", s_scriptdata.server.allowMaxPing);

	UIE_SetSkirmishCvarInt( NULL, "uie_maxrate", s_scriptdata.server.maxrate);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowmaxrate", s_scriptdata.server.allowmaxrate);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowdownload", s_scriptdata.server.allowdownload);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowvote", s_scriptdata.server.allowvote);
	UIE_SetSkirmishCvarInt( NULL, "uie_allowpass", s_scriptdata.server.allowpass);

	UIE_SetSkirmishCvarInt( NULL, "uie_gravity", s_scriptdata.server.gravity);
	UIE_SetSkirmishCvarInt( NULL, "uie_knockback", s_scriptdata.server.knockback);
	UIE_SetSkirmishCvarInt( NULL, "uie_quadfactor", s_scriptdata.server.quadfactor);
	UIE_SetSkirmishCvarInt( NULL, "uie_netport", s_scriptdata.server.netport);
	UIE_SetSkirmishCvarInt( NULL, "uie_svfps", s_scriptdata.server.sv_fps);

	UIE_SetSkirmishCvar( NULL, "uie_password", s_scriptdata.server.password);

	UIE_SetSkirmishCvarInt( NULL, "uie_allowprivateclients", s_scriptdata.server.allowPrivateClients);
	UIE_SetSkirmishCvarInt( NULL, "uie_privateclients", s_scriptdata.server.privateClients);
	UIE_SetSkirmishCvar( NULL, "uie_privatepassword", s_scriptdata.server.privatePassword);

	UIE_SetSkirmishCvarInt( NULL, "uie_preventConfigBug", s_scriptdata.server.preventConfigBug);

	if (s_scriptdata.multiplayer) {
		UIE_SetSkirmishCvarInt( NULL, "uie_dedicated", s_scriptdata.server.dedicatedServer);
		UIE_SetSkirmishCvarInt( NULL, "uie_inactivity", s_scriptdata.server.inactivityTime);

		UIE_SetSkirmishCvarInt( NULL, "uie_punkbuster", s_scriptdata.server.punkbuster);
		UIE_SetSkirmishCvarInt( NULL, "uie_strictAuth", s_scriptdata.server.strictAuth);
		UIE_SetSkirmishCvarInt( NULL, "uie_lanForceRate", s_scriptdata.server.lanForceRate);
	}

	//
	// save gametype specific data
	//

	gametype = s_scriptdata.gametype;
	s = gametype_cvar_base[ gametype_remap2[gametype] ];

	//
	// save state values
	//

	UIE_SetSkirmishCvar(s, "hostname", s_scriptdata.server.hostname);
	UIE_SetSkirmishCvarInt(s, "ForceRespawn", s_scriptdata.server.forceRespawn);

	UIE_SetSkirmishCvarInt(s, "doWarmup", s_scriptdata.server.allowWarmup);
	UIE_SetSkirmishCvarInt(s, "WarmUp", s_scriptdata.server.warmupTime);

	if (gametype >= GT_TEAM) {
		// ff is an existing cvar, so we use the existing cvar 
		friendly = s_scriptdata.server.friendlyFire;
		if (gametype == GT_TEAM) {
			trap_Cvar_SetValue( "ui_team_friendly", friendly );
		}
		else if (gametype == GT_CTF) {
			trap_Cvar_SetValue( "ui_ctf_friendly", friendly );
		}

		UIE_SetSkirmishCvarInt(s, "AutoJoin", s_scriptdata.server.autoJoin);
		UIE_SetSkirmishCvarInt(s, "TeamBalance", s_scriptdata.server.teamBalance);
	}
}



/*
==========================================================================

INIT SCRIPT DATA

==========================================================================
*/



/*
=================
StartServer_LoadScriptDataFromType

Loads script data for the give game type
=================
*/
void StartServer_LoadScriptDataFromType(int gametype)
{
	s_scriptdata.gametype = gametype;

	StartServer_LoadMapScriptData();
	StartServer_LoadBotScriptData();
	StartServer_LoadItemScriptData();
	StartServer_LoadServerScriptData();
}




/*
=================
StartServer_InitScriptData

Loads all script data
=================
*/
void StartServer_InitScriptData(qboolean multiplayer)
{
	memset(&s_scriptdata, 0, sizeof(scriptdata_t));

	UIE_StartServer_LoadSkirmishCvars();

	s_scriptdata.multiplayer = multiplayer;
	StartServer_LoadScriptDataFromType((int)Com_Clamp( 0, MAX_GAME_TYPE, UIE_GetSkirmishCvarInt( NULL, "uie_gametype" ) ));
	StartServer_BuildMapDistribution();
}





/*
=================
StartServer_SaveScriptData

Saves all script data
=================
*/
void StartServer_SaveScriptData(void)
{
	UIE_SetSkirmishCvarInt( NULL, "uie_gametype", s_scriptdata.gametype );

	StartServer_SaveMapScriptData();
	StartServer_SaveBotScriptData();
	StartServer_SaveItemScriptData();
	StartServer_SaveServerScriptData();

	UIE_StartServer_SaveSkirmishCvars();
}




