// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=============================================================================

START SERVER MENU HEADER ( Q3 INTERFACE INDEPENDENT DEFINTIONS/DATA ) *****

=============================================================================
*/



#ifdef MISSIONPACK
#define MAX_GAME_TYPE GT_MAX_GAME_TYPE
#else
#define MAX_GAME_TYPE (GT_CTF + 1)
#endif


#define NUM_GAMETYPES 4





/*
=============================================================================

MAP DATA *****

=============================================================================
*/



#define MAX_MAPPAGES 4
#define NUMMAPS_PERPAGE 8
#define MAX_NUMMAPS (MAX_MAPPAGES * NUMMAPS_PERPAGE)
#define HALF_NUMMAPS_PERPAGE (NUMMAPS_PERPAGE/2)
#define MAX_LIMIT_BUF 4
#define SHORTMAP_BUFFER 16
#define LONGMAP_BUFFER 32
#define MAPNAME_BUFFER 16
#define INDEXEDSHORTMAP_BUFFER (SHORTMAP_BUFFER + 4)

#define MAX_MAPTYPES 32

#define MAX_MAPS_LIST 512



// indicies for counting map types
enum {
	MAP_GROUP_ID,
	MAP_GROUP_NONID,

	MAX_MAP_GROUP
};


enum mapSource {
	MAP_MS_ORDER,
	MAP_MS_RANDOMLIST,
	MAP_MS_RANDOM,
	MAP_MS_RANDOMEXCLUDE,

	MAP_MS_MAX
};


enum randomMapType {
	MAP_RND_ANY,
	MAP_RND_ID,
	MAP_RND_NONID,
	MAP_RND_BIASID,
	MAP_RND_BIASNONID,

	MAP_RND_MAX
};


enum enumLimitType {
	MAP_LT_DEFAULT,
	MAP_LT_NONE,
	MAP_LT_CUSTOM,

	MAP_LT_COUNT
};


enum mapCopyFrom {
	MAP_CF_ARENASCRIPT,
	MAP_CF_TIME,
	MAP_CF_FRAG,
	MAP_CF_BOTH,
	MAP_CF_CLEARALL,
	MAP_CF_CLEARPAGE,

	MAP_CF_COUNT
};


enum mapCopyTo {
	MAP_CT_SELECTED,
	MAP_CT_PAGE,
	MAP_CT_ALL,

	MAP_CT_COUNT
};



// this is used on the map chooser, but is referenced here
// so that data on the map page can be initialized
enum {
	MAPFILTER_OFF,
	MAPFILTER_ID,
	MAPFILTER_NONID,

	MAPFILTER_MAX
};




typedef struct mapdata_s {
	char shortName[SHORTMAP_BUFFER];
	char longName[LONGMAP_BUFFER];
	char fragLimit[MAX_LIMIT_BUF];
	char timeLimit[MAX_LIMIT_BUF];
} mapdata_t;



// data used by the map page
typedef struct mapparameters_s {
	int num_maps;
	mapdata_t data[MAX_NUMMAPS];

	int listSource;

	// values applied to all maps
	int fragLimit;	// also doubles as caplimit
	int timeLimit;

	int fragLimitType;
	int timeLimitType;

	qboolean Repeat;

	int SourceCount;
	int SourceType;

	int TypeCount[MAX_GAME_TYPE][MAX_MAP_GROUP];
} mapparameters_t;



//
// map data manipulation functions
//

// map data based on list/exclude type
void StartServer_LoadMapList(void);
void StartServer_SaveMapList(void);
void StartServer_RefreshMapNames(void);

// map list manipulation
void StartServer_StoreMap(int pos, int arena);
void StartServer_InsertMap(int pos, int arena);
void StartServer_DeleteMap(int index);
qboolean StartServer_SwapMaps(int from, int to);
void StartServer_MapDoAction( int src, int dest, int page, int selected );

