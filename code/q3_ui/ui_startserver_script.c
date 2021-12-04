/*
=============================================================================

START SERVER SCRIPT ENGINE *****

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

#define BEGIN_PARAMETER_BLOCK 	"BEGIN_UIE_PARAMETER_BLOCK"
#define END_PARAMETER_BLOCK 	"END_UIE_PARAMETER_BLOCK"

#define CVAR_BUFFER 	64



// game parameters we need to save in a block
// for later recovery. Strings begining with a
// * are gametype specific

// uie_dedicated is deliberately missing to allow
// script loading in both Skirmish and Multiplayer
// versions of the browser

// uie_punkbuster is handled as a special case in the save code
static const char* saveparam_list[] = {
	"uie_gametype", "uie_pure", "uie_inactivity", "uie_allowmaxrate",
	"uie_maxrate", "uie_allowpass","uie_password", "uie_allowvote",
	"uie_allowdownload", "uie_smoothclients", "uie_pmove_fixed",
	"uie_pmove_msec", "uie_syncclients", "uie_minPing", "uie_maxPing",
	"uie_allowMinPing", "uie_allowMaxPing", "uie_gravity", "uie_knockback",
	"uie_quadfactor", "uie_netport", "uie_svfps", "uie_allowprivateclients",
	"uie_privateclients", "uie_privatepassword", "uie_strictAuth",
   "uie_lanForceRate",

	// uie_<gametype>_*
	"*fragtype", "*timetype", "*customfraglimits", "*customcapturelimits",
	"*customtimelimits", "*maplist", "*maplistexclude", "*MapRepeat",
	"*MapSource", "*RandomMapCount", "*RandomMapType", "*slottype",
	"*botname", "*botexclude", "*botskill", "*BotSelection", "*BotCount",
	"*BotChange", "*OpenSlotCount", "*BotSkillType", "*BotSkillValue",
	"*BotSkillBias", "*PlayerJoinAs", "*hostname", "*ForceRespawn",
	"*itemGroups", "*itemsHidden", "*Warmup", "*doWarmup", "*weaponrespawn",

	// many of these are specific to a gametype, but since we
	// check for the existance of the Cvar they won't appear in
	// gametypes that don't set them

	"*AutoJoin", "*TeamBalance", "*TeamSwapped", "*AutoJoin",
	"*TeamBalance", "*TeamSwapped", "*fraglimit", "*capturelimit", "*timelimit", "*friendly",
	0
};

/*
typedef struct customsaveparam_s {
	int type;
	char* param;
} customsaveparam_t;


// custom game parameters, those available on a subset of gametypes
// Note: many of these are existing Cvars, not those added by UIE
// It wouldn't make sense to store ui_ffa_* values in a tourney
// script, but they're always valid Cvars, so we can't eliminate them
// by checking for their existence from saveparam_list[]

// these cvars are now obsolete
static const customsaveparam_t customsaveparam_list[] = {
	{ GT_FFA, "ui_ffa_fraglimit" },
	{ GT_FFA, "ui_ffa_timelimit" },
	{ GT_TOURNAMENT, "ui_tourney_fraglimit" },
	{ GT_TOURNAMENT, "ui_tourney_timelimit" },
	{ GT_TEAM, "ui_team_fraglimit" },
	{ GT_TEAM, "ui_team_timelimit" },
	{ GT_TEAM, "ui_team_friendly" },
	{ GT_CTF, "ui_ctf_capturelimit" },
	{ GT_CTF, "ui_ctf_timelimit" },
	{ GT_CTF, "ui_ctf_friendly" }
};
*/



static const int botChange_frequency[BOTCHANGE_COUNT + 1] = {
	0,	// BOTCHANGE_NEVER
	1,
	2,
	3,
	4,	// BOTCHANGE_MAP4
	0	// size matches botChange_list[]
};




// internal Q3 exe script buffer is limited to 16K in size
// so there's no benefit in increasing our script buffer
#define SCRIPT_BUFFER (1024 * 16 - 1)

#define SERVER_ADDBOT "uie_ab"
#define SERVER_KICKBOT "uie_kb"


typedef struct serverexec_s {
	char server_script[SCRIPT_BUFFER];

	int maxBots;
	int usedBots[MAX_BOTS];
	int lastBots[MAX_BOTS];

	int player_client;

	int rnd_nummaps;

	int cycle_count;	// number of maps in the cycle

	// for MAP_MS_RANDOMLIST: stores listed map order
	// for MAP_MS_RANDOM, MAP_MS_RANDOMEXCLUDE: stores map indices as they're generated
	qboolean random_generate;	// qtrue if map_rnd_index[] is used	
	qboolean random_order;		// qtrue if map_rnd[] is used
	int	random_count;			// number of variables stored in map_rnd[] 
	int map_rnd[MAX_MAPS_LIST];	// order in which maps are written
	int map_rnd_index[MAX_MAPS_LIST];	// indices of map that will be written

	int botcount_firstmap;	// only used with BOTTYPE_*ARENASCRIPT
	int max_scripted_bots;	// only used with BOTTYPE_*ARENASCRIPT

   int bots_in_slots[PLAYER_SLOTS]; // the bot indexes for bots found in selection slots
   int num_bots_in_slots;  // number of bots found in selection slots

	// protects against ordering problems
	qboolean map_generated;
	qboolean bot_generated;
} serverexec_t;

static serverexec_t s_serverexec;


static int addbot_primes[] = { 7, 11, 17, 23 };
static int num_addbot_primes = sizeof (addbot_primes)/sizeof(addbot_primes[0]);

static char lasterror_text[MAX_STATUSBAR_TEXT] = {'\0'};


static char* bot_teamname[] = { "blue", "red" };




/*
=============================================================================

WRITE SCRIPT *****

=============================================================================
*/




/*
=================
UIE_IsCaptureLimited

Returns qtrue if the gametype uses capturelimit instead of fraglimit
=================
*/
static qboolean UIE_IsCaptureLimited(int type)
{
	if (type == GT_CTF)
		return qtrue;

	return qfalse;
}


/*
=================
Clamp_Random

Returns a random number between 0 and r
=================
*/
int Clamp_Random(int r)
{
	int index;

	r += 1;
	do {
		index = r * random();
	} while (index == r);

	return index;
}



/*
=================
AddScript
=================
*/
static void AddScript(const char* scriptLine)
{
	Q_strcat(s_serverexec.server_script, SCRIPT_BUFFER, scriptLine);
}



/*
=================
StartServer_GetLastScriptError
=================
*/
const char* StartServer_GetLastScriptError( void )
{
	return lasterror_text;
}



/*
=================
StartServer_PrintMessage
=================
*/
static void StartServer_PrintMessage( const char* error )
{
	if (!error)
		return;

	trap_Print( va(S_COLOR_RED"StartServer: %s", error));
	Q_strncpyz(lasterror_text, error, MAX_STATUSBAR_TEXT);
}




