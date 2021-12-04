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

/*
vmCvar_t	ui_skin1;
vmCvar_t	ui_skin2;
vmCvar_t	ui_skin3;
vmCvar_t	ui_skin4;
vmCvar_t	ui_skin5;
vmCvar_t	ui_skin6;
vmCvar_t	ui_skin7;
vmCvar_t	ui_skin8;
vmCvar_t	ui_skin9;
vmCvar_t	ui_skin10;
vmCvar_t	ui_skin11;
vmCvar_t	ui_skin12;
vmCvar_t	ui_skin13;
vmCvar_t	ui_skin14;
vmCvar_t	ui_skin15;
vmCvar_t	ui_skin16;
vmCvar_t	ui_skin17;
vmCvar_t	ui_skin18;
vmCvar_t	ui_skin19;
vmCvar_t	ui_skin20;
vmCvar_t	ui_skin21;
vmCvar_t	ui_skin22;
vmCvar_t	ui_skin23;
vmCvar_t	ui_skin24;
vmCvar_t	ui_skin25;
vmCvar_t	ui_skin26;
vmCvar_t	ui_skin27;
vmCvar_t	ui_skin28;
vmCvar_t	ui_skin29;
vmCvar_t	ui_skin30;
vmCvar_t	ui_skin31;
vmCvar_t	ui_skin32;
vmCvar_t	ui_skin33;
vmCvar_t	ui_skin34;
vmCvar_t	ui_skin35;
vmCvar_t	ui_skin36;
vmCvar_t	ui_skin37;
vmCvar_t	ui_skin38;
vmCvar_t	ui_skin39;
vmCvar_t	ui_skin40;
vmCvar_t	ui_skin41;
vmCvar_t	ui_skin42;
vmCvar_t	ui_skin43;
vmCvar_t	ui_skin44;
vmCvar_t	ui_skin45;
vmCvar_t	ui_skin46;
vmCvar_t	ui_skin47;
vmCvar_t	ui_skin48;
vmCvar_t	ui_skin49;
vmCvar_t	ui_skin50;
vmCvar_t	ui_skin51;
vmCvar_t	ui_skin52;
vmCvar_t	ui_skin53;
vmCvar_t	ui_skin54;
vmCvar_t	ui_skin55;
vmCvar_t	ui_skin56;
vmCvar_t	ui_skin57;
vmCvar_t	ui_skin58;
vmCvar_t	ui_skin59;
vmCvar_t	ui_skin60;
vmCvar_t	ui_skin61;
vmCvar_t	ui_skin62;
vmCvar_t	ui_skin63;
vmCvar_t	ui_skin64;
vmCvar_t	ui_skin65;
vmCvar_t	ui_skin66;
vmCvar_t	ui_skin67;
vmCvar_t	ui_skin68;
vmCvar_t	ui_skin69;
vmCvar_t	ui_skin70;
vmCvar_t	ui_skin71;
vmCvar_t	ui_skin72;
vmCvar_t	ui_skin73;
vmCvar_t	ui_skin74;
vmCvar_t	ui_skin75;
vmCvar_t	ui_skin76;
vmCvar_t	ui_skin77;
vmCvar_t	ui_skin78;
vmCvar_t	ui_skin79;
vmCvar_t	ui_skin80;
vmCvar_t	ui_skin81;
vmCvar_t	ui_skin82;
vmCvar_t	ui_skin83;
vmCvar_t	ui_skin84;
vmCvar_t	ui_skin85;
vmCvar_t	ui_skin86;
vmCvar_t	ui_skin87;
vmCvar_t	ui_skin88;
vmCvar_t	ui_skin89;
vmCvar_t	ui_skin90;
vmCvar_t	ui_skin91;
vmCvar_t	ui_skin92;
vmCvar_t	ui_skin93;
vmCvar_t	ui_skin94;
vmCvar_t	ui_skin95;
vmCvar_t	ui_skin96;
vmCvar_t	ui_skin97;
vmCvar_t	ui_skin98;
vmCvar_t	ui_skin99;
vmCvar_t	ui_skin100;
vmCvar_t	ui_skin101;
vmCvar_t	ui_skin102;
vmCvar_t	ui_skin103;
vmCvar_t	ui_skin104;
vmCvar_t	ui_skin105;
vmCvar_t	ui_skin106;
vmCvar_t	ui_skin107;
vmCvar_t	ui_skin108;
vmCvar_t	ui_skin109;
vmCvar_t	ui_skin110;
vmCvar_t	ui_skin111;
vmCvar_t	ui_skin112;
vmCvar_t	ui_skin113;
vmCvar_t	ui_skin114;
vmCvar_t	ui_skin115;
vmCvar_t	ui_skin116;
vmCvar_t	ui_skin117;
vmCvar_t	ui_skin118;
vmCvar_t	ui_skin119;
vmCvar_t	ui_skin120;
vmCvar_t	ui_skin121;
vmCvar_t	ui_skin122;
vmCvar_t	ui_skin123;
vmCvar_t	ui_skin124;
vmCvar_t	ui_skin125;
vmCvar_t	ui_skin126;
vmCvar_t	ui_skin127;
vmCvar_t	ui_skin128;
vmCvar_t	ui_skin129;
vmCvar_t	ui_skin130;
vmCvar_t	ui_skin131;
vmCvar_t	ui_skin132;
vmCvar_t	ui_skin133;
vmCvar_t	ui_skin134;
vmCvar_t	ui_skin135;
vmCvar_t	ui_skin136;
vmCvar_t	ui_skin137;
vmCvar_t	ui_skin138;
vmCvar_t	ui_skin139;
vmCvar_t	ui_skin140;
vmCvar_t	ui_skin141;
vmCvar_t	ui_skin142;
vmCvar_t	ui_skin143;
vmCvar_t	ui_skin144;
vmCvar_t	ui_skin145;
vmCvar_t	ui_skin146;
vmCvar_t	ui_skin147;
vmCvar_t	ui_skin148;
vmCvar_t	ui_skin149;
vmCvar_t	ui_skin150;
vmCvar_t	ui_skin151;
vmCvar_t	ui_skin152;
vmCvar_t	ui_skin153;
vmCvar_t	ui_skin154;
vmCvar_t	ui_skin155;
vmCvar_t	ui_skin156;
vmCvar_t	ui_skin157;
vmCvar_t	ui_skin158;
vmCvar_t	ui_skin159;
vmCvar_t	ui_skin160;
vmCvar_t	ui_skin161;
vmCvar_t	ui_skin162;
vmCvar_t	ui_skin163;
vmCvar_t	ui_skin164;
vmCvar_t	ui_skin165;
vmCvar_t	ui_skin166;
vmCvar_t	ui_skin167;
vmCvar_t	ui_skin168;
vmCvar_t	ui_skin169;
vmCvar_t	ui_skin170;
vmCvar_t	ui_skin171;
vmCvar_t	ui_skin172;
vmCvar_t	ui_skin173;
vmCvar_t	ui_skin174;
vmCvar_t	ui_skin175;
vmCvar_t	ui_skin176;
vmCvar_t	ui_skin177;
vmCvar_t	ui_skin178;
vmCvar_t	ui_skin179;
vmCvar_t	ui_skin180;
vmCvar_t	ui_skin181;
vmCvar_t	ui_skin182;
vmCvar_t	ui_skin183;
vmCvar_t	ui_skin184;
vmCvar_t	ui_skin185;
vmCvar_t	ui_skin186;
vmCvar_t	ui_skin187;
vmCvar_t	ui_skin188;
vmCvar_t	ui_skin189;
vmCvar_t	ui_skin190;
vmCvar_t	ui_skin191;
vmCvar_t	ui_skin192;
vmCvar_t	ui_skin193;
vmCvar_t	ui_skin194;
vmCvar_t	ui_skin195;
vmCvar_t	ui_skin196;
vmCvar_t	ui_skin197;
vmCvar_t	ui_skin198;
vmCvar_t	ui_skin199;
vmCvar_t	ui_skin200;
vmCvar_t	ui_skin201;
vmCvar_t	ui_skin202;
vmCvar_t	ui_skin203;
vmCvar_t	ui_skin204;
vmCvar_t	ui_skin205;
vmCvar_t	ui_skin206;
vmCvar_t	ui_skin207;
vmCvar_t	ui_skin208;
vmCvar_t	ui_skin209;
vmCvar_t	ui_skin210;
vmCvar_t	ui_skin211;
vmCvar_t	ui_skin212;
vmCvar_t	ui_skin213;
vmCvar_t	ui_skin214;
vmCvar_t	ui_skin215;
vmCvar_t	ui_skin216;
vmCvar_t	ui_skin217;
vmCvar_t	ui_skin218;
vmCvar_t	ui_skin219;
vmCvar_t	ui_skin220;
vmCvar_t	ui_skin221;
vmCvar_t	ui_skin222;
vmCvar_t	ui_skin223;
vmCvar_t	ui_skin224;
vmCvar_t	ui_skin225;
vmCvar_t	ui_skin226;
vmCvar_t	ui_skin227;
vmCvar_t	ui_skin228;
vmCvar_t	ui_skin229;
vmCvar_t	ui_skin230;
vmCvar_t	ui_skin231;
vmCvar_t	ui_skin232;
vmCvar_t	ui_skin233;
vmCvar_t	ui_skin234;
vmCvar_t	ui_skin235;
vmCvar_t	ui_skin236;
vmCvar_t	ui_skin237;
vmCvar_t	ui_skin238;
vmCvar_t	ui_skin239;
vmCvar_t	ui_skin240;
vmCvar_t	ui_skin241;
vmCvar_t	ui_skin242;
vmCvar_t	ui_skin243;
vmCvar_t	ui_skin244;
vmCvar_t	ui_skin245;
vmCvar_t	ui_skin246;
vmCvar_t	ui_skin247;
vmCvar_t	ui_skin248;
vmCvar_t	ui_skin249;
vmCvar_t	ui_skin250;
vmCvar_t	ui_skin251;
vmCvar_t	ui_skin252;
vmCvar_t	ui_skin253;
vmCvar_t	ui_skin254;
vmCvar_t	ui_skin255;
vmCvar_t	ui_skin256;
vmCvar_t	ui_skin257;
vmCvar_t	ui_skin258;
vmCvar_t	ui_skin259;
vmCvar_t	ui_skin260;
vmCvar_t	ui_skin261;
vmCvar_t	ui_skin262;
vmCvar_t	ui_skin263;
vmCvar_t	ui_skin264;
vmCvar_t	ui_skin265;
vmCvar_t	ui_skin266;
vmCvar_t	ui_skin267;
vmCvar_t	ui_skin268;
vmCvar_t	ui_skin269;
vmCvar_t	ui_skin270;
vmCvar_t	ui_skin271;
vmCvar_t	ui_skin272;
vmCvar_t	ui_skin273;
vmCvar_t	ui_skin274;
vmCvar_t	ui_skin275;
vmCvar_t	ui_skin276;
vmCvar_t	ui_skin277;
vmCvar_t	ui_skin278;
vmCvar_t	ui_skin279;
vmCvar_t	ui_skin280;
vmCvar_t	ui_skin281;
vmCvar_t	ui_skin282;
vmCvar_t	ui_skin283;
vmCvar_t	ui_skin284;
vmCvar_t	ui_skin285;
vmCvar_t	ui_skin286;
vmCvar_t	ui_skin287;
vmCvar_t	ui_skin288;
vmCvar_t	ui_skin289;
vmCvar_t	ui_skin290;
vmCvar_t	ui_skin291;
vmCvar_t	ui_skin292;
vmCvar_t	ui_skin293;
vmCvar_t	ui_skin294;
vmCvar_t	ui_skin295;
vmCvar_t	ui_skin296;
vmCvar_t	ui_skin297;
vmCvar_t	ui_skin298;
vmCvar_t	ui_skin299;
vmCvar_t	ui_skin300;
vmCvar_t	ui_skin301;
vmCvar_t	ui_skin302;
vmCvar_t	ui_skin303;
vmCvar_t	ui_skin304;
vmCvar_t	ui_skin305;
vmCvar_t	ui_skin306;
vmCvar_t	ui_skin307;
vmCvar_t	ui_skin308;
vmCvar_t	ui_skin309;
vmCvar_t	ui_skin310;
vmCvar_t	ui_skin311;
vmCvar_t	ui_skin312;
vmCvar_t	ui_skin313;
vmCvar_t	ui_skin314;
vmCvar_t	ui_skin315;
vmCvar_t	ui_skin316;
vmCvar_t	ui_skin317;
vmCvar_t	ui_skin318;
vmCvar_t	ui_skin319;
vmCvar_t	ui_skin320;
vmCvar_t	ui_skin321;
vmCvar_t	ui_skin322;
vmCvar_t	ui_skin323;
vmCvar_t	ui_skin324;
vmCvar_t	ui_skin325;
vmCvar_t	ui_skin326;
vmCvar_t	ui_skin327;
vmCvar_t	ui_skin328;
vmCvar_t	ui_skin329;
vmCvar_t	ui_skin330;
vmCvar_t	ui_skin331;
vmCvar_t	ui_skin332;
vmCvar_t	ui_skin333;
vmCvar_t	ui_skin334;
vmCvar_t	ui_skin335;
vmCvar_t	ui_skin336;
vmCvar_t	ui_skin337;
vmCvar_t	ui_skin338;
vmCvar_t	ui_skin339;
vmCvar_t	ui_skin340;
vmCvar_t	ui_skin341;
vmCvar_t	ui_skin342;
vmCvar_t	ui_skin343;
vmCvar_t	ui_skin344;
vmCvar_t	ui_skin345;
vmCvar_t	ui_skin346;
vmCvar_t	ui_skin347;
vmCvar_t	ui_skin348;
vmCvar_t	ui_skin349;
vmCvar_t	ui_skin350;
vmCvar_t	ui_skin351;
vmCvar_t	ui_skin352;
vmCvar_t	ui_skin353;
vmCvar_t	ui_skin354;
vmCvar_t	ui_skin355;
vmCvar_t	ui_skin356;
vmCvar_t	ui_skin357;
vmCvar_t	ui_skin358;
vmCvar_t	ui_skin359;
vmCvar_t	ui_skin360;
vmCvar_t	ui_skin361;
vmCvar_t	ui_skin362;
vmCvar_t	ui_skin363;
vmCvar_t	ui_skin364;
vmCvar_t	ui_skin365;
vmCvar_t	ui_skin366;
vmCvar_t	ui_skin367;
vmCvar_t	ui_skin368;
vmCvar_t	ui_skin369;
vmCvar_t	ui_skin370;
vmCvar_t	ui_skin371;
vmCvar_t	ui_skin372;
vmCvar_t	ui_skin373;
vmCvar_t	ui_skin374;
vmCvar_t	ui_skin375;
vmCvar_t	ui_skin376;
vmCvar_t	ui_skin377;
vmCvar_t	ui_skin378;
vmCvar_t	ui_skin379;
vmCvar_t	ui_skin380;
vmCvar_t	ui_skin381;
vmCvar_t	ui_skin382;
vmCvar_t	ui_skin383;
vmCvar_t	ui_skin384;
vmCvar_t	ui_skin385;
vmCvar_t	ui_skin386;
vmCvar_t	ui_skin387;
vmCvar_t	ui_skin388;
vmCvar_t	ui_skin389;
vmCvar_t	ui_skin390;
vmCvar_t	ui_skin391;
vmCvar_t	ui_skin392;
vmCvar_t	ui_skin393;
vmCvar_t	ui_skin394;
vmCvar_t	ui_skin395;
vmCvar_t	ui_skin396;
vmCvar_t	ui_skin397;
vmCvar_t	ui_skin398;
vmCvar_t	ui_skin399;
vmCvar_t	ui_skin400;
vmCvar_t	ui_skin401;
vmCvar_t	ui_skin402;
vmCvar_t	ui_skin403;
vmCvar_t	ui_skin404;
vmCvar_t	ui_skin405;
vmCvar_t	ui_skin406;
vmCvar_t	ui_skin407;
vmCvar_t	ui_skin408;
vmCvar_t	ui_skin409;
vmCvar_t	ui_skin410;
vmCvar_t	ui_skin411;
vmCvar_t	ui_skin412;
vmCvar_t	ui_skin413;
vmCvar_t	ui_skin414;
vmCvar_t	ui_skin415;
vmCvar_t	ui_skin416;
vmCvar_t	ui_skin417;
vmCvar_t	ui_skin418;
vmCvar_t	ui_skin419;
vmCvar_t	ui_skin420;
vmCvar_t	ui_skin421;
vmCvar_t	ui_skin422;
vmCvar_t	ui_skin423;
vmCvar_t	ui_skin424;
vmCvar_t	ui_skin425;
vmCvar_t	ui_skin426;
vmCvar_t	ui_skin427;
vmCvar_t	ui_skin428;
vmCvar_t	ui_skin429;
vmCvar_t	ui_skin430;
vmCvar_t	ui_skin431;
vmCvar_t	ui_skin432;
vmCvar_t	ui_skin433;
vmCvar_t	ui_skin434;
vmCvar_t	ui_skin435;
vmCvar_t	ui_skin436;
vmCvar_t	ui_skin437;
vmCvar_t	ui_skin438;
vmCvar_t	ui_skin439;
vmCvar_t	ui_skin440;
vmCvar_t	ui_skin441;
vmCvar_t	ui_skin442;
vmCvar_t	ui_skin443;
vmCvar_t	ui_skin444;
vmCvar_t	ui_skin445;
vmCvar_t	ui_skin446;
vmCvar_t	ui_skin447;
vmCvar_t	ui_skin448;
vmCvar_t	ui_skin449;
vmCvar_t	ui_skin450;
vmCvar_t	ui_skin451;
vmCvar_t	ui_skin452;
vmCvar_t	ui_skin453;
vmCvar_t	ui_skin454;
vmCvar_t	ui_skin455;
vmCvar_t	ui_skin456;
vmCvar_t	ui_skin457;
vmCvar_t	ui_skin458;
vmCvar_t	ui_skin459;
vmCvar_t	ui_skin460;
vmCvar_t	ui_skin461;
vmCvar_t	ui_skin462;
vmCvar_t	ui_skin463;
vmCvar_t	ui_skin464;
vmCvar_t	ui_skin465;
vmCvar_t	ui_skin466;
vmCvar_t	ui_skin467;
vmCvar_t	ui_skin468;
vmCvar_t	ui_skin469;
vmCvar_t	ui_skin470;
vmCvar_t	ui_skin471;
vmCvar_t	ui_skin472;
vmCvar_t	ui_skin473;
vmCvar_t	ui_skin474;
vmCvar_t	ui_skin475;
vmCvar_t	ui_skin476;
vmCvar_t	ui_skin477;
vmCvar_t	ui_skin478;
vmCvar_t	ui_skin479;
vmCvar_t	ui_skin480;
vmCvar_t	ui_skin481;
vmCvar_t	ui_skin482;
vmCvar_t	ui_skin483;
vmCvar_t	ui_skin484;
vmCvar_t	ui_skin485;
vmCvar_t	ui_skin486;
vmCvar_t	ui_skin487;
vmCvar_t	ui_skin488;
vmCvar_t	ui_skin489;
vmCvar_t	ui_skin490;
vmCvar_t	ui_skin491;
vmCvar_t	ui_skin492;
vmCvar_t	ui_skin493;
vmCvar_t	ui_skin494;
vmCvar_t	ui_skin495;
vmCvar_t	ui_skin496;
vmCvar_t	ui_skin497;
vmCvar_t	ui_skin498;
vmCvar_t	ui_skin499;
vmCvar_t	ui_skin500;
vmCvar_t	ui_skin501;
vmCvar_t	ui_skin502;
vmCvar_t	ui_skin503;
vmCvar_t	ui_skin504;
vmCvar_t	ui_skin505;
vmCvar_t	ui_skin506;
vmCvar_t	ui_skin507;
vmCvar_t	ui_skin508;
vmCvar_t	ui_skin509;
vmCvar_t	ui_skin510;
vmCvar_t	ui_skin511;
vmCvar_t	ui_skin512;
vmCvar_t	ui_skin513;
vmCvar_t	ui_skin514;
vmCvar_t	ui_skin515;
vmCvar_t	ui_skin516;
vmCvar_t	ui_skin517;
vmCvar_t	ui_skin518;
vmCvar_t	ui_skin519;
vmCvar_t	ui_skin520;
vmCvar_t	ui_skin521;
vmCvar_t	ui_skin522;
vmCvar_t	ui_skin523;
vmCvar_t	ui_skin524;
vmCvar_t	ui_skin525;
vmCvar_t	ui_skin526;
vmCvar_t	ui_skin527;
vmCvar_t	ui_skin528;
vmCvar_t	ui_skin529;
vmCvar_t	ui_skin530;
vmCvar_t	ui_skin531;
vmCvar_t	ui_skin532;
vmCvar_t	ui_skin533;
vmCvar_t	ui_skin534;
vmCvar_t	ui_skin535;
vmCvar_t	ui_skin536;
vmCvar_t	ui_skin537;
vmCvar_t	ui_skin538;
vmCvar_t	ui_skin539;
vmCvar_t	ui_skin540;
vmCvar_t	ui_skin541;
vmCvar_t	ui_skin542;
vmCvar_t	ui_skin543;
vmCvar_t	ui_skin544;
vmCvar_t	ui_skin545;
vmCvar_t	ui_skin546;
vmCvar_t	ui_skin547;
vmCvar_t	ui_skin548;
vmCvar_t	ui_skin549;
vmCvar_t	ui_skin550;
vmCvar_t	ui_skin551;
vmCvar_t	ui_skin552;
vmCvar_t	ui_skin553;
vmCvar_t	ui_skin554;
vmCvar_t	ui_skin555;
vmCvar_t	ui_skin556;
vmCvar_t	ui_skin557;
vmCvar_t	ui_skin558;
vmCvar_t	ui_skin559;
vmCvar_t	ui_skin560;
vmCvar_t	ui_skin561;
vmCvar_t	ui_skin562;
vmCvar_t	ui_skin563;
vmCvar_t	ui_skin564;
vmCvar_t	ui_skin565;
vmCvar_t	ui_skin566;
vmCvar_t	ui_skin567;
vmCvar_t	ui_skin568;
vmCvar_t	ui_skin569;
vmCvar_t	ui_skin570;
vmCvar_t	ui_skin571;
vmCvar_t	ui_skin572;
vmCvar_t	ui_skin573;
vmCvar_t	ui_skin574;
vmCvar_t	ui_skin575;
vmCvar_t	ui_skin576;
vmCvar_t	ui_skin577;
vmCvar_t	ui_skin578;
vmCvar_t	ui_skin579;
vmCvar_t	ui_skin580;
vmCvar_t	ui_skin581;
vmCvar_t	ui_skin582;
vmCvar_t	ui_skin583;
vmCvar_t	ui_skin584;
vmCvar_t	ui_skin585;
vmCvar_t	ui_skin586;
vmCvar_t	ui_skin587;
vmCvar_t	ui_skin588;
vmCvar_t	ui_skin589;
vmCvar_t	ui_skin590;
vmCvar_t	ui_skin591;
vmCvar_t	ui_skin592;
vmCvar_t	ui_skin593;
vmCvar_t	ui_skin594;
vmCvar_t	ui_skin595;
vmCvar_t	ui_skin596;
vmCvar_t	ui_skin597;
vmCvar_t	ui_skin598;
vmCvar_t	ui_skin599;
vmCvar_t	ui_skin600;
vmCvar_t	ui_skin601;
vmCvar_t	ui_skin602;
vmCvar_t	ui_skin603;
vmCvar_t	ui_skin604;
vmCvar_t	ui_skin605;
vmCvar_t	ui_skin606;
vmCvar_t	ui_skin607;
vmCvar_t	ui_skin608;
vmCvar_t	ui_skin609;
vmCvar_t	ui_skin610;
vmCvar_t	ui_skin611;
vmCvar_t	ui_skin612;
vmCvar_t	ui_skin613;
vmCvar_t	ui_skin614;
vmCvar_t	ui_skin615;
vmCvar_t	ui_skin616;
vmCvar_t	ui_skin617;
vmCvar_t	ui_skin618;
vmCvar_t	ui_skin619;
vmCvar_t	ui_skin620;
vmCvar_t	ui_skin621;
vmCvar_t	ui_skin622;
vmCvar_t	ui_skin623;
vmCvar_t	ui_skin624;
vmCvar_t	ui_skin625;
vmCvar_t	ui_skin626;
vmCvar_t	ui_skin627;
vmCvar_t	ui_skin628;
vmCvar_t	ui_skin629;
vmCvar_t	ui_skin630;
vmCvar_t	ui_skin631;
vmCvar_t	ui_skin632;
vmCvar_t	ui_skin633;
vmCvar_t	ui_skin634;
vmCvar_t	ui_skin635;
vmCvar_t	ui_skin636;
vmCvar_t	ui_skin637;
vmCvar_t	ui_skin638;
vmCvar_t	ui_skin639;
vmCvar_t	ui_skin640;
vmCvar_t	ui_skin641;
vmCvar_t	ui_skin642;
vmCvar_t	ui_skin643;
vmCvar_t	ui_skin644;
vmCvar_t	ui_skin645;
vmCvar_t	ui_skin646;
vmCvar_t	ui_skin647;
vmCvar_t	ui_skin648;
vmCvar_t	ui_skin649;
vmCvar_t	ui_skin650;
vmCvar_t	ui_skin651;
vmCvar_t	ui_skin652;
vmCvar_t	ui_skin653;
vmCvar_t	ui_skin654;
vmCvar_t	ui_skin655;
vmCvar_t	ui_skin656;
vmCvar_t	ui_skin657;
vmCvar_t	ui_skin658;
vmCvar_t	ui_skin659;
vmCvar_t	ui_skin660;
vmCvar_t	ui_skin661;
vmCvar_t	ui_skin662;
vmCvar_t	ui_skin663;
vmCvar_t	ui_skin664;
vmCvar_t	ui_skin665;
vmCvar_t	ui_skin666;
vmCvar_t	ui_skin667;
vmCvar_t	ui_skin668;
vmCvar_t	ui_skin669;
vmCvar_t	ui_skin670;
vmCvar_t	ui_skin671;
vmCvar_t	ui_skin672;
vmCvar_t	ui_skin673;
vmCvar_t	ui_skin674;
vmCvar_t	ui_skin675;
vmCvar_t	ui_skin676;
vmCvar_t	ui_skin677;
vmCvar_t	ui_skin678;
vmCvar_t	ui_skin679;
vmCvar_t	ui_skin680;
vmCvar_t	ui_skin681;
vmCvar_t	ui_skin682;
vmCvar_t	ui_skin683;
vmCvar_t	ui_skin684;
vmCvar_t	ui_skin685;
vmCvar_t	ui_skin686;
vmCvar_t	ui_skin687;
vmCvar_t	ui_skin688;
vmCvar_t	ui_skin689;
vmCvar_t	ui_skin690;
vmCvar_t	ui_skin691;
vmCvar_t	ui_skin692;
vmCvar_t	ui_skin693;
vmCvar_t	ui_skin694;
vmCvar_t	ui_skin695;
vmCvar_t	ui_skin696;
vmCvar_t	ui_skin697;
vmCvar_t	ui_skin698;
vmCvar_t	ui_skin699;
vmCvar_t	ui_skin700;
vmCvar_t	ui_skin701;
vmCvar_t	ui_skin702;
vmCvar_t	ui_skin703;
vmCvar_t	ui_skin704;
vmCvar_t	ui_skin705;
vmCvar_t	ui_skin706;
vmCvar_t	ui_skin707;
vmCvar_t	ui_skin708;
vmCvar_t	ui_skin709;
vmCvar_t	ui_skin710;
vmCvar_t	ui_skin711;
vmCvar_t	ui_skin712;
vmCvar_t	ui_skin713;
vmCvar_t	ui_skin714;
vmCvar_t	ui_skin715;
vmCvar_t	ui_skin716;
vmCvar_t	ui_skin717;
vmCvar_t	ui_skin718;
vmCvar_t	ui_skin719;
vmCvar_t	ui_skin720;
vmCvar_t	ui_skin721;
vmCvar_t	ui_skin722;
vmCvar_t	ui_skin723;
vmCvar_t	ui_skin724;
vmCvar_t	ui_skin725;
vmCvar_t	ui_skin726;
vmCvar_t	ui_skin727;
vmCvar_t	ui_skin728;
vmCvar_t	ui_skin729;
vmCvar_t	ui_skin730;
vmCvar_t	ui_skin731;
vmCvar_t	ui_skin732;
vmCvar_t	ui_skin733;
vmCvar_t	ui_skin734;
vmCvar_t	ui_skin735;
vmCvar_t	ui_skin736;
vmCvar_t	ui_skin737;
vmCvar_t	ui_skin738;
vmCvar_t	ui_skin739;
vmCvar_t	ui_skin740;
vmCvar_t	ui_skin741;
vmCvar_t	ui_skin742;
vmCvar_t	ui_skin743;
vmCvar_t	ui_skin744;
vmCvar_t	ui_skin745;
vmCvar_t	ui_skin746;
vmCvar_t	ui_skin747;
vmCvar_t	ui_skin748;
vmCvar_t	ui_skin749;
vmCvar_t	ui_skin750;
vmCvar_t	ui_skin751;
vmCvar_t	ui_skin752;
vmCvar_t	ui_skin753;
vmCvar_t	ui_skin754;
vmCvar_t	ui_skin755;
vmCvar_t	ui_skin756;
vmCvar_t	ui_skin757;
vmCvar_t	ui_skin758;
vmCvar_t	ui_skin759;
vmCvar_t	ui_skin760;
vmCvar_t	ui_skin761;
vmCvar_t	ui_skin762;
vmCvar_t	ui_skin763;
vmCvar_t	ui_skin764;
vmCvar_t	ui_skin765;
vmCvar_t	ui_skin766;
vmCvar_t	ui_skin767;
vmCvar_t	ui_skin768;
vmCvar_t	ui_skin769;
vmCvar_t	ui_skin770;
vmCvar_t	ui_skin771;
vmCvar_t	ui_skin772;
vmCvar_t	ui_skin773;
vmCvar_t	ui_skin774;
vmCvar_t	ui_skin775;
vmCvar_t	ui_skin776;
vmCvar_t	ui_skin777;
vmCvar_t	ui_skin778;
vmCvar_t	ui_skin779;
vmCvar_t	ui_skin780;
vmCvar_t	ui_skin781;
vmCvar_t	ui_skin782;
vmCvar_t	ui_skin783;
vmCvar_t	ui_skin784;
vmCvar_t	ui_skin785;
vmCvar_t	ui_skin786;
vmCvar_t	ui_skin787;
vmCvar_t	ui_skin788;
vmCvar_t	ui_skin789;
vmCvar_t	ui_skin790;
vmCvar_t	ui_skin791;
vmCvar_t	ui_skin792;
vmCvar_t	ui_skin793;
vmCvar_t	ui_skin794;
vmCvar_t	ui_skin795;
vmCvar_t	ui_skin796;
vmCvar_t	ui_skin797;
vmCvar_t	ui_skin798;
vmCvar_t	ui_skin799;
vmCvar_t	ui_skin800;
vmCvar_t	ui_skin801;
vmCvar_t	ui_skin802;
vmCvar_t	ui_skin803;
vmCvar_t	ui_skin804;
vmCvar_t	ui_skin805;
vmCvar_t	ui_skin806;
vmCvar_t	ui_skin807;
vmCvar_t	ui_skin808;
vmCvar_t	ui_skin809;
vmCvar_t	ui_skin810;
vmCvar_t	ui_skin811;
vmCvar_t	ui_skin812;
vmCvar_t	ui_skin813;
vmCvar_t	ui_skin814;
vmCvar_t	ui_skin815;
vmCvar_t	ui_skin816;
vmCvar_t	ui_skin817;
vmCvar_t	ui_skin818;
vmCvar_t	ui_skin819;
vmCvar_t	ui_skin820;
vmCvar_t	ui_skin821;
vmCvar_t	ui_skin822;
vmCvar_t	ui_skin823;
vmCvar_t	ui_skin824;
vmCvar_t	ui_skin825;
vmCvar_t	ui_skin826;
vmCvar_t	ui_skin827;
vmCvar_t	ui_skin828;
vmCvar_t	ui_skin829;
vmCvar_t	ui_skin830;
vmCvar_t	ui_skin831;
vmCvar_t	ui_skin832;
vmCvar_t	ui_skin833;
vmCvar_t	ui_skin834;
vmCvar_t	ui_skin835;
vmCvar_t	ui_skin836;
vmCvar_t	ui_skin837;
vmCvar_t	ui_skin838;
vmCvar_t	ui_skin839;
vmCvar_t	ui_skin840;
vmCvar_t	ui_skin841;
vmCvar_t	ui_skin842;
vmCvar_t	ui_skin843;
vmCvar_t	ui_skin844;
vmCvar_t	ui_skin845;
vmCvar_t	ui_skin846;
vmCvar_t	ui_skin847;
vmCvar_t	ui_skin848;
vmCvar_t	ui_skin849;
vmCvar_t	ui_skin850;	*/



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
	{ &ui_loaded, "ui_loaded", "0", CVAR_ARCHIVE },
	{ &ui_char, "ui_char", "0", CVAR_ARCHIVE },
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

