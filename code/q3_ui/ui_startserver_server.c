/*
=============================================================================

START SERVER MENU *****

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
#include "ui_startserver_q3.h"




#define ID_SERVER_GAMETYPE 300
#define ID_SERVER_HOSTNAME 301
#define ID_SERVER_RESPAWN 302
#define ID_SERVER_WARMUP 303
#define ID_SERVER_FRIENDLY 304
#define ID_SERVER_AUTOJOIN 305
#define ID_SERVER_TEAMBALANCE 306
#define ID_SERVER_PURE 307
#define ID_SERVER_DEDICATED 308
#define ID_SERVER_INACTIVITY 309
#define ID_SERVER_SAVE 311
#define ID_SERVER_LOAD 312
#define ID_SERVER_PMOVEFIXED 313
#define ID_SERVER_PMOVEMSEC 314
#define ID_SERVER_SMOOTHCLIENTS 315

#define ID_SERVER_MAXRATE 316
#define ID_SERVER_ALLOWDOWNLOAD 317
#define ID_SERVER_PASSWORD 318
#define ID_SERVER_ALLOWPASS 319
#define ID_SERVER_ALLOWVOTE 320
#define ID_SERVER_ALLOWMAXRATE 321
#define ID_SERVER_ALLOWWARMUP 322
#define ID_SERVER_SYNCCLIENTS 323
#define ID_SERVER_MINPING 324
#define ID_SERVER_MAXPING 325
#define ID_SERVER_ALLOWMINPING 326
#define ID_SERVER_ALLOWMAXPING 327
#define ID_SERVER_CONFIGBUG 328
#define ID_SERVER_GRAVITY 329
#define ID_SERVER_KNOCKBACK 330
#define ID_SERVER_QUADFACTOR 331
#define ID_SERVER_NETPORT 332
#define ID_SERVER_SVFPS 333
#define ID_SERVER_ALLOWPRIVATECLIENT 334
#define ID_SERVER_PRIVATECLIENT 335
#define ID_SERVER_PRIVATECLIENTPWD 336
#define ID_SERVER_WEAPONRESPAWN 337
#define ID_SERVER_PUNKBUSTER 338
#define ID_SERVER_STRICTAUTH 339
#define ID_SERVER_LANFORCERATE 340


// server page tabs
#define ID_SERVERTAB_CONNECT 350
#define ID_SERVERTAB_GAMEPLAY 351
#define ID_SERVERTAB_TEAM 352
#define ID_SERVERTAB_ADMIN 353
#define ID_SERVERTAB_MISC 354
#define ID_SERVERTAB_MULTIPLAY 355
#define ID_SERVERTAB_PHYSICS 356
#define ID_SERVERTAB_PASSWORD 357


#define SERVER_SAVE0 "menu/art/save_0"
#define SERVER_SAVE1 "menu/art/save_1"
#define SERVER_LOAD0 "menu/art/load_0"
#define SERVER_LOAD1 "menu/art/load_1"


#define CONTROL_POSX (GAMETYPECOLUMN_X + 6*SMALLCHAR_WIDTH)

#define SERVERCOLUMN_X GAMETYPECOLUMN_X



enum {
	SRVCTRL_SPIN,
	SRVCTRL_RADIO,
	SRVCTRL_TEXTFIELD,
	SRVCTRL_NUMFIELD,
	SRVCTRL_BLANK
};


/*
	These flags define how controls are drawn

	ITEM_ALWAYSON			never modified
	ITEM_GRAYIF_PREVON		grayed if prev spin control is on (dyn)
	ITEM_GRAYIF_PREVOFF		grayed if prev spin control is off (dyn)
	ITEM_TEAM_GAME			control displayed when a team game
	ITEM_NOTEAM_GAME		control displayed when not a team game
	ITEM_HALFGAP			places a gap after this item

	On use of ITEM_GRAYIF_* flags:
	The control with this flag will be enabled/grayed depending on the
	most recent radio control that is enabled. You can use this flag to
	enable/disable groups of controls that include a radio control - without
	that disabled radio control influencing the group.

	Example:

	radio1
	spin1	GRAYIF_PREVON
	radio2	GRAYIF_PREVON
	spin2	GRAYIF_PREVON

	if radio1 is on then all following controls are grayed, radio2 is ignored
	if radio1 is off then spin1 and radio2 are enabled, and spin2 depends on radio2
*/
#define ITEM_ALWAYSON			0x0000
#define ITEM_GRAYIF_PREVON	 	0x0001
#define ITEM_GRAYIF_PREVOFF 	0x0002
#define ITEM_TEAM_GAME			0x0004
#define ITEM_NOTEAM_GAME		0x0008
#define ITEM_HALFGAP			0x0010



// list of created controls on page
typedef struct controlinit_s {
	int type;	// SRVCTRL_*
	int offset;	// index into array storing type
	int id;		// control id ID_SERVER_*
	int flags;	// ITEM_* flags

	char* title;	// text describing control

	// used by RADIO, NUMFIELD, or SPIN
	int* number;

	// used by NUMFIELD
	// min, max ignored if identical
	int min;	// min value of number
	int max;	// max value of number

	// used by TEXTFIELD
	char* array;

	// used by TEXTFIELD and NUMFIELD
	int displaysize;
	int arraysize;

	// used by SPIN
	const char** itemnames;
} controlinit_t;



#define ARRAY_COUNT(array) (sizeof(array)/sizeof(array[0]))


// single tabbed page of controls
typedef struct initlist_s {
	int id;
	char* title;
	menutext_s* menutext;
	controlinit_t* list;
	int count;
} initlist_t;





typedef struct radiobuttoncontrol_s {
	menuradiobutton_s control;

	controlinit_t* init;
} radiobuttoncontrol_t;


typedef struct textfieldcontrol_s {
	menufield_s control;

	controlinit_t* init;
} textfieldcontrol_t;


typedef struct spincontrol_s {
	menulist_s control;

	controlinit_t* init;
} spincontrol_t;



#define MAX_SERVER_RADIO_CONTROL 24
#define MAX_SERVER_MFIELD_CONTROL 12
#define MAX_SERVER_SPIN_CONTROL 12



typedef struct servercontrols_s {
	menuframework_s menu;
	commoncontrols_t common;

	menulist_s gameType;
	menubitmap_s gameTypeIcon;
	menufield_s hostname;

	radiobuttoncontrol_t radio[MAX_SERVER_RADIO_CONTROL];
	textfieldcontrol_t field[MAX_SERVER_MFIELD_CONTROL];
	spincontrol_t spin[MAX_SERVER_SPIN_CONTROL];

	menutext_s connect;
	menutext_s gameplay;
	menutext_s physics;
	menutext_s team;
	menutext_s admin;
	menutext_s password;
	menutext_s misc;
	menutext_s multiplay;

	// currently selected tabbeed page for server
	int activePage;

	// source of data for manipulating list
	initlist_t* pageList;
	int pageListSize;

	// current number of controls on displayed page
	int num_radio;
	int num_field;
	int num_spin;

	menubitmap_s saveScript;
	menubitmap_s loadScript;

	int statusbar_height;
	int savetime;
	char statusbar_message[MAX_STATUSBAR_TEXT];
} servercontrols_t;




