/*
===========================================================================
Copyright (C) 1999-2005 Id Software, Inc.

This file is part of Quake III Arena source code.

Quake III Arena source code is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

Quake III Arena source code is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Quake III Arena source code; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/
//
/*
=======================================================================

USER INTERFACE MAIN

=======================================================================
*/


#include "ui_local.h"



/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .qvm file
================
*/
intptr_t vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
	switch ( command ) {
	case UI_GETAPIVERSION:
		return UI_API_VERSION;

	case UI_INIT:
		UI_Init();
		return 0;

	case UI_SHUTDOWN:
		UI_Shutdown();
		return 0;

	case UI_KEY_EVENT:
		UI_KeyEvent( arg0, arg1 );
		return 0;

	case UI_MOUSE_EVENT:
		UI_MouseEvent( arg0, arg1 );
		return 0;

	case UI_REFRESH:
		UI_Refresh( arg0 );
		return 0;

	case UI_IS_FULLSCREEN:
		return UI_IsFullscreen();

	case UI_SET_ACTIVE_MENU:
		UI_SetActiveMenu( arg0 );
		return 0;

	case UI_CONSOLE_COMMAND:
		return UI_ConsoleCommand(arg0);

	case UI_DRAW_CONNECT_SCREEN:
		UI_DrawConnectScreen( arg0 );
		return 0;
	case UI_HASUNIQUECDKEY:				// mod authors need to observe this
		return qtrue;  // bk010117 - change this to qfalse for mods!
	}

	return -1;
}


/*
================
cvars
================
*/

typedef struct {
	vmCvar_t	*vmCvar;
	char		*cvarName;
	char		*defaultString;
	int			cvarFlags;
} cvarTable_t;

vmCvar_t	Gop_n0;
vmCvar_t	Gop_n1;
vmCvar_t	Gop_n2;
vmCvar_t	Gop_n3;
vmCvar_t	Gop_n4;
vmCvar_t	Gop_n5;
vmCvar_t	Gop_n6;
vmCvar_t	Gop_v3;
vmCvar_t	Gop_ne1;
vmCvar_t	Gop_ne2;
vmCvar_t	Gop_b1;
vmCvar_t	Gop_b2;
vmCvar_t	ui_zplmd;
vmCvar_t	ui_nomapicons;
vmCvar_t	MusicplayerMusic;
vmCvar_t	skinsmultiplayer;
vmCvar_t	onandroid;
vmCvar_t	IsGame;
vmCvar_t	onnextarena;
vmCvar_t	ui_loaded;
vmCvar_t	ui_char;
vmCvar_t	ui_actionmenu;
vmCvar_t	ui_custommaps;
vmCvar_t	ui_gamemodesall;
vmCvar_t	ui_mslegsmodel;
vmCvar_t	ui_mslegsskin;
vmCvar_t	ui_msheadmodel;
vmCvar_t	ui_msheadskin;
vmCvar_t	ui_msmodel;
vmCvar_t	ui_msskin;
vmCvar_t	ui_legsmodel;
vmCvar_t	ui_headmodelt;
vmCvar_t	ui_headmodel;
vmCvar_t	ui_coop;
vmCvar_t	ui_cwriteb;
vmCvar_t	ui_backcolor;
vmCvar_t	ui_mapiconsizeq;
vmCvar_t	ui_skinprice;
vmCvar_t	ui_maprowsq;
vmCvar_t	ui_mapcolsq;
vmCvar_t	ui_cwritev;
vmCvar_t	ui_skinsunlocked;
vmCvar_t	ui_playerangle;
vmCvar_t	g_ammolimit;
vmCvar_t	rus;
vmCvar_t	playerxp;
vmCvar_t	ui_secretcode;
vmCvar_t	ui_mainmodel;
vmCvar_t	ui_modname;
vmCvar_t	ui_singleplayer;
vmCvar_t	ui_singleplayer_x;
vmCvar_t	ui_singleplayer_y;
vmCvar_t	ui_singleplayer_text;
vmCvar_t	ui_multiplayer;
vmCvar_t	ui_multiplayer_x;
vmCvar_t	ui_multiplayer_y;
vmCvar_t	ui_multiplayer_text;
vmCvar_t	ui_settings;
vmCvar_t	ui_settings_x;
vmCvar_t	ui_settings_y;
vmCvar_t	ui_settings_text;
vmCvar_t	ui_demos;
vmCvar_t	ui_demos_x;
vmCvar_t	ui_demos_y;
vmCvar_t	ui_demos_text;
vmCvar_t	ui_statistics;
vmCvar_t	ui_statistics_x;
vmCvar_t	ui_statistics_y;
vmCvar_t	ui_statistics_text;
vmCvar_t	ui_mods;
vmCvar_t	ui_mods_x;
vmCvar_t	ui_mods_y;
vmCvar_t	ui_mods_text;
vmCvar_t	ui_exit;
vmCvar_t	ui_exit_x;
vmCvar_t	ui_exit_y;
vmCvar_t	ui_exit_text;
vmCvar_t	ui_gametype;
vmCvar_t		cg_ch9slze;
vmCvar_t	ui_ffa_fraglimit;
vmCvar_t	ui_ffa_timelimit;

