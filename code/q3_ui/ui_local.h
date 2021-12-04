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
#ifndef __UI_LOCAL_H__
#define __UI_LOCAL_H__

#define BASEOA

#include "../qcommon/q_shared.h"
#include "../renderer/tr_types.h"
//NOTE: include the ui_public.h from the new UI
#include "../ui/ui_public.h" // bk001205 - yes, do have to use this
//redefine to old API version
#undef UI_API_VERSION
#define UI_API_VERSION	4
#include "../client/keycodes.h"
#include "../game/bg_public.h"
#include "../ui/ui_shared.h"

typedef void (*voidfunc_f)(void);

extern int	mod_ammolimit;
extern vmCvar_t	Gop_n0;
extern vmCvar_t	Gop_n1;
extern vmCvar_t	Gop_n2;
extern vmCvar_t	Gop_n3;
extern vmCvar_t	Gop_n4;
extern vmCvar_t	Gop_n5;
extern vmCvar_t	Gop_n6;
extern vmCvar_t	Gop_v3;
extern vmCvar_t	Gop_ne1;
extern vmCvar_t	Gop_ne2;
extern vmCvar_t	Gop_b1;
extern vmCvar_t	Gop_b2;
extern vmCvar_t	ui_nomapicons;
extern vmCvar_t	MusicplayerMusic;
extern vmCvar_t	g_ammolimit;
extern vmCvar_t	skinsmultiplayer;
extern vmCvar_t	ui_loaded;
extern vmCvar_t	ui_char;
extern vmCvar_t	ui_custommaps;
extern vmCvar_t	ui_actionmenu;
extern vmCvar_t	ui_gamemodesall;
extern vmCvar_t	ui_playerangle;
extern vmCvar_t	ui_legsmodel;
extern vmCvar_t	ui_mslegsmodel;
extern vmCvar_t	ui_mslegsskin;
extern vmCvar_t	ui_msheadmodel;
extern vmCvar_t	ui_msheadskin;
extern vmCvar_t	ui_msmodel;
extern vmCvar_t	ui_msskin;
extern vmCvar_t	ui_headmodel;
extern vmCvar_t	ui_headmodelt;
extern vmCvar_t	onandroid;
extern vmCvar_t	IsGame;
extern vmCvar_t	onnextarena;
extern vmCvar_t	ui_coop;
extern vmCvar_t	ui_backcolor;
extern vmCvar_t	ui_mapiconsizeq;
extern vmCvar_t	ui_skinprice;
extern vmCvar_t	ui_maprowsq;
extern vmCvar_t	ui_mapcolsq;
extern vmCvar_t	ui_cwriteb;
extern vmCvar_t	ui_cwritev;
extern vmCvar_t	ui_skinsunlocked;
extern vmCvar_t	ui_secretcode;
extern vmCvar_t	ui_gametype;
extern vmCvar_t	rus;
extern vmCvar_t	playerxp;
extern vmCvar_t	ui_mainmodel;
extern vmCvar_t	ui_modname;
extern vmCvar_t	ui_singleplayer;
extern vmCvar_t	ui_singleplayer_x;
extern vmCvar_t	ui_singleplayer_y;
extern vmCvar_t	ui_singleplayer_text;
extern vmCvar_t	ui_multiplayer;
extern vmCvar_t	ui_multiplayer_x;
extern vmCvar_t	ui_multiplayer_y;
extern vmCvar_t	ui_multiplayer_text;
extern vmCvar_t	ui_settings;
extern vmCvar_t	ui_settings_x;
extern vmCvar_t	ui_settings_y;
extern vmCvar_t	ui_settings_text;
extern vmCvar_t	ui_demos;
extern vmCvar_t	ui_demos_x;
extern vmCvar_t	ui_demos_y;
extern vmCvar_t	ui_demos_text;
extern vmCvar_t	ui_statistics;
extern vmCvar_t	ui_statistics_x;
extern vmCvar_t	ui_statistics_y;
extern vmCvar_t	ui_statistics_text;
extern vmCvar_t	ui_mods;
extern vmCvar_t	ui_mods_x;
extern vmCvar_t	ui_mods_y;
extern vmCvar_t	ui_mods_text;
extern vmCvar_t	ui_exit;
extern vmCvar_t	ui_exit_x;
extern vmCvar_t	ui_exit_y;
extern vmCvar_t	ui_exit_text;

extern vmCvar_t	ui_ffa_fraglimit;
extern vmCvar_t	ui_ffa_timelimit;

extern vmCvar_t	ui_tourney_fraglimit;
extern vmCvar_t	ui_tourney_timelimit;

extern vmCvar_t	ui_team_fraglimit;
extern vmCvar_t	ui_team_timelimit;
extern vmCvar_t	ui_team_friendly;

extern vmCvar_t	ui_ctf_capturelimit;
extern vmCvar_t	ui_ctf_timelimit;
extern vmCvar_t	ui_ctf_friendly;

extern vmCvar_t	ui_1fctf_capturelimit;
extern vmCvar_t	ui_1fctf_timelimit;
extern vmCvar_t	ui_1fctf_friendly;

extern vmCvar_t	ui_overload_capturelimit;
extern vmCvar_t	ui_overload_timelimit;
extern vmCvar_t	ui_overload_friendly;

extern vmCvar_t	ui_harvester_capturelimit;
extern vmCvar_t	ui_harvester_timelimit;
extern vmCvar_t	ui_harvester_friendly;

extern vmCvar_t	ui_elimination_capturelimit;
extern vmCvar_t	ui_elimination_timelimit;

extern vmCvar_t	ui_ctf_elimination_capturelimit;
extern vmCvar_t	ui_ctf_elimination_timelimit;

extern vmCvar_t	ui_lms_fraglimit;
extern vmCvar_t	ui_lms_timelimit;

extern vmCvar_t	ui_dd_capturelimit;
extern vmCvar_t	ui_dd_timelimit;
extern vmCvar_t	ui_dd_friendly;

extern vmCvar_t	ui_dom_capturelimit;
extern vmCvar_t	ui_dom_timelimit;
extern vmCvar_t	ui_dom_friendly;

extern vmCvar_t	ui_arenasFile;
extern vmCvar_t	ui_botsFile;
extern vmCvar_t	ui_spScores1;
extern vmCvar_t	ui_spScores2;
extern vmCvar_t	ui_spScores3;
extern vmCvar_t	ui_spScores4;
extern vmCvar_t	ui_spScores5;
extern vmCvar_t	ui_spAwards;
extern vmCvar_t	ui_spVideos;
extern vmCvar_t	ui_spSkill;

extern vmCvar_t	ui_spSelection;

extern vmCvar_t	ui_browserMaster;
extern vmCvar_t	ui_browserGameType;
extern vmCvar_t	ui_browserSortKey;
extern vmCvar_t	ui_browserShowFull;
extern vmCvar_t	ui_browserShowEmpty;
extern vmCvar_t		cg_ch9slze;
extern vmCvar_t	ui_brassTime;
extern vmCvar_t	ui_drawCrosshair;
extern vmCvar_t	ui_drawCrosshairNames;
extern vmCvar_t	ui_marks;

extern vmCvar_t	ui_server1;
extern vmCvar_t	ui_server2;
extern vmCvar_t	ui_server3;
extern vmCvar_t	ui_server4;
extern vmCvar_t	ui_server5;
extern vmCvar_t	ui_server6;
extern vmCvar_t	ui_server7;
extern vmCvar_t	ui_server8;
extern vmCvar_t	ui_server9;
extern vmCvar_t	ui_server10;
extern vmCvar_t	ui_server11;
extern vmCvar_t	ui_server12;
extern vmCvar_t	ui_server13;
extern vmCvar_t	ui_server14;
extern vmCvar_t	ui_server15;
extern vmCvar_t	ui_server16;