static servercontrols_t s_servercontrols;



//
// static data used by controls
//


static const char *dedicated_list[] = {
	"No",	// SRVDED_OFF
	"LAN",	// SRVDED_LAN
	"Internet",	// SRVDED_INTERNET
	0
};




// connect controls
static controlinit_t srv_connect[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_PURE, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Pure server:", &s_scriptdata.server.pure, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWMINPING, ITEM_ALWAYSON,
		"Use min ping:", &s_scriptdata.server.allowMinPing, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_MINPING, ITEM_GRAYIF_PREVOFF,
		"Min ping (ms):", &s_scriptdata.server.minPing, 0, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWMAXPING, ITEM_ALWAYSON,
		"Use max ping:", &s_scriptdata.server.allowMaxPing, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_MAXPING, ITEM_GRAYIF_PREVOFF,
		"Max ping (ms):", &s_scriptdata.server.maxPing, 0, 999, NULL, 4, 4, NULL }
};


// gameplay controls
static controlinit_t srv_gameplay[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWWARMUP, ITEM_ALWAYSON,
		"Allow warmup:", &s_scriptdata.server.allowWarmup, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_WARMUP, ITEM_GRAYIF_PREVOFF|ITEM_HALFGAP,
		"Warmup time:", &s_scriptdata.server.warmupTime, 0, 0, NULL, 4, 4, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_SMOOTHCLIENTS, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Smooth clients:", &s_scriptdata.server.smoothclients, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_RESPAWN, ITEM_ALWAYSON,
		"Respawn time:", &s_scriptdata.server.forceRespawn, 0, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_WEAPONRESPAWN, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Weapon respawn:", &s_scriptdata.server.weaponrespawn, 0, 9999, NULL, 5, 5, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_QUADFACTOR, ITEM_ALWAYSON,
		"Quadfactor:", &s_scriptdata.server.quadfactor, 0, 15, NULL, 4, 4, NULL }

};



// physics
static controlinit_t srv_physics[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_PMOVEFIXED, ITEM_ALWAYSON,
		"Pmove fixed:", &s_scriptdata.server.pmove_fixed, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_PMOVEMSEC, ITEM_GRAYIF_PREVOFF|ITEM_HALFGAP,
		"msec:", &s_scriptdata.server.pmove_msec, 8, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_GRAVITY, ITEM_ALWAYSON,
		"Gravity:", &s_scriptdata.server.gravity, 20, 10000, NULL, 5, 5, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_KNOCKBACK, ITEM_ALWAYSON,
		"Knockback:", &s_scriptdata.server.knockback, 0, 99999, NULL, 5, 5, NULL },

};


// team controls
static controlinit_t srv_team[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_FRIENDLY, ITEM_TEAM_GAME,
		"Friendly fire:", &s_scriptdata.server.friendlyFire, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_AUTOJOIN, ITEM_TEAM_GAME,
		"Team auto join:", &s_scriptdata.server.autoJoin, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_TEAMBALANCE, ITEM_TEAM_GAME,
		"Team balance:", &s_scriptdata.server.teamBalance, 0, 0, NULL, 0, 0, NULL }
};



// admin controls
static controlinit_t srv_admin[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWMAXRATE, ITEM_ALWAYSON,
		"Server maxrate:", &s_scriptdata.server.allowmaxrate, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_MAXRATE, ITEM_GRAYIF_PREVOFF|ITEM_HALFGAP,
		"bytes/s:", &s_scriptdata.server.maxrate, 0, 0, NULL, 6, 6, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWVOTE, ITEM_ALWAYSON,
		"Allow voting:", &s_scriptdata.server.allowvote, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWDOWNLOAD, ITEM_ALWAYSON,
		"Allow download:", &s_scriptdata.server.allowdownload, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_SYNCCLIENTS, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Sync clients:", &s_scriptdata.server.syncClients, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_NETPORT, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Net Port:", &s_scriptdata.server.netport, 1024, 65535, NULL, 6, 6, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_SVFPS, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Server FPS:", &s_scriptdata.server.sv_fps, 20, 160, NULL, 4, 4, NULL }
};


// password controls
static controlinit_t srv_password[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWPASS, ITEM_ALWAYSON,
		"Private server:", &s_scriptdata.server.allowpass, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_TEXTFIELD, 0, ID_SERVER_PASSWORD, ITEM_GRAYIF_PREVOFF|ITEM_HALFGAP,
		"Private password:", NULL, 0, 0, s_scriptdata.server.password, 10, MAX_PASSWORD_LENGTH, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_ALLOWPRIVATECLIENT, ITEM_ALWAYSON,
		"Reserve clients:", &s_scriptdata.server.allowPrivateClients, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_PRIVATECLIENT, ITEM_GRAYIF_PREVOFF,
		"Private clients:", &s_scriptdata.server.privateClients, 0, 32, NULL, 4, 4, NULL },

	{ SRVCTRL_TEXTFIELD, 0, ID_SERVER_PRIVATECLIENTPWD, ITEM_GRAYIF_PREVOFF,
		"Client password:", NULL, 0, 0, s_scriptdata.server.privatePassword, 10, MAX_PASSWORD_LENGTH, NULL }
};


// misc controls
static controlinit_t srv_misc[] = {
	{ SRVCTRL_RADIO, 0, ID_SERVER_CONFIGBUG, ITEM_ALWAYSON,
		"Fix config bug:", &s_scriptdata.server.preventConfigBug, 0, 0, NULL, 0, 0, NULL }
};


// multiplayer controls (punkbuster)
static controlinit_t srv_multiplay[] = {
	{ SRVCTRL_SPIN, 0, ID_SERVER_DEDICATED, ITEM_ALWAYSON,
		"Dedicated server:", &s_scriptdata.server.dedicatedServer, 0, 0, NULL, 0, 0, dedicated_list },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_INACTIVITY, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Inactivity timeout:", &s_scriptdata.server.inactivityTime, 0, 999, NULL, 3, 3, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_PUNKBUSTER, ITEM_ALWAYSON,
		"PunkBuster:", &s_scriptdata.server.punkbuster, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_STRICTAUTH, ITEM_GRAYIF_PREVOFF|ITEM_HALFGAP,
		"Strict auth:", &s_scriptdata.server.strictAuth, 0, 0, NULL, 0,0, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_LANFORCERATE, ITEM_ALWAYSON,
		"LAN force rate:", &s_scriptdata.server.lanForceRate, 0, 0, NULL, 0, 0, NULL },
};