/*
=================
StartServer_InitServerExec
=================
*/
static qboolean StartServer_InitServerExec( void )
{
	int i, count, mapsource;
   int index, botnum;

	memset(&s_serverexec, 0, sizeof(serverexec_t));

	//
	// init map stuff
	//
	count = s_scriptdata.map.num_maps;
	mapsource = s_scriptdata.map.listSource;

	if (StartServer_IsRandomGeneratedMapList(mapsource))
	{
		count = s_scriptdata.map.SourceCount;
	}

	s_serverexec.cycle_count = count;

	//
	// init bot stuff
	//
	s_serverexec.maxBots = UI_GetNumBots();

	if (s_serverexec.maxBots >= MAX_BOTS)
		s_serverexec.maxBots = MAX_BOTS - 1;

	s_serverexec.random_generate = qfalse;
	s_serverexec.random_order = qfalse;
	s_serverexec.random_count = 0;

	s_serverexec.botcount_firstmap = 0;
	s_serverexec.max_scripted_bots = 0;

	s_serverexec.map_generated = qfalse;
	s_serverexec.bot_generated = qfalse;

   // build list of bots found in slots (info may or may not be used)
   index = 0;
   for (i = 0; i < PLAYER_SLOTS; i++) {
      if (s_scriptdata.bot.slotType[i] != SLOTTYPE_BOT)
         continue;   // not a bot
      if (s_scriptdata.bot.name[i][0] == '\0')
         continue;   // blank name
      botnum = UI_GetBotNumByName(s_scriptdata.bot.name[i]);
      if (botnum >= 0) {
         s_serverexec.bots_in_slots[index] = botnum;
         index++;
      }
   }
   s_serverexec.num_bots_in_slots = index;

   if (s_scriptdata.bot.typeSelect == BOTTYPE_SELECTARENASCRIPT && s_serverexec.num_bots_in_slots == 0) {
		trap_Print(S_COLOR_RED"InitServerExec: Not enough bots for game type\n");
      return qfalse;
   }

	return qtrue;
}




/*
=================
StartServer_WriteServerParams
=================
*/
static qboolean StartServer_WriteServerParams( void )
{
	int i, value, open;
	char* password;
	int botcount;
	qboolean useping;

	AddScript("\n// WriteServerParams()\n\n");

	if (!s_serverexec.bot_generated) {
		trap_Print(S_COLOR_RED"WriteServerParams called before WriteBotParams\n");
		return qfalse;
	}

	AddScript(va("g_gameType %i\n", s_scriptdata.gametype));

	if (s_scriptdata.server.hostname[0])
		AddScript(va("sv_hostname \"%s\"\n", s_scriptdata.server.hostname));

	AddScript(va("sv_pure %i\n", s_scriptdata.server.pure));
	if (s_scriptdata.multiplayer) {
		AddScript(va("dedicated %i\n", s_scriptdata.server.dedicatedServer));
		AddScript(va("g_inactivity %i\n", s_scriptdata.server.inactivityTime));

      // LAN force rate
      AddScript(va("sv_lanForceRate %i\n", s_scriptdata.server.lanForceRate));

      // punkbuster
      if (uis.punkbuster) {
         AddScript(va("sv_punkbuster %i\n", s_scriptdata.server.punkbuster));
         AddScript(va("sv_strictAuth %i\n", s_scriptdata.server.strictAuth));
      }

	}

	AddScript(va("set g_forcerespawn %i\n", s_scriptdata.server.forceRespawn));

	if (s_scriptdata.server.allowWarmup) {
		value = s_scriptdata.server.warmupTime;
		if (value == 0) {
			AddScript(va("g_doWarmup 0\n"));
		}
		else {
			AddScript(va("g_doWarmup 1\n"));
			AddScript(va("g_warmup %i\n", value));
		}
	}
	else {
		AddScript(va("g_doWarmup 0\n"));
	}


	// special server parameters
	if (s_scriptdata.server.allowmaxrate)
		value = s_scriptdata.server.maxrate;
	else
		value = 0;
	AddScript(va("sv_maxrate %i\n", value));

	password = "";
	if (s_scriptdata.server.allowpass)
		password = s_scriptdata.server.password;
	if (!password[0]) {
		AddScript("g_needpass 0\n");
	}
	else {
		AddScript(va("g_needpass %i\n", s_scriptdata.server.allowpass));
		AddScript(va("g_Password \"%s\"\n", password));
	}

	AddScript(va("sv_allowDownload %i\n", s_scriptdata.server.allowdownload));
	AddScript(va("g_allowVote %i\n", s_scriptdata.server.allowvote));

	// team game options
	if (s_scriptdata.gametype >= GT_TEAM) {
		AddScript(va("g_friendlyFire %i\n", s_scriptdata.server.friendlyFire));
		AddScript(va("g_teamAutoJoin %i\n", s_scriptdata.server.autoJoin));
		AddScript(va("g_teamForceBalance %i\n", s_scriptdata.server.teamBalance));
	}

	// count the number of clients
	botcount = 0;
	if (s_scriptdata.bot.typeSelect == BOTTYPE_SELECT) {
		value = 0;
		open = 0;
		for (i = 0; i < PLAYER_SLOTS; i++) {
			if (s_scriptdata.bot.slotType[i] == SLOTTYPE_BOT) {
				value++;
				if (s_scriptdata.bot.name[i][0]!='\0')
					botcount++;
			}
			else if (s_scriptdata.bot.slotType[i] == SLOTTYPE_OPEN)
				value++;
		}
	}
	else if (StartServer_IsBotArenaScript(s_scriptdata.bot.typeSelect)) {
		open = s_scriptdata.bot.numberOpen;
		botcount = s_serverexec.botcount_firstmap;
		value = s_serverexec.max_scripted_bots + open;
	}
	else {	// BOTTYPE_RANDOM or BOTTYPE_RANDOMEXCLUDE
		open = s_scriptdata.bot.numberOpen;
		botcount = s_scriptdata.bot.numberBots;
		value = botcount + open;
	}

	if (s_scriptdata.bot.joinAs == 1 || open == 0)
		value++;	// spectator on, allow one more slot

	if (value > MAX_CLIENTS)
		value = MAX_CLIENTS;

	s_serverexec.player_client = botcount;

	AddScript(va("sv_maxclients %i\n",value));

	// pmove
	value = s_scriptdata.server.pmove_fixed;
	AddScript(va("pmove_fixed %i\n", value));
	if (value) {
		AddScript(va("pmove_msec %i\n", s_scriptdata.server.pmove_msec));
	}

	// smoothclients
	AddScript(va("g_smoothClients %i\n", s_scriptdata.server.smoothclients));

	// syncclients
	AddScript(va("g_synchronousClients %i\n", s_scriptdata.server.syncClients));

	// ping limits
	useping = qtrue;
	if (s_scriptdata.server.allowMinPing && s_scriptdata.server.allowMaxPing) {
		if (s_scriptdata.server.minPing > s_scriptdata.server.maxPing)
			useping = qfalse;
	}

	if (s_scriptdata.server.allowMinPing && useping)
		AddScript(va("sv_minPing %i\n", s_scriptdata.server.minPing));
	if (s_scriptdata.server.allowMaxPing && useping)
		AddScript(va("sv_maxPing %i\n", s_scriptdata.server.maxPing));

	// gameplay
//	AddScript(va("g_gravity %i\n", s_scriptdata.server.gravity));
	AddScript(va("g_knockback %i\n", s_scriptdata.server.knockback));
	AddScript(va("g_quadfactor %i\n", s_scriptdata.server.quadfactor));

	// server frame rate
	AddScript(va("sv_fps %i\n", s_scriptdata.server.sv_fps));

	// weapon respawn
	if (s_scriptdata.gametype == GT_TEAM)
		AddScript(va("g_weaponTeamrespawn %i\n", s_scriptdata.server.weaponrespawn));
	else
		AddScript(va("g_weaponrespawn %i\n", s_scriptdata.server.weaponrespawn));

	// private clients
	if (s_scriptdata.server.allowPrivateClients) {
		AddScript(va("sv_privateClients %i\n", s_scriptdata.server.privateClients));
		AddScript(va("sv_privatePassword \"%s\"\n", s_scriptdata.server.privatePassword));
	}

	// netport
	AddScript(va("net_port %i\n", s_scriptdata.server.netport));

	// allow values to take effect
	AddScript("\nwait 5\n");

	return qtrue;
}




