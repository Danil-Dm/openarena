// Copyright (C) 1999-2000 Id Software, Inc.
//
/*
=============================================================================

START SERVER MENU *****

=============================================================================
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


#define SERVER_SAVE0 "menu/art/save_0"
#define SERVER_SAVE1 "menu/art/save_1"
#define SERVER_LOAD0 "menu/art/load_0"
#define SERVER_LOAD1 "menu/art/load_1"



#define SERVERCOLUMN_X GAMETYPECOLUMN_X



enum {
	SRVCTRL_SPIN,
	SRVCTRL_RADIO,
	SRVCTRL_TEXTFIELD,
	SRVCTRL_NUMFIELD,
	SRVCTRL_BLANK
};


enum {
	SCRPOS_LEFT,
	SCRPOS_MIDDLE,
	SCRPOS_RIGHT,
	SCRPOS_LEFTOFFSET,
	SCRPOS_MIDDLEOFFSET,
	SCRPOS_RIGHTOFFSET,

	SCRPOS_COUNT
};



// list of created controls on page
typedef struct controlinit_s {
	int type;	// SRVCTRL_*
	int id;		// control id ID_SERVER_*
	int screenpos;	// SCRPOS_*

	char* title;	// text describing control

	// used by RADIO, NUMFIELD, or SPIN
	// min, max ignored if identical
	int* number;

	// used by NUMFIELD
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

	radiobuttoncontrol_t radio[MAX_SERVER_RADIO_CONTROL];
	textfieldcontrol_t field[MAX_SERVER_MFIELD_CONTROL];
	spincontrol_t spin[MAX_SERVER_SPIN_CONTROL];

	int num_radio;
	int num_field;
	int num_spin;

	int control_height[SCRPOS_COUNT];

	menubitmap_s saveScript;
	menubitmap_s loadScript;

	int statusbar_height;
	int savetime;
	char statusbar_message[MAX_STATUSBAR_TEXT];
} servercontrols_t;




servercontrols_t s_servercontrols;



//
// static data used by controls
//


static const char *dedicated_list[] = {
	"No",	// SRVDED_OFF
	"LAN",	// SRVDED_LAN
	"Internet",	// SRVDED_INTERNET
	0
};





//
// controls on server page
//

/*
	Grouping controls: related columns (e.g. SCRPOS_LEFT and SCRPOS_LEFTOFFSET)
	will always use the lower of the two y heights for the next entry of that type

	If you want this effect:

	<LEFT>       <LEFTOFFSET>
	CONTROL#1    CONTROL#2
				 CONTROL#3
				 CONTROL#4
	CONTROL#5

	then you must list those controls in this array in numerical order.

	The LEFT, MIDDLE and RIGHT column types are independent of each other,
	and may need padding, use SRVCTRL_BLANK.
*/
static controlinit_t InitControls[] = {
	{ SRVCTRL_TEXTFIELD, ID_SERVER_HOSTNAME, SCRPOS_MIDDLE,
		"Hostname:", NULL, 0, 0, s_scriptdata.server.hostname, 32, MAX_HOSTNAME_LENGTH, NULL },

	// controls on left side of page

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWWARMUP, SCRPOS_LEFT,
		"Allow warmup:", &s_scriptdata.server.allowWarmup, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_WARMUP, SCRPOS_LEFTOFFSET,
		"seconds:", &s_scriptdata.server.warmupTime, 0, 0, NULL, 4, 4, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_RESPAWN, SCRPOS_LEFT,
		"Respawn time:", &s_scriptdata.server.forceRespawn, 0, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWVOTE, SCRPOS_LEFT,
		"Allow voting:", &s_scriptdata.server.allowvote, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWPASS, SCRPOS_LEFT,
		"Private server:", &s_scriptdata.server.allowpass, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_TEXTFIELD, ID_SERVER_PASSWORD, SCRPOS_LEFTOFFSET,
		"password:", NULL, 0, 0, s_scriptdata.server.password, 10, MAX_PASSWORD_LENGTH, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_PMOVEFIXED, SCRPOS_LEFT,
		"Pmove fixed:", &s_scriptdata.server.pmove_fixed, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_PMOVEMSEC, SCRPOS_LEFTOFFSET,
		"msec:", &s_scriptdata.server.pmove_msec, 8, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWMAXRATE, SCRPOS_LEFT,
		"Server maxrate:", &s_scriptdata.server.allowmaxrate, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_MAXRATE, SCRPOS_LEFTOFFSET,
		"bytes/s:", &s_scriptdata.server.maxrate, 0, 0, NULL, 6, 6, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWDOWNLOAD, SCRPOS_LEFT,
		"Allow download:", &s_scriptdata.server.allowdownload, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWMINPING, SCRPOS_LEFT,
		"Minimum ping:", &s_scriptdata.server.allowMinPing, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_MINPING, SCRPOS_LEFTOFFSET,
		"ping:", &s_scriptdata.server.minPing, 0, 999, NULL, 4, 4, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_ALLOWMAXPING, SCRPOS_LEFT,
		"Maximum ping:", &s_scriptdata.server.allowMaxPing, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_NUMFIELD, ID_SERVER_MAXPING, SCRPOS_LEFTOFFSET,
		"ping:", &s_scriptdata.server.maxPing, 0, 999, NULL, 4, 4, NULL },

	// controls on right side of page

	{ SRVCTRL_BLANK, 0, SCRPOS_RIGHT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_RIGHT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_PURE, SCRPOS_RIGHT,
		"Pure server:", &s_scriptdata.server.pure, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_SMOOTHCLIENTS, SCRPOS_RIGHT,
		"Smooth clients:", &s_scriptdata.server.smoothclients, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_SYNCCLIENTS, SCRPOS_RIGHT,
		"Sync clients:", &s_scriptdata.server.syncClients, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_RIGHT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_CONFIGBUG, SCRPOS_RIGHT,
		"Fix config bug:", &s_scriptdata.server.preventConfigBug, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_RIGHT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_FRIENDLY, SCRPOS_RIGHT,
		"Friendly fire:", &s_scriptdata.server.friendlyFire, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_AUTOJOIN, SCRPOS_RIGHT,
		"Team auto join:", &s_scriptdata.server.autoJoin, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_RADIO, ID_SERVER_TEAMBALANCE, SCRPOS_RIGHT,
		"Team balance:", &s_scriptdata.server.teamBalance, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL },

	{ SRVCTRL_BLANK, 0, SCRPOS_LEFT,
		NULL, NULL, 0, 0, NULL, 0, 0, NULL }
};