// map info
int StartServer_MapPageCount(void);
int StartServer_RangeClipMapIndex(int index);
qboolean StartServer_IsRandomGeneratedMapList( int type );
qboolean StartServer_IsIdMap(const char* mapname);






/*
=============================================================================

BOT DATA *****

=============================================================================
*/


#define PLAYER_SLOTS 16
#define PLAYER_SLOTS_PERCOL (PLAYER_SLOTS/2)

#define MAX_SKILL 5


// note restrictions on ordering below
// see StartServer_BotPage_Event(), case ID_BOT_TYPE
enum {
	BOTSKILL_SAME,	// must be first non-custom value
	BOTSKILL_RANGE,	// must be last non-custom value

	BOTSKILL_CUSTOMSINGLE,	// display bot skill controls at this value and higher. Must be first CUSTOM value
	BOTSKILL_CUSTOMRANGE,

	BOTSKILL_COUNT
};



enum {
	BOTTYPE_SELECT,
	BOTTYPE_RANDOM,
	BOTTYPE_RANDOMEXCLUDE,
	BOTTYPE_RANDOMARENASCRIPT,
	BOTTYPE_ARENASCRIPT,
   BOTTYPE_SELECTARENASCRIPT,

	BOTTYPE_MAX
};


enum {
	SKILLBIAS_NONE,
	SKILLBIAS_VLOW,
	SKILLBIAS_LOW,
	SKILLBIAS_HIGH,
	SKILLBIAS_VHIGH,

   SKILLBIAS_FRACTIONAL,
   SKILLBIAS_FRAC_VLOW,
   SKILLBIAS_FRAC_LOW,
   SKILLBIAS_FRAC_HIGH,
   SKILLBIAS_FRAC_VHIGH,

	SKILLBIAS_COUNT
};


enum {
	SLOTTYPE_EMPTY,
	SLOTTYPE_HUMAN,
	SLOTTYPE_BOT,
	SLOTTYPE_OPEN,

	SLOTTYPE_COUNT
};



enum {
	SLOTTEAM_INVALID,
	SLOTTEAM_NONE,
	SLOTTEAM_ONE,
	SLOTTEAM_TWO
};



enum {
	BOTCHANGE_NEVER,
	BOTCHANGE_EVERYMAP,
	BOTCHANGE_MAP2,
	BOTCHANGE_MAP3,
	BOTCHANGE_MAP4,

	BOTCHANGE_COUNT
};



enum botCopyTo {
	BOT_CT_CLEARALL,
	BOT_CT_INDIV_SELECTED,
	BOT_CT_RANGE_SELECTED,
	BOT_CT_INDIV_ALL,
	BOT_CT_RANGE_ALL,
	BOT_CT_NEATEN,

	BOT_CT_COUNT
};



// bot skill control data
typedef struct botskill_s {
	int low;
	int high;
	int value;

	qboolean range;
} botskill_t;



// data used by the bot page
typedef struct botparameters_s {
	char name[PLAYER_SLOTS][MAX_NAME_LENGTH];
	botskill_t skill[PLAYER_SLOTS];
	qboolean drawName[PLAYER_SLOTS];
	int slotType[PLAYER_SLOTS];

	// way in which bots are selected
	int typeSelect;

	int numberOpen;
	int joinAs;

	int numberBots;
	int changeBots;

	int skillType;
	int skillBias;
	botskill_t globalSkill;

	qboolean teamSwapped;
} botparameters_t;


//
// bot data manipulation functions
//

// bot list based on list/exclude type
void StartServer_LoadBotNameList(int type);
void StartServer_SaveBotNameList(void);

// bot list manipulation
qboolean StartServer_InsertBotSlot(int index);
qboolean StartServer_DeleteBotSlot(int index);
void StartServer_MoveBotToOtherTeam(int selected);
void StartServer_DoBotAction(int action, int selected);
void StartServer_SetBotSkillRangeType(int skill);
void StartServer_SetNamedBot(int index, char* name);
void StartServer_InsertNamedBot(int index, char* name);
void StartServer_BotNameDrawn(int index, qboolean drawn);