/*
=================
StartServer_GetBotSkillFloat
=================
*/
static float StartServer_GetFracBotSkill(botskill_t* skill) {
   int high, low;
   float width;
   float slope;
   float area, target;
   float result;
   qboolean reverse;

   high = skill->high;
   low = skill->low;
   width = high - low;

   // determine shape of skewed distributions
   reverse = qfalse;
	switch (s_scriptdata.bot.skillBias) {
		case SKILLBIAS_FRAC_VLOW:
         reverse = qtrue;
			slope = 0.5;
			break;
		case SKILLBIAS_FRAC_LOW:
         reverse = qtrue;
			slope = 0.25;
			break;
		case SKILLBIAS_FRAC_HIGH:
			slope = 0.25;
			break;
		case SKILLBIAS_FRAC_VHIGH:
         slope = 0.5;
			break;
		case SKILLBIAS_FRACTIONAL:
		default:
         return (1.0 + low + width * random());
	}

   area = width * width * slope;
   target = area * random();

   result = sqrt(target / slope);
   if (reverse == qtrue) {
      return 1 + high - result;
   }

   return 1 + low + result;
}



/*
=================
StartServer_GetIntBotSkill
=================
*/
static int StartServer_GetIntBotSkill(botskill_t* skill) {
   int i;
   int low, high;
	float value, step;
   float bin[MAX_SKILL];
	float selected;

	low = skill->low;
	high = skill->high;

   // determine shape of skewed distributions
	switch (s_scriptdata.bot.skillBias) {
		case SKILLBIAS_VLOW:
			value = (high - low) + 1.0;
			step = -1.0;
			break;
		case SKILLBIAS_LOW:
			value = (high - low) * 0.5 + 0.5;
			step = -0.5;
			break;
		case SKILLBIAS_HIGH:
			value = 0.5;
			step = 0.5;
			break;
		case SKILLBIAS_VHIGH:
			value = 1.0;
			step = 1.0;
			break;
		case SKILLBIAS_NONE:
		default:
			value = 1.0;
			step = 0.0;
			break;
	}

	for (i = 0; i < MAX_SKILL; i++) {
		if (i < low || i > high)
			bin[i] = 0.0;
		else {
			bin[i] = value;
			value += step;
		}
		if (i > 0)
			bin[i] = bin[i] + bin[i - 1];
	}

	selected = bin[MAX_SKILL - 1] * random();

	for (i = 0; i < MAX_SKILL ; i++)
		if (selected < bin[i])
			return i + 1;

	return MAX_SKILL;
}


/*
=================
StartServer_GetBotSkillInteger
=================
*/
static char* StartServer_GetBotSkill(botskill_t* skill)
{
   static char skill_out[10];

	if (!skill->range) {
      Q_strncpyz(skill_out, va("%i", skill->value + 1), sizeof(skill_out));
      return skill_out;
   }

   // prepare default value
   Q_strncpyz(skill_out, va("%i", skill->low + 1), sizeof(skill_out));
	if (skill->low == skill->high) {
      return skill_out;
   }

	switch (s_scriptdata.bot.skillBias) {
		case SKILLBIAS_FRAC_VLOW:
		case SKILLBIAS_FRAC_LOW:
		case SKILLBIAS_FRAC_HIGH:
		case SKILLBIAS_FRAC_VHIGH:
		case SKILLBIAS_FRACTIONAL:
      {
         float f_skill = StartServer_GetFracBotSkill(skill);
         Q_strncpyz(skill_out, va("%4.2f", f_skill), sizeof(skill_out));
         break;
      }
		case SKILLBIAS_VLOW:
		case SKILLBIAS_LOW:
		case SKILLBIAS_HIGH:
		case SKILLBIAS_VHIGH:
		case SKILLBIAS_NONE:
      {
         int i_skill = StartServer_GetIntBotSkill(skill);
         Q_strncpyz(skill_out, va("%i", i_skill), sizeof(skill_out));
         break;
      }
      default:
         break;
   }

   //trap_Print(va("Bot skill: %s\n", skill_out));
   return skill_out;
}




/*
=================
StartServer_GetPlayerTeam
=================
*/
static int StartServer_GetPlayerTeam( void )
{
	if (s_scriptdata.bot.teamSwapped)
		return 1;
	return 0;
}



/*
=================
StartServer_WriteSelectedBotParams
=================
*/
static void StartServer_WriteSelectedBotParams( void )
{
	int i;
	int team;
   const char* skill;
	qboolean custom;
	int left,right;
	botskill_t* skillrange;

	skillrange = &s_scriptdata.bot.globalSkill;

	custom = qfalse;
	if (s_scriptdata.bot.skillType >= BOTSKILL_CUSTOMSINGLE)
		custom = qtrue;

	if (s_scriptdata.gametype >= GT_TEAM) {
		// team game
		// we must interleave red and blue in case
		// we have team_forcebalance enabled
		team = StartServer_GetPlayerTeam();

		left = 0;
		right = PLAYER_SLOTS_PERCOL;
		do {
			// find first free left bot
			for ( ; left < PLAYER_SLOTS_PERCOL; left++) {
				if (s_scriptdata.bot.slotType[left] != SLOTTYPE_BOT)
					continue;
				if (s_scriptdata.bot.name[left][0] == '\0')
					continue;
				break;
			}

			// find next free right bot
			for ( ; right < PLAYER_SLOTS; right++) {
				if (s_scriptdata.bot.slotType[right] != SLOTTYPE_BOT)
					continue;
				if (s_scriptdata.bot.name[right][0] == '\0')
					continue;
				break;
			}

			if (left < PLAYER_SLOTS_PERCOL) {
				if (custom)
					skillrange = &s_scriptdata.bot.skill[left];
				skill = StartServer_GetBotSkill(skillrange);
				AddScript(va("addbot %s %s %s; ", s_scriptdata.bot.name[left], skill, bot_teamname[team]));
				left++;
			}

			if (right < PLAYER_SLOTS) {
				if (custom)
					skillrange = &s_scriptdata.bot.skill[right];
				skill = StartServer_GetBotSkill(skillrange);
				AddScript(va("addbot %s %s %s; ", s_scriptdata.bot.name[right], skill, bot_teamname[1 - team]));
				right++;
			}
		} while (left < PLAYER_SLOTS_PERCOL && right < PLAYER_SLOTS);
	}
	else {
		// single player game
		for (i = 0; i < PLAYER_SLOTS; i++) {
			if (s_scriptdata.bot.slotType[i] != SLOTTYPE_BOT)
				continue;

			// no blank bot fields
			if (s_scriptdata.bot.name[i][0] == '\0')
				continue;

			if (custom)
				skillrange = &s_scriptdata.bot.skill[i];

			skill = StartServer_GetBotSkill(skillrange);

			AddScript(va("addbot %s %s; ", s_scriptdata.bot.name[i], skill));
		}
	}
}