static int InitControls_Size = sizeof(InitControls)/sizeof(InitControls[0]);




// additional controls shown in multiplayer version of this page

static controlinit_t InitMultiControls[] = {
	{ SRVCTRL_SPIN, ID_SERVER_DEDICATED, SCRPOS_MIDDLE,
		"Dedicated server:", &s_scriptdata.server.dedicatedServer, 0, 0, NULL, 0, 0, dedicated_list },

	{ SRVCTRL_NUMFIELD, ID_SERVER_INACTIVITY, SCRPOS_MIDDLE,
		"Inactivity timeout:", &s_scriptdata.server.inactivityTime, 0, 999, NULL, 3, 3, NULL }
};


static int InitMultiControls_Size = sizeof(InitMultiControls)/sizeof(InitMultiControls[0]);



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
	menucommon_s* c;
	int i;

	// locate control

	c = NULL;
	for (i = 0; i < s_servercontrols.num_radio; i++) {
		if (s_servercontrols.radio[i].init->id == id)
		{
			c = &s_servercontrols.radio[i].control.generic;
			break;
		}
	}

	for (i = s_servercontrols.num_field - 1; i >= 0 && !c; i--)
	{
		if (s_servercontrols.field[i].init->id == id) {
			c = &s_servercontrols.field[i].control.generic;
		}
	}

	for (i = s_servercontrols.num_spin - 1; i >= 0 && !c; i--)
	{
		if (s_servercontrols.spin[i].init->id == id) {
			c = &s_servercontrols.spin[i].control.generic;
		}
	}

	if (!c)
		return;

	StartServer_ServerPage_SetControlState(c, type);
}