// bot info
int StartServer_ValidBotCount( void );
qboolean StartServer_BotOnSelectionList( const char *checkName );
void StartServer_ValidateBotSlotCount(int bots, int open);
int StartServer_SlotTeam(int index);	// returns SLOTTEAM_* values

// list type info
qboolean StartServer_IsRandomBotList( int type );
qboolean StartServer_IsBotArenaScript(int type);
qboolean StartServer_IsRandomBotExclude(int type);




/*
=============================================================================

ITEM DATA *****

=============================================================================
*/



// must match order in item_serverlist[]
enum {
	ITEM_MGUN,
	ITEM_SHOTGUN,
	ITEM_GRENADE,
	ITEM_ROCKET,
	ITEM_PLASMA,
	ITEM_LIGHTNING,
	ITEM_RAIL,
	ITEM_BFG,

	ITEM_MGUN_AMMO,
	ITEM_SHOTGUN_AMMO,
	ITEM_GRENADE_AMMO,
	ITEM_ROCKET_AMMO,
	ITEM_PLASMA_AMMO,
	ITEM_LIGHTNING_AMMO,
	ITEM_RAIL_AMMO,
	ITEM_BFG_AMMO,

	ITEM_MEGA,
	ITEM_HEALTH_SMALL,
	ITEM_HEALTH_MEDIUM,
	ITEM_HEALTH_LARGE,

	ITEM_ARMOUR_RED,
	ITEM_ARMOUR_YELLOW,
	ITEM_ARMOUR_SHARD,

	ITEM_QUAD,
	ITEM_REGEN,
	ITEM_HASTE,

	ITEM_BATTLESUIT,
	ITEM_INVISIBLE,
	ITEM_FLIGHT,

	ITEM_MEDKIT,
	ITEM_TELEPORTER,

	ITEM_COUNT	// total number of items
};


// item group types, each has a master override that
// forces all on, all off, or custom
enum {
	ITEMGROUP_WEAPON,
	ITEMGROUP_AMMO,
	ITEMGROUP_HEALTH,
	ITEMGROUP_ARMOUR,
	ITEMGROUP_POWERUPS,
	ITEMGROUP_HOLDABLE,

	ITEMGROUP_COUNT
};




// possible values group master control
enum {
	ALLGROUPS_ENABLED,
	ALLGROUPS_CUSTOM,
	ALLGROUPS_HIDDEN
};





typedef struct itemnode_s {
	int 			groupid;
	int 			ident;	// index of item in server_itemlist[]
	const char* 	mapitem;
	const char* 	shortitem;
} itemnode_t;

extern itemnode_t server_itemlist[ITEM_COUNT];




typedef struct itemparameters_s {
	int groupstate[ITEMGROUP_COUNT];
	qboolean enabled[ITEM_COUNT];
} itemparameters_t;



//
// item data manipulation functions
//

// item list based on gametype
void StartServer_LoadDisabledItems(void);






/*
=============================================================================

SERVER DATA *****

=============================================================================
*/


enum {
	SRVDED_OFF,
	SRVDED_LAN,
	SRVDED_INTERNET
};



#define MAX_HOSTNAME_LENGTH 64
#define MAX_PASSWORD_LENGTH	24


typedef struct serverparameters_s {
	char hostname[MAX_HOSTNAME_LENGTH];
	int pmove_fixed;
	int pmove_msec;
	int smoothclients;

	int allowmaxrate;
	int maxrate;

	int allowdownload;
	int allowvote;
	int allowpass;

	char password[MAX_PASSWORD_LENGTH];

	int forceRespawn;
	int allowWarmup;
	int warmupTime;

	int friendlyFire;
	int teamBalance;
	int autoJoin;

   int syncClients;

	int allowMinPing;
	int minPing;
	int allowMaxPing;
	int maxPing;

	int pure;

	int preventConfigBug;

	int dedicatedServer;
	int inactivityTime;

	int gravity;
	int knockback;
	int quadfactor;

	int allowPrivateClients;
	int privateClients;
	char privatePassword[MAX_PASSWORD_LENGTH];

	int sv_fps;
   int weaponrespawn;

	int netport;

   int punkbuster;
   int strictAuth;

   int lanForceRate;
} serverparameters_t;