/*extern vmCvar_t	ui_skin1;
extern vmCvar_t	ui_skin2;
extern vmCvar_t	ui_skin3;
extern vmCvar_t	ui_skin4;
extern vmCvar_t	ui_skin5;
extern vmCvar_t	ui_skin6;
extern vmCvar_t	ui_skin7;
extern vmCvar_t	ui_skin8;
extern vmCvar_t	ui_skin9;
extern vmCvar_t	ui_skin10;
extern vmCvar_t	ui_skin11;
extern vmCvar_t	ui_skin12;
extern vmCvar_t	ui_skin13;
extern vmCvar_t	ui_skin14;
extern vmCvar_t	ui_skin15;
extern vmCvar_t	ui_skin16;
extern vmCvar_t	ui_skin17;
extern vmCvar_t	ui_skin18;
extern vmCvar_t	ui_skin19;
extern vmCvar_t	ui_skin20;
extern vmCvar_t	ui_skin21;
extern vmCvar_t	ui_skin22;
extern vmCvar_t	ui_skin23;
extern vmCvar_t	ui_skin24;
extern vmCvar_t	ui_skin25;
extern vmCvar_t	ui_skin26;
extern vmCvar_t	ui_skin27;
extern vmCvar_t	ui_skin28;
extern vmCvar_t	ui_skin29;
extern vmCvar_t	ui_skin30;
extern vmCvar_t	ui_skin31;
extern vmCvar_t	ui_skin32;
extern vmCvar_t	ui_skin33;
extern vmCvar_t	ui_skin34;
extern vmCvar_t	ui_skin35;
extern vmCvar_t	ui_skin36;
extern vmCvar_t	ui_skin37;
extern vmCvar_t	ui_skin38;
extern vmCvar_t	ui_skin39;
extern vmCvar_t	ui_skin40;
extern vmCvar_t	ui_skin41;
extern vmCvar_t	ui_skin42;
extern vmCvar_t	ui_skin43;
extern vmCvar_t	ui_skin44;
extern vmCvar_t	ui_skin45;
extern vmCvar_t	ui_skin46;
extern vmCvar_t	ui_skin47;
extern vmCvar_t	ui_skin48;
extern vmCvar_t	ui_skin49;
extern vmCvar_t	ui_skin50;
extern vmCvar_t	ui_skin51;
extern vmCvar_t	ui_skin52;
extern vmCvar_t	ui_skin53;
extern vmCvar_t	ui_skin54;
extern vmCvar_t	ui_skin55;
extern vmCvar_t	ui_skin56;
extern vmCvar_t	ui_skin57;
extern vmCvar_t	ui_skin58;
extern vmCvar_t	ui_skin59;
extern vmCvar_t	ui_skin60;
extern vmCvar_t	ui_skin61;
extern vmCvar_t	ui_skin62;
extern vmCvar_t	ui_skin63;
extern vmCvar_t	ui_skin64;
extern vmCvar_t	ui_skin65;
extern vmCvar_t	ui_skin66;
extern vmCvar_t	ui_skin67;
extern vmCvar_t	ui_skin68;
extern vmCvar_t	ui_skin69;
extern vmCvar_t	ui_skin70;
extern vmCvar_t	ui_skin71;
extern vmCvar_t	ui_skin72;
extern vmCvar_t	ui_skin73;
extern vmCvar_t	ui_skin74;
extern vmCvar_t	ui_skin75;
extern vmCvar_t	ui_skin76;
extern vmCvar_t	ui_skin77;
extern vmCvar_t	ui_skin78;
extern vmCvar_t	ui_skin79;
extern vmCvar_t	ui_skin80;
extern vmCvar_t	ui_skin81;
extern vmCvar_t	ui_skin82;
extern vmCvar_t	ui_skin83;
extern vmCvar_t	ui_skin84;
extern vmCvar_t	ui_skin85;
extern vmCvar_t	ui_skin86;
extern vmCvar_t	ui_skin87;
extern vmCvar_t	ui_skin88;
extern vmCvar_t	ui_skin89;
extern vmCvar_t	ui_skin90;
extern vmCvar_t	ui_skin91;
extern vmCvar_t	ui_skin92;
extern vmCvar_t	ui_skin93;
extern vmCvar_t	ui_skin94;
extern vmCvar_t	ui_skin95;
extern vmCvar_t	ui_skin96;
extern vmCvar_t	ui_skin97;
extern vmCvar_t	ui_skin98;
extern vmCvar_t	ui_skin99;
extern vmCvar_t	ui_skin100;
extern vmCvar_t	ui_skin101;
extern vmCvar_t	ui_skin102;
extern vmCvar_t	ui_skin103;
extern vmCvar_t	ui_skin104;
extern vmCvar_t	ui_skin105;
extern vmCvar_t	ui_skin106;
extern vmCvar_t	ui_skin107;
extern vmCvar_t	ui_skin108;
extern vmCvar_t	ui_skin109;
extern vmCvar_t	ui_skin110;
extern vmCvar_t	ui_skin111;
extern vmCvar_t	ui_skin112;
extern vmCvar_t	ui_skin113;
extern vmCvar_t	ui_skin114;
extern vmCvar_t	ui_skin115;
extern vmCvar_t	ui_skin116;
extern vmCvar_t	ui_skin117;
extern vmCvar_t	ui_skin118;
extern vmCvar_t	ui_skin119;
extern vmCvar_t	ui_skin120;
extern vmCvar_t	ui_skin121;
extern vmCvar_t	ui_skin122;
extern vmCvar_t	ui_skin123;
extern vmCvar_t	ui_skin124;
extern vmCvar_t	ui_skin125;
extern vmCvar_t	ui_skin126;
extern vmCvar_t	ui_skin127;
extern vmCvar_t	ui_skin128;
extern vmCvar_t	ui_skin129;
extern vmCvar_t	ui_skin130;
extern vmCvar_t	ui_skin131;
extern vmCvar_t	ui_skin132;
extern vmCvar_t	ui_skin133;
extern vmCvar_t	ui_skin134;
extern vmCvar_t	ui_skin135;
extern vmCvar_t	ui_skin136;
extern vmCvar_t	ui_skin137;
extern vmCvar_t	ui_skin138;
extern vmCvar_t	ui_skin139;
extern vmCvar_t	ui_skin140;
extern vmCvar_t	ui_skin141;
extern vmCvar_t	ui_skin142;
extern vmCvar_t	ui_skin143;
extern vmCvar_t	ui_skin144;
extern vmCvar_t	ui_skin145;
extern vmCvar_t	ui_skin146;
extern vmCvar_t	ui_skin147;
extern vmCvar_t	ui_skin148;
extern vmCvar_t	ui_skin149;
extern vmCvar_t	ui_skin150;
extern vmCvar_t	ui_skin151;
extern vmCvar_t	ui_skin152;
extern vmCvar_t	ui_skin153;
extern vmCvar_t	ui_skin154;
extern vmCvar_t	ui_skin155;
extern vmCvar_t	ui_skin156;
extern vmCvar_t	ui_skin157;
extern vmCvar_t	ui_skin158;
extern vmCvar_t	ui_skin159;
extern vmCvar_t	ui_skin160;
extern vmCvar_t	ui_skin161;
extern vmCvar_t	ui_skin162;
extern vmCvar_t	ui_skin163;
extern vmCvar_t	ui_skin164;
extern vmCvar_t	ui_skin165;
extern vmCvar_t	ui_skin166;
extern vmCvar_t	ui_skin167;
extern vmCvar_t	ui_skin168;
extern vmCvar_t	ui_skin169;
extern vmCvar_t	ui_skin170;
extern vmCvar_t	ui_skin171;
extern vmCvar_t	ui_skin172;
extern vmCvar_t	ui_skin173;
extern vmCvar_t	ui_skin174;
extern vmCvar_t	ui_skin175;
extern vmCvar_t	ui_skin176;
extern vmCvar_t	ui_skin177;
extern vmCvar_t	ui_skin178;
extern vmCvar_t	ui_skin179;
extern vmCvar_t	ui_skin180;
extern vmCvar_t	ui_skin181;
extern vmCvar_t	ui_skin182;
extern vmCvar_t	ui_skin183;
extern vmCvar_t	ui_skin184;
extern vmCvar_t	ui_skin185;
extern vmCvar_t	ui_skin186;
extern vmCvar_t	ui_skin187;
extern vmCvar_t	ui_skin188;
extern vmCvar_t	ui_skin189;
extern vmCvar_t	ui_skin190;
extern vmCvar_t	ui_skin191;
extern vmCvar_t	ui_skin192;
extern vmCvar_t	ui_skin193;
extern vmCvar_t	ui_skin194;
extern vmCvar_t	ui_skin195;
extern vmCvar_t	ui_skin196;
extern vmCvar_t	ui_skin197;
extern vmCvar_t	ui_skin198;
extern vmCvar_t	ui_skin199;
extern vmCvar_t	ui_skin200;
extern vmCvar_t	ui_skin201;
extern vmCvar_t	ui_skin202;
extern vmCvar_t	ui_skin203;
extern vmCvar_t	ui_skin204;
extern vmCvar_t	ui_skin205;
extern vmCvar_t	ui_skin206;
extern vmCvar_t	ui_skin207;
extern vmCvar_t	ui_skin208;
extern vmCvar_t	ui_skin209;
extern vmCvar_t	ui_skin210;
extern vmCvar_t	ui_skin211;
extern vmCvar_t	ui_skin212;
extern vmCvar_t	ui_skin213;
extern vmCvar_t	ui_skin214;
extern vmCvar_t	ui_skin215;
extern vmCvar_t	ui_skin216;
extern vmCvar_t	ui_skin217;
extern vmCvar_t	ui_skin218;
extern vmCvar_t	ui_skin219;
extern vmCvar_t	ui_skin220;
extern vmCvar_t	ui_skin221;
extern vmCvar_t	ui_skin222;
extern vmCvar_t	ui_skin223;
extern vmCvar_t	ui_skin224;
extern vmCvar_t	ui_skin225;
extern vmCvar_t	ui_skin226;
extern vmCvar_t	ui_skin227;
extern vmCvar_t	ui_skin228;
extern vmCvar_t	ui_skin229;
extern vmCvar_t	ui_skin230;
extern vmCvar_t	ui_skin231;
extern vmCvar_t	ui_skin232;
extern vmCvar_t	ui_skin233;
extern vmCvar_t	ui_skin234;
extern vmCvar_t	ui_skin235;
extern vmCvar_t	ui_skin236;
extern vmCvar_t	ui_skin237;
extern vmCvar_t	ui_skin238;
extern vmCvar_t	ui_skin239;
extern vmCvar_t	ui_skin240;
extern vmCvar_t	ui_skin241;
extern vmCvar_t	ui_skin242;
extern vmCvar_t	ui_skin243;
extern vmCvar_t	ui_skin244;
extern vmCvar_t	ui_skin245;
extern vmCvar_t	ui_skin246;
extern vmCvar_t	ui_skin247;
extern vmCvar_t	ui_skin248;
extern vmCvar_t	ui_skin249;
extern vmCvar_t	ui_skin250;
extern vmCvar_t	ui_skin251;
extern vmCvar_t	ui_skin252;
extern vmCvar_t	ui_skin253;
extern vmCvar_t	ui_skin254;
extern vmCvar_t	ui_skin255;
extern vmCvar_t	ui_skin256;
extern vmCvar_t	ui_skin257;
extern vmCvar_t	ui_skin258;
extern vmCvar_t	ui_skin259;
extern vmCvar_t	ui_skin260;
extern vmCvar_t	ui_skin261;
extern vmCvar_t	ui_skin262;
extern vmCvar_t	ui_skin263;
extern vmCvar_t	ui_skin264;
extern vmCvar_t	ui_skin265;
extern vmCvar_t	ui_skin266;
extern vmCvar_t	ui_skin267;
extern vmCvar_t	ui_skin268;
extern vmCvar_t	ui_skin269;
extern vmCvar_t	ui_skin270;
extern vmCvar_t	ui_skin271;
extern vmCvar_t	ui_skin272;
extern vmCvar_t	ui_skin273;
extern vmCvar_t	ui_skin274;
extern vmCvar_t	ui_skin275;
extern vmCvar_t	ui_skin276;
extern vmCvar_t	ui_skin277;
extern vmCvar_t	ui_skin278;
extern vmCvar_t	ui_skin279;
extern vmCvar_t	ui_skin280;
extern vmCvar_t	ui_skin281;
extern vmCvar_t	ui_skin282;
extern vmCvar_t	ui_skin283;
extern vmCvar_t	ui_skin284;
extern vmCvar_t	ui_skin285;
extern vmCvar_t	ui_skin286;
extern vmCvar_t	ui_skin287;
extern vmCvar_t	ui_skin288;
extern vmCvar_t	ui_skin289;
extern vmCvar_t	ui_skin290;
extern vmCvar_t	ui_skin291;
extern vmCvar_t	ui_skin292;
extern vmCvar_t	ui_skin293;
extern vmCvar_t	ui_skin294;
extern vmCvar_t	ui_skin295;
extern vmCvar_t	ui_skin296;
extern vmCvar_t	ui_skin297;
extern vmCvar_t	ui_skin298;
extern vmCvar_t	ui_skin299;
extern vmCvar_t	ui_skin300;
extern vmCvar_t	ui_skin301;
extern vmCvar_t	ui_skin302;
extern vmCvar_t	ui_skin303;
extern vmCvar_t	ui_skin304;
extern vmCvar_t	ui_skin305;
extern vmCvar_t	ui_skin306;
extern vmCvar_t	ui_skin307;
extern vmCvar_t	ui_skin308;
extern vmCvar_t	ui_skin309;
extern vmCvar_t	ui_skin310;
extern vmCvar_t	ui_skin311;
extern vmCvar_t	ui_skin312;
extern vmCvar_t	ui_skin313;
extern vmCvar_t	ui_skin314;
extern vmCvar_t	ui_skin315;
extern vmCvar_t	ui_skin316;
extern vmCvar_t	ui_skin317;
extern vmCvar_t	ui_skin318;
extern vmCvar_t	ui_skin319;
extern vmCvar_t	ui_skin320;
extern vmCvar_t	ui_skin321;
extern vmCvar_t	ui_skin322;
extern vmCvar_t	ui_skin323;
extern vmCvar_t	ui_skin324;
extern vmCvar_t	ui_skin325;
extern vmCvar_t	ui_skin326;
extern vmCvar_t	ui_skin327;
extern vmCvar_t	ui_skin328;
extern vmCvar_t	ui_skin329;
extern vmCvar_t	ui_skin330;
extern vmCvar_t	ui_skin331;
extern vmCvar_t	ui_skin332;
extern vmCvar_t	ui_skin333;
extern vmCvar_t	ui_skin334;
extern vmCvar_t	ui_skin335;
extern vmCvar_t	ui_skin336;
extern vmCvar_t	ui_skin337;
extern vmCvar_t	ui_skin338;
extern vmCvar_t	ui_skin339;
extern vmCvar_t	ui_skin340;
extern vmCvar_t	ui_skin341;
extern vmCvar_t	ui_skin342;
extern vmCvar_t	ui_skin343;
extern vmCvar_t	ui_skin344;
extern vmCvar_t	ui_skin345;
extern vmCvar_t	ui_skin346;
extern vmCvar_t	ui_skin347;
extern vmCvar_t	ui_skin348;
extern vmCvar_t	ui_skin349;
extern vmCvar_t	ui_skin350;
extern vmCvar_t	ui_skin351;
extern vmCvar_t	ui_skin352;
extern vmCvar_t	ui_skin353;
extern vmCvar_t	ui_skin354;
extern vmCvar_t	ui_skin355;
extern vmCvar_t	ui_skin356;
extern vmCvar_t	ui_skin357;
extern vmCvar_t	ui_skin358;
extern vmCvar_t	ui_skin359;
extern vmCvar_t	ui_skin360;
extern vmCvar_t	ui_skin361;
extern vmCvar_t	ui_skin362;
extern vmCvar_t	ui_skin363;
extern vmCvar_t	ui_skin364;
extern vmCvar_t	ui_skin365;
extern vmCvar_t	ui_skin366;
extern vmCvar_t	ui_skin367;
extern vmCvar_t	ui_skin368;
extern vmCvar_t	ui_skin369;
extern vmCvar_t	ui_skin370;
extern vmCvar_t	ui_skin371;
extern vmCvar_t	ui_skin372;
extern vmCvar_t	ui_skin373;
extern vmCvar_t	ui_skin374;
extern vmCvar_t	ui_skin375;
extern vmCvar_t	ui_skin376;
extern vmCvar_t	ui_skin377;
extern vmCvar_t	ui_skin378;
extern vmCvar_t	ui_skin379;
extern vmCvar_t	ui_skin380;
extern vmCvar_t	ui_skin381;
extern vmCvar_t	ui_skin382;
extern vmCvar_t	ui_skin383;
extern vmCvar_t	ui_skin384;
extern vmCvar_t	ui_skin385;
extern vmCvar_t	ui_skin386;
extern vmCvar_t	ui_skin387;
extern vmCvar_t	ui_skin388;
extern vmCvar_t	ui_skin389;
extern vmCvar_t	ui_skin390;
extern vmCvar_t	ui_skin391;
extern vmCvar_t	ui_skin392;
extern vmCvar_t	ui_skin393;
extern vmCvar_t	ui_skin394;
extern vmCvar_t	ui_skin395;
extern vmCvar_t	ui_skin396;
extern vmCvar_t	ui_skin397;
extern vmCvar_t	ui_skin398;
extern vmCvar_t	ui_skin399;
extern vmCvar_t	ui_skin400;
extern vmCvar_t	ui_skin401;
extern vmCvar_t	ui_skin402;
extern vmCvar_t	ui_skin403;
extern vmCvar_t	ui_skin404;
extern vmCvar_t	ui_skin405;
extern vmCvar_t	ui_skin406;
extern vmCvar_t	ui_skin407;
extern vmCvar_t	ui_skin408;
extern vmCvar_t	ui_skin409;
extern vmCvar_t	ui_skin410;
extern vmCvar_t	ui_skin411;
extern vmCvar_t	ui_skin412;
extern vmCvar_t	ui_skin413;
extern vmCvar_t	ui_skin414;
extern vmCvar_t	ui_skin415;
extern vmCvar_t	ui_skin416;
extern vmCvar_t	ui_skin417;
extern vmCvar_t	ui_skin418;
extern vmCvar_t	ui_skin419;
extern vmCvar_t	ui_skin420;
extern vmCvar_t	ui_skin421;
extern vmCvar_t	ui_skin422;
extern vmCvar_t	ui_skin423;
extern vmCvar_t	ui_skin424;
extern vmCvar_t	ui_skin425;
extern vmCvar_t	ui_skin426;
extern vmCvar_t	ui_skin427;
extern vmCvar_t	ui_skin428;
extern vmCvar_t	ui_skin429;
extern vmCvar_t	ui_skin430;
extern vmCvar_t	ui_skin431;
extern vmCvar_t	ui_skin432;
extern vmCvar_t	ui_skin433;
extern vmCvar_t	ui_skin434;
extern vmCvar_t	ui_skin435;
extern vmCvar_t	ui_skin436;
extern vmCvar_t	ui_skin437;
extern vmCvar_t	ui_skin438;
extern vmCvar_t	ui_skin439;
extern vmCvar_t	ui_skin440;
extern vmCvar_t	ui_skin441;
extern vmCvar_t	ui_skin442;
extern vmCvar_t	ui_skin443;
extern vmCvar_t	ui_skin444;
extern vmCvar_t	ui_skin445;
extern vmCvar_t	ui_skin446;
extern vmCvar_t	ui_skin447;
extern vmCvar_t	ui_skin448;
extern vmCvar_t	ui_skin449;
extern vmCvar_t	ui_skin450;
extern vmCvar_t	ui_skin451;
extern vmCvar_t	ui_skin452;
extern vmCvar_t	ui_skin453;
extern vmCvar_t	ui_skin454;
extern vmCvar_t	ui_skin455;
extern vmCvar_t	ui_skin456;
extern vmCvar_t	ui_skin457;
extern vmCvar_t	ui_skin458;
extern vmCvar_t	ui_skin459;
extern vmCvar_t	ui_skin460;
extern vmCvar_t	ui_skin461;
extern vmCvar_t	ui_skin462;
extern vmCvar_t	ui_skin463;
extern vmCvar_t	ui_skin464;
extern vmCvar_t	ui_skin465;
extern vmCvar_t	ui_skin466;
extern vmCvar_t	ui_skin467;
extern vmCvar_t	ui_skin468;
extern vmCvar_t	ui_skin469;
extern vmCvar_t	ui_skin470;
extern vmCvar_t	ui_skin471;
extern vmCvar_t	ui_skin472;
extern vmCvar_t	ui_skin473;
extern vmCvar_t	ui_skin474;
extern vmCvar_t	ui_skin475;
extern vmCvar_t	ui_skin476;
extern vmCvar_t	ui_skin477;
extern vmCvar_t	ui_skin478;
extern vmCvar_t	ui_skin479;
extern vmCvar_t	ui_skin480;
extern vmCvar_t	ui_skin481;
extern vmCvar_t	ui_skin482;
extern vmCvar_t	ui_skin483;
extern vmCvar_t	ui_skin484;
extern vmCvar_t	ui_skin485;
extern vmCvar_t	ui_skin486;
extern vmCvar_t	ui_skin487;
extern vmCvar_t	ui_skin488;
extern vmCvar_t	ui_skin489;
extern vmCvar_t	ui_skin490;
extern vmCvar_t	ui_skin491;
extern vmCvar_t	ui_skin492;
extern vmCvar_t	ui_skin493;
extern vmCvar_t	ui_skin494;
extern vmCvar_t	ui_skin495;
extern vmCvar_t	ui_skin496;
extern vmCvar_t	ui_skin497;
extern vmCvar_t	ui_skin498;
extern vmCvar_t	ui_skin499;
extern vmCvar_t	ui_skin500;
extern vmCvar_t	ui_skin501;
extern vmCvar_t	ui_skin502;
extern vmCvar_t	ui_skin503;
extern vmCvar_t	ui_skin504;
extern vmCvar_t	ui_skin505;
extern vmCvar_t	ui_skin506;
extern vmCvar_t	ui_skin507;
extern vmCvar_t	ui_skin508;
extern vmCvar_t	ui_skin509;
extern vmCvar_t	ui_skin510;
extern vmCvar_t	ui_skin511;
extern vmCvar_t	ui_skin512;
extern vmCvar_t	ui_skin513;
extern vmCvar_t	ui_skin514;
extern vmCvar_t	ui_skin515;
extern vmCvar_t	ui_skin516;
extern vmCvar_t	ui_skin517;
extern vmCvar_t	ui_skin518;
extern vmCvar_t	ui_skin519;
extern vmCvar_t	ui_skin520;
extern vmCvar_t	ui_skin521;
extern vmCvar_t	ui_skin522;
extern vmCvar_t	ui_skin523;
extern vmCvar_t	ui_skin524;
extern vmCvar_t	ui_skin525;
extern vmCvar_t	ui_skin526;
extern vmCvar_t	ui_skin527;
extern vmCvar_t	ui_skin528;
extern vmCvar_t	ui_skin529;
extern vmCvar_t	ui_skin530;
extern vmCvar_t	ui_skin531;
extern vmCvar_t	ui_skin532;
extern vmCvar_t	ui_skin533;
extern vmCvar_t	ui_skin534;
extern vmCvar_t	ui_skin535;
extern vmCvar_t	ui_skin536;
extern vmCvar_t	ui_skin537;
extern vmCvar_t	ui_skin538;
extern vmCvar_t	ui_skin539;
extern vmCvar_t	ui_skin540;
extern vmCvar_t	ui_skin541;
extern vmCvar_t	ui_skin542;
extern vmCvar_t	ui_skin543;
extern vmCvar_t	ui_skin544;
extern vmCvar_t	ui_skin545;
extern vmCvar_t	ui_skin546;
extern vmCvar_t	ui_skin547;
extern vmCvar_t	ui_skin548;
extern vmCvar_t	ui_skin549;
extern vmCvar_t	ui_skin550;
extern vmCvar_t	ui_skin551;
extern vmCvar_t	ui_skin552;
extern vmCvar_t	ui_skin553;
extern vmCvar_t	ui_skin554;
extern vmCvar_t	ui_skin555;
extern vmCvar_t	ui_skin556;
extern vmCvar_t	ui_skin557;
extern vmCvar_t	ui_skin558;
extern vmCvar_t	ui_skin559;
extern vmCvar_t	ui_skin560;
extern vmCvar_t	ui_skin561;
extern vmCvar_t	ui_skin562;
extern vmCvar_t	ui_skin563;
extern vmCvar_t	ui_skin564;
extern vmCvar_t	ui_skin565;
extern vmCvar_t	ui_skin566;
extern vmCvar_t	ui_skin567;
extern vmCvar_t	ui_skin568;
extern vmCvar_t	ui_skin569;
extern vmCvar_t	ui_skin570;
extern vmCvar_t	ui_skin571;
extern vmCvar_t	ui_skin572;
extern vmCvar_t	ui_skin573;
extern vmCvar_t	ui_skin574;
extern vmCvar_t	ui_skin575;
extern vmCvar_t	ui_skin576;
extern vmCvar_t	ui_skin577;
extern vmCvar_t	ui_skin578;
extern vmCvar_t	ui_skin579;
extern vmCvar_t	ui_skin580;
extern vmCvar_t	ui_skin581;
extern vmCvar_t	ui_skin582;
extern vmCvar_t	ui_skin583;
extern vmCvar_t	ui_skin584;
extern vmCvar_t	ui_skin585;
extern vmCvar_t	ui_skin586;
extern vmCvar_t	ui_skin587;
extern vmCvar_t	ui_skin588;
extern vmCvar_t	ui_skin589;
extern vmCvar_t	ui_skin590;
extern vmCvar_t	ui_skin591;
extern vmCvar_t	ui_skin592;
extern vmCvar_t	ui_skin593;
extern vmCvar_t	ui_skin594;
extern vmCvar_t	ui_skin595;
extern vmCvar_t	ui_skin596;
extern vmCvar_t	ui_skin597;
extern vmCvar_t	ui_skin598;
extern vmCvar_t	ui_skin599;
extern vmCvar_t	ui_skin600;
extern vmCvar_t	ui_skin601;
extern vmCvar_t	ui_skin602;
extern vmCvar_t	ui_skin603;
extern vmCvar_t	ui_skin604;
extern vmCvar_t	ui_skin605;
extern vmCvar_t	ui_skin606;
extern vmCvar_t	ui_skin607;
extern vmCvar_t	ui_skin608;
extern vmCvar_t	ui_skin609;
extern vmCvar_t	ui_skin610;
extern vmCvar_t	ui_skin611;
extern vmCvar_t	ui_skin612;
extern vmCvar_t	ui_skin613;
extern vmCvar_t	ui_skin614;
extern vmCvar_t	ui_skin615;
extern vmCvar_t	ui_skin616;
extern vmCvar_t	ui_skin617;
extern vmCvar_t	ui_skin618;
extern vmCvar_t	ui_skin619;
extern vmCvar_t	ui_skin620;
extern vmCvar_t	ui_skin621;
extern vmCvar_t	ui_skin622;
extern vmCvar_t	ui_skin623;
extern vmCvar_t	ui_skin624;
extern vmCvar_t	ui_skin625;
extern vmCvar_t	ui_skin626;
extern vmCvar_t	ui_skin627;
extern vmCvar_t	ui_skin628;
extern vmCvar_t	ui_skin629;
extern vmCvar_t	ui_skin630;
extern vmCvar_t	ui_skin631;
extern vmCvar_t	ui_skin632;
extern vmCvar_t	ui_skin633;
extern vmCvar_t	ui_skin634;
extern vmCvar_t	ui_skin635;
extern vmCvar_t	ui_skin636;
extern vmCvar_t	ui_skin637;
extern vmCvar_t	ui_skin638;
extern vmCvar_t	ui_skin639;
extern vmCvar_t	ui_skin640;
extern vmCvar_t	ui_skin641;
extern vmCvar_t	ui_skin642;
extern vmCvar_t	ui_skin643;
extern vmCvar_t	ui_skin644;
extern vmCvar_t	ui_skin645;
extern vmCvar_t	ui_skin646;
extern vmCvar_t	ui_skin647;
extern vmCvar_t	ui_skin648;
extern vmCvar_t	ui_skin649;
extern vmCvar_t	ui_skin650;
extern vmCvar_t	ui_skin651;
extern vmCvar_t	ui_skin652;
extern vmCvar_t	ui_skin653;
extern vmCvar_t	ui_skin654;
extern vmCvar_t	ui_skin655;
extern vmCvar_t	ui_skin656;
extern vmCvar_t	ui_skin657;
extern vmCvar_t	ui_skin658;
extern vmCvar_t	ui_skin659;
extern vmCvar_t	ui_skin660;
extern vmCvar_t	ui_skin661;
extern vmCvar_t	ui_skin662;
extern vmCvar_t	ui_skin663;
extern vmCvar_t	ui_skin664;
extern vmCvar_t	ui_skin665;
extern vmCvar_t	ui_skin666;
extern vmCvar_t	ui_skin667;
extern vmCvar_t	ui_skin668;
extern vmCvar_t	ui_skin669;
extern vmCvar_t	ui_skin670;
extern vmCvar_t	ui_skin671;
extern vmCvar_t	ui_skin672;
extern vmCvar_t	ui_skin673;
extern vmCvar_t	ui_skin674;
extern vmCvar_t	ui_skin675;
extern vmCvar_t	ui_skin676;
extern vmCvar_t	ui_skin677;
extern vmCvar_t	ui_skin678;
extern vmCvar_t	ui_skin679;
extern vmCvar_t	ui_skin680;
extern vmCvar_t	ui_skin681;
extern vmCvar_t	ui_skin682;
extern vmCvar_t	ui_skin683;
extern vmCvar_t	ui_skin684;
extern vmCvar_t	ui_skin685;
extern vmCvar_t	ui_skin686;
extern vmCvar_t	ui_skin687;
extern vmCvar_t	ui_skin688;
extern vmCvar_t	ui_skin689;
extern vmCvar_t	ui_skin690;
extern vmCvar_t	ui_skin691;
extern vmCvar_t	ui_skin692;
extern vmCvar_t	ui_skin693;
extern vmCvar_t	ui_skin694;
extern vmCvar_t	ui_skin695;
extern vmCvar_t	ui_skin696;
extern vmCvar_t	ui_skin697;
extern vmCvar_t	ui_skin698;
extern vmCvar_t	ui_skin699;
extern vmCvar_t	ui_skin700;
extern vmCvar_t	ui_skin701;
extern vmCvar_t	ui_skin702;
extern vmCvar_t	ui_skin703;
extern vmCvar_t	ui_skin704;
extern vmCvar_t	ui_skin705;
extern vmCvar_t	ui_skin706;
extern vmCvar_t	ui_skin707;
extern vmCvar_t	ui_skin708;
extern vmCvar_t	ui_skin709;
extern vmCvar_t	ui_skin710;
extern vmCvar_t	ui_skin711;
extern vmCvar_t	ui_skin712;
extern vmCvar_t	ui_skin713;
extern vmCvar_t	ui_skin714;
extern vmCvar_t	ui_skin715;
extern vmCvar_t	ui_skin716;
extern vmCvar_t	ui_skin717;
extern vmCvar_t	ui_skin718;
extern vmCvar_t	ui_skin719;
extern vmCvar_t	ui_skin720;
extern vmCvar_t	ui_skin721;
extern vmCvar_t	ui_skin722;
extern vmCvar_t	ui_skin723;
extern vmCvar_t	ui_skin724;
extern vmCvar_t	ui_skin725;
extern vmCvar_t	ui_skin726;
extern vmCvar_t	ui_skin727;
extern vmCvar_t	ui_skin728;
extern vmCvar_t	ui_skin729;
extern vmCvar_t	ui_skin730;
extern vmCvar_t	ui_skin731;
extern vmCvar_t	ui_skin732;
extern vmCvar_t	ui_skin733;
extern vmCvar_t	ui_skin734;
extern vmCvar_t	ui_skin735;
extern vmCvar_t	ui_skin736;
extern vmCvar_t	ui_skin737;
extern vmCvar_t	ui_skin738;
extern vmCvar_t	ui_skin739;
extern vmCvar_t	ui_skin740;
extern vmCvar_t	ui_skin741;
extern vmCvar_t	ui_skin742;
extern vmCvar_t	ui_skin743;
extern vmCvar_t	ui_skin744;
extern vmCvar_t	ui_skin745;
extern vmCvar_t	ui_skin746;
extern vmCvar_t	ui_skin747;
extern vmCvar_t	ui_skin748;
extern vmCvar_t	ui_skin749;
extern vmCvar_t	ui_skin750;
extern vmCvar_t	ui_skin751;
extern vmCvar_t	ui_skin752;
extern vmCvar_t	ui_skin753;
extern vmCvar_t	ui_skin754;
extern vmCvar_t	ui_skin755;
extern vmCvar_t	ui_skin756;
extern vmCvar_t	ui_skin757;
extern vmCvar_t	ui_skin758;
extern vmCvar_t	ui_skin759;
extern vmCvar_t	ui_skin760;
extern vmCvar_t	ui_skin761;
extern vmCvar_t	ui_skin762;
extern vmCvar_t	ui_skin763;
extern vmCvar_t	ui_skin764;
extern vmCvar_t	ui_skin765;
extern vmCvar_t	ui_skin766;
extern vmCvar_t	ui_skin767;
extern vmCvar_t	ui_skin768;
extern vmCvar_t	ui_skin769;
extern vmCvar_t	ui_skin770;
extern vmCvar_t	ui_skin771;
extern vmCvar_t	ui_skin772;
extern vmCvar_t	ui_skin773;
extern vmCvar_t	ui_skin774;
extern vmCvar_t	ui_skin775;
extern vmCvar_t	ui_skin776;
extern vmCvar_t	ui_skin777;
extern vmCvar_t	ui_skin778;
extern vmCvar_t	ui_skin779;
extern vmCvar_t	ui_skin780;
extern vmCvar_t	ui_skin781;
extern vmCvar_t	ui_skin782;
extern vmCvar_t	ui_skin783;
extern vmCvar_t	ui_skin784;
extern vmCvar_t	ui_skin785;
extern vmCvar_t	ui_skin786;
extern vmCvar_t	ui_skin787;
extern vmCvar_t	ui_skin788;
extern vmCvar_t	ui_skin789;
extern vmCvar_t	ui_skin790;
extern vmCvar_t	ui_skin791;
extern vmCvar_t	ui_skin792;
extern vmCvar_t	ui_skin793;
extern vmCvar_t	ui_skin794;
extern vmCvar_t	ui_skin795;
extern vmCvar_t	ui_skin796;
extern vmCvar_t	ui_skin797;
extern vmCvar_t	ui_skin798;
extern vmCvar_t	ui_skin799;
extern vmCvar_t	ui_skin800;
extern vmCvar_t	ui_skin801;
extern vmCvar_t	ui_skin802;
extern vmCvar_t	ui_skin803;
extern vmCvar_t	ui_skin804;
extern vmCvar_t	ui_skin805;
extern vmCvar_t	ui_skin806;
extern vmCvar_t	ui_skin807;
extern vmCvar_t	ui_skin808;
extern vmCvar_t	ui_skin809;
extern vmCvar_t	ui_skin810;
extern vmCvar_t	ui_skin811;
extern vmCvar_t	ui_skin812;
extern vmCvar_t	ui_skin813;
extern vmCvar_t	ui_skin814;
extern vmCvar_t	ui_skin815;
extern vmCvar_t	ui_skin816;
extern vmCvar_t	ui_skin817;
extern vmCvar_t	ui_skin818;
extern vmCvar_t	ui_skin819;
extern vmCvar_t	ui_skin820;
extern vmCvar_t	ui_skin821;
extern vmCvar_t	ui_skin822;
extern vmCvar_t	ui_skin823;
extern vmCvar_t	ui_skin824;
extern vmCvar_t	ui_skin825;
extern vmCvar_t	ui_skin826;
extern vmCvar_t	ui_skin827;
extern vmCvar_t	ui_skin828;
extern vmCvar_t	ui_skin829;
extern vmCvar_t	ui_skin830;
extern vmCvar_t	ui_skin831;
extern vmCvar_t	ui_skin832;
extern vmCvar_t	ui_skin833;
extern vmCvar_t	ui_skin834;
extern vmCvar_t	ui_skin835;
extern vmCvar_t	ui_skin836;
extern vmCvar_t	ui_skin837;
extern vmCvar_t	ui_skin838;
extern vmCvar_t	ui_skin839;
extern vmCvar_t	ui_skin840;
extern vmCvar_t	ui_skin841;
extern vmCvar_t	ui_skin842;
extern vmCvar_t	ui_skin843;
extern vmCvar_t	ui_skin844;
extern vmCvar_t	ui_skin845;
extern vmCvar_t	ui_skin846;
extern vmCvar_t	ui_skin847;
extern vmCvar_t	ui_skin848;
extern vmCvar_t	ui_skin849;
extern vmCvar_t	ui_skin850;	*/