// multiplayer controls (no punkbuster)
static controlinit_t srv_multiplay_nopunkbuster[] = {
	{ SRVCTRL_SPIN, 0, ID_SERVER_DEDICATED, ITEM_ALWAYSON,
		"Dedicated server:", &s_scriptdata.server.dedicatedServer, 0, 0, NULL, 0, 0, dedicated_list },

	{ SRVCTRL_NUMFIELD, 0, ID_SERVER_INACTIVITY, ITEM_ALWAYSON|ITEM_HALFGAP,
		"Inactivity timeout:", &s_scriptdata.server.inactivityTime, 0, 999, NULL, 3, 3, NULL },

	{ SRVCTRL_RADIO, 0, ID_SERVER_LANFORCERATE, ITEM_ALWAYSON,
		"LAN force rate:", &s_scriptdata.server.lanForceRate, 0, 0, NULL, 0, 0, NULL },
};




// list of controls used for a multiplayer/dedicated game
static initlist_t srv_multiplayerserver[] =
{
	{ ID_SERVERTAB_CONNECT, "CONNECT", &s_servercontrols.connect, srv_connect, ARRAY_COUNT(srv_connect) },
	{ ID_SERVERTAB_GAMEPLAY, "GAMEPLAY", &s_servercontrols.gameplay, srv_gameplay, ARRAY_COUNT(srv_gameplay) },
	{ ID_SERVERTAB_PHYSICS, "PHYSICS", &s_servercontrols.physics, srv_physics, ARRAY_COUNT(srv_physics) },
	{ ID_SERVERTAB_TEAM, "TEAM", &s_servercontrols.team, srv_team, ARRAY_COUNT(srv_team) },
	{ ID_SERVERTAB_ADMIN, "ADMIN", &s_servercontrols.admin, srv_admin, ARRAY_COUNT(srv_admin) },
	{ ID_SERVERTAB_PASSWORD, "PASSWORD", &s_servercontrols.password, srv_password, ARRAY_COUNT(srv_password) },
	{ ID_SERVERTAB_MISC, "MISC", &s_servercontrols.misc, srv_misc, ARRAY_COUNT(srv_misc) },
	{ ID_SERVERTAB_MULTIPLAY, "MULTIPLAY", &s_servercontrols.multiplay, srv_multiplay, ARRAY_COUNT(srv_multiplay) }
};


// list of controls used for a multiplayer/dedicated game
static initlist_t srv_multiplayerserver_nopunkbuster[] =
{
	{ ID_SERVERTAB_CONNECT, "CONNECT", &s_servercontrols.connect, srv_connect, ARRAY_COUNT(srv_connect) },
	{ ID_SERVERTAB_GAMEPLAY, "GAMEPLAY", &s_servercontrols.gameplay, srv_gameplay, ARRAY_COUNT(srv_gameplay) },
	{ ID_SERVERTAB_PHYSICS, "PHYSICS", &s_servercontrols.physics, srv_physics, ARRAY_COUNT(srv_physics) },
	{ ID_SERVERTAB_TEAM, "TEAM", &s_servercontrols.team, srv_team, ARRAY_COUNT(srv_team) },
	{ ID_SERVERTAB_ADMIN, "ADMIN", &s_servercontrols.admin, srv_admin, ARRAY_COUNT(srv_admin) },
	{ ID_SERVERTAB_PASSWORD, "PASSWORD", &s_servercontrols.password, srv_password, ARRAY_COUNT(srv_password) },
	{ ID_SERVERTAB_MISC, "MISC", &s_servercontrols.misc, srv_misc, ARRAY_COUNT(srv_misc) },
	{ ID_SERVERTAB_MULTIPLAY, "MULTIPLAY", &s_servercontrols.multiplay, srv_multiplay_nopunkbuster, ARRAY_COUNT(srv_multiplay) }
};



// list of controls used for a skirmish server on own machine
static initlist_t srv_skirmishserver[] =
{
	{ ID_SERVERTAB_CONNECT, "CONNECT", &s_servercontrols.connect, srv_connect, ARRAY_COUNT(srv_connect) },
	{ ID_SERVERTAB_GAMEPLAY, "GAMEPLAY", &s_servercontrols.gameplay, srv_gameplay, ARRAY_COUNT(srv_gameplay) },
	{ ID_SERVERTAB_PHYSICS, "PHYSICS", &s_servercontrols.physics, srv_physics, ARRAY_COUNT(srv_physics) },
	{ ID_SERVERTAB_TEAM, "TEAM", &s_servercontrols.team, srv_team, ARRAY_COUNT(srv_team) },
	{ ID_SERVERTAB_ADMIN, "ADMIN", &s_servercontrols.admin, srv_admin, ARRAY_COUNT(srv_admin) },
	{ ID_SERVERTAB_PASSWORD, "PASSWORD", &s_servercontrols.password, srv_password, ARRAY_COUNT(srv_password) },
	{ ID_SERVERTAB_MISC, "MISC", &s_servercontrols.misc, srv_misc, ARRAY_COUNT(srv_misc) }
};





/*
=================
StartServer_ServerPage_SetControlState
=================
*/
static void StartServer_ServerPage_SetControlState(menucommon_s* c,int type)
{
	// set its appearance
	switch (type) {
	default:
		c->flags &= ~(QMF_HIDDEN|QMF_INACTIVE|QMF_GRAYED);
		break;
	case QMF_HIDDEN:
		c->flags &= ~(QMF_GRAYED);
		c->flags |= (QMF_HIDDEN|QMF_INACTIVE);
		break;
	case QMF_GRAYED:
		c->flags &= ~(QMF_HIDDEN|QMF_INACTIVE);
		c->flags |= (QMF_GRAYED);
	}
}



/*
=================
StartServer_ServerPage_SetControlFromId
=================
*/
static void StartServer_ServerPage_SetControlFromId(int id, int type)
{
	int i;

	// locate control
	for (i = 0; i < s_servercontrols.num_radio; i++) {
		if (s_servercontrols.radio[i].init->id == id)
		{
			StartServer_ServerPage_SetControlState(&s_servercontrols.radio[i].control.generic, type);
			return;
		}
	}

	for (i = 0; i < s_servercontrols.num_field; i++)
	{
		if (s_servercontrols.field[i].init->id == id) {
			StartServer_ServerPage_SetControlState(&s_servercontrols.field[i].control.generic, type);
			return;
		}
	}

	for (i = 0; i < s_servercontrols.num_spin; i++)
	{
		if (s_servercontrols.spin[i].init->id == id) {
			StartServer_ServerPage_SetControlState(&s_servercontrols.spin[i].control.generic, type);
			return;
		}
	}
}