/*
=============================================================================

ALL SCRIPT DATA *****

=============================================================================
*/


typedef struct scriptdata_s {
	// general date, used by all pages
	int gametype;	// stored as GT_*

	// controls the setting up some params in a server script 
	qboolean multiplayer;

	// specific groups of related parameters
	mapparameters_t map;
	botparameters_t bot;
	itemparameters_t item;
	serverparameters_t server;
} scriptdata_t;


extern scriptdata_t s_scriptdata;




//
//  global functions
//

// ui_startserver_data.c
qboolean StartServer_CanFight(void);

void UIE_SetSkirmishCvar( char* base, const char* var_name, const char* string );
void UIE_SetSkirmishCvarInt( char* base, const char* name, int value);

qboolean UIE_GetSkirmishCvar( char* base, const char* var_name, char* buffer, int buflen );
int UIE_GetSkirmishCvarInt( char* base, const char* name );
int UIE_GetSkirmishCvarIntClamp( int min, int max, char* base, const char* name );

void UIE_StartServer_SaveSkirmishCvars( void );
void UIE_StartServer_LoadSkirmishCvars( void );
qboolean UIE_SkirmishCvarExists( char* base, const char* var_name);

void UIE_ConvertOldCvar( char* cvar, int size);





// ui_startserver_script.c
void StartServer_InitScriptData(qboolean multi);
void StartServer_LoadScriptDataFromType(int gametype);
void StartServer_SaveScriptData(void);

typedef char* (*String_Callback)(int index);
void UI_LoadMultiArray(char* base, const char* key, String_Callback callback, int count, int size, char newnull);
void UI_SaveMultiArray(char* base, const char* key, String_Callback callback, int count, int size, char newnull);

qboolean StartServer_LoadFromConfig( const char* filename);
qboolean StartServer_CreateServer(const char* scriptFile);
const char* StartServer_GetLastScriptError( void );



//
// ui_startserver_custommaps.c
//


enum {
	MAPICONS_ALL,
	MAPICONS_CUSTOM,
	MAPICONS_NONE,

	MAPICONS_MAX
};

// stores info on a picture that might be drawn on screen
typedef struct mappic_s {
	char mapname[SHORTMAP_BUFFER];
	int gamebits;
	int type[MAX_MAPTYPES];
	int num_types;
} mappic_t;


typedef qboolean (*callbackMapList)(const char*);

int GametypeBits( char *string );
int UI_BuildMapListByType(int* list, int listmax, int gametype, callbackMapList);
void StartServer_SetIconFromGameType(menubitmap_s* b, int gametype, qboolean custom);
qboolean StartServer_MapSupportsBots(const char* mapname);
int StartServer_NumCustomMapTypes(void);
void StartServer_InitMapPictureFromIndex(mappic_t* mappic, int index);
void StartServer_InitMapPicture(mappic_t* mappic, const char* mapname);
void StartServer_DrawMapPicture(int x, int y, int w, int h, mappic_t* mappic, vec4_t color);
qboolean StartServer_IsCustomMapType(const char* mapname, int type);
const char* StartServer_MapIconFromType(int gametype, qboolean isCustomMap);
void UI_LoadMapTypeInfo(void);




//
// global data
//

extern const char* idmap_list[];
extern int gametype_remap[NUM_GAMETYPES];
extern int gametype_remap2[MAX_GAME_TYPE];
extern const char *gametype_items[NUM_GAMETYPES + 1];
extern const char* randommaptype_items[MAP_RND_MAX + MAX_MAPTYPES + 1];
extern char* gametype_cvar_base[NUM_GAMETYPES];
extern const char* mapfilter_items[MAPFILTER_MAX + MAX_MAPTYPES + 1];