//extern vmCvar_t	ui_cdkey;
//extern vmCvar_t	ui_cdkeychecked;
extern vmCvar_t ui_setupchecked;

//new in beta 23:
extern vmCvar_t ui_browserOnlyHumans;

//
// ui_qmenu.c
//

#define RCOLUMN_OFFSET			( BIGCHAR_WIDTH )
#define LCOLUMN_OFFSET			(-BIGCHAR_WIDTH )

#define SLIDER_RANGE			10
#define	MAX_EDIT_LINE			256

#define MAX_MENUDEPTH			8
#ifndef MAX_MENUITEMS
#define MAX_MENUITEMS			512
#endif

#define MTYPE_NULL				0
#define MTYPE_SLIDER			1
#define MTYPE_ACTION			2
#define MTYPE_SPINCONTROL		3
#define MTYPE_FIELD				4
#define MTYPE_RADIOBUTTON		5
#define MTYPE_BITMAP			6
#define MTYPE_TEXT				7
#define MTYPE_SCROLLLIST		8
#define MTYPE_PTEXT				9
#define MTYPE_BTEXT				10

#define QMF_BLINK				(unsigned int)0x00000001
#define QMF_SMALLFONT			(unsigned int)0x00000002
#define QMF_LEFT_JUSTIFY		(unsigned int)0x00000004
#define QMF_CENTER_JUSTIFY		(unsigned int)0x00000008
#define QMF_RIGHT_JUSTIFY		(unsigned int)0x00000010
#define QMF_NUMBERSONLY			(unsigned int)0x00000020	// edit field is only numbers
#define QMF_HIGHLIGHT			(unsigned int)0x00000040
#define QMF_HIGHLIGHT_IF_FOCUS	(unsigned int)0x00000080	// steady focus
#define QMF_PULSEIFFOCUS		(unsigned int)0x00000100	// pulse if focus
#define QMF_HASMOUSEFOCUS		(unsigned int)0x00000200
#define QMF_NOONOFFTEXT			(unsigned int)0x00000400
#define QMF_MOUSEONLY			(unsigned int)0x00000800	// only mouse input allowed
#define QMF_HIDDEN				(unsigned int)0x00001000	// skips drawing
#define QMF_GRAYED				(unsigned int)0x00002000	// grays and disables
#define QMF_INACTIVE			(unsigned int)0x00004000	// disables any input
#define QMF_NODEFAULTINIT		(unsigned int)0x00008000	// skip default initialization
#define QMF_OWNERDRAW			(unsigned int)0x00010000
#define QMF_PULSE				(unsigned int)0x00020000
#define QMF_LOWERCASE			(unsigned int)0x00040000	// edit field is all lower case
#define QMF_UPPERCASE			(unsigned int)0x00080000	// edit field is all upper case
#define QMF_SILENT				(unsigned int)0x00100000