/*
=================
StartServer_ServerPage_UpdateInterface
=================
*/
static void StartServer_ServerPage_UpdateInterface(void)
{
	int i;
	initlist_t* group;
	qboolean lastSet;

	StartServer_SetIconFromGameType(&s_servercontrols.gameTypeIcon, s_scriptdata.gametype, qfalse);

	// clear visible controls
	for (i = 0; i < s_servercontrols.num_radio; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.radio[i].control.generic, 0);
	}

	for (i = 0; i < s_servercontrols.num_field; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.field[i].control.generic, 0);
	}

	for (i = 0; i < s_servercontrols.num_spin; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.spin[i].control.generic, 0);
	}


	// walk item list, setting states as appropriate
	group = &s_servercontrols.pageList[s_servercontrols.activePage];
	lastSet = qfalse;
	for (i = 0; i < group->count; i++) {
		// hide/show control based on previous set value
		// if item is grayed then we avoid changing the lastSet flag by
		// continuing. This prevents a grayed *radio* control from affecting
		// a group of grayed controls
		if ((group->list[i].flags & ITEM_GRAYIF_PREVON) && lastSet) {
			StartServer_ServerPage_SetControlFromId(group->list[i].id, QMF_GRAYED);
			continue;
		}

		if ((group->list[i].flags & ITEM_GRAYIF_PREVOFF) && !lastSet) {
			StartServer_ServerPage_SetControlFromId(group->list[i].id, QMF_GRAYED);
			continue;
		}

		// update status of "most recent" spin control
		if (group->list[i].type == SRVCTRL_RADIO) {
			if (s_servercontrols.radio[ group->list[i].offset ].control.curvalue)
				lastSet = qtrue;
			else
				lastSet = qfalse;
		}
	}

	// enable fight button if possible
	if (!StartServer_CheckFightReady(&s_servercontrols.common)) {
		s_servercontrols.saveScript.generic.flags |= QMF_GRAYED;
	}
	else {
		s_servercontrols.saveScript.generic.flags &= ~QMF_GRAYED;
	}
}



/*
=================
StartServer_ServerPage_Cache
=================
*/
void StartServer_ServerPage_Cache( void )
{
	trap_R_RegisterShaderNoMip( SERVER_SAVE0 );
	trap_R_RegisterShaderNoMip( SERVER_SAVE1 );
}





/*
=================
StartServer_ServerPage_Save
=================
*/
static void StartServer_ServerPage_Save( void )
{
	StartServer_SaveScriptData();
}






/*
=================
StartServer_ServerPage_CheckMinMaxFail
=================
*/
static qboolean StartServer_ServerPage_CheckMinMaxFail( controlinit_t* c )
{
	int value;

	if (c->min == c->max)
		return qfalse;

	value = *(c->number);
	if (value < c->min)
	{
		*(c->number) = c->min;
		return qtrue;
	}
	if (value > c->max)
	{
		*(c->number) = c->max;
		return qtrue;
	}

	return qfalse;
}




/*
=================
StartServer_ServerPage_SpinEvent
=================
*/
static void StartServer_ServerPage_SpinEvent( void* ptr, int event )
{
	int id;
	spincontrol_t* s;

	if (event != QM_ACTIVATED)
		return;

	id = ((menucommon_s*)ptr)->id;

	s = &s_servercontrols.spin[id];

	*(s->init->number) = s_servercontrols.spin[id].control.curvalue;
	StartServer_ServerPage_UpdateInterface();
}




/*
=================
StartServer_ServerPage_RadioEvent
=================
*/
static void StartServer_ServerPage_RadioEvent( void* ptr, int event )
{
	int id;
	radiobuttoncontrol_t* r;

	if (event != QM_ACTIVATED)
		return;

	id = ((menucommon_s*)ptr)->id;

	r = &s_servercontrols.radio[id];

	*(r->init->number) = s_servercontrols.radio[id].control.curvalue;

	StartServer_ServerPage_UpdateInterface();
}



/*
=================
StartServer_ServerPage_FieldEvent
=================
*/
static void StartServer_ServerPage_FieldEvent( void* ptr, int event )
{
	int id;
	textfieldcontrol_t* r;
	controlinit_t* c;

	if (event != QM_LOSTFOCUS)
		return;

	id = ((menucommon_s*)ptr)->id;

	r = &s_servercontrols.field[id];
	c = r->init;

	if (c->type == SRVCTRL_NUMFIELD)
	{
		*(c->number) = atoi(r->control.field.buffer);
		if (StartServer_ServerPage_CheckMinMaxFail(c)) {
			Q_strncpyz(r->control.field.buffer, va("%i", *(c->number)), c->arraysize);
		}
	}
	else if (c->type == SRVCTRL_TEXTFIELD)
	{
		Q_strncpyz(c->array, r->control.field.buffer, c->arraysize);
	}

	StartServer_ServerPage_UpdateInterface();
}




/*
=================
StartServer_ServerPage_SetStatusBar
=================
*/
static void StartServer_ServerPage_SetStatusBar( const char* text )
{
	s_servercontrols.savetime = uis.realtime + STATUSBAR_FADETIME;
	if (text)
		Q_strncpyz(s_servercontrols.statusbar_message, text, MAX_STATUSBAR_TEXT);
}