/*	{ &ui_skin1, "ui_skin1", "0", CVAR_ARCHIVE },
	{ &ui_skin2, "ui_skin2", "0", CVAR_ARCHIVE },
	{ &ui_skin3, "ui_skin3", "0", CVAR_ARCHIVE },
	{ &ui_skin4, "ui_skin4", "0", CVAR_ARCHIVE },
	{ &ui_skin5, "ui_skin5", "0", CVAR_ARCHIVE },
	{ &ui_skin6, "ui_skin6", "0", CVAR_ARCHIVE },
	{ &ui_skin7, "ui_skin7", "0", CVAR_ARCHIVE },
	{ &ui_skin8, "ui_skin8", "0", CVAR_ARCHIVE },
	{ &ui_skin9, "ui_skin9", "0", CVAR_ARCHIVE },
	{ &ui_skin10, "ui_skin10", "0", CVAR_ARCHIVE },
	{ &ui_skin11, "ui_skin11", "0", CVAR_ARCHIVE },
	{ &ui_skin12, "ui_skin12", "0", CVAR_ARCHIVE },
	{ &ui_skin13, "ui_skin13", "0", CVAR_ARCHIVE },
	{ &ui_skin14, "ui_skin14", "0", CVAR_ARCHIVE },
	{ &ui_skin15, "ui_skin15", "0", CVAR_ARCHIVE },
	{ &ui_skin16, "ui_skin16", "0", CVAR_ARCHIVE },
	{ &ui_skin17, "ui_skin17", "0", CVAR_ARCHIVE },
	{ &ui_skin18, "ui_skin18", "0", CVAR_ARCHIVE },
	{ &ui_skin19, "ui_skin19", "0", CVAR_ARCHIVE },
	{ &ui_skin20, "ui_skin20", "0", CVAR_ARCHIVE },
	{ &ui_skin21, "ui_skin21", "0", CVAR_ARCHIVE },
	{ &ui_skin22, "ui_skin22", "0", CVAR_ARCHIVE },
	{ &ui_skin23, "ui_skin23", "0", CVAR_ARCHIVE },
	{ &ui_skin24, "ui_skin24", "0", CVAR_ARCHIVE },
	{ &ui_skin25, "ui_skin25", "0", CVAR_ARCHIVE },
	{ &ui_skin26, "ui_skin26", "0", CVAR_ARCHIVE },
	{ &ui_skin27, "ui_skin27", "0", CVAR_ARCHIVE },
	{ &ui_skin28, "ui_skin28", "0", CVAR_ARCHIVE },
	{ &ui_skin29, "ui_skin29", "0", CVAR_ARCHIVE },
	{ &ui_skin30, "ui_skin30", "0", CVAR_ARCHIVE },
	{ &ui_skin31, "ui_skin31", "0", CVAR_ARCHIVE },
	{ &ui_skin32, "ui_skin32", "0", CVAR_ARCHIVE },
	{ &ui_skin33, "ui_skin33", "0", CVAR_ARCHIVE },
	{ &ui_skin34, "ui_skin34", "0", CVAR_ARCHIVE },
	{ &ui_skin35, "ui_skin35", "0", CVAR_ARCHIVE },
	{ &ui_skin36, "ui_skin36", "0", CVAR_ARCHIVE },
	{ &ui_skin37, "ui_skin37", "0", CVAR_ARCHIVE },
	{ &ui_skin38, "ui_skin38", "0", CVAR_ARCHIVE },
	{ &ui_skin39, "ui_skin39", "0", CVAR_ARCHIVE },
	{ &ui_skin40, "ui_skin40", "0", CVAR_ARCHIVE },
	{ &ui_skin41, "ui_skin41", "0", CVAR_ARCHIVE },
	{ &ui_skin42, "ui_skin42", "0", CVAR_ARCHIVE },
	{ &ui_skin43, "ui_skin43", "0", CVAR_ARCHIVE },
	{ &ui_skin44, "ui_skin44", "0", CVAR_ARCHIVE },
	{ &ui_skin45, "ui_skin45", "0", CVAR_ARCHIVE },
	{ &ui_skin46, "ui_skin46", "0", CVAR_ARCHIVE },
	{ &ui_skin47, "ui_skin47", "0", CVAR_ARCHIVE },
	{ &ui_skin48, "ui_skin48", "0", CVAR_ARCHIVE },
	{ &ui_skin49, "ui_skin49", "0", CVAR_ARCHIVE },
	{ &ui_skin50, "ui_skin50", "0", CVAR_ARCHIVE },
	{ &ui_skin51, "ui_skin51", "0", CVAR_ARCHIVE },
	{ &ui_skin52, "ui_skin52", "0", CVAR_ARCHIVE },
	{ &ui_skin53, "ui_skin53", "0", CVAR_ARCHIVE },
	{ &ui_skin54, "ui_skin54", "0", CVAR_ARCHIVE },
	{ &ui_skin55, "ui_skin55", "0", CVAR_ARCHIVE },
	{ &ui_skin56, "ui_skin56", "0", CVAR_ARCHIVE },
	{ &ui_skin57, "ui_skin57", "0", CVAR_ARCHIVE },
	{ &ui_skin58, "ui_skin58", "0", CVAR_ARCHIVE },
	{ &ui_skin59, "ui_skin59", "0", CVAR_ARCHIVE },
	{ &ui_skin60, "ui_skin60", "0", CVAR_ARCHIVE },
	{ &ui_skin61, "ui_skin61", "0", CVAR_ARCHIVE },
	{ &ui_skin62, "ui_skin62", "0", CVAR_ARCHIVE },
	{ &ui_skin63, "ui_skin63", "0", CVAR_ARCHIVE },
	{ &ui_skin64, "ui_skin64", "0", CVAR_ARCHIVE },
	{ &ui_skin65, "ui_skin65", "0", CVAR_ARCHIVE },
	{ &ui_skin66, "ui_skin66", "0", CVAR_ARCHIVE },
	{ &ui_skin67, "ui_skin67", "0", CVAR_ARCHIVE },
	{ &ui_skin68, "ui_skin68", "0", CVAR_ARCHIVE },
	{ &ui_skin69, "ui_skin69", "0", CVAR_ARCHIVE },
	{ &ui_skin70, "ui_skin70", "0", CVAR_ARCHIVE },
	{ &ui_skin71, "ui_skin71", "0", CVAR_ARCHIVE },
	{ &ui_skin72, "ui_skin72", "0", CVAR_ARCHIVE },
	{ &ui_skin73, "ui_skin73", "0", CVAR_ARCHIVE },
	{ &ui_skin74, "ui_skin74", "0", CVAR_ARCHIVE },
	{ &ui_skin75, "ui_skin75", "0", CVAR_ARCHIVE },
	{ &ui_skin76, "ui_skin76", "0", CVAR_ARCHIVE },
	{ &ui_skin77, "ui_skin77", "0", CVAR_ARCHIVE },
	{ &ui_skin78, "ui_skin78", "0", CVAR_ARCHIVE },
	{ &ui_skin79, "ui_skin79", "0", CVAR_ARCHIVE },
	{ &ui_skin80, "ui_skin80", "0", CVAR_ARCHIVE },
	{ &ui_skin81, "ui_skin81", "0", CVAR_ARCHIVE },
	{ &ui_skin82, "ui_skin82", "0", CVAR_ARCHIVE },
	{ &ui_skin83, "ui_skin83", "0", CVAR_ARCHIVE },
	{ &ui_skin84, "ui_skin84", "0", CVAR_ARCHIVE },
	{ &ui_skin85, "ui_skin85", "0", CVAR_ARCHIVE },
	{ &ui_skin86, "ui_skin86", "0", CVAR_ARCHIVE },
	{ &ui_skin87, "ui_skin87", "0", CVAR_ARCHIVE },
	{ &ui_skin88, "ui_skin88", "0", CVAR_ARCHIVE },
	{ &ui_skin89, "ui_skin89", "0", CVAR_ARCHIVE },
	{ &ui_skin90, "ui_skin90", "0", CVAR_ARCHIVE },
	{ &ui_skin91, "ui_skin91", "0", CVAR_ARCHIVE },
	{ &ui_skin92, "ui_skin92", "0", CVAR_ARCHIVE },
	{ &ui_skin93, "ui_skin93", "0", CVAR_ARCHIVE },
	{ &ui_skin94, "ui_skin94", "0", CVAR_ARCHIVE },
	{ &ui_skin95, "ui_skin95", "0", CVAR_ARCHIVE },
	{ &ui_skin96, "ui_skin96", "0", CVAR_ARCHIVE },
	{ &ui_skin97, "ui_skin97", "0", CVAR_ARCHIVE },
	{ &ui_skin98, "ui_skin98", "0", CVAR_ARCHIVE },
	{ &ui_skin99, "ui_skin99", "0", CVAR_ARCHIVE },
	{ &ui_skin100, "ui_skin100", "0", CVAR_ARCHIVE },
	{ &ui_skin101, "ui_skin101", "0", CVAR_ARCHIVE },
	{ &ui_skin102, "ui_skin102", "0", CVAR_ARCHIVE },
	{ &ui_skin103, "ui_skin103", "0", CVAR_ARCHIVE },
	{ &ui_skin104, "ui_skin104", "0", CVAR_ARCHIVE },
	{ &ui_skin105, "ui_skin105", "0", CVAR_ARCHIVE },
	{ &ui_skin106, "ui_skin106", "0", CVAR_ARCHIVE },
	{ &ui_skin107, "ui_skin107", "0", CVAR_ARCHIVE },
	{ &ui_skin108, "ui_skin108", "0", CVAR_ARCHIVE },
	{ &ui_skin109, "ui_skin109", "0", CVAR_ARCHIVE },
	{ &ui_skin110, "ui_skin110", "0", CVAR_ARCHIVE },
	{ &ui_skin111, "ui_skin111", "0", CVAR_ARCHIVE },
	{ &ui_skin112, "ui_skin112", "0", CVAR_ARCHIVE },
	{ &ui_skin113, "ui_skin113", "0", CVAR_ARCHIVE },
	{ &ui_skin114, "ui_skin114", "0", CVAR_ARCHIVE },
	{ &ui_skin115, "ui_skin115", "0", CVAR_ARCHIVE },
	{ &ui_skin116, "ui_skin116", "0", CVAR_ARCHIVE },
	{ &ui_skin117, "ui_skin117", "0", CVAR_ARCHIVE },
	{ &ui_skin118, "ui_skin118", "0", CVAR_ARCHIVE },
	{ &ui_skin119, "ui_skin119", "0", CVAR_ARCHIVE },
	{ &ui_skin120, "ui_skin120", "0", CVAR_ARCHIVE },
	{ &ui_skin121, "ui_skin121", "0", CVAR_ARCHIVE },
	{ &ui_skin122, "ui_skin122", "0", CVAR_ARCHIVE },
	{ &ui_skin123, "ui_skin123", "0", CVAR_ARCHIVE },
	{ &ui_skin124, "ui_skin124", "0", CVAR_ARCHIVE },
	{ &ui_skin125, "ui_skin125", "0", CVAR_ARCHIVE },
	{ &ui_skin126, "ui_skin126", "0", CVAR_ARCHIVE },
	{ &ui_skin127, "ui_skin127", "0", CVAR_ARCHIVE },
	{ &ui_skin128, "ui_skin128", "0", CVAR_ARCHIVE },
	{ &ui_skin129, "ui_skin129", "0", CVAR_ARCHIVE },
	{ &ui_skin130, "ui_skin130", "0", CVAR_ARCHIVE },
	{ &ui_skin131, "ui_skin131", "0", CVAR_ARCHIVE },
	{ &ui_skin132, "ui_skin132", "0", CVAR_ARCHIVE },
	{ &ui_skin133, "ui_skin133", "0", CVAR_ARCHIVE },
	{ &ui_skin134, "ui_skin134", "0", CVAR_ARCHIVE },
	{ &ui_skin135, "ui_skin135", "0", CVAR_ARCHIVE },
	{ &ui_skin136, "ui_skin136", "0", CVAR_ARCHIVE },
	{ &ui_skin137, "ui_skin137", "0", CVAR_ARCHIVE },
	{ &ui_skin138, "ui_skin138", "0", CVAR_ARCHIVE },
	{ &ui_skin139, "ui_skin139", "0", CVAR_ARCHIVE },
	{ &ui_skin140, "ui_skin140", "0", CVAR_ARCHIVE },
	{ &ui_skin141, "ui_skin141", "0", CVAR_ARCHIVE },
	{ &ui_skin142, "ui_skin142", "0", CVAR_ARCHIVE },
	{ &ui_skin143, "ui_skin143", "0", CVAR_ARCHIVE },
	{ &ui_skin144, "ui_skin144", "0", CVAR_ARCHIVE },
	{ &ui_skin145, "ui_skin145", "0", CVAR_ARCHIVE },
	{ &ui_skin146, "ui_skin146", "0", CVAR_ARCHIVE },
	{ &ui_skin147, "ui_skin147", "0", CVAR_ARCHIVE },
	{ &ui_skin148, "ui_skin148", "0", CVAR_ARCHIVE },
	{ &ui_skin149, "ui_skin149", "0", CVAR_ARCHIVE },
	{ &ui_skin150, "ui_skin150", "0", CVAR_ARCHIVE },
	{ &ui_skin151, "ui_skin151", "0", CVAR_ARCHIVE },
	{ &ui_skin152, "ui_skin152", "0", CVAR_ARCHIVE },
	{ &ui_skin153, "ui_skin153", "0", CVAR_ARCHIVE },
	{ &ui_skin154, "ui_skin154", "0", CVAR_ARCHIVE },
	{ &ui_skin155, "ui_skin155", "0", CVAR_ARCHIVE },
	{ &ui_skin156, "ui_skin156", "0", CVAR_ARCHIVE },
	{ &ui_skin157, "ui_skin157", "0", CVAR_ARCHIVE },
	{ &ui_skin158, "ui_skin158", "0", CVAR_ARCHIVE },
	{ &ui_skin159, "ui_skin159", "0", CVAR_ARCHIVE },
	{ &ui_skin160, "ui_skin160", "0", CVAR_ARCHIVE },
	{ &ui_skin161, "ui_skin161", "0", CVAR_ARCHIVE },
	{ &ui_skin162, "ui_skin162", "0", CVAR_ARCHIVE },
	{ &ui_skin163, "ui_skin163", "0", CVAR_ARCHIVE },
	{ &ui_skin164, "ui_skin164", "0", CVAR_ARCHIVE },
	{ &ui_skin165, "ui_skin165", "0", CVAR_ARCHIVE },
	{ &ui_skin166, "ui_skin166", "0", CVAR_ARCHIVE },
	{ &ui_skin167, "ui_skin167", "0", CVAR_ARCHIVE },
	{ &ui_skin168, "ui_skin168", "0", CVAR_ARCHIVE },
	{ &ui_skin169, "ui_skin169", "0", CVAR_ARCHIVE },
	{ &ui_skin170, "ui_skin170", "0", CVAR_ARCHIVE },
	{ &ui_skin171, "ui_skin171", "0", CVAR_ARCHIVE },
	{ &ui_skin172, "ui_skin172", "0", CVAR_ARCHIVE },
	{ &ui_skin173, "ui_skin173", "0", CVAR_ARCHIVE },
	{ &ui_skin174, "ui_skin174", "0", CVAR_ARCHIVE },
	{ &ui_skin175, "ui_skin175", "0", CVAR_ARCHIVE },
	{ &ui_skin176, "ui_skin176", "0", CVAR_ARCHIVE },
	{ &ui_skin177, "ui_skin177", "0", CVAR_ARCHIVE },
	{ &ui_skin178, "ui_skin178", "0", CVAR_ARCHIVE },
	{ &ui_skin179, "ui_skin179", "0", CVAR_ARCHIVE },
	{ &ui_skin180, "ui_skin180", "0", CVAR_ARCHIVE },
	{ &ui_skin181, "ui_skin181", "0", CVAR_ARCHIVE },
	{ &ui_skin182, "ui_skin182", "0", CVAR_ARCHIVE },
	{ &ui_skin183, "ui_skin183", "0", CVAR_ARCHIVE },
	{ &ui_skin184, "ui_skin184", "0", CVAR_ARCHIVE },
	{ &ui_skin185, "ui_skin185", "0", CVAR_ARCHIVE },
	{ &ui_skin186, "ui_skin186", "0", CVAR_ARCHIVE },
	{ &ui_skin187, "ui_skin187", "0", CVAR_ARCHIVE },
	{ &ui_skin188, "ui_skin188", "0", CVAR_ARCHIVE },
	{ &ui_skin189, "ui_skin189", "0", CVAR_ARCHIVE },
	{ &ui_skin190, "ui_skin190", "0", CVAR_ARCHIVE },
	{ &ui_skin191, "ui_skin191", "0", CVAR_ARCHIVE },
	{ &ui_skin192, "ui_skin192", "0", CVAR_ARCHIVE },
	{ &ui_skin193, "ui_skin193", "0", CVAR_ARCHIVE },
	{ &ui_skin194, "ui_skin194", "0", CVAR_ARCHIVE },
	{ &ui_skin195, "ui_skin195", "0", CVAR_ARCHIVE },
	{ &ui_skin196, "ui_skin196", "0", CVAR_ARCHIVE },
	{ &ui_skin197, "ui_skin197", "0", CVAR_ARCHIVE },
	{ &ui_skin198, "ui_skin198", "0", CVAR_ARCHIVE },
	{ &ui_skin199, "ui_skin199", "0", CVAR_ARCHIVE },
	{ &ui_skin200, "ui_skin200", "0", CVAR_ARCHIVE },
	{ &ui_skin201, "ui_skin201", "0", CVAR_ARCHIVE },
	{ &ui_skin202, "ui_skin202", "0", CVAR_ARCHIVE },
	{ &ui_skin203, "ui_skin203", "0", CVAR_ARCHIVE },
	{ &ui_skin204, "ui_skin204", "0", CVAR_ARCHIVE },
	{ &ui_skin205, "ui_skin205", "0", CVAR_ARCHIVE },
	{ &ui_skin206, "ui_skin206", "0", CVAR_ARCHIVE },
	{ &ui_skin207, "ui_skin207", "0", CVAR_ARCHIVE },
	{ &ui_skin208, "ui_skin208", "0", CVAR_ARCHIVE },
	{ &ui_skin209, "ui_skin209", "0", CVAR_ARCHIVE },
	{ &ui_skin210, "ui_skin210", "0", CVAR_ARCHIVE },
	{ &ui_skin211, "ui_skin211", "0", CVAR_ARCHIVE },
	{ &ui_skin212, "ui_skin212", "0", CVAR_ARCHIVE },
	{ &ui_skin213, "ui_skin213", "0", CVAR_ARCHIVE },
	{ &ui_skin214, "ui_skin214", "0", CVAR_ARCHIVE },
	{ &ui_skin215, "ui_skin215", "0", CVAR_ARCHIVE },
	{ &ui_skin216, "ui_skin216", "0", CVAR_ARCHIVE },
	{ &ui_skin217, "ui_skin217", "0", CVAR_ARCHIVE },
	{ &ui_skin218, "ui_skin218", "0", CVAR_ARCHIVE },
	{ &ui_skin219, "ui_skin219", "0", CVAR_ARCHIVE },
	{ &ui_skin220, "ui_skin220", "0", CVAR_ARCHIVE },
	{ &ui_skin221, "ui_skin221", "0", CVAR_ARCHIVE },
	{ &ui_skin222, "ui_skin222", "0", CVAR_ARCHIVE },
	{ &ui_skin223, "ui_skin223", "0", CVAR_ARCHIVE },
	{ &ui_skin224, "ui_skin224", "0", CVAR_ARCHIVE },
	{ &ui_skin225, "ui_skin225", "0", CVAR_ARCHIVE },
	{ &ui_skin226, "ui_skin226", "0", CVAR_ARCHIVE },
	{ &ui_skin227, "ui_skin227", "0", CVAR_ARCHIVE },
	{ &ui_skin228, "ui_skin228", "0", CVAR_ARCHIVE },
	{ &ui_skin229, "ui_skin229", "0", CVAR_ARCHIVE },
	{ &ui_skin230, "ui_skin230", "0", CVAR_ARCHIVE },
	{ &ui_skin231, "ui_skin231", "0", CVAR_ARCHIVE },
	{ &ui_skin232, "ui_skin232", "0", CVAR_ARCHIVE },
	{ &ui_skin233, "ui_skin233", "0", CVAR_ARCHIVE },
	{ &ui_skin234, "ui_skin234", "0", CVAR_ARCHIVE },
	{ &ui_skin235, "ui_skin235", "0", CVAR_ARCHIVE },
	{ &ui_skin236, "ui_skin236", "0", CVAR_ARCHIVE },
	{ &ui_skin237, "ui_skin237", "0", CVAR_ARCHIVE },
	{ &ui_skin238, "ui_skin238", "0", CVAR_ARCHIVE },
	{ &ui_skin239, "ui_skin239", "0", CVAR_ARCHIVE },
	{ &ui_skin240, "ui_skin240", "0", CVAR_ARCHIVE },
	{ &ui_skin241, "ui_skin241", "0", CVAR_ARCHIVE },
	{ &ui_skin242, "ui_skin242", "0", CVAR_ARCHIVE },
	{ &ui_skin243, "ui_skin243", "0", CVAR_ARCHIVE },
	{ &ui_skin244, "ui_skin244", "0", CVAR_ARCHIVE },
	{ &ui_skin245, "ui_skin245", "0", CVAR_ARCHIVE },
	{ &ui_skin246, "ui_skin246", "0", CVAR_ARCHIVE },
	{ &ui_skin247, "ui_skin247", "0", CVAR_ARCHIVE },
	{ &ui_skin248, "ui_skin248", "0", CVAR_ARCHIVE },
	{ &ui_skin249, "ui_skin249", "0", CVAR_ARCHIVE },
	{ &ui_skin250, "ui_skin250", "0", CVAR_ARCHIVE },
	{ &ui_skin251, "ui_skin251", "0", CVAR_ARCHIVE },
	{ &ui_skin252, "ui_skin252", "0", CVAR_ARCHIVE },
	{ &ui_skin253, "ui_skin253", "0", CVAR_ARCHIVE },
	{ &ui_skin254, "ui_skin254", "0", CVAR_ARCHIVE },
	{ &ui_skin255, "ui_skin255", "0", CVAR_ARCHIVE },
	{ &ui_skin256, "ui_skin256", "0", CVAR_ARCHIVE },
	{ &ui_skin257, "ui_skin257", "0", CVAR_ARCHIVE },
	{ &ui_skin258, "ui_skin258", "0", CVAR_ARCHIVE },
	{ &ui_skin259, "ui_skin259", "0", CVAR_ARCHIVE },
	{ &ui_skin260, "ui_skin260", "0", CVAR_ARCHIVE },
	{ &ui_skin261, "ui_skin261", "0", CVAR_ARCHIVE },
	{ &ui_skin262, "ui_skin262", "0", CVAR_ARCHIVE },
	{ &ui_skin263, "ui_skin263", "0", CVAR_ARCHIVE },
	{ &ui_skin264, "ui_skin264", "0", CVAR_ARCHIVE },
	{ &ui_skin265, "ui_skin265", "0", CVAR_ARCHIVE },
	{ &ui_skin266, "ui_skin266", "0", CVAR_ARCHIVE },
	{ &ui_skin267, "ui_skin267", "0", CVAR_ARCHIVE },
	{ &ui_skin268, "ui_skin268", "0", CVAR_ARCHIVE },
	{ &ui_skin269, "ui_skin269", "0", CVAR_ARCHIVE },
	{ &ui_skin270, "ui_skin270", "0", CVAR_ARCHIVE },
	{ &ui_skin271, "ui_skin271", "0", CVAR_ARCHIVE },
	{ &ui_skin272, "ui_skin272", "0", CVAR_ARCHIVE },
	{ &ui_skin273, "ui_skin273", "0", CVAR_ARCHIVE },
	{ &ui_skin274, "ui_skin274", "0", CVAR_ARCHIVE },
	{ &ui_skin275, "ui_skin275", "0", CVAR_ARCHIVE },
	{ &ui_skin276, "ui_skin276", "0", CVAR_ARCHIVE },
	{ &ui_skin277, "ui_skin277", "0", CVAR_ARCHIVE },
	{ &ui_skin278, "ui_skin278", "0", CVAR_ARCHIVE },
	{ &ui_skin279, "ui_skin279", "0", CVAR_ARCHIVE },
	{ &ui_skin280, "ui_skin280", "0", CVAR_ARCHIVE },
	{ &ui_skin281, "ui_skin281", "0", CVAR_ARCHIVE },
	{ &ui_skin282, "ui_skin282", "0", CVAR_ARCHIVE },
	{ &ui_skin283, "ui_skin283", "0", CVAR_ARCHIVE },
	{ &ui_skin284, "ui_skin284", "0", CVAR_ARCHIVE },
	{ &ui_skin285, "ui_skin285", "0", CVAR_ARCHIVE },
	{ &ui_skin286, "ui_skin286", "0", CVAR_ARCHIVE },
	{ &ui_skin287, "ui_skin287", "0", CVAR_ARCHIVE },
	{ &ui_skin288, "ui_skin288", "0", CVAR_ARCHIVE },
	{ &ui_skin289, "ui_skin289", "0", CVAR_ARCHIVE },
	{ &ui_skin290, "ui_skin290", "0", CVAR_ARCHIVE },
	{ &ui_skin291, "ui_skin291", "0", CVAR_ARCHIVE },
	{ &ui_skin292, "ui_skin292", "0", CVAR_ARCHIVE },
	{ &ui_skin293, "ui_skin293", "0", CVAR_ARCHIVE },
	{ &ui_skin294, "ui_skin294", "0", CVAR_ARCHIVE },
	{ &ui_skin295, "ui_skin295", "0", CVAR_ARCHIVE },
	{ &ui_skin296, "ui_skin296", "0", CVAR_ARCHIVE },
	{ &ui_skin297, "ui_skin297", "0", CVAR_ARCHIVE },
	{ &ui_skin298, "ui_skin298", "0", CVAR_ARCHIVE },
	{ &ui_skin299, "ui_skin299", "0", CVAR_ARCHIVE },
	{ &ui_skin300, "ui_skin300", "0", CVAR_ARCHIVE },
	{ &ui_skin301, "ui_skin301", "0", CVAR_ARCHIVE },
	{ &ui_skin302, "ui_skin302", "0", CVAR_ARCHIVE },
	{ &ui_skin303, "ui_skin303", "0", CVAR_ARCHIVE },
	{ &ui_skin304, "ui_skin304", "0", CVAR_ARCHIVE },
	{ &ui_skin305, "ui_skin305", "0", CVAR_ARCHIVE },
	{ &ui_skin306, "ui_skin306", "0", CVAR_ARCHIVE },
	{ &ui_skin307, "ui_skin307", "0", CVAR_ARCHIVE },
	{ &ui_skin308, "ui_skin308", "0", CVAR_ARCHIVE },
	{ &ui_skin309, "ui_skin309", "0", CVAR_ARCHIVE },
	{ &ui_skin310, "ui_skin310", "0", CVAR_ARCHIVE },
	{ &ui_skin311, "ui_skin311", "0", CVAR_ARCHIVE },
	{ &ui_skin312, "ui_skin312", "0", CVAR_ARCHIVE },
	{ &ui_skin313, "ui_skin313", "0", CVAR_ARCHIVE },
	{ &ui_skin314, "ui_skin314", "0", CVAR_ARCHIVE },
	{ &ui_skin315, "ui_skin315", "0", CVAR_ARCHIVE },
	{ &ui_skin316, "ui_skin316", "0", CVAR_ARCHIVE },
	{ &ui_skin317, "ui_skin317", "0", CVAR_ARCHIVE },
	{ &ui_skin318, "ui_skin318", "0", CVAR_ARCHIVE },
	{ &ui_skin319, "ui_skin319", "0", CVAR_ARCHIVE },
	{ &ui_skin320, "ui_skin320", "0", CVAR_ARCHIVE },
	{ &ui_skin321, "ui_skin321", "0", CVAR_ARCHIVE },
	{ &ui_skin322, "ui_skin322", "0", CVAR_ARCHIVE },
	{ &ui_skin323, "ui_skin323", "0", CVAR_ARCHIVE },
	{ &ui_skin324, "ui_skin324", "0", CVAR_ARCHIVE },
	{ &ui_skin325, "ui_skin325", "0", CVAR_ARCHIVE },
	{ &ui_skin326, "ui_skin326", "0", CVAR_ARCHIVE },
	{ &ui_skin327, "ui_skin327", "0", CVAR_ARCHIVE },
	{ &ui_skin328, "ui_skin328", "0", CVAR_ARCHIVE },
	{ &ui_skin329, "ui_skin329", "0", CVAR_ARCHIVE },
	{ &ui_skin330, "ui_skin330", "0", CVAR_ARCHIVE },
	{ &ui_skin331, "ui_skin331", "0", CVAR_ARCHIVE },
	{ &ui_skin332, "ui_skin332", "0", CVAR_ARCHIVE },
	{ &ui_skin333, "ui_skin333", "0", CVAR_ARCHIVE },
	{ &ui_skin334, "ui_skin334", "0", CVAR_ARCHIVE },
	{ &ui_skin335, "ui_skin335", "0", CVAR_ARCHIVE },
	{ &ui_skin336, "ui_skin336", "0", CVAR_ARCHIVE },
	{ &ui_skin337, "ui_skin337", "0", CVAR_ARCHIVE },
	{ &ui_skin338, "ui_skin338", "0", CVAR_ARCHIVE },
	{ &ui_skin339, "ui_skin339", "0", CVAR_ARCHIVE },
	{ &ui_skin340, "ui_skin340", "0", CVAR_ARCHIVE },
	{ &ui_skin341, "ui_skin341", "0", CVAR_ARCHIVE },
	{ &ui_skin342, "ui_skin342", "0", CVAR_ARCHIVE },
	{ &ui_skin343, "ui_skin343", "0", CVAR_ARCHIVE },
	{ &ui_skin344, "ui_skin344", "0", CVAR_ARCHIVE },
	{ &ui_skin345, "ui_skin345", "0", CVAR_ARCHIVE },
	{ &ui_skin346, "ui_skin346", "0", CVAR_ARCHIVE },
	{ &ui_skin347, "ui_skin347", "0", CVAR_ARCHIVE },
	{ &ui_skin348, "ui_skin348", "0", CVAR_ARCHIVE },
	{ &ui_skin349, "ui_skin349", "0", CVAR_ARCHIVE },
	{ &ui_skin350, "ui_skin350", "0", CVAR_ARCHIVE },
	{ &ui_skin351, "ui_skin351", "0", CVAR_ARCHIVE },
	{ &ui_skin352, "ui_skin352", "0", CVAR_ARCHIVE },
	{ &ui_skin353, "ui_skin353", "0", CVAR_ARCHIVE },
	{ &ui_skin354, "ui_skin354", "0", CVAR_ARCHIVE },
	{ &ui_skin355, "ui_skin355", "0", CVAR_ARCHIVE },
	{ &ui_skin356, "ui_skin356", "0", CVAR_ARCHIVE },
	{ &ui_skin357, "ui_skin357", "0", CVAR_ARCHIVE },
	{ &ui_skin358, "ui_skin358", "0", CVAR_ARCHIVE },
	{ &ui_skin359, "ui_skin359", "0", CVAR_ARCHIVE },
	{ &ui_skin360, "ui_skin360", "0", CVAR_ARCHIVE },
	{ &ui_skin361, "ui_skin361", "0", CVAR_ARCHIVE },
	{ &ui_skin362, "ui_skin362", "0", CVAR_ARCHIVE },
	{ &ui_skin363, "ui_skin363", "0", CVAR_ARCHIVE },
	{ &ui_skin364, "ui_skin364", "0", CVAR_ARCHIVE },
	{ &ui_skin365, "ui_skin365", "0", CVAR_ARCHIVE },
	{ &ui_skin366, "ui_skin366", "0", CVAR_ARCHIVE },
	{ &ui_skin367, "ui_skin367", "0", CVAR_ARCHIVE },
	{ &ui_skin368, "ui_skin368", "0", CVAR_ARCHIVE },
	{ &ui_skin369, "ui_skin369", "0", CVAR_ARCHIVE },
	{ &ui_skin370, "ui_skin370", "0", CVAR_ARCHIVE },
	{ &ui_skin371, "ui_skin371", "0", CVAR_ARCHIVE },
	{ &ui_skin372, "ui_skin372", "0", CVAR_ARCHIVE },
	{ &ui_skin373, "ui_skin373", "0", CVAR_ARCHIVE },
	{ &ui_skin374, "ui_skin374", "0", CVAR_ARCHIVE },
	{ &ui_skin375, "ui_skin375", "0", CVAR_ARCHIVE },
	{ &ui_skin376, "ui_skin376", "0", CVAR_ARCHIVE },
	{ &ui_skin377, "ui_skin377", "0", CVAR_ARCHIVE },
	{ &ui_skin378, "ui_skin378", "0", CVAR_ARCHIVE },
	{ &ui_skin379, "ui_skin379", "0", CVAR_ARCHIVE },
	{ &ui_skin380, "ui_skin380", "0", CVAR_ARCHIVE },
	{ &ui_skin381, "ui_skin381", "0", CVAR_ARCHIVE },
	{ &ui_skin382, "ui_skin382", "0", CVAR_ARCHIVE },
	{ &ui_skin383, "ui_skin383", "0", CVAR_ARCHIVE },
	{ &ui_skin384, "ui_skin384", "0", CVAR_ARCHIVE },
	{ &ui_skin385, "ui_skin385", "0", CVAR_ARCHIVE },
	{ &ui_skin386, "ui_skin386", "0", CVAR_ARCHIVE },
	{ &ui_skin387, "ui_skin387", "0", CVAR_ARCHIVE },
	{ &ui_skin388, "ui_skin388", "0", CVAR_ARCHIVE },
	{ &ui_skin389, "ui_skin389", "0", CVAR_ARCHIVE },
	{ &ui_skin390, "ui_skin390", "0", CVAR_ARCHIVE },
	{ &ui_skin391, "ui_skin391", "0", CVAR_ARCHIVE },
	{ &ui_skin392, "ui_skin392", "0", CVAR_ARCHIVE },
	{ &ui_skin393, "ui_skin393", "0", CVAR_ARCHIVE },
	{ &ui_skin394, "ui_skin394", "0", CVAR_ARCHIVE },
	{ &ui_skin395, "ui_skin395", "0", CVAR_ARCHIVE },
	{ &ui_skin396, "ui_skin396", "0", CVAR_ARCHIVE },
	{ &ui_skin397, "ui_skin397", "0", CVAR_ARCHIVE },
	{ &ui_skin398, "ui_skin398", "0", CVAR_ARCHIVE },
	{ &ui_skin399, "ui_skin399", "0", CVAR_ARCHIVE },
	{ &ui_skin400, "ui_skin400", "0", CVAR_ARCHIVE },
	{ &ui_skin401, "ui_skin401", "0", CVAR_ARCHIVE },
	{ &ui_skin402, "ui_skin402", "0", CVAR_ARCHIVE },
	{ &ui_skin403, "ui_skin403", "0", CVAR_ARCHIVE },
	{ &ui_skin404, "ui_skin404", "0", CVAR_ARCHIVE },
	{ &ui_skin405, "ui_skin405", "0", CVAR_ARCHIVE },
	{ &ui_skin406, "ui_skin406", "0", CVAR_ARCHIVE },
	{ &ui_skin407, "ui_skin407", "0", CVAR_ARCHIVE },
	{ &ui_skin408, "ui_skin408", "0", CVAR_ARCHIVE },
	{ &ui_skin409, "ui_skin409", "0", CVAR_ARCHIVE },
	{ &ui_skin410, "ui_skin410", "0", CVAR_ARCHIVE },
	{ &ui_skin411, "ui_skin411", "0", CVAR_ARCHIVE },
	{ &ui_skin412, "ui_skin412", "0", CVAR_ARCHIVE },
	{ &ui_skin413, "ui_skin413", "0", CVAR_ARCHIVE },
	{ &ui_skin414, "ui_skin414", "0", CVAR_ARCHIVE },
	{ &ui_skin415, "ui_skin415", "0", CVAR_ARCHIVE },
	{ &ui_skin416, "ui_skin416", "0", CVAR_ARCHIVE },
	{ &ui_skin417, "ui_skin417", "0", CVAR_ARCHIVE },
	{ &ui_skin418, "ui_skin418", "0", CVAR_ARCHIVE },
	{ &ui_skin419, "ui_skin419", "0", CVAR_ARCHIVE },
	{ &ui_skin420, "ui_skin420", "0", CVAR_ARCHIVE },
	{ &ui_skin421, "ui_skin421", "0", CVAR_ARCHIVE },
	{ &ui_skin422, "ui_skin422", "0", CVAR_ARCHIVE },
	{ &ui_skin423, "ui_skin423", "0", CVAR_ARCHIVE },
	{ &ui_skin424, "ui_skin424", "0", CVAR_ARCHIVE },
	{ &ui_skin425, "ui_skin425", "0", CVAR_ARCHIVE },
	{ &ui_skin426, "ui_skin426", "0", CVAR_ARCHIVE },
	{ &ui_skin427, "ui_skin427", "0", CVAR_ARCHIVE },
	{ &ui_skin428, "ui_skin428", "0", CVAR_ARCHIVE },
	{ &ui_skin429, "ui_skin429", "0", CVAR_ARCHIVE },
	{ &ui_skin430, "ui_skin430", "0", CVAR_ARCHIVE },
	{ &ui_skin431, "ui_skin431", "0", CVAR_ARCHIVE },
	{ &ui_skin432, "ui_skin432", "0", CVAR_ARCHIVE },
	{ &ui_skin433, "ui_skin433", "0", CVAR_ARCHIVE },
	{ &ui_skin434, "ui_skin434", "0", CVAR_ARCHIVE },
	{ &ui_skin435, "ui_skin435", "0", CVAR_ARCHIVE },
	{ &ui_skin436, "ui_skin436", "0", CVAR_ARCHIVE },
	{ &ui_skin437, "ui_skin437", "0", CVAR_ARCHIVE },
	{ &ui_skin438, "ui_skin438", "0", CVAR_ARCHIVE },
	{ &ui_skin439, "ui_skin439", "0", CVAR_ARCHIVE },
	{ &ui_skin440, "ui_skin440", "0", CVAR_ARCHIVE },
	{ &ui_skin441, "ui_skin441", "0", CVAR_ARCHIVE },
	{ &ui_skin442, "ui_skin442", "0", CVAR_ARCHIVE },
	{ &ui_skin443, "ui_skin443", "0", CVAR_ARCHIVE },
	{ &ui_skin444, "ui_skin444", "0", CVAR_ARCHIVE },
	{ &ui_skin445, "ui_skin445", "0", CVAR_ARCHIVE },
	{ &ui_skin446, "ui_skin446", "0", CVAR_ARCHIVE },
	{ &ui_skin447, "ui_skin447", "0", CVAR_ARCHIVE },
	{ &ui_skin448, "ui_skin448", "0", CVAR_ARCHIVE },
	{ &ui_skin449, "ui_skin449", "0", CVAR_ARCHIVE },
	{ &ui_skin450, "ui_skin450", "0", CVAR_ARCHIVE },
	{ &ui_skin451, "ui_skin451", "0", CVAR_ARCHIVE },
	{ &ui_skin452, "ui_skin452", "0", CVAR_ARCHIVE },
	{ &ui_skin453, "ui_skin453", "0", CVAR_ARCHIVE },
	{ &ui_skin454, "ui_skin454", "0", CVAR_ARCHIVE },
	{ &ui_skin455, "ui_skin455", "0", CVAR_ARCHIVE },
	{ &ui_skin456, "ui_skin456", "0", CVAR_ARCHIVE },
	{ &ui_skin457, "ui_skin457", "0", CVAR_ARCHIVE },
	{ &ui_skin458, "ui_skin458", "0", CVAR_ARCHIVE },
	{ &ui_skin459, "ui_skin459", "0", CVAR_ARCHIVE },
	{ &ui_skin460, "ui_skin460", "0", CVAR_ARCHIVE },
	{ &ui_skin461, "ui_skin461", "0", CVAR_ARCHIVE },
	{ &ui_skin462, "ui_skin462", "0", CVAR_ARCHIVE },
	{ &ui_skin463, "ui_skin463", "0", CVAR_ARCHIVE },
	{ &ui_skin464, "ui_skin464", "0", CVAR_ARCHIVE },
	{ &ui_skin465, "ui_skin465", "0", CVAR_ARCHIVE },
	{ &ui_skin466, "ui_skin466", "0", CVAR_ARCHIVE },
	{ &ui_skin467, "ui_skin467", "0", CVAR_ARCHIVE },
	{ &ui_skin468, "ui_skin468", "0", CVAR_ARCHIVE },
	{ &ui_skin469, "ui_skin469", "0", CVAR_ARCHIVE },
	{ &ui_skin470, "ui_skin470", "0", CVAR_ARCHIVE },
	{ &ui_skin471, "ui_skin471", "0", CVAR_ARCHIVE },
	{ &ui_skin472, "ui_skin472", "0", CVAR_ARCHIVE },
	{ &ui_skin473, "ui_skin473", "0", CVAR_ARCHIVE },
	{ &ui_skin474, "ui_skin474", "0", CVAR_ARCHIVE },
	{ &ui_skin475, "ui_skin475", "0", CVAR_ARCHIVE },
	{ &ui_skin476, "ui_skin476", "0", CVAR_ARCHIVE },
	{ &ui_skin477, "ui_skin477", "0", CVAR_ARCHIVE },
	{ &ui_skin478, "ui_skin478", "0", CVAR_ARCHIVE },
	{ &ui_skin479, "ui_skin479", "0", CVAR_ARCHIVE },
	{ &ui_skin480, "ui_skin480", "0", CVAR_ARCHIVE },
	{ &ui_skin481, "ui_skin481", "0", CVAR_ARCHIVE },
	{ &ui_skin482, "ui_skin482", "0", CVAR_ARCHIVE },
	{ &ui_skin483, "ui_skin483", "0", CVAR_ARCHIVE },
	{ &ui_skin484, "ui_skin484", "0", CVAR_ARCHIVE },
	{ &ui_skin485, "ui_skin485", "0", CVAR_ARCHIVE },
	{ &ui_skin486, "ui_skin486", "0", CVAR_ARCHIVE },
	{ &ui_skin487, "ui_skin487", "0", CVAR_ARCHIVE },
	{ &ui_skin488, "ui_skin488", "0", CVAR_ARCHIVE },
	{ &ui_skin489, "ui_skin489", "0", CVAR_ARCHIVE },
	{ &ui_skin490, "ui_skin490", "0", CVAR_ARCHIVE },
	{ &ui_skin491, "ui_skin491", "0", CVAR_ARCHIVE },
	{ &ui_skin492, "ui_skin492", "0", CVAR_ARCHIVE },
	{ &ui_skin493, "ui_skin493", "0", CVAR_ARCHIVE },
	{ &ui_skin494, "ui_skin494", "0", CVAR_ARCHIVE },
	{ &ui_skin495, "ui_skin495", "0", CVAR_ARCHIVE },
	{ &ui_skin496, "ui_skin496", "0", CVAR_ARCHIVE },
	{ &ui_skin497, "ui_skin497", "0", CVAR_ARCHIVE },
	{ &ui_skin498, "ui_skin498", "0", CVAR_ARCHIVE },
	{ &ui_skin499, "ui_skin499", "0", CVAR_ARCHIVE },
	{ &ui_skin500, "ui_skin500", "0", CVAR_ARCHIVE },
	{ &ui_skin501, "ui_skin501", "0", CVAR_ARCHIVE },
	{ &ui_skin502, "ui_skin502", "0", CVAR_ARCHIVE },
	{ &ui_skin503, "ui_skin503", "0", CVAR_ARCHIVE },
	{ &ui_skin504, "ui_skin504", "0", CVAR_ARCHIVE },
	{ &ui_skin505, "ui_skin505", "0", CVAR_ARCHIVE },
	{ &ui_skin506, "ui_skin506", "0", CVAR_ARCHIVE },
	{ &ui_skin507, "ui_skin507", "0", CVAR_ARCHIVE },
	{ &ui_skin508, "ui_skin508", "0", CVAR_ARCHIVE },
	{ &ui_skin509, "ui_skin509", "0", CVAR_ARCHIVE },
	{ &ui_skin510, "ui_skin510", "0", CVAR_ARCHIVE },
	{ &ui_skin511, "ui_skin511", "0", CVAR_ARCHIVE },
	{ &ui_skin512, "ui_skin512", "0", CVAR_ARCHIVE },
	{ &ui_skin513, "ui_skin513", "0", CVAR_ARCHIVE },
	{ &ui_skin514, "ui_skin514", "0", CVAR_ARCHIVE },
	{ &ui_skin515, "ui_skin515", "0", CVAR_ARCHIVE },
	{ &ui_skin516, "ui_skin516", "0", CVAR_ARCHIVE },
	{ &ui_skin517, "ui_skin517", "0", CVAR_ARCHIVE },
	{ &ui_skin518, "ui_skin518", "0", CVAR_ARCHIVE },
	{ &ui_skin519, "ui_skin519", "0", CVAR_ARCHIVE },
	{ &ui_skin520, "ui_skin520", "0", CVAR_ARCHIVE },
	{ &ui_skin521, "ui_skin521", "0", CVAR_ARCHIVE },
	{ &ui_skin522, "ui_skin522", "0", CVAR_ARCHIVE },
	{ &ui_skin523, "ui_skin523", "0", CVAR_ARCHIVE },
	{ &ui_skin524, "ui_skin524", "0", CVAR_ARCHIVE },
	{ &ui_skin525, "ui_skin525", "0", CVAR_ARCHIVE },
	{ &ui_skin526, "ui_skin526", "0", CVAR_ARCHIVE },
	{ &ui_skin527, "ui_skin527", "0", CVAR_ARCHIVE },
	{ &ui_skin528, "ui_skin528", "0", CVAR_ARCHIVE },
	{ &ui_skin529, "ui_skin529", "0", CVAR_ARCHIVE },
	{ &ui_skin530, "ui_skin530", "0", CVAR_ARCHIVE },
	{ &ui_skin531, "ui_skin531", "0", CVAR_ARCHIVE },
	{ &ui_skin532, "ui_skin532", "0", CVAR_ARCHIVE },
	{ &ui_skin533, "ui_skin533", "0", CVAR_ARCHIVE },
	{ &ui_skin534, "ui_skin534", "0", CVAR_ARCHIVE },
	{ &ui_skin535, "ui_skin535", "0", CVAR_ARCHIVE },
	{ &ui_skin536, "ui_skin536", "0", CVAR_ARCHIVE },
	{ &ui_skin537, "ui_skin537", "0", CVAR_ARCHIVE },
	{ &ui_skin538, "ui_skin538", "0", CVAR_ARCHIVE },
	{ &ui_skin539, "ui_skin539", "0", CVAR_ARCHIVE },
	{ &ui_skin540, "ui_skin540", "0", CVAR_ARCHIVE },
	{ &ui_skin541, "ui_skin541", "0", CVAR_ARCHIVE },
	{ &ui_skin542, "ui_skin542", "0", CVAR_ARCHIVE },
	{ &ui_skin543, "ui_skin543", "0", CVAR_ARCHIVE },
	{ &ui_skin544, "ui_skin544", "0", CVAR_ARCHIVE },
	{ &ui_skin545, "ui_skin545", "0", CVAR_ARCHIVE },
	{ &ui_skin546, "ui_skin546", "0", CVAR_ARCHIVE },
	{ &ui_skin547, "ui_skin547", "0", CVAR_ARCHIVE },
	{ &ui_skin548, "ui_skin548", "0", CVAR_ARCHIVE },
	{ &ui_skin549, "ui_skin549", "0", CVAR_ARCHIVE },
	{ &ui_skin550, "ui_skin550", "0", CVAR_ARCHIVE },
	{ &ui_skin551, "ui_skin551", "0", CVAR_ARCHIVE },
	{ &ui_skin552, "ui_skin552", "0", CVAR_ARCHIVE },
	{ &ui_skin553, "ui_skin553", "0", CVAR_ARCHIVE },
	{ &ui_skin554, "ui_skin554", "0", CVAR_ARCHIVE },
	{ &ui_skin555, "ui_skin555", "0", CVAR_ARCHIVE },
	{ &ui_skin556, "ui_skin556", "0", CVAR_ARCHIVE },
	{ &ui_skin557, "ui_skin557", "0", CVAR_ARCHIVE },
	{ &ui_skin558, "ui_skin558", "0", CVAR_ARCHIVE },
	{ &ui_skin559, "ui_skin559", "0", CVAR_ARCHIVE },
	{ &ui_skin560, "ui_skin560", "0", CVAR_ARCHIVE },
	{ &ui_skin561, "ui_skin561", "0", CVAR_ARCHIVE },
	{ &ui_skin562, "ui_skin562", "0", CVAR_ARCHIVE },
	{ &ui_skin563, "ui_skin563", "0", CVAR_ARCHIVE },
	{ &ui_skin564, "ui_skin564", "0", CVAR_ARCHIVE },
	{ &ui_skin565, "ui_skin565", "0", CVAR_ARCHIVE },
	{ &ui_skin566, "ui_skin566", "0", CVAR_ARCHIVE },
	{ &ui_skin567, "ui_skin567", "0", CVAR_ARCHIVE },
	{ &ui_skin568, "ui_skin568", "0", CVAR_ARCHIVE },
	{ &ui_skin569, "ui_skin569", "0", CVAR_ARCHIVE },
	{ &ui_skin570, "ui_skin570", "0", CVAR_ARCHIVE },
	{ &ui_skin571, "ui_skin571", "0", CVAR_ARCHIVE },
	{ &ui_skin572, "ui_skin572", "0", CVAR_ARCHIVE },
	{ &ui_skin573, "ui_skin573", "0", CVAR_ARCHIVE },
	{ &ui_skin574, "ui_skin574", "0", CVAR_ARCHIVE },
	{ &ui_skin575, "ui_skin575", "0", CVAR_ARCHIVE },
	{ &ui_skin576, "ui_skin576", "0", CVAR_ARCHIVE },
	{ &ui_skin577, "ui_skin577", "0", CVAR_ARCHIVE },
	{ &ui_skin578, "ui_skin578", "0", CVAR_ARCHIVE },
	{ &ui_skin579, "ui_skin579", "0", CVAR_ARCHIVE },
	{ &ui_skin580, "ui_skin580", "0", CVAR_ARCHIVE },
	{ &ui_skin581, "ui_skin581", "0", CVAR_ARCHIVE },
	{ &ui_skin582, "ui_skin582", "0", CVAR_ARCHIVE },
	{ &ui_skin583, "ui_skin583", "0", CVAR_ARCHIVE },
	{ &ui_skin584, "ui_skin584", "0", CVAR_ARCHIVE },
	{ &ui_skin585, "ui_skin585", "0", CVAR_ARCHIVE },
	{ &ui_skin586, "ui_skin586", "0", CVAR_ARCHIVE },
	{ &ui_skin587, "ui_skin587", "0", CVAR_ARCHIVE },
	{ &ui_skin588, "ui_skin588", "0", CVAR_ARCHIVE },
	{ &ui_skin589, "ui_skin589", "0", CVAR_ARCHIVE },
	{ &ui_skin590, "ui_skin590", "0", CVAR_ARCHIVE },
	{ &ui_skin591, "ui_skin591", "0", CVAR_ARCHIVE },
	{ &ui_skin592, "ui_skin592", "0", CVAR_ARCHIVE },
	{ &ui_skin593, "ui_skin593", "0", CVAR_ARCHIVE },
	{ &ui_skin594, "ui_skin594", "0", CVAR_ARCHIVE },
	{ &ui_skin595, "ui_skin595", "0", CVAR_ARCHIVE },
	{ &ui_skin596, "ui_skin596", "0", CVAR_ARCHIVE },
	{ &ui_skin597, "ui_skin597", "0", CVAR_ARCHIVE },
	{ &ui_skin598, "ui_skin598", "0", CVAR_ARCHIVE },
	{ &ui_skin599, "ui_skin599", "0", CVAR_ARCHIVE },
	{ &ui_skin600, "ui_skin600", "0", CVAR_ARCHIVE },
	{ &ui_skin601, "ui_skin601", "0", CVAR_ARCHIVE },
	{ &ui_skin602, "ui_skin602", "0", CVAR_ARCHIVE },
	{ &ui_skin603, "ui_skin603", "0", CVAR_ARCHIVE },
	{ &ui_skin604, "ui_skin604", "0", CVAR_ARCHIVE },
	{ &ui_skin605, "ui_skin605", "0", CVAR_ARCHIVE },
	{ &ui_skin606, "ui_skin606", "0", CVAR_ARCHIVE },
	{ &ui_skin607, "ui_skin607", "0", CVAR_ARCHIVE },
	{ &ui_skin608, "ui_skin608", "0", CVAR_ARCHIVE },
	{ &ui_skin609, "ui_skin609", "0", CVAR_ARCHIVE },
	{ &ui_skin610, "ui_skin610", "0", CVAR_ARCHIVE },
	{ &ui_skin611, "ui_skin611", "0", CVAR_ARCHIVE },
	{ &ui_skin612, "ui_skin612", "0", CVAR_ARCHIVE },
	{ &ui_skin613, "ui_skin613", "0", CVAR_ARCHIVE },
	{ &ui_skin614, "ui_skin614", "0", CVAR_ARCHIVE },
	{ &ui_skin615, "ui_skin615", "0", CVAR_ARCHIVE },
	{ &ui_skin616, "ui_skin616", "0", CVAR_ARCHIVE },
	{ &ui_skin617, "ui_skin617", "0", CVAR_ARCHIVE },
	{ &ui_skin618, "ui_skin618", "0", CVAR_ARCHIVE },
	{ &ui_skin619, "ui_skin619", "0", CVAR_ARCHIVE },
	{ &ui_skin620, "ui_skin620", "0", CVAR_ARCHIVE },
	{ &ui_skin621, "ui_skin621", "0", CVAR_ARCHIVE },
	{ &ui_skin622, "ui_skin622", "0", CVAR_ARCHIVE },
	{ &ui_skin623, "ui_skin623", "0", CVAR_ARCHIVE },
	{ &ui_skin624, "ui_skin624", "0", CVAR_ARCHIVE },
	{ &ui_skin625, "ui_skin625", "0", CVAR_ARCHIVE },
	{ &ui_skin626, "ui_skin626", "0", CVAR_ARCHIVE },
	{ &ui_skin627, "ui_skin627", "0", CVAR_ARCHIVE },
	{ &ui_skin628, "ui_skin628", "0", CVAR_ARCHIVE },
	{ &ui_skin629, "ui_skin629", "0", CVAR_ARCHIVE },
	{ &ui_skin630, "ui_skin630", "0", CVAR_ARCHIVE },
	{ &ui_skin631, "ui_skin631", "0", CVAR_ARCHIVE },
	{ &ui_skin632, "ui_skin632", "0", CVAR_ARCHIVE },
	{ &ui_skin633, "ui_skin633", "0", CVAR_ARCHIVE },
	{ &ui_skin634, "ui_skin634", "0", CVAR_ARCHIVE },
	{ &ui_skin635, "ui_skin635", "0", CVAR_ARCHIVE },
	{ &ui_skin636, "ui_skin636", "0", CVAR_ARCHIVE },
	{ &ui_skin637, "ui_skin637", "0", CVAR_ARCHIVE },
	{ &ui_skin638, "ui_skin638", "0", CVAR_ARCHIVE },
	{ &ui_skin639, "ui_skin639", "0", CVAR_ARCHIVE },
	{ &ui_skin640, "ui_skin640", "0", CVAR_ARCHIVE },
	{ &ui_skin641, "ui_skin641", "0", CVAR_ARCHIVE },
	{ &ui_skin642, "ui_skin642", "0", CVAR_ARCHIVE },
	{ &ui_skin643, "ui_skin643", "0", CVAR_ARCHIVE },
	{ &ui_skin644, "ui_skin644", "0", CVAR_ARCHIVE },
	{ &ui_skin645, "ui_skin645", "0", CVAR_ARCHIVE },
	{ &ui_skin646, "ui_skin646", "0", CVAR_ARCHIVE },
	{ &ui_skin647, "ui_skin647", "0", CVAR_ARCHIVE },
	{ &ui_skin648, "ui_skin648", "0", CVAR_ARCHIVE },
	{ &ui_skin649, "ui_skin649", "0", CVAR_ARCHIVE },
	{ &ui_skin650, "ui_skin650", "0", CVAR_ARCHIVE },
	{ &ui_skin651, "ui_skin651", "0", CVAR_ARCHIVE },
	{ &ui_skin652, "ui_skin652", "0", CVAR_ARCHIVE },
	{ &ui_skin653, "ui_skin653", "0", CVAR_ARCHIVE },
	{ &ui_skin654, "ui_skin654", "0", CVAR_ARCHIVE },
	{ &ui_skin655, "ui_skin655", "0", CVAR_ARCHIVE },
	{ &ui_skin656, "ui_skin656", "0", CVAR_ARCHIVE },
	{ &ui_skin657, "ui_skin657", "0", CVAR_ARCHIVE },
	{ &ui_skin658, "ui_skin658", "0", CVAR_ARCHIVE },
	{ &ui_skin659, "ui_skin659", "0", CVAR_ARCHIVE },
	{ &ui_skin660, "ui_skin660", "0", CVAR_ARCHIVE },
	{ &ui_skin661, "ui_skin661", "0", CVAR_ARCHIVE },
	{ &ui_skin662, "ui_skin662", "0", CVAR_ARCHIVE },
	{ &ui_skin663, "ui_skin663", "0", CVAR_ARCHIVE },
	{ &ui_skin664, "ui_skin664", "0", CVAR_ARCHIVE },
	{ &ui_skin665, "ui_skin665", "0", CVAR_ARCHIVE },
	{ &ui_skin666, "ui_skin666", "0", CVAR_ARCHIVE },
	{ &ui_skin667, "ui_skin667", "0", CVAR_ARCHIVE },
	{ &ui_skin668, "ui_skin668", "0", CVAR_ARCHIVE },
	{ &ui_skin669, "ui_skin669", "0", CVAR_ARCHIVE },
	{ &ui_skin670, "ui_skin670", "0", CVAR_ARCHIVE },
	{ &ui_skin671, "ui_skin671", "0", CVAR_ARCHIVE },
	{ &ui_skin672, "ui_skin672", "0", CVAR_ARCHIVE },
	{ &ui_skin673, "ui_skin673", "0", CVAR_ARCHIVE },
	{ &ui_skin674, "ui_skin674", "0", CVAR_ARCHIVE },
	{ &ui_skin675, "ui_skin675", "0", CVAR_ARCHIVE },
	{ &ui_skin676, "ui_skin676", "0", CVAR_ARCHIVE },
	{ &ui_skin677, "ui_skin677", "0", CVAR_ARCHIVE },
	{ &ui_skin678, "ui_skin678", "0", CVAR_ARCHIVE },
	{ &ui_skin679, "ui_skin679", "0", CVAR_ARCHIVE },
	{ &ui_skin680, "ui_skin680", "0", CVAR_ARCHIVE },
	{ &ui_skin681, "ui_skin681", "0", CVAR_ARCHIVE },
	{ &ui_skin682, "ui_skin682", "0", CVAR_ARCHIVE },
	{ &ui_skin683, "ui_skin683", "0", CVAR_ARCHIVE },
	{ &ui_skin684, "ui_skin684", "0", CVAR_ARCHIVE },
	{ &ui_skin685, "ui_skin685", "0", CVAR_ARCHIVE },
	{ &ui_skin686, "ui_skin686", "0", CVAR_ARCHIVE },
	{ &ui_skin687, "ui_skin687", "0", CVAR_ARCHIVE },
	{ &ui_skin688, "ui_skin688", "0", CVAR_ARCHIVE },
	{ &ui_skin689, "ui_skin689", "0", CVAR_ARCHIVE },
	{ &ui_skin690, "ui_skin690", "0", CVAR_ARCHIVE },
	{ &ui_skin691, "ui_skin691", "0", CVAR_ARCHIVE },
	{ &ui_skin692, "ui_skin692", "0", CVAR_ARCHIVE },
	{ &ui_skin693, "ui_skin693", "0", CVAR_ARCHIVE },
	{ &ui_skin694, "ui_skin694", "0", CVAR_ARCHIVE },
	{ &ui_skin695, "ui_skin695", "0", CVAR_ARCHIVE },
	{ &ui_skin696, "ui_skin696", "0", CVAR_ARCHIVE },
	{ &ui_skin697, "ui_skin697", "0", CVAR_ARCHIVE },
	{ &ui_skin698, "ui_skin698", "0", CVAR_ARCHIVE },
	{ &ui_skin699, "ui_skin699", "0", CVAR_ARCHIVE },
	{ &ui_skin700, "ui_skin700", "0", CVAR_ARCHIVE },
	{ &ui_skin701, "ui_skin701", "0", CVAR_ARCHIVE },
	{ &ui_skin702, "ui_skin702", "0", CVAR_ARCHIVE },
	{ &ui_skin703, "ui_skin703", "0", CVAR_ARCHIVE },
	{ &ui_skin704, "ui_skin704", "0", CVAR_ARCHIVE },
	{ &ui_skin705, "ui_skin705", "0", CVAR_ARCHIVE },
	{ &ui_skin706, "ui_skin706", "0", CVAR_ARCHIVE },
	{ &ui_skin707, "ui_skin707", "0", CVAR_ARCHIVE },
	{ &ui_skin708, "ui_skin708", "0", CVAR_ARCHIVE },
	{ &ui_skin709, "ui_skin709", "0", CVAR_ARCHIVE },
	{ &ui_skin710, "ui_skin710", "0", CVAR_ARCHIVE },
	{ &ui_skin711, "ui_skin711", "0", CVAR_ARCHIVE },
	{ &ui_skin712, "ui_skin712", "0", CVAR_ARCHIVE },
	{ &ui_skin713, "ui_skin713", "0", CVAR_ARCHIVE },
	{ &ui_skin714, "ui_skin714", "0", CVAR_ARCHIVE },
	{ &ui_skin715, "ui_skin715", "0", CVAR_ARCHIVE },
	{ &ui_skin716, "ui_skin716", "0", CVAR_ARCHIVE },
	{ &ui_skin717, "ui_skin717", "0", CVAR_ARCHIVE },
	{ &ui_skin718, "ui_skin718", "0", CVAR_ARCHIVE },
	{ &ui_skin719, "ui_skin719", "0", CVAR_ARCHIVE },
	{ &ui_skin720, "ui_skin720", "0", CVAR_ARCHIVE },
	{ &ui_skin721, "ui_skin721", "0", CVAR_ARCHIVE },
	{ &ui_skin722, "ui_skin722", "0", CVAR_ARCHIVE },
	{ &ui_skin723, "ui_skin723", "0", CVAR_ARCHIVE },
	{ &ui_skin724, "ui_skin724", "0", CVAR_ARCHIVE },
	{ &ui_skin725, "ui_skin725", "0", CVAR_ARCHIVE },
	{ &ui_skin726, "ui_skin726", "0", CVAR_ARCHIVE },
	{ &ui_skin727, "ui_skin727", "0", CVAR_ARCHIVE },
	{ &ui_skin728, "ui_skin728", "0", CVAR_ARCHIVE },
	{ &ui_skin729, "ui_skin729", "0", CVAR_ARCHIVE },
	{ &ui_skin730, "ui_skin730", "0", CVAR_ARCHIVE },
	{ &ui_skin731, "ui_skin731", "0", CVAR_ARCHIVE },
	{ &ui_skin732, "ui_skin732", "0", CVAR_ARCHIVE },
	{ &ui_skin733, "ui_skin733", "0", CVAR_ARCHIVE },
	{ &ui_skin734, "ui_skin734", "0", CVAR_ARCHIVE },
	{ &ui_skin735, "ui_skin735", "0", CVAR_ARCHIVE },
	{ &ui_skin736, "ui_skin736", "0", CVAR_ARCHIVE },
	{ &ui_skin737, "ui_skin737", "0", CVAR_ARCHIVE },
	{ &ui_skin738, "ui_skin738", "0", CVAR_ARCHIVE },
	{ &ui_skin739, "ui_skin739", "0", CVAR_ARCHIVE },
	{ &ui_skin740, "ui_skin740", "0", CVAR_ARCHIVE },
	{ &ui_skin741, "ui_skin741", "0", CVAR_ARCHIVE },
	{ &ui_skin742, "ui_skin742", "0", CVAR_ARCHIVE },
	{ &ui_skin743, "ui_skin743", "0", CVAR_ARCHIVE },
	{ &ui_skin744, "ui_skin744", "0", CVAR_ARCHIVE },
	{ &ui_skin745, "ui_skin745", "0", CVAR_ARCHIVE },
	{ &ui_skin746, "ui_skin746", "0", CVAR_ARCHIVE },
	{ &ui_skin747, "ui_skin747", "0", CVAR_ARCHIVE },
	{ &ui_skin748, "ui_skin748", "0", CVAR_ARCHIVE },
	{ &ui_skin749, "ui_skin749", "0", CVAR_ARCHIVE },
	{ &ui_skin750, "ui_skin750", "0", CVAR_ARCHIVE },
	{ &ui_skin751, "ui_skin751", "0", CVAR_ARCHIVE },
	{ &ui_skin752, "ui_skin752", "0", CVAR_ARCHIVE },
	{ &ui_skin753, "ui_skin753", "0", CVAR_ARCHIVE },
	{ &ui_skin754, "ui_skin754", "0", CVAR_ARCHIVE },
	{ &ui_skin755, "ui_skin755", "0", CVAR_ARCHIVE },
	{ &ui_skin756, "ui_skin756", "0", CVAR_ARCHIVE },
	{ &ui_skin757, "ui_skin757", "0", CVAR_ARCHIVE },
	{ &ui_skin758, "ui_skin758", "0", CVAR_ARCHIVE },
	{ &ui_skin759, "ui_skin759", "0", CVAR_ARCHIVE },
	{ &ui_skin760, "ui_skin760", "0", CVAR_ARCHIVE },
	{ &ui_skin761, "ui_skin761", "0", CVAR_ARCHIVE },
	{ &ui_skin762, "ui_skin762", "0", CVAR_ARCHIVE },
	{ &ui_skin763, "ui_skin763", "0", CVAR_ARCHIVE },
	{ &ui_skin764, "ui_skin764", "0", CVAR_ARCHIVE },
	{ &ui_skin765, "ui_skin765", "0", CVAR_ARCHIVE },
	{ &ui_skin766, "ui_skin766", "0", CVAR_ARCHIVE },
	{ &ui_skin767, "ui_skin767", "0", CVAR_ARCHIVE },
	{ &ui_skin768, "ui_skin768", "0", CVAR_ARCHIVE },
	{ &ui_skin769, "ui_skin769", "0", CVAR_ARCHIVE },
	{ &ui_skin770, "ui_skin770", "0", CVAR_ARCHIVE },
	{ &ui_skin771, "ui_skin771", "0", CVAR_ARCHIVE },
	{ &ui_skin772, "ui_skin772", "0", CVAR_ARCHIVE },
	{ &ui_skin773, "ui_skin773", "0", CVAR_ARCHIVE },
	{ &ui_skin774, "ui_skin774", "0", CVAR_ARCHIVE },
	{ &ui_skin775, "ui_skin775", "0", CVAR_ARCHIVE },
	{ &ui_skin776, "ui_skin776", "0", CVAR_ARCHIVE },
	{ &ui_skin777, "ui_skin777", "0", CVAR_ARCHIVE },
	{ &ui_skin778, "ui_skin778", "0", CVAR_ARCHIVE },
	{ &ui_skin779, "ui_skin779", "0", CVAR_ARCHIVE },
	{ &ui_skin780, "ui_skin780", "0", CVAR_ARCHIVE },
	{ &ui_skin781, "ui_skin781", "0", CVAR_ARCHIVE },
	{ &ui_skin782, "ui_skin782", "0", CVAR_ARCHIVE },
	{ &ui_skin783, "ui_skin783", "0", CVAR_ARCHIVE },
	{ &ui_skin784, "ui_skin784", "0", CVAR_ARCHIVE },
	{ &ui_skin785, "ui_skin785", "0", CVAR_ARCHIVE },
	{ &ui_skin786, "ui_skin786", "0", CVAR_ARCHIVE },
	{ &ui_skin787, "ui_skin787", "0", CVAR_ARCHIVE },
	{ &ui_skin788, "ui_skin788", "0", CVAR_ARCHIVE },
	{ &ui_skin789, "ui_skin789", "0", CVAR_ARCHIVE },
	{ &ui_skin790, "ui_skin790", "0", CVAR_ARCHIVE },
	{ &ui_skin791, "ui_skin791", "0", CVAR_ARCHIVE },
	{ &ui_skin792, "ui_skin792", "0", CVAR_ARCHIVE },
	{ &ui_skin793, "ui_skin793", "0", CVAR_ARCHIVE },
	{ &ui_skin794, "ui_skin794", "0", CVAR_ARCHIVE },
	{ &ui_skin795, "ui_skin795", "0", CVAR_ARCHIVE },
	{ &ui_skin796, "ui_skin796", "0", CVAR_ARCHIVE },
	{ &ui_skin797, "ui_skin797", "0", CVAR_ARCHIVE },
	{ &ui_skin798, "ui_skin798", "0", CVAR_ARCHIVE },
	{ &ui_skin799, "ui_skin799", "0", CVAR_ARCHIVE },
	{ &ui_skin800, "ui_skin800", "0", CVAR_ARCHIVE },
	{ &ui_skin801, "ui_skin801", "0", CVAR_ARCHIVE },
	{ &ui_skin802, "ui_skin802", "0", CVAR_ARCHIVE },
	{ &ui_skin803, "ui_skin803", "0", CVAR_ARCHIVE },
	{ &ui_skin804, "ui_skin804", "0", CVAR_ARCHIVE },
	{ &ui_skin805, "ui_skin805", "0", CVAR_ARCHIVE },
	{ &ui_skin806, "ui_skin806", "0", CVAR_ARCHIVE },
	{ &ui_skin807, "ui_skin807", "0", CVAR_ARCHIVE },
	{ &ui_skin808, "ui_skin808", "0", CVAR_ARCHIVE },
	{ &ui_skin809, "ui_skin809", "0", CVAR_ARCHIVE },
	{ &ui_skin810, "ui_skin810", "0", CVAR_ARCHIVE },
	{ &ui_skin811, "ui_skin811", "0", CVAR_ARCHIVE },
	{ &ui_skin812, "ui_skin812", "0", CVAR_ARCHIVE },
	{ &ui_skin813, "ui_skin813", "0", CVAR_ARCHIVE },
	{ &ui_skin814, "ui_skin814", "0", CVAR_ARCHIVE },
	{ &ui_skin815, "ui_skin815", "0", CVAR_ARCHIVE },
	{ &ui_skin816, "ui_skin816", "0", CVAR_ARCHIVE },
	{ &ui_skin817, "ui_skin817", "0", CVAR_ARCHIVE },
	{ &ui_skin818, "ui_skin818", "0", CVAR_ARCHIVE },
	{ &ui_skin819, "ui_skin819", "0", CVAR_ARCHIVE },
	{ &ui_skin820, "ui_skin820", "0", CVAR_ARCHIVE },
	{ &ui_skin821, "ui_skin821", "0", CVAR_ARCHIVE },
	{ &ui_skin822, "ui_skin822", "0", CVAR_ARCHIVE },
	{ &ui_skin823, "ui_skin823", "0", CVAR_ARCHIVE },
	{ &ui_skin824, "ui_skin824", "0", CVAR_ARCHIVE },
	{ &ui_skin825, "ui_skin825", "0", CVAR_ARCHIVE },
	{ &ui_skin826, "ui_skin826", "0", CVAR_ARCHIVE },
	{ &ui_skin827, "ui_skin827", "0", CVAR_ARCHIVE },
	{ &ui_skin828, "ui_skin828", "0", CVAR_ARCHIVE },
	{ &ui_skin829, "ui_skin829", "0", CVAR_ARCHIVE },
	{ &ui_skin830, "ui_skin830", "0", CVAR_ARCHIVE },
	{ &ui_skin831, "ui_skin831", "0", CVAR_ARCHIVE },
	{ &ui_skin832, "ui_skin832", "0", CVAR_ARCHIVE },
	{ &ui_skin833, "ui_skin833", "0", CVAR_ARCHIVE },
	{ &ui_skin834, "ui_skin834", "0", CVAR_ARCHIVE },
	{ &ui_skin835, "ui_skin835", "0", CVAR_ARCHIVE },
	{ &ui_skin836, "ui_skin836", "0", CVAR_ARCHIVE },
	{ &ui_skin837, "ui_skin837", "0", CVAR_ARCHIVE },
	{ &ui_skin838, "ui_skin838", "0", CVAR_ARCHIVE },
	{ &ui_skin839, "ui_skin839", "0", CVAR_ARCHIVE },
	{ &ui_skin840, "ui_skin840", "0", CVAR_ARCHIVE },
	{ &ui_skin841, "ui_skin841", "0", CVAR_ARCHIVE },
	{ &ui_skin842, "ui_skin842", "0", CVAR_ARCHIVE },
	{ &ui_skin843, "ui_skin843", "0", CVAR_ARCHIVE },
	{ &ui_skin844, "ui_skin844", "0", CVAR_ARCHIVE },
	{ &ui_skin845, "ui_skin845", "0", CVAR_ARCHIVE },
	{ &ui_skin846, "ui_skin846", "0", CVAR_ARCHIVE },
	{ &ui_skin847, "ui_skin847", "0", CVAR_ARCHIVE },
	{ &ui_skin848, "ui_skin848", "0", CVAR_ARCHIVE },
	{ &ui_skin849, "ui_skin849", "0", CVAR_ARCHIVE },
	{ &ui_skin850, "ui_skin850", "0", CVAR_ARCHIVE },*/


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
		mod_ammolimit = g_ammolimit.integer;
		trap_Cvar_Set("com_hunkmegs","512");
		trap_Cvar_Set("com_zonemegs","256");
		trap_Cvar_Set("com_soundmegs","256");
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
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f1 OpenActions;" );
//		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f OpenActions;" );
if((int)trap_Cvar_VariableValue("protocol")==68){
	trap_Cmd_ExecuteText( EXEC_APPEND, "exec ultragraph.cfg\n" );
}
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