//for cgs.ffa_gt and g_ffa kinda leary about this...
//#define FREEFORALL			(s_serveroptions.gametype==GT_LMS)
//#define TRAP_FREEFORALL			(trap_Cvar_VariableValue( "g_gametype" ) == GT_LMS)

// callback notifications
#define QM_GOTFOCUS				1
#define QM_LOSTFOCUS			2
#define QM_ACTIVATED			3

typedef struct _tag_menuframework
{
	int	cursor;
	int cursor_prev;

	int	nitems;
	void *items[MAX_MENUITEMS];

	void (*draw) (void);
	sfxHandle_t (*key) (int key);

	qboolean	wrapAround;
	qboolean	fullscreen;
	qboolean	showlogo;
} menuframework_s;

typedef struct
{
	int type;
	const char *name;
	int	id;
	int x, y;
	int left;
	int	top;
	int	right;
	int	bottom;
	menuframework_s *parent;
	int menuPosition;
	unsigned flags;

	void (*callback)( void *self, int event );
	void (*statusbar)( void *self );
	void (*ownerdraw)( void *self );
} menucommon_s;

typedef struct {
	int		cursor;
	int		scroll;
	int		widthInChars;
	char	buffer[MAX_EDIT_LINE];
	int		maxchars;
} mfield_t;