/*
=================
StartServer_ServerPage_UpdateInterface
=================
*/
static void StartServer_ServerPage_UpdateInterface(void)
{
	int flag;

	flag = 0;
	if (s_scriptdata.gametype < GT_TEAM) {
		flag = QMF_HIDDEN;
	}
	StartServer_ServerPage_SetControlFromId(ID_SERVER_FRIENDLY, flag);
	StartServer_ServerPage_SetControlFromId(ID_SERVER_AUTOJOIN, flag);
	StartServer_ServerPage_SetControlFromId(ID_SERVER_TEAMBALANCE, flag);

	StartServer_SetIconFromGameType(&s_servercontrols.gameTypeIcon, s_scriptdata.gametype, qfalse);

	if (s_scriptdata.server.pmove_fixed)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_PMOVEMSEC, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_PMOVEMSEC, QMF_HIDDEN);

	if (s_scriptdata.server.allowmaxrate)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MAXRATE, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MAXRATE, QMF_HIDDEN);

	if (s_scriptdata.server.allowpass)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_PASSWORD, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_PASSWORD, QMF_HIDDEN);

	if (s_scriptdata.server.allowWarmup)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_WARMUP, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_WARMUP, QMF_HIDDEN);

	if (s_scriptdata.server.allowMinPing)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MINPING, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MINPING, QMF_HIDDEN);

	if (s_scriptdata.server.allowMaxPing)
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MAXPING, 0);
	else
		StartServer_ServerPage_SetControlFromId(ID_SERVER_MAXPING, QMF_HIDDEN);

	// enable fight button if possible
	StartServer_CheckFightReady(&s_servercontrols.common);
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
StartServer_ServerPage_InitControlsFromScript
=================
*/
static void StartServer_ServerPage_InitControlsFromScript( void )
{
	int i;
	radiobuttoncontrol_t* r;
	textfieldcontrol_t* t;

	// set radio controls
	for (i = 0; i < s_servercontrols.num_radio; i++)
	{
		r = &s_servercontrols.radio[i];
		r->control.curvalue = *(r->init->number);
	}

	// set text field controls
	for (i = 0; i < s_servercontrols.num_field; i++)
	{
		t = &s_servercontrols.field[i];
		if (t->init->type == SRVCTRL_NUMFIELD) {
			Q_strncpyz(t->control.field.buffer, va("%i",*t->init->number), t->init->arraysize);
		}
		else if (t->init->type == SRVCTRL_TEXTFIELD) {
			Q_strncpyz(t->control.field.buffer, t->init->array, t->init->arraysize);
		}

		t->control.field.cursor = 0;
		t->control.field.scroll = 0;
	}
}




/*
=================
StartServer_ServerPage_Load
=================
*/
static void StartServer_ServerPage_Load( void )
{
	s_servercontrols.gameType.curvalue = gametype_remap2[s_scriptdata.gametype];

	StartServer_ServerPage_InitControlsFromScript();
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

	switch (((menucommon_s*)ptr)->id) {
		case ID_SERVER_GAMETYPE:
			if( event != QM_ACTIVATED ) {
				return;
			}

			StartServer_SaveScriptData();
			StartServer_LoadScriptDataFromType(gametype_remap[s_servercontrols.gameType.curvalue]);
			StartServer_ServerPage_InitControlsFromScript();

			StartServer_ServerPage_UpdateInterface();
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
	}
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
/*	case ID_SERVER_SAVE:
		StartServer_ServerPage_SetStatusBar("Create a script for later use with \\exec");
		break;*/

	case ID_SERVER_LOAD:
		StartServer_ServerPage_SetStatusBar("Load a previously saved UIE script");
		break;
	};
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
		StartServer_ServerPage_SetStatusBar("prevents unexpected change of time and frag limits");
		return;

	case ID_SERVER_PMOVEMSEC:
		StartServer_ServerPage_SetStatusBar("pmove step time, minimum 8 (recommended)");
		return;

	case ID_SERVER_PMOVEFIXED:
		StartServer_ServerPage_SetStatusBar("on = same movement physics for all players");
		return;

	case ID_SERVER_ALLOWMAXRATE:
		StartServer_ServerPage_SetStatusBar("max quantity of data sent to a single client");
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
StartServer_ServerPage_GetControlX
=================
*/
static int StartServer_ServerPage_GetControlX(int type)
{
	switch (type) {
	case SCRPOS_LEFT:
		return 160;

	default:
	case SCRPOS_MIDDLE:
		return SERVERCOLUMN_X;

	case SCRPOS_RIGHT:
		return 520;

	case SCRPOS_LEFTOFFSET:
		return 160 + 17*SMALLCHAR_WIDTH;

	case SCRPOS_MIDDLEOFFSET:
		return SERVERCOLUMN_X + 17*SMALLCHAR_WIDTH;

	case SCRPOS_RIGHTOFFSET:
		return 520 + 17*SMALLCHAR_WIDTH;
	}
}