/*
=================
StartServer_ServerPage_ControlListStatusBar
=================
*/
static void StartServer_ServerPage_ControlListStatusBar(void* ptr)
{
	menucommon_s* m;
	controlinit_t* c;
	int i;

	m = (menucommon_s*)ptr;

	switch (m->type) {
	case MTYPE_RADIOBUTTON:
		c = s_servercontrols.radio[m->id].init;
		break;

	case MTYPE_SPINCONTROL:
		c = s_servercontrols.spin[m->id].init;
		break;

	case MTYPE_FIELD:
		c = s_servercontrols.field[m->id].init;
		break;

	default:
		Com_Printf("Status bar: unsupported control type (%i)\n", m->id);
		return;
	}


	switch (c->id) {
	case ID_SERVER_CONFIGBUG:
		StartServer_ServerPage_SetStatusBar("fixes change of time and frag limits (pre 1.30 only)");
		return;

	case ID_SERVER_PMOVEMSEC:
		StartServer_ServerPage_SetStatusBar("pmove step time, minimum 8 (recommended)");
		return;

	case ID_SERVER_PMOVEFIXED:
		StartServer_ServerPage_SetStatusBar("on = same movement physics for all players");
		return;

	case ID_SERVER_RESPAWN:
		StartServer_ServerPage_SetStatusBar("forces respawn of dead player");
		return;

	case ID_SERVER_ALLOWMAXRATE:
		StartServer_ServerPage_SetStatusBar("limit data sent to a single client per second");
		return;

	case ID_SERVER_MAXRATE:
		StartServer_ServerPage_SetStatusBar("8000 or 10000 are typical, 0 = no limit");
		return;

	case ID_SERVER_DEDICATED:
		StartServer_ServerPage_SetStatusBar("LAN = local game, Internet = announced to master server");
		return;

	case ID_SERVER_SMOOTHCLIENTS:
		StartServer_ServerPage_SetStatusBar("on = server allows a client to predict other player movement");
		return;

	case ID_SERVER_SYNCCLIENTS:
		StartServer_ServerPage_SetStatusBar("on = allows client to record demos, may affect performance");
		return;

	case ID_SERVER_GRAVITY:
		StartServer_ServerPage_SetStatusBar("affects all maps, default = 800");
		return;

	case ID_SERVER_KNOCKBACK:
		StartServer_ServerPage_SetStatusBar("kickback from damage, default = 1000");
		return;

	case ID_SERVER_QUADFACTOR:
		StartServer_ServerPage_SetStatusBar("additional damage caused by quad, default = 3");
		return;

	case ID_SERVER_NETPORT:
		StartServer_ServerPage_SetStatusBar("server listens on this port for client connections");
		return;

	case ID_SERVER_SVFPS:
		StartServer_ServerPage_SetStatusBar("server framerate, default = 20");
		return;

	case ID_SERVER_ALLOWPRIVATECLIENT:
		StartServer_ServerPage_SetStatusBar("reserve some player slots - password required");
		return;

	case ID_SERVER_PRIVATECLIENT:
		StartServer_ServerPage_SetStatusBar("number of reserved slots, reduces max clients");
		return;

	case ID_SERVER_WEAPONRESPAWN:
		StartServer_ServerPage_SetStatusBar("time before weapon respawns, default = 5, TeamDM = 30");
		return;

	case ID_SERVER_ALLOWPASS:
		StartServer_ServerPage_SetStatusBar("all clients must use a password to connect");
		return;

	case ID_SERVER_ALLOWMINPING:
	case ID_SERVER_ALLOWMAXPING:
	case ID_SERVER_MINPING:
	case ID_SERVER_MAXPING:
		StartServer_ServerPage_SetStatusBar("Client ping limit, tested on first connection");
		return;
	}
}






/*
=================
StartServer_ServerPage_InitSpinCtrl
=================
*/
static void StartServer_ServerPage_InitSpinCtrl(controlinit_t* c, int height)
{
	spincontrol_t* s;

	if (s_servercontrols.num_spin == MAX_SERVER_SPIN_CONTROL) {
		Com_Printf("ServerPage: Max spin controls (%i) reached\n", s_servercontrols.num_spin);
		return;
	}

	if (!c->number) {
		Com_Printf("ServerPage: Spin control (id:%i) has no data\n", c->id);
		return;
	}

	if (!c->itemnames) {
		Com_Printf("ServerPage: Spin control (id:%i) has no strings\n", c->id);
		return;
	}

	s = &s_servercontrols.spin[s_servercontrols.num_spin];

	s->init = c;

	s->control.generic.type		= MTYPE_SPINCONTROL;
	s->control.generic.name		= c->title;
	s->control.generic.id		= s_servercontrols.num_spin;	// self reference
	s->control.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT|QMF_RIGHT_JUSTIFY;
	s->control.generic.callback	= StartServer_ServerPage_SpinEvent;
	s->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	s->control.generic.x			= CONTROL_POSX;
	s->control.generic.y			= height;
	s->control.itemnames 			= c->itemnames;

	s->control.curvalue = *(c->number);

	// item is registered but we have to do the init here
	SpinControl_Init(&s->control);

	c->offset = s_servercontrols.num_spin++;
}




/*
=================
StartServer_ServerPage_InitRadioCtrl
=================
*/
static void StartServer_ServerPage_InitRadioCtrl(controlinit_t* c, int height)
{
	radiobuttoncontrol_t* r;

	if (s_servercontrols.num_radio == MAX_SERVER_RADIO_CONTROL) {
		Com_Printf("ServerPage: Max radio controls (%i) reached\n", s_servercontrols.num_radio);
		return;
	}

	if (!c->number) {
		Com_Printf("ServerPage: Radio control (id:%i) has no data\n", c->id);
		return;
	}

	r = &s_servercontrols.radio[s_servercontrols.num_radio];

	r->init = c;

	r->control.generic.type		= MTYPE_RADIOBUTTON;
	r->control.generic.name		= c->title;
	r->control.generic.id		= s_servercontrols.num_radio;	// self reference
	r->control.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT|QMF_RIGHT_JUSTIFY;
	r->control.generic.callback	= StartServer_ServerPage_RadioEvent;
	r->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	r->control.generic.x			= CONTROL_POSX;
	r->control.generic.y			= height;

	r->control.curvalue = *(c->number);

	c->offset = s_servercontrols.num_radio++;
}



/*
=================
StartServer_ServerPage_InitFieldCtrl
=================
*/
static void StartServer_ServerPage_InitFieldCtrl(controlinit_t* c, int height)
{
	textfieldcontrol_t* f;
	int flags;

	if (s_servercontrols.num_field == MAX_SERVER_MFIELD_CONTROL) {
		Com_Printf("ServerPage: Max field controls (%i) reached\n", s_servercontrols.num_field);
		return;
	}

	if (c->type == SRVCTRL_NUMFIELD && !c->number) {
		Com_Printf("ServerPage: NumField control (id:%i) has no data\n", c->id);
		return;
	}

	if (c->type == SRVCTRL_TEXTFIELD && !c->array) {
		Com_Printf("ServerPage: TextField control (id:%i) has no data\n", c->id);
		return;
	}

	f = &s_servercontrols.field[s_servercontrols.num_field];

	f->init = c;

	flags = QMF_SMALLFONT|QMF_PULSEIFFOCUS|QMF_RIGHT_JUSTIFY;
	if (c->type == SRVCTRL_NUMFIELD)
		flags |= QMF_NUMBERSONLY;

	f->control.generic.type       = MTYPE_FIELD;
	f->control.generic.name       = c->title;
	f->control.generic.id		= s_servercontrols.num_field;	// self reference
	f->control.generic.callback	= StartServer_ServerPage_FieldEvent;
	f->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	f->control.generic.flags      = flags;
	f->control.generic.x			= CONTROL_POSX;
	f->control.generic.y			= height;

	f->control.field.widthInChars = c->displaysize;
	f->control.field.maxchars     = c->arraysize;

	// setting of field is deferred until after init

	c->offset = s_servercontrols.num_field++;
}