typedef struct
{
	menucommon_s	generic;
	mfield_t		field;
} menufield_s;

typedef struct
{
	menucommon_s generic;

	float minvalue;
	float maxvalue;
	float curvalue;

	float range;
} menuslider_s;

typedef struct
{
	menucommon_s generic;

	int	oldvalue;
	int curvalue;
	int	numitems;
	int	top;

	const char **itemnames;

	int width;
	int height;
	int	columns;
	int	seperation;
} menulist_s;

typedef struct
{
	menucommon_s generic;
} menuaction_s;

typedef struct
{
	menucommon_s generic;
	int curvalue;
} menuradiobutton_s;

typedef struct
{
	menucommon_s	generic;
	char*			focuspic;
	char*			errorpic;
	qhandle_t		shader;
	qhandle_t		focusshader;
	int				width;
	int				height;
	float*			focuscolor;
} menubitmap_s;

typedef struct
{
	menucommon_s	generic;
	char*			string;
	int				style;
	float*			color;
} menutext_s;

#define MAX_MAPNAME_LENGTH 32

typedef struct {
	int pagenumber;
	char mapname[10][MAX_MAPNAME_LENGTH];
} t_mappage;

extern t_mappage mappage;

extern void			Menu_Cache( void );
extern void			Menu_Focus( menucommon_s *m );
extern void			Menu_AddItem( menuframework_s *menu, void *item );
extern void			Menu_AdjustCursor( menuframework_s *menu, int dir );
extern void			Menu_Draw( menuframework_s *menu );
extern void			*Menu_ItemAtCursor( menuframework_s *m );
extern sfxHandle_t	Menu_ActivateItem( menuframework_s *s, menucommon_s* item );
extern void			Menu_SetCursor( menuframework_s *s, int cursor );
extern void			Menu_SetCursorToItem( menuframework_s *m, void* ptr );
extern sfxHandle_t	Menu_DefaultKey( menuframework_s *s, int key );
extern void			Bitmap_Init( menubitmap_s *b );
extern void			Bitmap_Draw( menubitmap_s *b );
extern void			ScrollList_Draw( menulist_s *l );
extern sfxHandle_t	ScrollList_Key( menulist_s *l, int key );
extern sfxHandle_t	menu_in_sound;
extern sfxHandle_t	menu_move_sound;
extern sfxHandle_t	menu_out_sound;
extern sfxHandle_t	menu_buzz_sound;
extern sfxHandle_t	menu_null_sound;
extern sfxHandle_t	weaponChangeSound;
extern vec4_t		menu_text_color;
extern vec4_t		menu_grayed_color;
extern vec4_t		menu_dark_color;
extern vec4_t		menu_highlight_color;
extern vec4_t		menu_red_color;
extern vec4_t		menu_black_color;
extern vec4_t		menu_dim_color;
extern vec4_t		color_black;
extern vec4_t		color_white;
extern vec4_t		color_yellow;
extern vec4_t		color_blue;
extern vec4_t		color_orange;
extern vec4_t		color_red;
extern vec4_t		color_dim;
extern vec4_t		color_green;
extern vec4_t		name_color;
extern vec4_t		list_color;
extern vec4_t		listbar_color;
extern vec4_t		text_color_disabled;
extern vec4_t		text_color_normal;
extern vec4_t		text_color_highlight;