vmCvar_t	ui_tourney_fraglimit;
vmCvar_t	ui_tourney_timelimit;

vmCvar_t	ui_team_fraglimit;
vmCvar_t	ui_team_timelimit;
vmCvar_t	ui_team_friendly;

vmCvar_t	ui_ctf_capturelimit;
vmCvar_t	ui_ctf_timelimit;
vmCvar_t	ui_ctf_friendly;

vmCvar_t	ui_1fctf_capturelimit;
vmCvar_t	ui_1fctf_timelimit;
vmCvar_t	ui_1fctf_friendly;

vmCvar_t	ui_overload_capturelimit;
vmCvar_t	ui_overload_timelimit;
vmCvar_t	ui_overload_friendly;

vmCvar_t	ui_harvester_capturelimit;
vmCvar_t	ui_harvester_timelimit;
vmCvar_t	ui_harvester_friendly;

vmCvar_t	ui_elimination_capturelimit;
vmCvar_t	ui_elimination_timelimit;

vmCvar_t	ui_ctf_elimination_capturelimit;
vmCvar_t	ui_ctf_elimination_timelimit;

vmCvar_t	ui_lms_fraglimit;
vmCvar_t	ui_lms_timelimit;

vmCvar_t	ui_dd_capturelimit;
vmCvar_t	ui_dd_timelimit;
vmCvar_t	ui_dd_friendly;

vmCvar_t	ui_dom_capturelimit;
vmCvar_t	ui_dom_timelimit;
vmCvar_t	ui_dom_friendly;

vmCvar_t	ui_arenasFile;
vmCvar_t	ui_botsFile;
vmCvar_t	ui_spScores1;
vmCvar_t	ui_spScores2;
vmCvar_t	ui_spScores3;
vmCvar_t	ui_spScores4;
vmCvar_t	ui_spScores5;
vmCvar_t	ui_spAwards;
vmCvar_t	ui_spVideos;
vmCvar_t	ui_spSkill;

vmCvar_t	ui_spSelection;

vmCvar_t	ui_browserMaster;
vmCvar_t	ui_browserGameType;
vmCvar_t	ui_browserSortKey;
vmCvar_t	ui_browserShowFull;
vmCvar_t	ui_browserShowEmpty;

vmCvar_t	ui_brassTime;
vmCvar_t	ui_drawCrosshair;
vmCvar_t	ui_drawCrosshairNames;
vmCvar_t	ui_marks;