/*
=================
StartServer_ServerPage_InitControlList
=================
*/
static void StartServer_ServerPage_InitControlList(initlist_t* il)
{
	int i;
	int offset;
	controlinit_t* list;
	controlinit_t* c;
	textfieldcontrol_t* f;
	int size;
	qboolean teamGame;

	list = il->list;
	size = il->count;

	teamGame = qfalse;
	if (s_scriptdata.gametype >= GT_TEAM)
		teamGame = qtrue;

	offset = 0;	// relative to top of list
	for (i = 0; i < size; i++)
	{
		if (teamGame && (list[i].flags & ITEM_NOTEAM_GAME))
			continue;
		if (!teamGame && (list[i].flags & ITEM_TEAM_GAME))
			continue;

		switch (list[i].type) {
		case SRVCTRL_SPIN:
			StartServer_ServerPage_InitSpinCtrl(&list[i], offset);
			break;
		case SRVCTRL_RADIO:
			StartServer_ServerPage_InitRadioCtrl(&list[i], offset);
			break;
		case SRVCTRL_TEXTFIELD:
		case SRVCTRL_NUMFIELD:
			StartServer_ServerPage_InitFieldCtrl(&list[i], offset);
			break;
		case SRVCTRL_BLANK:
			break;
		}

		offset += LINE_HEIGHT;

		if (list[i].flags & ITEM_HALFGAP)
			offset += (LINE_HEIGHT/2);
	}

	// move all controls to middle of screen and init them
	offset = TABCONTROLCENTER_Y - offset/2;
	for (i = 0; i < s_servercontrols.num_radio; i++) {
		s_servercontrols.radio[i].control.generic.y += offset;

		// item is registered but we have to do the init here
		RadioButton_Init(&s_servercontrols.radio[i].control);
	}

	for (i = 0; i < s_servercontrols.num_field; i++) {
		c = s_servercontrols.field[i].init;
		f = &s_servercontrols.field[i];

		f->control.generic.y += offset;

		// item is registered but we have to do the init here
		MenuField_Init(&f->control);

		// deferred init because MenuField_Init() clears text
		if (c->type == SRVCTRL_NUMFIELD) {
			Q_strncpyz(f->control.field.buffer, va("%i", *c->number), c->arraysize);
		}
		else if (c->type == SRVCTRL_TEXTFIELD) {
			Q_strncpyz(f->control.field.buffer, c->array, c->arraysize);
		}
	}

	for (i = 0; i < s_servercontrols.num_spin; i++) {
		s_servercontrols.spin[i].control.generic.y += offset;

		// item is registered but we have to do the init here
		SpinControl_Init(&s_servercontrols.spin[i].control);
	}
}




/*
=================
StartServer_ServerPage_SetTab
=================
*/
static void StartServer_ServerPage_SetTab( int tab )
{
	int i, index;
	initlist_t* controlList;

	if (tab == -1) {
		index = s_servercontrols.activePage;
	}
	else {
		index = -1;
		for (i = 0; i < s_servercontrols.pageListSize; i++) {
			if (s_servercontrols.pageList[i].menutext->generic.id == tab) {
				index = i;
				break;
			}
		}
	}

	// walk all controls and mark them hidden
	for (i = 0; i < s_servercontrols.num_radio; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.radio[i].control.generic, QMF_HIDDEN);
	}

	for (i = 0; i < s_servercontrols.num_field; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.field[i].control.generic, QMF_HIDDEN);
	}

	for (i = 0; i < s_servercontrols.num_spin; i++) {
		StartServer_ServerPage_SetControlState(&s_servercontrols.spin[i].control.generic, QMF_HIDDEN);
	}

	if (index == -1) {
		Com_Printf("Server tab: unknown index (%i)\n", tab);
		return;
	}

	// set the controls for the current tab
	s_servercontrols.activePage = index;
	s_servercontrols.num_radio = 0;
	s_servercontrols.num_field = 0;
	s_servercontrols.num_spin = 0;

	StartServer_ServerPage_InitControlList(&s_servercontrols.pageList[index]);

	// brighten active tab control, remove pulse effect
	for (i = 0; i < s_servercontrols.pageListSize; i++) {
		s_servercontrols.pageList[i].menutext->generic.flags &= ~(QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
		s_servercontrols.pageList[i].menutext->generic.flags |= QMF_PULSEIFFOCUS;
	}

	s_servercontrols.pageList[index].menutext->generic.flags |= (QMF_HIGHLIGHT|QMF_HIGHLIGHT_IF_FOCUS);
	s_servercontrols.pageList[index].menutext->generic.flags &= ~(QMF_PULSEIFFOCUS);
}




/*
=================
StartServer_ServerPage_InitControlsFromScript
=================
*/
static void StartServer_ServerPage_InitControlsFromScript( int tab )
{
	int i;
	radiobuttoncontrol_t* r;
	textfieldcontrol_t* t;
	spincontrol_t* s;

	StartServer_ServerPage_SetTab(tab);

	// set hostname
	Q_strncpyz(s_servercontrols.hostname.field.buffer, s_scriptdata.server.hostname, MAX_HOSTNAME_LENGTH);
}




/*
=================
StartServer_ServerPage_Load
=================
*/
static void StartServer_ServerPage_Load( void )
{
	s_servercontrols.gameType.curvalue = gametype_remap2[s_scriptdata.gametype];

	StartServer_ServerPage_InitControlsFromScript(-1);
}





/*
=================
StartServer_ServerPage_CommonEvent
=================
*/
static void StartServer_ServerPage_CommonEvent( void* ptr, int event )
{
	if( event != QM_ACTIVATED ) {
		return;
	}

	StartServer_ServerPage_Save();
	switch( ((menucommon_s*)ptr)->id )
	{
		case ID_SERVERCOMMON_ITEMS:
			UI_PopMenu();
			break;

		case ID_SERVERCOMMON_BOTS:
			UI_PopMenu();
			UI_PopMenu();
			break;

		case ID_SERVERCOMMON_MAPS:
			UI_PopMenu();
			UI_PopMenu();
			UI_PopMenu();
			break;

		case ID_SERVERCOMMON_BACK:
			UI_PopMenu();
			UI_PopMenu();
			UI_PopMenu();
			UI_PopMenu();
			break;

		case ID_SERVERCOMMON_FIGHT:
			StartServer_CreateServer(NULL);
			break;
	}
}



/*
=================
StartServer_ServerPage_DrawStatusBarText
=================
*/
static void StartServer_ServerPage_DrawStatusBarText( void )
{
	vec4_t color;
	int fade;
	float fadecol;

	if (uis.realtime > s_servercontrols.savetime)
		return;

	if (!s_servercontrols.statusbar_message[0])
		return;

	fade = s_servercontrols.savetime - uis.realtime;

	fadecol = (float)fade/STATUSBAR_FADETIME;

	color[0] = 1.0;
	color[1] = 1.0;
	color[2] = 1.0;
	color[3] = fadecol;

	UI_DrawString(320, s_servercontrols.statusbar_height,
		s_servercontrols.statusbar_message, UI_CENTER|UI_SMALLFONT, color);
}