extern char	*ui_medalNames[];
extern char	*ui_medalPicNames[];
extern char	*ui_medalSounds[];

//
// ui_mfield.c
//
extern void			MField_Clear( mfield_t *edit );
extern void			MField_KeyDownEvent( mfield_t *edit, int key );
extern void			MField_CharEvent( mfield_t *edit, int ch );
extern void			MField_Draw( mfield_t *edit, int x, int y, int style, vec4_t color );
extern void			MenuField_Init( menufield_s* m );
extern void			MenuField_Draw( menufield_s *f );
extern sfxHandle_t	MenuField_Key( menufield_s* m, int* key );

//
// ui_menu.c
//
extern int SelRandom(int r);
extern void MainMenu_Cache( void );
extern void UI_MainMenu(void);
extern void UI_RegisterCvars( void );
extern void UI_UpdateCvars( void );
extern void UI_SetDefaultCvar(const char* cvar, const char* value);

//
// ui_credits.c
//
extern void UI_CreditMenu( void );

//
// ui_ingame.c
//
extern void InGame_Cache( void );
extern void UI_InGameMenu(void);

//
// ui_confirm.c
//
extern void ConfirmMenu_Cache( void );
extern void UI_ConfirmMenu( const char *question, void (*draw)( void ), void (*action)( qboolean result ) );
extern void UI_ConfirmMenu_Style( const char *question, int style, void (*draw)( void ), void (*action)( qboolean result ) );
extern void UI_Message( const char **lines );