/*
=================
StartServer_RejectRandomBot
=================
*/
static qboolean StartServer_RejectRandomBot( int newbot, int* botlist, int max )
{
	int i;
	char botname[MAX_NAME_LENGTH];
	char* bot;

	for (i = 0 ; i < max; i++)
	{
		if (newbot == botlist[i])
			return qtrue;
	}

	// compare only if we have an exclude list
	if (StartServer_IsRandomBotExclude(s_scriptdata.bot.typeSelect))
	{
		bot = UI_GetBotInfoByNumber( newbot );
		Q_strncpyz(botname, Info_ValueForKey(bot, "name"), MAX_NAME_LENGTH);

		for (i = 0; i < PLAYER_SLOTS; i++)
			if (!Q_stricmp(s_scriptdata.bot.name[i], botname))
				return qtrue;
	}

	return qfalse;
}


/*
=================
StartServer_GenerateBotList
=================
*/
static void StartServer_GenerateBotList( int* botlist, int listmax, int listnum )
{
	int count, i, j, newbot;
	qboolean repeat;

	for (i = 0; i < listnum; i++) {
		// find an unused bot number, but don't try too hard
		count = 0;
		do {
			repeat = qfalse;
			newbot = Clamp_Random( listmax - 1 );
			if (StartServer_RejectRandomBot(newbot, botlist, i))
			{
				repeat = qtrue;
			}
			count++;
		} while (repeat && count < 32);

		botlist[i] = newbot;
	}
}



/*
=================
StartServer_WriteBotList
=================
*/
static void StartServer_WriteBotList( int* botlist, int listnum, qboolean kick )
{
	int i;
   const char* skill;
	char* bot;
	char* funname;
	char* spacechar;
	char botname[MAX_NAME_LENGTH];
	botskill_t* skillrange;
	int team, player_team;

	skillrange = &s_scriptdata.bot.globalSkill;
	player_team = StartServer_GetPlayerTeam();
	for (i = 0; i < listnum; i++) {
		bot = UI_GetBotInfoByNumber( botlist[i] );
		Q_strncpyz(botname, Info_ValueForKey(bot, "name"), MAX_NAME_LENGTH);

		if (kick) {
			// kicking is based on the funname, if available
			funname = Info_ValueForKey(bot, "funname");
			if (funname[0])
			{
				Q_strncpyz(botname, funname, MAX_NAME_LENGTH);
				Q_CleanStr(botname);
				Q_strncpyz(botname, va("\"%s\"", botname), MAX_NAME_LENGTH);
			}

			AddScript(va("kick %s; ", botname));
		}
		else {
			skill = StartServer_GetBotSkill(skillrange);
			if (s_scriptdata.gametype >= GT_TEAM) {
				team = (player_team + i + 1) % 2;	// start with opposite team

				if (i == listnum - 1 && team == player_team)
					team = 1 - team;	// even number of bots: put last one on opposite team

				AddScript(va("addbot %s %s %s; ", botname, skill, bot_teamname[ team ]));
			}
			else {
				AddScript(va("addbot %s %s; ", botname, skill));
			}
		}
	}
}



/*
=================
StartServer_WriteRandomBotParams
=================
*/
static void StartServer_WriteRandomBotParams( void )
{
	int i, j;
	int max, index, period, next;
	int frequency, bots_perlevel;
	int* kickbots;
	int* addbots;

	frequency = botChange_frequency[ s_scriptdata.bot.changeBots ];

	bots_perlevel = s_scriptdata.bot.numberBots;
	if (bots_perlevel > s_serverexec.maxBots)
		bots_perlevel = s_serverexec.maxBots;

	if (frequency == 0 || bots_perlevel == 0) {	// one-off addbot
		// write kickbot (never kicks a bot, loops forever)
		AddScript("set "SERVER_KICKBOT"0 \"set "SERVER_KICKBOT" vstr "SERVER_KICKBOT"0\"\n");

		// write first addbot
		AddScript("set "SERVER_ADDBOT"0 \"");

		if (bots_perlevel > 0) {
			StartServer_GenerateBotList(s_serverexec.usedBots, s_serverexec.maxBots, bots_perlevel);
			StartServer_WriteBotList(s_serverexec.usedBots, bots_perlevel, qfalse);
		}

		AddScript("set "SERVER_ADDBOT" vstr "SERVER_ADDBOT"1\"\n");

		// write second addbot
		// does nothing
		AddScript("set "SERVER_ADDBOT"1 \"\"\n");
	}
	else {
		// bots that we need to delete when loop comes around again
		StartServer_GenerateBotList(s_serverexec.lastBots, s_serverexec.maxBots, bots_perlevel);

		// to minimize the overlap and repeat of bot/map combinations
		// the period of bot repeat is a prime number > than the number
		// of maps
		period = addbot_primes[ num_addbot_primes - 1 ];
		for (i = 0; i < num_addbot_primes; i++) {
			if (addbot_primes[i] > s_serverexec.cycle_count) {
				period = addbot_primes[i];
				break;
			}
		}

		// write the list
		index = 0;
		max = frequency * period;
		kickbots = s_serverexec.lastBots;
		addbots = s_serverexec.usedBots;
		for (i = period - 1; i >= 0; i--) {
			next = (index + 1)%max;

			// kick the previous bots
			AddScript(va("set "SERVER_KICKBOT"%i \"", index));
			if (bots_perlevel > 0) {
				StartServer_WriteBotList(kickbots, bots_perlevel, qtrue);
			}

			AddScript(va("set "SERVER_KICKBOT" vstr "SERVER_KICKBOT"%i\"\n", next));

			// add the bots
			AddScript(va("set "SERVER_ADDBOT"%i \"", index));
			if (bots_perlevel > 0) {
				if (i == 0) {
					// make sure we add the correct bots that we
					// kicked at the start of the cycle
					addbots = s_serverexec.lastBots;
				}
				else {
					StartServer_GenerateBotList(addbots, s_serverexec.maxBots, bots_perlevel);
				}
				StartServer_WriteBotList(addbots, bots_perlevel, qfalse);
				kickbots = s_serverexec.usedBots;
			}

			AddScript(va("set "SERVER_ADDBOT" vstr "SERVER_ADDBOT"%i\"\n\n", next));

			// pad out so new bots are kicked at the correct number of maps
			for (j = 1; j < frequency; j++) {
				index++;
				next = (index + 1)%max;

				AddScript(va("set "SERVER_KICKBOT"%i \"set "SERVER_KICKBOT" vstr "SERVER_KICKBOT"%i\"\n", index, next));
				AddScript(va("set "SERVER_ADDBOT"%i \"set "SERVER_ADDBOT" vstr "SERVER_ADDBOT"%i\"\n\n", index, next));
			}

			index++;
		}

	}
}