/*
=================
StartServer_ServerPage_MenuKey
=================
*/
static sfxHandle_t StartServer_ServerPage_MenuKey( int key )
{
	switch (key)
	{
		case K_MOUSE2:
		case K_ESCAPE:
			StartServer_ServerPage_Save();
			UI_PopMenu();
			UI_PopMenu();
			UI_PopMenu();
			break;
	}

	return ( Menu_DefaultKey( &s_servercontrols.menu, key ) );
}





/*
=================
StartServer_ServerPage_SaveScript
=================
*/
static qboolean StartServer_ServerPage_SaveScript( const char* filename )
{
	UI_PopMenu();
	if (StartServer_CreateServer( filename )) {
		StartServer_ServerPage_SetStatusBar("Saved!");
		return qtrue;
	}
	else {
		StartServer_ServerPage_SetStatusBar(StartServer_GetLastScriptError());
		return qfalse;
	}
}


/*
=================
StartServer_ServerPage_LoadScript
=================
*/
static qboolean StartServer_ServerPage_LoadScript( const char* filename )
{
	UI_PopMenu();

	if (StartServer_LoadFromConfig(filename))
	{
		// so far we've only loaded the cvars, now we need
		// to refresh the stored data
		StartServer_LoadScriptDataFromType(s_scriptdata.gametype);

		StartServer_ServerPage_Load();
		StartServer_ServerPage_UpdateInterface();

		StartServer_ServerPage_SetStatusBar("Loaded!");
	}
	return qtrue;
}





/*
=================
StartServer_ServerPage_Event
=================
*/
static void StartServer_ServerPage_Event( void* ptr, int event )
{
	int value;
	int id;

	id = ((menucommon_s*)ptr)->id;
	switch (id) {
		case ID_SERVER_GAMETYPE:
			if( event != QM_ACTIVATED ) {
				return;
			}

			StartServer_SaveScriptData();
			StartServer_LoadScriptDataFromType(gametype_remap[s_servercontrols.gameType.curvalue]);

			StartServer_ServerPage_InitControlsFromScript(-1);	// gametype is already accurate
			StartServer_ServerPage_UpdateInterface();
			break;

		case ID_SERVER_HOSTNAME:
			if (event != QM_LOSTFOCUS)
				return;

			// store hostname
			Q_strncpyz(s_scriptdata.server.hostname, s_servercontrols.hostname.field.buffer, MAX_HOSTNAME_LENGTH);
			break;

		case ID_SERVER_SAVE:
			if( event != QM_ACTIVATED ) {
				return;
			}
			StartServer_ServerPage_Save();
			UI_ConfigMenu("SAVE SCRIPT", qfalse, StartServer_ServerPage_SaveScript);
			break;

		case ID_SERVER_LOAD:
			if( event != QM_ACTIVATED ) {
				return;
			}
			StartServer_ServerPage_Save();
			UI_ConfigMenu("LOAD SCRIPT", qtrue, StartServer_ServerPage_LoadScript);
			break;

		case ID_SERVERTAB_CONNECT:
		case ID_SERVERTAB_GAMEPLAY:
		case ID_SERVERTAB_TEAM:
		case ID_SERVERTAB_ADMIN:
		case ID_SERVERTAB_MISC:
		case ID_SERVERTAB_MULTIPLAY:
			if( event != QM_ACTIVATED ) {
				return;
			}
			StartServer_ServerPage_SetTab(id);
			StartServer_ServerPage_UpdateInterface();
			break;
	}
}


/*
=================
StartServer_ServerPage_TabEvent
=================
*/
static void StartServer_ServerPage_TabEvent( void* ptr, int event )
{
	int id;

	if( event != QM_ACTIVATED ) {
		return;
	}

	id = ((menucommon_s*)ptr)->id;
	StartServer_ServerPage_SetTab(id);
	StartServer_ServerPage_UpdateInterface();
}





/*
=================
StartServer_ServerPage_MenuDraw
=================
*/
static void StartServer_ServerPage_MenuDraw(void)
{
	if (uis.firstdraw) {
		StartServer_ServerPage_Load();
		StartServer_ServerPage_UpdateInterface();
	}

	StartServer_BackgroundDraw(qfalse);

	// draw the controls
	Menu_Draw(&s_servercontrols.menu);

	// if we have no server controls, say so
	if (s_servercontrols.num_spin == 0 && s_servercontrols.num_radio == 0 &&
		s_servercontrols.num_field == 0)
	{
		UI_DrawString(CONTROL_POSX, TABCONTROLCENTER_Y - LINE_HEIGHT/2,
			"<no controls>", UI_RIGHT|UI_SMALLFONT, text_color_disabled);
	}

	StartServer_ServerPage_DrawStatusBarText();
}




/*
=================
StartServer_ServerPage_StatusBar
=================
*/
static void StartServer_ServerPage_StatusBar(void* ptr)
{
	switch (((menucommon_s*)ptr)->id) {
	case ID_SERVER_SAVE:
		StartServer_ServerPage_SetStatusBar("Create a script for use with \\exec");
		break;

	case ID_SERVER_LOAD:
		StartServer_ServerPage_SetStatusBar("Load a previously saved UIE script");
		break;
	};
}