//
// ui_setup.c
//
extern void UI_SetupMenu_Cache( void );
extern void UI_SetupMenu(void);

//
// ui_team.c
//
extern void UI_TeamMainMenu( void );
extern void TeamMain_Cache( void );

//
// ui_actions.c
//
extern void UI_ActMainMenu( void );
extern void ActMain_Cache( void );

//
// ui_connect.c
//
extern void UI_DrawConnectScreen( qboolean overlay );

//
// ui_controls2.c
//
extern void UI_ControlsMenu( void );
extern void Controls_Cache( void );

//
// ui_demo2.c
//
extern void UI_DemosMenu( void );
extern void Demos_Cache( void );

//
// ui_challenges.c
//
extern void UI_Challenges( void );

//
// ui_cinematics.c
//
extern void UI_CinematicsMenu( void );
extern void UI_CinematicsMenu_f( void );
extern void UI_CinematicsMenu_Cache( void );

//
// ui_mods.c
//
extern void UI_ModsMenu( void );
extern void UI_ModsMenu_Cache( void );

//
// ui_cdkey.c
//
extern void UI_CDKeyMenu( void );
extern void UI_CDKeyMenu_Cache( void );
extern void UI_CDKeyMenu_f( void );

//
// ui_playermodel.c
//
extern void UI_PlayerModelMenu( int type );
extern void PlayerModel_Cache( int type );

//
// ui_playersettings.c
//
extern void UI_PlayerSettingsMenu( void );
extern void PlayerSettings_Cache( void );

//
// ui_preferences.c
//
extern void UI_PreferencesMenu( void );
extern void Preferences_Cache( void );

//
// ui_specifyleague.c
//
extern void UI_SpecifyLeagueMenu( void );
extern void SpecifyLeague_Cache( void );

//
// ui_specifyserver.c
//
extern void UI_SpecifyServerMenu( void );
extern void SpecifyServer_Cache( void );

//
// ui_servers2.c
//
#define MAX_FAVORITESERVERS 16

extern void UI_ArenaServersMenu( void );
extern void ArenaServers_Cache( void );

//
// ui_startserver.c
//
extern void UI_StartServerMenu( qboolean multiplayer );
extern void StartServer_Cache( void );
extern void ServerOptions_Cache( void );
extern void UI_BotSelectMenu( char *bot );
extern void UI_BotSelectMenu_Cache( void );

//
// ui_serverinfo.c
//
extern void UI_ServerInfoMenu( void );
extern void ServerInfo_Cache( void );

//
// ui_video.c
//
extern void UI_GraphicsOptionsMenu( void );
extern void GraphicsOptions_Cache( void );
extern void DriverInfo_Cache( void );

//
// ui_votemenu.c
//
extern void UI_VoteMenuMenu( void );

//
// ui_votemenu_fraglimit.c
//
extern void UI_VoteFraglimitMenu( void );

//
// ui_votemenu_timelimit.c
//
extern void UI_VoteTimelimitMenu( void );

//
// ui_votemenu_gametype.c
//
extern void UI_VoteGametypeMenu( void );

//
// ui_votemenu_kick.c
//
extern void UI_VoteKickMenu( void );

//
// ui_votemenu_map.c
//
extern void UI_VoteMapMenu( void );
extern void UI_VoteMapMenuInternal( void );

//
// ui_password.c
//
extern void SpecifyPassword_Cache( void );
extern void UI_SpecifyPasswordMenu( char* string, char *name );

//
// ui_firstconnect.c
//
extern void FirstConnect_Cache( void );
extern void UI_FirstConnectMenu( void );

//
// ui_votemenu_custom.c

extern void UI_VoteCustomMenu( void );

//
// ui_players.c
//

//FIXME ripped from cg_local.h
typedef struct {
	int			oldFrame;
	int			oldFrameTime;		// time when ->oldFrame was exactly on

	int			frame;
	int			frameTime;			// time when ->frame will be exactly on

	float		backlerp;

	float		yawAngle;
	qboolean	yawing;
	float		pitchAngle;
	qboolean	pitching;

	int			animationNumber;	// may include ANIM_TOGGLEBIT
	animation_t	*animation;
	int			animationTime;		// time when the first frame of the animation will be exact
} lerpFrame_t;

typedef struct {
	// model info
	qhandle_t		legsModel;
	qhandle_t		legsSkin;
	lerpFrame_t		legs;

	qhandle_t		torsoModel;
	qhandle_t		torsoSkin;
	lerpFrame_t		torso;

	qhandle_t		headModel;
	qhandle_t		headSkin;

	animation_t		animations[MAX_ANIMATIONS];

	qhandle_t		weaponModel;
	qhandle_t		barrelModel;
	qhandle_t		flashModel;
	vec3_t			flashDlightColor;
	int				muzzleFlashTime;

	// currently in use drawing parms
	vec3_t			viewAngles;
	vec3_t			moveAngles;
	weapon_t		currentWeapon;
	int				legsAnim;
	int				torsoAnim;

	// animation vars
	weapon_t		weapon;
	weapon_t		lastWeapon;
	weapon_t		pendingWeapon;
	int				weaponTimer;
	int				pendingLegsAnim;
	int				torsoAnimationTimer;

	int				pendingTorsoAnim;
	int				legsAnimationTimer;

	qboolean		chat;
	qboolean		newModel;

	qboolean		barrelSpinning;
	float			barrelAngle;
	int				barrelTime;

	int				realWeapon;
} playerInfo_t;

void UI_DrawPlayer( float x, float y, float w, float h, playerInfo_t *pi, int time );
void UI_PlayerInfo_SetModel( playerInfo_t *pi, const char *model );
void UI_PlayerInfo_SetInfo( playerInfo_t *pi, int legsAnim, int torsoAnim, vec3_t viewAngles, vec3_t moveAngles, weapon_t weaponNum, qboolean chat );
qboolean UI_RegisterClientModelname( playerInfo_t *pi, const char *modelSkinName );

//
// ui_atoms.c
//
typedef struct {
	int					frametime;
	int					realtime;
	int					cursorx;
	int					cursory;
	int					menusp;
	menuframework_s*	activemenu;
	menuframework_s*	stack[MAX_MENUDEPTH];
	glconfig_t			glconfig;
	qboolean			debug;
	qhandle_t			whiteShader;
	qhandle_t			menuBackShader;
	qhandle_t			menuBackNoLogoShader;
	qhandle_t			charset;
	qhandle_t			charsetProp;
	qhandle_t			charsetPropGlow;
	qhandle_t			charsetPropB;
	qhandle_t			cursor;
	qhandle_t			rb_on;
	qhandle_t			rb_off;
	float				xscale;
	float				yscale;
	float				bias;
	qboolean			demoversion;
	qboolean			firstdraw;
} uiStatic_t;

extern void UI_ServerPlayerIcon( const char *modelAndSkin, char *iconName, int iconNameMaxSize );
extern void			UI_Init( void );
extern void			UI_Shutdown( void );
extern void			UI_KeyEvent( int key, int down );
extern void			UI_MouseEvent( int dx, int dy );
extern void			UI_Refresh( int realtime );
extern qboolean		UI_ConsoleCommand( int realTime );
extern float		UI_ClampCvar( float min, float max, float value );
extern void			UI_DrawNamedPic( float x, float y, float width, float height, const char *picname );
extern void			UI_DrawHandlePic( float x, float y, float w, float h, qhandle_t hShader );
extern void			UI_FillRect( float x, float y, float width, float height, const float *color );
extern void			UI_DrawRect( float x, float y, float width, float height, const float *color );
extern void			UI_UpdateScreen( void );
extern void			UI_SetColor( const float *rgba );
extern void			UI_LerpColor(vec4_t a, vec4_t b, vec4_t c, float t);
extern void			UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color );
extern float		UI_ProportionalSizeScale( int style );
extern void			UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color );
extern void			UI_DrawProportionalString_AutoWrapped( int x, int ystart, int xmax, int ystep, const char* str, int style, vec4_t color );
extern int			UI_ProportionalStringWidth( const char* str );
extern void			UI_DrawString( int x, int y, const char* str, int style, vec4_t color );
extern void			UI_DrawChar( int x, int y, int ch, int style, vec4_t color );
extern qboolean 	UI_CursorInRect (int x, int y, int width, int height);
extern void			UI_AdjustFrom640( float *x, float *y, float *w, float *h );
extern void			UI_DrawTextBox (int x, int y, int width, int lines);
extern qboolean		UI_IsFullscreen( void );
extern void			UI_SetActiveMenu( uiMenuCommand_t menu );
extern void			UI_PushMenu ( menuframework_s *menu );
extern void			UI_PopMenu (void);
extern void			UI_ForceMenuOff (void);
extern char			*UI_Argv( int arg );
extern char			*UI_Cvar_VariableString( const char *var_name );
extern void			UI_Refresh( int time );
extern void			UI_StartDemoLoop( void );
extern qboolean		m_entersound;
extern uiStatic_t	uis;