/*
=================
StartServer_GenerateSelectedArenaBotList
=================
*/
static void StartServer_GenerateSelectedArenaBotList(int* bots, int botnum) {
	int count, i, j, newbot;
	qboolean repeat;

	for (i = 0; i < botnum; i++) {
		// find an unused bot number, but don't try too hard
		count = 0;
		do {
			repeat = qfalse;
			newbot = s_serverexec.bots_in_slots[Clamp_Random( s_serverexec.num_bots_in_slots - 1 )];
			if (StartServer_RejectRandomBot(newbot, bots, i))
			{
				repeat = qtrue;
			}
			count++;
		} while (repeat && count < 32);

		bots[i] = newbot;
	}
}



/*
=================
StartServer_GenerateArenaBotList
=================
*/
static int StartServer_GenerateArenaBotList( int* bots, int max, const char* mapname )
{
	const char* info;
	const char* botinfo;
	char* p;
	const char* botname;
	int num;
	int botnum;
	char botlist[MAX_INFO_STRING];

	info = UI_GetArenaInfoByMap(mapname);

	num = 0;

	// we're counting up the number of bots for this level,
	// as well as parsing the bot list
	if (info) {
		Q_strncpyz(botlist, Info_ValueForKey(info, "bots"), MAX_INFO_STRING);
		if (*botlist) {
			// arena has bots, search through them
			p = botlist;
			while ( num < max) {
				botname = COM_Parse(&p);
				if (!botname || !botname[0])
					break;

				botnum = UI_GetBotNumByName(botname);
				if (botnum < 0)
					continue;

				// found the bot, get its index
				bots[num] = botnum;
				num++;
			}

			// only return if we use the parsed results
			if (s_scriptdata.bot.typeSelect == BOTTYPE_ARENASCRIPT)
				return num;
		}
	}

	// no bots on map, so generate a random number
	if (num == 0)
		num = s_scriptdata.bot.numberBots;

	if (num > max)
		num = max;

   // now build the list of bots
   if (s_scriptdata.bot.typeSelect == BOTTYPE_SELECTARENASCRIPT) {
      if (s_serverexec.num_bots_in_slots > 0) {
         StartServer_GenerateSelectedArenaBotList(bots, num);
         return num;
      }
   }

   // list built is randomly generated
	if (num)
		StartServer_GenerateBotList(bots, UI_GetNumBots(), num);

	return num;
}





/*
=================
StartServer_WriteArenaScriptBotParams

Includes awareness of map ordering and random map generation
Copied into static buffer for safe keeping until next call
=================
*/
static char* StartServer_GetArenaScriptMapName( int index )
{
	static char mapname[SHORTMAP_BUFFER];
	char* map_ptr;
	const char* info;
	int mapnum;

	if (index < 0)
		return NULL;

	if (s_serverexec.random_order) {
		// a random order was imposed on the map
		index %= s_serverexec.random_count;

		if (s_serverexec.random_generate) {
			// the map list was also randomly generated
			mapnum = s_serverexec.map_rnd_index[ s_serverexec.map_rnd[index] ];
			info = UI_GetArenaInfoByNumber(mapnum);
			map_ptr = Info_ValueForKey(info, "map");
		}
		else {
			// random order on a defined list of maps
			map_ptr = s_scriptdata.map.data[ s_serverexec.map_rnd[index] ].shortName;
		}
	}
	else {
		// we used a linear list
		map_ptr = s_scriptdata.map.data[index].shortName;
	}

	// copy into local storage
	if (map_ptr && *map_ptr) {
		Q_strncpyz(mapname, map_ptr, SHORTMAP_BUFFER);
	}
	else {
		mapname[0] = '\0';
	}

	return mapname;
}



/*
=================
StartServer_WriteArenaScriptBotParams

Includes awareness of map ordering and random map generation
=================
*/
static void StartServer_WriteArenaScriptBotParams( void )
{
	int i;
	int count, period;
	int bots_onlevel, lastlevel_numbots;
	char *mapname;
	int *kickbots;
	int *addbots;
	int next;

	period = s_serverexec.cycle_count;
	count = period;
	if (s_serverexec.random_order) {
		count = s_serverexec.random_count;
	}

	// bots that we need to delete when loop comes around again
	mapname = StartServer_GetArenaScriptMapName(count - 1);
	lastlevel_numbots = StartServer_GenerateArenaBotList(s_serverexec.lastBots, s_serverexec.maxBots, mapname);

	s_serverexec.max_scripted_bots = lastlevel_numbots;

	// write the list
	kickbots = s_serverexec.lastBots;
	addbots = s_serverexec.usedBots;
	bots_onlevel = lastlevel_numbots;
	for (i = 0; i < count; i++) {
		next = (i + 1)%period;

		// kick the previous bots
		AddScript(va("set "SERVER_KICKBOT"%i \"", i));
		if (bots_onlevel > 0) {
			StartServer_WriteBotList(kickbots, bots_onlevel, qtrue);
		}

		AddScript(va("set "SERVER_KICKBOT" vstr "SERVER_KICKBOT"%i\"\n", next));

		// add the bots
		AddScript(va("set "SERVER_ADDBOT"%i \"", i));

		if (i == count - 1) {
			// make sure we add the correct bots that we
			// kicked at the start of the cycle
			addbots = s_serverexec.lastBots;
			bots_onlevel = lastlevel_numbots;
		}
		else {
			mapname = StartServer_GetArenaScriptMapName(i);
			bots_onlevel = StartServer_GenerateArenaBotList(addbots, s_serverexec.maxBots, mapname);
		}

		if (i == 0)
			s_serverexec.botcount_firstmap = bots_onlevel;

		if (bots_onlevel > s_serverexec.max_scripted_bots)
			s_serverexec.max_scripted_bots = bots_onlevel;

		StartServer_WriteBotList(addbots, bots_onlevel, qfalse);
		kickbots = s_serverexec.usedBots;

		AddScript(va("set "SERVER_ADDBOT" vstr "SERVER_ADDBOT"%i\"\n\n", next));
	}
}





/*
=================
StartServer_WriteBotParams

May depend on map ordering list, so StartServer_WriteMapParams()
must be called first
=================
*/
static qboolean StartServer_WriteBotParams( void )
{
	AddScript("\n// WriteBotParams()\n\n");

	if (!s_serverexec.map_generated) {
		trap_Print(S_COLOR_RED"WriteBotParams called before WriteMapParams\n");
		return qfalse;
	}

   // build list from selected bots
	if (s_scriptdata.bot.typeSelect == BOTTYPE_SELECT)
	{
		// bots are only added once

		AddScript("// allows 'reset "SERVER_ADDBOT"' to clear "SERVER_ADDBOT"\n");
		AddScript("set "SERVER_ADDBOT" \"\"\n");
		AddScript("set "SERVER_ADDBOT" \"");

		StartServer_WriteSelectedBotParams();

		// no more bots added, so clear addbot
		// last command in set SERVER_ADDBOT
		AddScript("reset "SERVER_ADDBOT" \"\n");

		// bots never kicked
		AddScript("set "SERVER_KICKBOT" \"\"\n");

		s_serverexec.bot_generated = qtrue;
		return qtrue;
	}

   if (StartServer_IsBotArenaScript(s_scriptdata.bot.typeSelect)) {
		StartServer_WriteArenaScriptBotParams();
	}
	else {	// BOTTYPE_RANDOM or BOTTYPE_RANDOMEXCLUDE
		StartServer_WriteRandomBotParams();
	}

	// setup bot add and kick commands
	// we don't need to kick any bots on first connect
	AddScript("\nset "SERVER_ADDBOT" \"vstr "SERVER_ADDBOT"0\"\n");
	AddScript("set "SERVER_KICKBOT" \"set "SERVER_KICKBOT" vstr "SERVER_KICKBOT"1\"\n");

	s_serverexec.bot_generated = qtrue;
	return qtrue;
}