/*
=================
StartServer_ServerPage_MenuInit
=================
*/
void StartServer_ServerPage_MenuInit(void)
{
	menuframework_s* menuptr;
	int y, y_base;
	int i;
	int style;
	float scale;

	memset(&s_servercontrols, 0, sizeof(servercontrols_t));

	StartServer_ServerPage_Cache();

	menuptr = &s_servercontrols.menu;

	menuptr->key = StartServer_ServerPage_MenuKey;
	menuptr->wrapAround = qtrue;
	menuptr->fullscreen = qtrue;
	menuptr->draw = StartServer_ServerPage_MenuDraw;

	StartServer_CommonControls_Init(menuptr, &s_servercontrols.common, StartServer_ServerPage_CommonEvent, COMMONCTRL_SERVER);


	//
	// the user controlled server params
	//

	y = GAMETYPEROW_Y;
	s_servercontrols.gameType.generic.type		= MTYPE_SPINCONTROL;
	s_servercontrols.gameType.generic.id		= ID_SERVER_GAMETYPE;
	s_servercontrols.gameType.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_servercontrols.gameType.generic.callback	= StartServer_ServerPage_Event;
	s_servercontrols.gameType.generic.x			= GAMETYPECOLUMN_X;
	s_servercontrols.gameType.generic.y			= y;
	s_servercontrols.gameType.generic.name		= "Game Type:";
	s_servercontrols.gameType.itemnames			= gametype_items;

	s_servercontrols.gameTypeIcon.generic.type  = MTYPE_BITMAP;
	s_servercontrols.gameTypeIcon.generic.flags = QMF_INACTIVE;
	s_servercontrols.gameTypeIcon.generic.x	 = GAMETYPEICON_X;
	s_servercontrols.gameTypeIcon.generic.y	 = y;
	s_servercontrols.gameTypeIcon.width  	     = 32;
	s_servercontrols.gameTypeIcon.height  	     = 32;

	y += LINE_HEIGHT;
	s_servercontrols.hostname.generic.type       = MTYPE_FIELD;
	s_servercontrols.hostname.generic.name       = "Hostname:";
	s_servercontrols.hostname.generic.flags      = QMF_SMALLFONT|QMF_PULSEIFFOCUS;
	s_servercontrols.hostname.generic.x          = GAMETYPECOLUMN_X;
	s_servercontrols.hostname.generic.y	        = y;
	s_servercontrols.hostname.generic.id	        = ID_SERVER_HOSTNAME;
	s_servercontrols.hostname.generic.callback	= StartServer_ServerPage_Event;
	s_servercontrols.hostname.field.widthInChars = 32;
	s_servercontrols.hostname.field.maxchars     = MAX_HOSTNAME_LENGTH;


	s_servercontrols.num_radio = 0;
	s_servercontrols.num_field = 0;
	s_servercontrols.num_spin = 0;

	y += LINE_HEIGHT;

	s_servercontrols.saveScript.generic.type  = MTYPE_BITMAP;
	s_servercontrols.saveScript.generic.name  = SERVER_SAVE0;
	s_servercontrols.saveScript.generic.flags = QMF_PULSEIFFOCUS;
	s_servercontrols.saveScript.generic.x	   =  320 - 128;
	s_servercontrols.saveScript.generic.y	   = 480 - 64;
	s_servercontrols.saveScript.generic.id	   = ID_SERVER_SAVE;
	s_servercontrols.saveScript.generic.callback = StartServer_ServerPage_Event;
	s_servercontrols.saveScript.generic.statusbar = StartServer_ServerPage_StatusBar;
	s_servercontrols.saveScript.width = 128;
	s_servercontrols.saveScript.height = 64;
	s_servercontrols.saveScript.focuspic = SERVER_SAVE1;

	s_servercontrols.loadScript.generic.type  = MTYPE_BITMAP;
	s_servercontrols.loadScript.generic.name  = SERVER_LOAD0;
	s_servercontrols.loadScript.generic.flags = QMF_PULSEIFFOCUS;
	s_servercontrols.loadScript.generic.x	   =  320;
	s_servercontrols.loadScript.generic.y	   = 480 - 64;
	s_servercontrols.loadScript.generic.id	   = ID_SERVER_LOAD;
	s_servercontrols.loadScript.generic.callback = StartServer_ServerPage_Event;
	s_servercontrols.loadScript.generic.statusbar = StartServer_ServerPage_StatusBar;
	s_servercontrols.loadScript.width = 128;
	s_servercontrols.loadScript.height = 64;
	s_servercontrols.loadScript.focuspic = SERVER_LOAD1;

	s_servercontrols.statusbar_height = 480 - 64 - LINE_HEIGHT;

	// init the tabbed control list for the page
	s_servercontrols.activePage = 0;
	s_servercontrols.pageList = srv_skirmishserver;
	s_servercontrols.pageListSize = ARRAY_COUNT(srv_skirmishserver);
	if (s_scriptdata.multiplayer) {
      if (uis.punkbuster) {
   		s_servercontrols.pageList = srv_multiplayerserver;
	   	s_servercontrols.pageListSize = ARRAY_COUNT(srv_multiplayerserver);
      }
      else {
   		s_servercontrols.pageList = srv_multiplayerserver_nopunkbuster;
	   	s_servercontrols.pageListSize = ARRAY_COUNT(srv_multiplayerserver_nopunkbuster);
      }
	}

	style = UI_RIGHT|UI_MEDIUMFONT;
	scale = UI_ProportionalSizeScale(style);
	y_base = TABCONTROLCENTER_Y - s_servercontrols.pageListSize*PROP_HEIGHT*scale/2;

	for (i = 0; i < s_servercontrols.pageListSize; i++)
	{
		s_servercontrols.pageList[i].menutext->generic.type     = MTYPE_PTEXT;
		s_servercontrols.pageList[i].menutext->generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
		s_servercontrols.pageList[i].menutext->generic.id	     = s_servercontrols.pageList[i].id;
		s_servercontrols.pageList[i].menutext->generic.callback = StartServer_ServerPage_TabEvent;
		s_servercontrols.pageList[i].menutext->generic.x	     = 180;
		s_servercontrols.pageList[i].menutext->generic.y	     = y_base + i*PROP_HEIGHT*scale;
		s_servercontrols.pageList[i].menutext->string			= s_servercontrols.pageList[i].title;
		s_servercontrols.pageList[i].menutext->style			= style;
		s_servercontrols.pageList[i].menutext->color			= color_red;

		Menu_AddItem( menuptr, s_servercontrols.pageList[i].menutext);
	}

	// register controls
	Menu_AddItem( menuptr, &s_servercontrols.gameType);
	Menu_AddItem( menuptr, &s_servercontrols.gameTypeIcon);
	Menu_AddItem( menuptr, &s_servercontrols.hostname);

	// we only need the QMF_NODEFAULTINIT flag to get these controls
	// registered. Type is added later
	for (i = 0; i < MAX_SERVER_RADIO_CONTROL; i++) {
		s_servercontrols.radio[i].control.generic.type = MTYPE_RADIOBUTTON;
		s_servercontrols.radio[i].control.generic.flags = QMF_NODEFAULTINIT|QMF_HIDDEN|QMF_INACTIVE;
		Menu_AddItem( menuptr, &s_servercontrols.radio[i].control);
	}

	for (i = 0; i < MAX_SERVER_MFIELD_CONTROL; i++) {
		s_servercontrols.field[i].control.generic.type = MTYPE_FIELD;
		s_servercontrols.field[i].control.generic.flags = QMF_NODEFAULTINIT|QMF_HIDDEN|QMF_INACTIVE;
		Menu_AddItem( menuptr, &s_servercontrols.field[i].control);
	}

	for (i = 0; i < MAX_SERVER_SPIN_CONTROL; i++) {
		s_servercontrols.spin[i].control.generic.type = MTYPE_SPINCONTROL;
		s_servercontrols.spin[i].control.generic.flags = QMF_NODEFAULTINIT|QMF_HIDDEN|QMF_INACTIVE;
		Menu_AddItem( menuptr, &s_servercontrols.spin[i].control);
	}

	Menu_AddItem( menuptr, &s_servercontrols.saveScript);
	Menu_AddItem( menuptr, &s_servercontrols.loadScript);

	// control init is done on uis.firstdraw
	UI_PushMenu( &s_servercontrols.menu );
}