//
// ui_spLevel.c
//
void UI_SPLevelMenu_Cache( void );
void UI_SPLevelMenu( void );
void UI_SPLevelMenu_f( void );
void UI_SPLevelMenu_ReInit( void );
void UI_SPLevelMenu_ResetAction( qboolean result );
void UI_SPLevelMenu_ResetDraw( void );

//
// ui_spArena.c
//
void UI_SPArena_Start( const char *arenaInfo );

//
// ui_spPostgame.c
//
void UI_SPPostgameMenu_Cache( void );
void UI_SPPostgameMenu_f( void );

//
// ui_spSkill.c
//
void UI_SPSkillMenu( const char *arenaInfo );
void UI_SPSkillMenu_Cache( void );

//
// ui_syscalls.c
//
void			trap_Print( const char *string );
void			trap_Error( const char *string )  __attribute__((noreturn));
int				trap_Milliseconds( void );
void			trap_Cvar_Register( vmCvar_t *vmCvar, const char *varName, const char *defaultValue, int flags );
void			trap_Cvar_Update( vmCvar_t *vmCvar );
void			trap_Cvar_Set( const char *var_name, const char *value );
float			trap_Cvar_VariableValue( const char *var_name );
void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
void			trap_Cvar_SetValue( const char *var_name, float value );
void			trap_Cvar_Reset( const char *name );
void			trap_Cvar_Create( const char *var_name, const char *var_value, int flags );
void			trap_Cvar_InfoStringBuffer( int bit, char *buffer, int bufsize );
int				trap_Argc( void );
void			trap_Argv( int n, char *buffer, int bufferLength );
void			trap_Cmd_ExecuteText( int exec_when, const char *text );	// don't use EXEC_NOW!
int				trap_FS_FOpenFile( const char *qpath, fileHandle_t *f, fsMode_t mode );
void			trap_FS_Read( void *buffer, int len, fileHandle_t f );
void			trap_FS_Write( const void *buffer, int len, fileHandle_t f );
void			trap_FS_FCloseFile( fileHandle_t f );
int				trap_FS_GetFileList(  const char *path, const char *extension, char *listbuf, int bufsize );
int				trap_FS_Seek( fileHandle_t f, long offset, int origin ); // fsOrigin_t
qhandle_t		trap_R_RegisterModel( const char *name );
qhandle_t		trap_R_RegisterSkin( const char *name );
qhandle_t		trap_R_RegisterShaderNoMip( const char *name );
void			trap_R_ClearScene( void );
void			trap_R_AddRefEntityToScene( const refEntity_t *re );
void			trap_R_AddPolyToScene( qhandle_t hShader , int numVerts, const polyVert_t *verts );
void			trap_R_AddLightToScene( const vec3_t org, float intensity, float r, float g, float b );
void			trap_R_RenderScene( const refdef_t *fd );
void			trap_R_SetColor( const float *rgba );
void			trap_R_DrawStretchPic( float x, float y, float w, float h, float s1, float t1, float s2, float t2, qhandle_t hShader );
void			trap_UpdateScreen( void );
int				trap_CM_LerpTag( orientation_t *tag, clipHandle_t mod, int startFrame, int endFrame, float frac, const char *tagName );
void			trap_S_StartLocalSound( sfxHandle_t sfx, int channelNum );
sfxHandle_t	trap_S_RegisterSound( const char *sample, qboolean compressed );
void			trap_Key_KeynumToStringBuf( int keynum, char *buf, int buflen );
void			trap_Key_GetBindingBuf( int keynum, char *buf, int buflen );
void			trap_Key_SetBinding( int keynum, const char *binding );
qboolean		trap_Key_IsDown( int keynum );
qboolean		trap_Key_GetOverstrikeMode( void );
void			trap_Key_SetOverstrikeMode( qboolean state );
void			trap_Key_ClearStates( void );
int				trap_Key_GetCatcher( void );
void			trap_Key_SetCatcher( int catcher );
void			trap_GetClipboardData( char *buf, int bufsize );
void			trap_GetClientState( uiClientState_t *state );
void			trap_GetGlconfig( glconfig_t *glconfig );
int				trap_GetConfigString( int index, char* buff, int buffsize );
int				trap_LAN_GetServerCount( int source );
void			trap_LAN_GetServerAddressString( int source, int n, char *buf, int buflen );
void			trap_LAN_GetServerInfo( int source, int n, char *buf, int buflen );
int				trap_LAN_GetPingQueueCount( void );
int				trap_LAN_ServerStatus( const char *serverAddress, char *serverStatus, int maxLen );
void			trap_LAN_ClearPing( int n );
void			trap_LAN_GetPing( int n, char *buf, int buflen, int *pingtime );
void			trap_LAN_GetPingInfo( int n, char *buf, int buflen );
int				trap_MemoryRemaining( void );
void			trap_GetCDKey( char *buf, int buflen );
void			trap_SetCDKey( char *buf );

qboolean               trap_VerifyCDKey( const char *key, const char *chksum); // bk001208 - RC4

void			trap_SetPbClStatus( int status );

//
// ui_addbots.c
//
void UI_AddBots_Cache( void );
void UI_AddBotsMenu( void );


//
// ui_removebots.c
//
void UI_RemoveBots_Cache( void );
void UI_RemoveBotsMenu( void );

//
// ui_teamorders.c
//
extern void UI_TeamOrdersMenu( void );
extern void UI_TeamOrdersMenu_f( void );
extern void UI_TeamOrdersMenu_Cache( void );

//
// ui_loadconfig.c
//
void UI_LoadConfig_Cache( void );
void UI_LoadConfigMenu( void );


//
// ui_saveconfig.c
//
void UI_SaveConfigMenu_Cache( void );
void UI_SaveConfigMenu( void );


//
// ui_loadMAP.c
//
void UI_loadMapEd_Cache( void );
void UI_loadMapEdMenu( void );


//
// ui_saveMAP.c
//
void UI_saveMapEdMenu_Cache( void );
void UI_saveMapEdMenu( void );

//
// ui_display.c
//
void UI_DisplayOptionsMenu_Cache( void );
void UI_DisplayOptionsMenu( void );

//
// ui_sound.c
//
void UI_SoundOptionsMenu_Cache( void );
void UI_SoundOptionsMenu( void );

//
// ui_network.c
//
void UI_NetworkOptionsMenu_Cache( void );
void UI_NetworkOptionsMenu( void );

//
// ui_gameinfo.c
//
typedef enum {
	AWARD_ACCURACY,
	AWARD_IMPRESSIVE,
	AWARD_EXCELLENT,
	AWARD_GAUNTLET,
	AWARD_FRAGS,
	AWARD_PERFECT
} awardType_t;

const char *UI_GetArenaInfoByNumber( int num );
const char *UI_GetArenaInfoByMap( const char *map );
const char *UI_GetSpecialArenaInfo( const char *tag );
int UI_GetNumArenas( void );
int UI_GetNumSPArenas( void );
int UI_GetNumSPTiers( void );

char *UI_GetBotInfoByNumber( int num );
char *UI_GetBotInfoByName( const char *name );
int UI_GetNumBots( void );

void UI_GetBestScore( int level, int *score, int *skill );
void UI_SetBestScore( int level, int score );
int UI_TierCompleted( int levelWon );
qboolean UI_ShowTierVideo( int tier );
qboolean UI_CanShowTierVideo( int tier );
int  UI_GetCurrentGame( void );
void UI_NewGame( void );
void UI_LogAwardData( int award, int data );
int UI_GetAwardLevel( int award );

void UI_SPUnlock_f( void );
void UI_SPUnlockMedals_f( void );
void UI_SPPlayerxp( void );

void UI_InitGameinfo( void );

//GRank

//
// ui_rankings.c
//
void Rankings_DrawText( void* self );
void Rankings_DrawName( void* self );
void Rankings_DrawPassword( void* self );
void Rankings_Cache( void );
void UI_RankingsMenu( void );

//
// ui_login.c
//
void Login_Cache( void );
void UI_LoginMenu( void );

//
// ui_signup.c
//
void Signup_Cache( void );
void UI_SignupMenu( void );

//
// ui_rankstatus.c
//
void RankStatus_Cache( void );
void UI_RankStatusMenu( void );

#endif