/*
=================
StartServer_IsRecentMap
=================
*/
static qboolean StartServer_IsRecentMap(int count, int index)
{
	int i;
	int start;
	int period;

	period = s_serverexec.rnd_nummaps;
	// no previous entries, or not enough maps
	if (count == 0 || period < 2)
		return qfalse;

	// must have used about half of maps before a repeat is allowed
	start = count - (period / 2);
	if (start < 0)
		start = 0;

	for (i = start; i < count; i++)
		if (s_serverexec.map_rnd_index[i] == index)
			return qtrue;

	return qfalse;
}



/*
=================
StartServer_IsBiasedMap
=================
*/
static qboolean StartServer_IsBiasedMap(int idtype, int index)
{
	const char* info;
	qboolean idmap;

	if (idtype != MAP_RND_BIASID && idtype != MAP_RND_BIASNONID)
		return qfalse;

	info = UI_GetArenaInfoByNumber(index);
	idmap = StartServer_IsIdMap(Info_ValueForKey(info, "map"));
	if (idtype == MAP_RND_BIASID && idmap)
		return qfalse;
	if (idtype == MAP_RND_BIASNONID && !idmap)
		return qfalse;

	if (random() < 0.25)
		return qfalse;

	return qtrue;		
}




/*
=================
StartServer_ExcludeMap_callback
=================
*/
static qboolean StartServer_ExcludeMap_callback(const char* info)
{
	int i;
	const char* mapname;
	int idtype;
	int subtype;
	qboolean idmap;

	subtype = s_scriptdata.map.SourceType;
	if (subtype < MAP_RND_MAX)
	{
		idtype = subtype;
		subtype = -1;
	}
	else
	{
		idtype = MAP_RND_ANY;
		subtype -= MAP_RND_MAX;
	}

	mapname = Info_ValueForKey(info, "map");
	if (!StartServer_MapSupportsBots(mapname))
		return qfalse;

	idmap = StartServer_IsIdMap(mapname);
	if (idmap && (idtype == MAP_RND_NONID))
		return qfalse;
	if (!idmap && (idtype == MAP_RND_ID))
		return qfalse;

	if (subtype >=0 && !StartServer_IsCustomMapType(mapname, subtype))
		return qfalse;

	if (s_scriptdata.map.listSource != MAP_MS_RANDOMEXCLUDE)
		return qtrue;	

	// check if on exclude list
	for (i = 0; i < s_scriptdata.map.num_maps; i++)
		if (!Q_stricmp(mapname, s_scriptdata.map.data[i].shortName))
			return qfalse;

	return qtrue;
}




/*
=================
StartServer_GenerateRandomMaps
=================
*/
static qboolean StartServer_GenerateRandomMaps(int count)
{
	int i, j;
	int map;
	int failed;
	int idtype;
	int maplist[MAX_MAPS_LIST * 2];
	callbackMapList callback;

	idtype = s_scriptdata.map.SourceType;
	if (idtype >= MAP_RND_MAX)
	{
		idtype = MAP_RND_ANY;
	}

	callback = StartServer_ExcludeMap_callback;
	s_serverexec.rnd_nummaps = UI_BuildMapListByType(
		maplist, MAX_MAPS_LIST * 2, s_scriptdata.gametype, callback);

	if (s_serverexec.rnd_nummaps == 0)
	{
		StartServer_PrintMessage( "No random maps available");
		return qfalse;
	}

	// try to add the map, but not too hard
	for (i = 0; i < count; i++)
	{
		failed = 0;
		do {
			map = Clamp_Random(s_serverexec.rnd_nummaps - 1 );
			if (StartServer_IsBiasedMap(idtype, maplist[map]))
				continue;

		} while (StartServer_IsRecentMap(i, maplist[map]) && failed++ < 32);

		s_serverexec.map_rnd_index[i] = maplist[map];
	}

	return qtrue;
}



/*
=================
StartServer_GenerateRandomMapOrder
=================
*/
static void StartServer_GenerateRandomMapOrder( int count, int avoid, int* map_rnd )
{
	int i, repeat;
	int src, dest, value;

	for (i = 0; i < count; i++)
		map_rnd[i] = i;

	repeat = 0;
	do {
		// do shuffle
		for (i = 0; i < 2 * count; i++) {
			src = Clamp_Random(count - 1);
			dest = Clamp_Random(count - 1);
			if (src != dest) {
				value = map_rnd[src];
				map_rnd[src] = map_rnd[dest];
				map_rnd[dest] = value;
			}
		}
		repeat++;
		// avoid matching first value
		// ensure there might be a different map,
		// and that we don't try too hard
	} while (avoid == map_rnd[0] && count > 1 && repeat < 32);
}