/*
=================
StartServer_ServerPage_GetControlY
=================
*/
static int StartServer_ServerPage_GetControlY(int type)
{
	int height;
	int* cy;

	cy = s_servercontrols.control_height;

	switch (type) {
	case SCRPOS_LEFT:
		if (cy[SCRPOS_LEFTOFFSET] > cy[SCRPOS_LEFT])
			cy[SCRPOS_LEFT] = cy[SCRPOS_LEFTOFFSET];
		break;

	case SCRPOS_MIDDLE:
		if (cy[SCRPOS_MIDDLEOFFSET] > cy[SCRPOS_MIDDLE])
			cy[SCRPOS_MIDDLE] = cy[SCRPOS_MIDDLEOFFSET];
		break;

	case SCRPOS_RIGHT:
		if (cy[SCRPOS_RIGHTOFFSET] > cy[SCRPOS_RIGHT])
			cy[SCRPOS_RIGHT] = cy[SCRPOS_RIGHTOFFSET];
		break;
	}

	height = cy[type];

	switch (type) {
	case SCRPOS_LEFT:
		cy[SCRPOS_LEFTOFFSET] = cy[SCRPOS_LEFT];
		break;

	case SCRPOS_MIDDLE:
		cy[SCRPOS_MIDDLEOFFSET] = cy[SCRPOS_MIDDLE];
		break;

	case SCRPOS_RIGHT:
		cy[SCRPOS_RIGHTOFFSET] = cy[SCRPOS_RIGHT];
		break;
	}

	// set position for next use
	cy[type] += LINE_HEIGHT;

	return height;
}




/*
=================
StartServer_ServerPage_InitSpinCtrl
=================
*/
static void StartServer_ServerPage_InitSpinCtrl(controlinit_t* c)
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
	s->control.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s->control.generic.callback	= StartServer_ServerPage_SpinEvent;
	s->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	s->control.generic.x			= StartServer_ServerPage_GetControlX(c->screenpos);
	s->control.generic.y			= StartServer_ServerPage_GetControlY(c->screenpos);
	s->control.itemnames 			= c->itemnames;

	s->control.curvalue = *(c->number);

	s_servercontrols.num_spin++;
}




/*
=================
StartServer_ServerPage_InitRadioCtrl
=================
*/
static void StartServer_ServerPage_InitRadioCtrl(controlinit_t* c)
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
	r->control.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	r->control.generic.callback	= StartServer_ServerPage_RadioEvent;
	r->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	r->control.generic.x			= StartServer_ServerPage_GetControlX(c->screenpos);
	r->control.generic.y			= StartServer_ServerPage_GetControlY(c->screenpos);

	r->control.curvalue = *(c->number);

	s_servercontrols.num_radio++;
}