vmCvar_t	ui_server1;
vmCvar_t	ui_server2;
vmCvar_t	ui_server3;
vmCvar_t	ui_server4;
vmCvar_t	ui_server5;
vmCvar_t	ui_server6;
vmCvar_t	ui_server7;
vmCvar_t	ui_server8;
vmCvar_t	ui_server9;
vmCvar_t	ui_server10;
vmCvar_t	ui_server11;
vmCvar_t	ui_server12;
vmCvar_t	ui_server13;
vmCvar_t	ui_server14;
vmCvar_t	ui_server15;
vmCvar_t	ui_server16;



//vmCvar_t	ui_cdkeychecked;

//new in beta 23:
vmCvar_t        ui_browserOnlyHumans;

//new in beta 37:
vmCvar_t        ui_setupchecked;

// bk001129 - made static to avoid aliasing.
static cvarTable_t		cvarTable[] = {

	{ &g_ammolimit, "g_ammolimit", "200", 0 },

	{ &MusicplayerMusic, "MusicplayerMusic", "0", CVAR_ARCHIVE },
	{ &skinsmultiplayer, "skinsmultiplayer", "0", CVAR_ARCHIVE },
	{ &onandroid, "onandroid", "0", CVAR_ARCHIVE },
	{ &IsGame, "IsGame", "0", CVAR_ARCHIVE },
	{ &onnextarena, "onnextarena", "0", CVAR_ARCHIVE },
	{ &ui_playerangle, "ui_playerangle", "170", 0 },
	{ &Gop_n0, "Gop_n0", "0", 0 },
	{ &Gop_n1, "Gop_n1", "1", 0 },
	{ &Gop_n2, "Gop_n2", "2", 0 },
	{ &Gop_n3, "Gop_n3", "3", 0 },
	{ &Gop_n4, "Gop_n4", "4", 0 },
	{ &Gop_n5, "Gop_n5", "5", 0 },
	{ &Gop_n6, "Gop_n6", "6", 0 },
	{ &Gop_v3, "Gop_v3", "0", 0 },
	{ &Gop_ne1, "Gop_ne1", "1", 0 },
	{ &Gop_ne2, "Gop_ne2", "2", 0 },
	{ &Gop_b1, "Gop_b1", "-1", 0 },
	{ &Gop_b2, "Gop_b2", "-2", 0 },
	{ &ui_nomapicons, "ui_nomapicons", "0", CVAR_ARCHIVE },
	{ &ui_loaded, "ui_loaded", "0", 0 },
	{ &ui_char, "ui_char", "0", CVAR_ARCHIVE },
	{ &ui_zplmd, "ui_zplmd", "1", CVAR_ARCHIVE },
	{ &ui_actionmenu, "ui_actionmenu", "0", 0 },
	{ &ui_gamemodesall, "ui_gamemodesall", "0", CVAR_ARCHIVE },
	{ &ui_custommaps, "ui_custommaps", "0", CVAR_ARCHIVE },
	{ &ui_headmodelt, "ui_headmodelt", "0", CVAR_ARCHIVE },
	{ &ui_headmodel, "ui_headmodel", "0", CVAR_ARCHIVE },
	{ &ui_legsmodel, "ui_legsmodel", "0", CVAR_ARCHIVE },
	{ &ui_msheadmodel, "ui_msheadmodel", "sarge", CVAR_ARCHIVE },
	{ &ui_msheadskin, "ui_msheadskin", "sarge", CVAR_ARCHIVE },
	{ &ui_mslegsmodel, "ui_mslegsmodel", "sarge", CVAR_ARCHIVE },
	{ &ui_mslegsskin, "ui_mslegsskin", "sarge", CVAR_ARCHIVE },
	{ &ui_msmodel, "ui_msmodel", "sarge", CVAR_ARCHIVE },
	{ &ui_msskin, "ui_msskin", "sarge", CVAR_ARCHIVE },
	{ &ui_coop, "ui_coop", "0", CVAR_ARCHIVE },
	{ &ui_backcolor, "ui_backcolor", "0", CVAR_ARCHIVE },
	{ &cg_ch9slze, "cg_ch9slze", "0", 0 },
	{ &ui_mapiconsizeq, "ui_mapiconsizeq", "1", CVAR_ARCHIVE },
	{ &ui_skinprice, "ui_skinprice", "5", CVAR_ARCHIVE },
	{ &ui_maprowsq, "ui_maprowsq", "4", CVAR_ARCHIVE },
	{ &ui_mapcolsq, "ui_mapcolsq", "2", CVAR_ARCHIVE },
	{ &ui_cwritev, "ui_cwritev", "0", CVAR_ARCHIVE },
	{ &ui_cwriteb, "ui_cwriteb", "0", CVAR_ARCHIVE },
	{ &ui_skinsunlocked, "ui_skinsunlocked", "0", CVAR_ARCHIVE },
	{ &rus, "rus", "0", CVAR_ARCHIVE },
	{ &playerxp, "playerxp", "0", CVAR_ARCHIVE },
	{ &ui_secretcode, "ui_secretcode", "000000", CVAR_ARCHIVE },
	{ &ui_mainmodel, "ui_mainmodel", "models/mapobjects/banner/banner5.md3", CVAR_ARCHIVE },
	{ &ui_modname, "ui_modname", "*", CVAR_ARCHIVE },
	{ &ui_singleplayer, "ui_singleplayer", "1", CVAR_ARCHIVE },
	{ &ui_singleplayer_x, "ui_singleplayer_x", "320", CVAR_ARCHIVE },
	{ &ui_singleplayer_y, "ui_singleplayer_y", "134", CVAR_ARCHIVE },
	{ &ui_singleplayer_text, "ui_singleplayer_text", "SINGLE PLAYER", CVAR_ARCHIVE },
	{ &ui_multiplayer, "ui_multiplayer", "1", CVAR_ARCHIVE },
	{ &ui_multiplayer_x, "ui_multiplayer_x", "320", CVAR_ARCHIVE },
	{ &ui_multiplayer_y, "ui_multiplayer_y", "168", CVAR_ARCHIVE },
	{ &ui_multiplayer_text, "ui_multiplayer_text", "MULTIPLAYER", CVAR_ARCHIVE },
	{ &ui_settings, "ui_settings", "1", CVAR_ARCHIVE },
	{ &ui_settings_x, "ui_settings_x", "320", CVAR_ARCHIVE },
	{ &ui_settings_y, "ui_settings_y", "202", CVAR_ARCHIVE },
	{ &ui_settings_text, "ui_settings_text", "SETTINGS", CVAR_ARCHIVE },
	{ &ui_demos, "ui_demos", "1", CVAR_ARCHIVE },
	{ &ui_demos_x, "ui_demos_x", "320", CVAR_ARCHIVE },
	{ &ui_demos_y, "ui_demos_y", "236", CVAR_ARCHIVE },
	{ &ui_demos_text, "ui_demos_text", "DEMOS", CVAR_ARCHIVE },
	{ &ui_statistics, "ui_statistics", "1", CVAR_ARCHIVE },
	{ &ui_statistics_x, "ui_statistics_x", "320", CVAR_ARCHIVE },
	{ &ui_statistics_y, "ui_statistics_y", "270", CVAR_ARCHIVE },
	{ &ui_statistics_text, "ui_statistics_text", "STATISTICS", CVAR_ARCHIVE },
	{ &ui_mods, "ui_mods", "1", CVAR_ARCHIVE },
	{ &ui_mods_x, "ui_mods_x", "320", CVAR_ARCHIVE },
	{ &ui_mods_y, "ui_mods_y", "304", CVAR_ARCHIVE },
	{ &ui_mods_text, "ui_mods_text", "MODS", CVAR_ARCHIVE },
	{ &ui_exit, "ui_exit", "1", CVAR_ARCHIVE },
	{ &ui_exit_x, "ui_exit_x", "320", CVAR_ARCHIVE },
	{ &ui_exit_y, "ui_exit_y", "338", CVAR_ARCHIVE },
	{ &ui_exit_text, "ui_exit_text", "EXIT", CVAR_ARCHIVE },
	{ &ui_gametype, "ui_gametype", "-1", CVAR_ARCHIVE },

	{ &ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE },
	{ &ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE },

	{ &ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE },
	{ &ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE },

	{ &ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE },
	{ &ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE },
	{ &ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE },

	{ &ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE },

        { &ui_1fctf_capturelimit, "ui_1fctf_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_1fctf_timelimit, "ui_1fctf_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_1fctf_friendly, "ui_1fctf_friendly",  "0", CVAR_ARCHIVE },

        { &ui_overload_capturelimit, "ui_overload_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_overload_timelimit, "ui_overload_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_overload_friendly, "ui_overload_friendly",  "0", CVAR_ARCHIVE },

        { &ui_harvester_capturelimit, "ui_harvester_capturelimit", "20", CVAR_ARCHIVE },
	{ &ui_harvester_timelimit, "ui_harvester_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_harvester_friendly, "ui_harvester_friendly",  "0", CVAR_ARCHIVE },

	{ &ui_elimination_capturelimit, "ui_elimination_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_elimination_timelimit, "ui_elimination_timelimit", "20", CVAR_ARCHIVE },

	{ &ui_ctf_elimination_capturelimit, "ui_ctf_elimination_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_ctf_elimination_timelimit, "ui_ctf_elimination_timelimit", "30", CVAR_ARCHIVE },

	{ &ui_lms_fraglimit, "ui_lms_fraglimit", "20", CVAR_ARCHIVE },
	{ &ui_lms_timelimit, "ui_lms_timelimit", "0", CVAR_ARCHIVE },

	{ &ui_dd_capturelimit, "ui_dd_capturelimit", "8", CVAR_ARCHIVE },
	{ &ui_dd_timelimit, "ui_dd_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_dd_friendly, "ui_dd_friendly",  "0", CVAR_ARCHIVE },

        { &ui_dom_capturelimit, "ui_dom_capturelimit", "500", CVAR_ARCHIVE },
	{ &ui_dom_timelimit, "ui_dom_timelimit", "30", CVAR_ARCHIVE },
	{ &ui_dom_friendly, "ui_dom_friendly",  "0", CVAR_ARCHIVE },

	{ &ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM },
	{ &ui_botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM },
	{ &ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE | CVAR_ROM },
	{ &ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE | CVAR_LATCH },

	{ &ui_spSelection, "ui_spSelection", "", CVAR_ROM },

	{ &ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE },
	{ &ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE },
	{ &ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE },
	{ &ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE },
	{ &ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE },

	{ &ui_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
	{ &ui_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
	{ &ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
	{ &ui_marks, "cg_marks", "1", CVAR_ARCHIVE },

	{ &ui_server1, "server1", "", CVAR_ARCHIVE },
	{ &ui_server2, "server2", "", CVAR_ARCHIVE },
	{ &ui_server3, "server3", "", CVAR_ARCHIVE },
	{ &ui_server4, "server4", "", CVAR_ARCHIVE },
	{ &ui_server5, "server5", "", CVAR_ARCHIVE },
	{ &ui_server6, "server6", "", CVAR_ARCHIVE },
	{ &ui_server7, "server7", "", CVAR_ARCHIVE },
	{ &ui_server8, "server8", "", CVAR_ARCHIVE },
	{ &ui_server9, "server9", "", CVAR_ARCHIVE },
	{ &ui_server10, "server10", "", CVAR_ARCHIVE },
	{ &ui_server11, "server11", "", CVAR_ARCHIVE },
	{ &ui_server12, "server12", "", CVAR_ARCHIVE },
	{ &ui_server13, "server13", "", CVAR_ARCHIVE },
	{ &ui_server14, "server14", "", CVAR_ARCHIVE },
	{ &ui_server15, "server15", "", CVAR_ARCHIVE },
	{ &ui_server16, "server16", "", CVAR_ARCHIVE },

	//{ &ui_cdkeychecked, "ui_cdkeychecked", "0", CVAR_ROM },

        //new in beta 23:
        { &ui_browserOnlyHumans, "ui_browserOnlyHumans", "0", CVAR_ARCHIVE },

        //new in beta 37:
        { &ui_setupchecked, "ui_setupchecked", "0", CVAR_ARCHIVE },
};

// bk001129 - made static to avoid aliasing
static int cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
int	mod_ammolimit;
/*
=================
UI_RegisterCvars
=================
*/
void UI_RegisterCvars( void ) {
	int			i;
	cvarTable_t	*cv;

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
	}
		mod_ammolimit = g_ammolimit.integer;
		trap_Cvar_Set("com_hunkmegs","1300");
		trap_Cvar_Set("com_zonemegs","128");
		trap_Cvar_Set("com_soundmegs","64");
		trap_Cvar_Set("com_maxfps","150");
		trap_Cvar_Set("videoflags","0");
		trap_Cvar_Set("skinsmultiplayer","1");
		trap_Cvar_Set("r_envMode","0");
		trap_Cvar_Set("dmflags","1024");
		trap_Cvar_Set("sv_fps","60");
		trap_Cvar_Set("cg_drawAmmoWarning","0");
		trap_Cvar_Set("cg_teamChatTime","10000");
		trap_Cvar_Set("cg_teamChatHeight","5");
		trap_Cvar_Set("cg_ch9slze","0");
		trap_Cvar_Set("ui_skinsunlocked","0");
		trap_Cvar_Set("bot_saveroutingcache","1");
		trap_Cvar_Set("cl_allowDownload","1");
		trap_Cvar_Set("sv_allowDownload","1");
		trap_Cvar_Set("cg_trueLightning","1");
		trap_Cvar_Set("r_smp","1");
		trap_Cvar_Set("r_marksOnTriangleMeshes","1");
		trap_Cvar_Set("cl_consoleType","2");
		trap_Cvar_Set("cl_consoleColorRed","0");
		trap_Cvar_Set("cl_consoleColorGreen","0");
		trap_Cvar_Set("cl_consoleColorBlue","0");
		trap_Cvar_Set("cl_consoleColorAlpha","0.6");
		trap_Cvar_Set("cl_consoleHeight","0.38");


		trap_Cmd_ExecuteText( EXEC_APPEND, "exec voice;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 1 vstr voicep;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 2 vsay_team onoffense;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 3 vsay_team ondefense;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 4 vsay_team onpatrol;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 5 vsay_team kill_insult;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 6 vsay_team onreturnflag;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 7 vstr voicen;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 8 vsay_team no;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 9 vsay_team yes;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind 0 vtaunt;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind z toggle cl_run;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind v toggle cg_thirdperson;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind y toggle cg_draw2D;" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f1 OpenActions;" );
//		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f OpenActions;" );
if((int)trap_Cvar_VariableValue("protocol")==68){
	trap_Cmd_ExecuteText( EXEC_APPEND, "exec ultragraph.cfg\n" );
}
}

/*
=================
UI_UpdateCvars
=================
*/
void UI_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		trap_Cvar_Update( cv->vmCvar );
	}
}

/*
==================
 * UI_SetDefaultCvar
 * If the cvar is blank it will be set to value
 * This is only good for cvars that cannot naturally be blank
==================
 */
void UI_SetDefaultCvar(const char* cvar, const char* value) {
    if(strlen(UI_Cvar_VariableString(cvar)) == 0)
        trap_Cvar_Set(cvar,value);
}