/*
=================
StartServer_WriteMapParams
=================
*/
static qboolean StartServer_WriteMapParams( void )
{
	int i, value, count, index, lastmap;
	int source;
	int fraglimit, timelimit;
	const char* info;
	const char* mapname;
	qboolean random_order;
	qboolean random_generate;

	AddScript("\n// WriteMapParams()\n\n");

	fraglimit = s_scriptdata.map.fragLimit;
	timelimit = s_scriptdata.map.timeLimit;

	if (s_scriptdata.map.fragLimitType == MAP_LT_NONE)
		fraglimit = 0;
	if (s_scriptdata.map.timeLimitType == MAP_LT_NONE)
		timelimit = 0;

	// set for unlimited frags
	if (UIE_IsCaptureLimited(s_scriptdata.gametype))
		AddScript("fraglimit 0\n");

	source = s_scriptdata.map.listSource;
	count = s_serverexec.cycle_count;

	random_generate = StartServer_IsRandomGeneratedMapList(source);
	random_order = (source == MAP_MS_RANDOMLIST || random_generate);
	if (random_order)
	{
		// the internal Q3 exe script buffer is limited to 16K.
		// Empirical evidence indicate problems start to happen at about
		// 80-100 randomly ordered map rotations, so we clip the values
		// and keep then under 100
		if (count < 20)
			count *= 4;
		else if (count < 40)
			count *= 2;

		if (count > MAX_MAPS_LIST)
			count = MAX_MAPS_LIST;
	}

	s_serverexec.random_generate = random_generate;
	s_serverexec.random_order = random_order;
	s_serverexec.random_count = count;

	if (StartServer_IsRandomGeneratedMapList(source) && !StartServer_GenerateRandomMaps(s_serverexec.cycle_count))
		return qfalse;

	// generate the random order before we do the output
	if (random_order) {
		lastmap = -1;
		for (i = 0; i < count; i += s_serverexec.cycle_count) {
			if (i > 0)
				lastmap = s_serverexec.map_rnd[ i - 1 ];
			StartServer_GenerateRandomMapOrder(s_serverexec.cycle_count, lastmap, &s_serverexec.map_rnd[i]);
		}
	}

	// build the script
	for (i = 0; i < count; i++) {
		// we start with the "in order" index
		index = i % s_serverexec.cycle_count;

		// now adjust the index for a random map order
		if (random_order) {
			if ( index == 0 && i > 0)
				AddScript("\n");

			index = s_serverexec.map_rnd[i];
		}

		// create the variable in the script
		AddScript(va("set m%i \"", i));

		// find and error check the map limits
		if (s_scriptdata.map.fragLimitType == MAP_LT_CUSTOM)
			fraglimit = atoi(s_scriptdata.map.data[index].fragLimit);
		if (s_scriptdata.map.timeLimitType == MAP_LT_CUSTOM)
			timelimit = atoi(s_scriptdata.map.data[index].timeLimit);

		if (timelimit == 0 && fraglimit == 0 && s_serverexec.cycle_count > 1)
			timelimit = 30;

		// write the map limits
		AddScript(va("timelimit %i; ", timelimit));

		if (UIE_IsCaptureLimited(s_scriptdata.gametype))
			AddScript(va("capturelimit %i; ", fraglimit));
		else
			AddScript(va("fraglimit %i; ", fraglimit));

		if (s_scriptdata.server.preventConfigBug)
			AddScript("writeconfig q3config; ");

		// write map name
		if (random_generate) {
			info = UI_GetArenaInfoByNumber(s_serverexec.map_rnd_index[index]);
			mapname = Info_ValueForKey(info, "map");
		}
		else {
			mapname = s_scriptdata.map.data[index].shortName;
		}
		AddScript(va("map %s; ", mapname));

		// sort the bots out
		AddScript("vstr "SERVER_KICKBOT"; vstr "SERVER_ADDBOT"; ");

		// set gravity if overriding default
		if (s_scriptdata.server.gravity != 800)
			AddScript(va("g_gravity %i; ", s_scriptdata.server.gravity));

		// terminate string
		value = (i + 1) % count;
		if (value == 0 && !s_scriptdata.map.Repeat) {
			// don't loop map list
			AddScript("\"\n");
			continue;
		}
		AddScript(va("set nextmap vstr m%i\"\n", value));
	}

	s_serverexec.map_generated = qtrue;
	return qtrue;
}



/*
=================
StartServer_WriteItemParams
=================
*/
static qboolean StartServer_WriteItemParams( void )
{
	int 		i, j;
	int 		type;
	qboolean	disable;

	AddScript("\n// WriteItemParams()\n\n");

	// write out the disabled items list
	for (i = 0; i < ITEM_COUNT; i++)
	{
		disable = qfalse;
		type = s_scriptdata.item.groupstate[ server_itemlist[i].groupid ];
		if (type == ALLGROUPS_HIDDEN) {
			disable = qtrue;
		}	
		else if (type == ALLGROUPS_CUSTOM) {
			disable = qtrue;
			if (s_scriptdata.item.enabled[i])
				disable = qfalse;
		}

		AddScript(va("set disable_%s %i\n", server_itemlist[i].mapitem, disable));
	}

	return qtrue;
}



static	char	uie_token[MAX_TOKEN_CHARS];
static	int		uie_lines;


/*
=================
UIE_Parse

Custom version of COM_ParseExt() that ignores // comments
We shouldn't modify the version in q_shared.c
=================
*/
char *UIE_Parse( char **data_p)
{
	int c = 0, len;
	int cc;
	qboolean hasNewLines = qfalse;
	char *data;
	qboolean allowLineBreaks;

	allowLineBreaks = qtrue;
	data = *data_p;
	len = 0;
	uie_token[0] = 0;

	// make sure incoming data is valid
	if ( !data )
	{
		*data_p = NULL;
		return uie_token;
	}

	while ( 1 )
	{
		// skip whitespace

		while( (cc = *data) <= ' ') {
			if( !cc ) {
				data = NULL;
				break;
			}
			if( cc == '\n' ) {
				uie_lines++;
				hasNewLines = qtrue;
			}
			data++;
		}

		if ( !data )
		{
			*data_p = NULL;
			return uie_token;
		}
		if ( hasNewLines && !allowLineBreaks )
		{
			*data_p = data;
			return uie_token;
		}

		c = *data;

		// skip /* */ comments
		if ( c=='/' && data[1] == '*' )
		{
			data += 2;
			while ( *data && ( *data != '*' || data[1] != '/' ) )
			{
				data++;
			}
			if ( *data )
			{
				data += 2;
			}
		}
		else
		{
			break;
		}
	}

	// handle quoted strings
	if (c == '\"')
	{
		data++;
		while (1)
		{
			c = *data++;
			if (c=='\"' || !c)
			{
				uie_token[len] = 0;
				*data_p = ( char * ) data;
				return uie_token;
			}
			if (len < MAX_TOKEN_CHARS)
			{
				uie_token[len] = c;
				len++;
			}
		}
	}

	// parse a regular word
	do
	{
		if (len < MAX_TOKEN_CHARS)
		{
			uie_token[len] = c;
			len++;
		}
		data++;
		c = *data;
		if ( c == '\n' )
			uie_lines++;
	} while (c>32);

	if (len == MAX_TOKEN_CHARS)
	{
//		Com_Printf ("Token exceeded %i chars, discarded.\n", MAX_TOKEN_CHARS);
		len = 0;
	}
	uie_token[len] = 0;

	*data_p = ( char * ) data;
	return uie_token;
}