/*
=================
StartServer_ServerPage_InitFieldCtrl
=================
*/
static void StartServer_ServerPage_InitFieldCtrl(controlinit_t* c)
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

	flags = QMF_SMALLFONT|QMF_PULSEIFFOCUS;
	if (c->type == SRVCTRL_NUMFIELD)
		flags |= QMF_NUMBERSONLY;

	f->control.generic.type       = MTYPE_FIELD;
	f->control.generic.name       = c->title;
	f->control.generic.id		= s_servercontrols.num_field;	// self reference
	f->control.generic.callback	= StartServer_ServerPage_FieldEvent;
	f->control.generic.statusbar	= StartServer_ServerPage_ControlListStatusBar;
	f->control.generic.flags      = flags;
	f->control.generic.x			= StartServer_ServerPage_GetControlX(c->screenpos);
	f->control.generic.y			= StartServer_ServerPage_GetControlY(c->screenpos);

	f->control.field.widthInChars = c->displaysize;
	f->control.field.maxchars     = c->arraysize;

	if (c->type == SRVCTRL_NUMFIELD) {
		Q_strncpyz(f->control.field.buffer, va("%i", *c->number), c->arraysize);
	}
	else if (c->type == SRVCTRL_TEXTFIELD) {
		Q_strncpyz(f->control.field.buffer, c->array, c->arraysize);
	}

	s_servercontrols.num_field++;
}




/*
=================
StartServer_ServerPage_InitControlList
=================
*/
static void StartServer_ServerPage_InitControlList(controlinit_t* list, int size)
{
	int i;

	for (i = 0; i < size; i++)
	{
		switch (list[i].type) {
		case SRVCTRL_SPIN:
			StartServer_ServerPage_InitSpinCtrl(&list[i]);
			break;
		case SRVCTRL_RADIO:
			StartServer_ServerPage_InitRadioCtrl(&list[i]);
			break;
		case SRVCTRL_TEXTFIELD:
		case SRVCTRL_NUMFIELD:
			StartServer_ServerPage_InitFieldCtrl(&list[i]);
			break;
		case SRVCTRL_BLANK:
			s_servercontrols.control_height[list[i].screenpos] += LINE_HEIGHT;
			break;
		}
	}
}



/*
=================
StartServer_ServerPage_MenuInit
=================
*/
void StartServer_ServerPage_MenuInit(void)
{
	menuframework_s* menuptr;
	int y, ymax;
	int i;

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


	s_servercontrols.num_radio = 0;
	s_servercontrols.num_field = 0;
	s_servercontrols.num_spin = 0;

	y += LINE_HEIGHT;

	for (i = 0; i < SCRPOS_COUNT; i++)
	{
		s_servercontrols.control_height[i] = y;
	}

	StartServer_ServerPage_InitControlList(InitControls, InitControls_Size);
	if (s_scriptdata.multiplayer) {
		ymax = 0;
		for (i = 0; i < SCRPOS_COUNT; i++)
			if (s_servercontrols.control_height[i] > ymax)
				ymax = s_servercontrols.control_height[i];

		for (i = 0; i < SCRPOS_COUNT; i++)
		{
			s_servercontrols.control_height[i] = ymax;
		}

		StartServer_ServerPage_InitControlList(InitMultiControls, InitMultiControls_Size);
	}

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



	
	// register controls

	Menu_AddItem( menuptr, &s_servercontrols.gameType);
	Menu_AddItem( menuptr, &s_servercontrols.gameTypeIcon);

	for (i = 0; i < s_servercontrols.num_radio; i++) {
		Menu_AddItem( menuptr, &s_servercontrols.radio[i].control);
	}

	for (i = 0; i < s_servercontrols.num_field; i++)
		Menu_AddItem( menuptr, &s_servercontrols.field[i].control);

	for (i = 0; i < s_servercontrols.num_spin; i++)
		Menu_AddItem( menuptr, &s_servercontrols.spin[i].control);

	Menu_AddItem( menuptr, &s_servercontrols.saveScript);
	Menu_AddItem( menuptr, &s_servercontrols.loadScript);

	UI_PushMenu( &s_servercontrols.menu );
}