/*
=================
StartServer_LoadFromConfig
=================
*/
qboolean StartServer_LoadFromConfig( const char* filename)
{
	fileHandle_t 	handle;
	char			cvar[CVAR_BUFFER];
	int 			len;
	char* 			begin;
	char* 			end;
	char*			ptr;
	char* 			token;
	int 			gametype;

	// load the script, re-use the server script buffer
	len = trap_FS_FOpenFile(filename, &handle, FS_READ);
	if (len <= 0)
	{
		Com_Printf("Config file not found: %s\n", filename);
		return qfalse;
	}

    UIE_StartServer_LoadSkirmishCvars();

	if (len >= SCRIPT_BUFFER)
		len = SCRIPT_BUFFER - 1;

	trap_FS_Read(s_serverexec.server_script, len, handle);
	s_serverexec.server_script[len] = '\0';
	trap_FS_FCloseFile(handle);

	// find the begin and end of block terminators
	begin = strstr(s_serverexec.server_script, BEGIN_PARAMETER_BLOCK);
	end = strstr(s_serverexec.server_script, END_PARAMETER_BLOCK);

	if (begin == 0) {
		StartServer_PrintMessage(va("Config file %s has no BEGIN block\n", filename));
		return qfalse;
	}

	if (end == 0) {
		StartServer_PrintMessage(va("Config file %s has no END block\n", filename));
		return qfalse;
	}

	if (begin > end) {
		StartServer_PrintMessage(va("Config file %s has bad parameter block\n", filename));
		return qfalse;
	}

	// scan in parameters
	// first token will be BEGIN, after that we have
	// Cvar/value pairs until we hit the END block
	ptr = begin;
	gametype = -1;
	COM_Parse(&ptr);	// drop BEGIN

	do {
		// grab Cvar name
		token = UIE_Parse(&ptr);
		if (!token) {
			// should never happen, unless tampered with
			StartServer_PrintMessage(va("Unexpected end of %s, possible corruption or tampering\n", filename));
			return qtrue;	// update anyway... fingers crossed
		}

		// backward compatibility with earlier cfg save data format
		if (strlen(token) > 2 && token[0] == '/' && token[1] == '/') {
			token += 2;
		}

		if (!Q_stricmp(token, END_PARAMETER_BLOCK))
			break;

		if (*token == '*') {
			if (gametype == -1) {
				StartServer_PrintMessage(va("Unknown gametype from %s, possible corruption or tampering\n", filename));

				// restore last saved cvar list
				UIE_StartServer_LoadSkirmishCvars();
				return qfalse;	// don't update
			}
			Q_strncpyz(cvar, va(gametype_cvar_base[gametype_remap2[gametype]], token + 1), CVAR_BUFFER);
		}
		else
			Q_strncpyz(cvar, token, CVAR_BUFFER);

		// grab value
		token = UIE_Parse(&ptr);
		UIE_ConvertOldCvar(cvar, CVAR_BUFFER);

		if (uis.debug)
			Com_Printf("Cvar: %s=%s\n", cvar, token);

		if (UIE_SkirmishCvarExists(NULL, cvar)) {
			UIE_SetSkirmishCvar(NULL, cvar, token);
		}

		// must get gametype before we can process "*cvarName" Cvars
		if (!Q_stricmp(cvar,"uie_gametype")) {
			gametype = (int)Com_Clamp(0, MAX_GAME_TYPE - 1, atoi(token));
		}

	} while (qtrue);

	UIE_StartServer_SaveSkirmishCvars();
	return qtrue;
}




/*
=================
StartServer_WriteScriptCvar
=================
*/
static void StartServer_WriteScriptCvar( const char* cvarTemplate )
{
	char 	buffer[MAX_INFO_STRING];
	const char*	cvar;
	char* 	s;

	if (!cvarTemplate || !*cvarTemplate)
		return;

	if (*cvarTemplate == '*') {
		cvar = cvarTemplate + 1;
		s = gametype_cvar_base[gametype_remap2[s_scriptdata.gametype]];
	}
	else {
		cvar = cvarTemplate;
		s = NULL;
	}

	if (UIE_GetSkirmishCvar(s, cvar, buffer, MAX_INFO_STRING)) {
		AddScript(va("//%s \"%s\"\n", cvarTemplate, buffer));
	}
}



/*
=================
StartServer_WriteScriptParams
=================
*/
static qboolean StartServer_WriteScriptParams( void )
{
	const char*	cvar;
	int  	i, count;
	char*	s;

	AddScript("\n// WriteScriptParams()\n\n");

	AddScript("// This block of data allows UIE to load\n");
	AddScript("// this script back into the map/bot setup pages.\n");
	AddScript("// Don't edit the contents!!!\n");
	AddScript("//"BEGIN_PARAMETER_BLOCK"\n");

    UIE_StartServer_LoadSkirmishCvars();

	// save the common parameters
	for (i = 0; saveparam_list[i]; i++) {
		StartServer_WriteScriptCvar(saveparam_list[i]);
	}

   if (uis.punkbuster) {
		StartServer_WriteScriptCvar("uie_punkbuster");
   }

	// save the gametype specific parameters
/*	count = sizeof(customsaveparam_list)/sizeof(customsaveparam_list[0]);
	for (i = 0 ; i < count; i++)
	{
		if (customsaveparam_list[i].type != s_scriptdata.gametype)
			continue;
		StartServer_WriteScriptCvar(customsaveparam_list[i].param);
	}*/

	// close off the block
	AddScript("//"END_PARAMETER_BLOCK"\n\n");
	return qtrue;
}



/*
=================
StartServer_ExecuteScript
=================
*/
static qboolean StartServer_ExecuteScript(const char* scriptFile)
{
	fileHandle_t f;
	int len;

	if (!s_serverexec.server_script[0])
		return qfalse;

	if (scriptFile) {
		len = strlen( s_serverexec.server_script );
		trap_FS_FOpenFile(scriptFile, &f, FS_WRITE);
		if ( !f) {
			StartServer_PrintMessage( va( "Can't open file (%s)", scriptFile) );
			return qfalse;
		}

		trap_FS_Write( s_serverexec.server_script, len, f );

		trap_FS_FCloseFile( f );
	}
	else {
		trap_Cmd_ExecuteText( EXEC_APPEND, s_serverexec.server_script );
	}

	return qtrue;
}



/*
=================
StartServer_CreateServer

Data for generating script must already be loaded and initialized
=================
*/
qboolean StartServer_CreateServer(const char* scriptFile)
{
	int i;
	float f;
	char* teamjoin;

//	StartServer_InitScriptData();

	// shift random number generator
	// otherwise we see identical map and bot rotations

	for (i = uis.realtime % 200; i; i--)
		f = random();

	if (!StartServer_InitServerExec())
		return qfalse;

	if (scriptFile) {
		AddScript("// Script generated by \"UI Enhanced\" " UIE_VERSION "\n");
		AddScript("// \"UI Enhanced\" written by HypoThermia\n");
		AddScript("// Homepage and latest version: http://www.planetquake.com/uie/\n");
		AddScript("// Q3 coding: http://www.planetquake.com/code3arena/\n\n");
	}

	//
	// script recovery parameters
	//
	if (scriptFile && !StartServer_WriteScriptParams())
		return qfalse;

	//
	// item parameters
	//
	if (!StartServer_WriteItemParams())
		return qfalse;

	//
	// map parameters
	//
	if (!StartServer_WriteMapParams())
		return qfalse;

	//
	// bot parameters
	//

	// bot parameters written may depend on map ordering
	if (!StartServer_WriteBotParams())
		return qfalse;

	//
	// server parameters
	//

	// server parameters may depend on bot generation
	if (!StartServer_WriteServerParams())
		return qfalse;

	//
	// force player to join team/specs
	//
	if (s_scriptdata.server.dedicatedServer == SRVDED_OFF) {
		if (scriptFile)
			AddScript("\n// Things that need to be done when first map starts\n");

		AddScript("set activeAction \"");

		teamjoin = "forceteam %i free";
		if (s_scriptdata.bot.joinAs) {
			teamjoin = "forceteam %i spectator";
		}
		else if (s_scriptdata.gametype >= GT_TEAM) {
			// use %%i so a single %i is generated for player client
			teamjoin = va("forceteam %%i %s", bot_teamname[StartServer_GetPlayerTeam()]);
		}
		else if (s_scriptdata.gametype == GT_TOURNAMENT) {
			for (i = 0; i < s_serverexec.player_client; i++)
				AddScript(va("forceteam %i spectator;", i));
		}

		AddScript(va(teamjoin, s_serverexec.player_client));
		AddScript("\"\n");
	}

	// start the map rotation running
	AddScript("\n");
	if (scriptFile)
		AddScript("// start map rotation\n");

	AddScript("vstr m0\n");

	//
	// execute!
	//
	return StartServer_ExecuteScript( scriptFile );
}


