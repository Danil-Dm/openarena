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

MAIN MENU

=======================================================================
*/


#include "ui_local.h"
#include "../game/challenges.h"


#define ID_SINGLEPLAYER			10
#define ID_MULTIPLAYER			11
#define ID_SETUP				12
#define ID_DEMOS				13
//#define ID_CINEMATICS			14
#define ID_CHALLENGES                   14
#define ID_TEAMARENA		15
#define ID_MODS					16
#define ID_EXIT					17
#define ID_RUS					18
#define ID_SECR1					19
#define ID_SECR2					20
#define ID_SECR3					21
#define ID_SECR4					22
#define ID_SECR5					23
#define ID_SECR6					24
#define ID_RUSV					25

#define MAIN_BANNER_MODEL				ui_mainmodel.string
#define MAIN_MENU_VERTICAL_SPACING		34


typedef struct {
	menuframework_s	menu;

	menubitmap_s		player;
	qhandle_t			fxBasePic;
	qhandle_t			fxPic[7];
	playerInfo_t		playerinfo;
	int					current_fx;
	char				playerModel[MAX_QPATH];

	menutext_s		singleplayer;
	menutext_s		multiplayer;
	menutext_s		setup;
	menutext_s		demos;
	//menutext_s		cinematics;
    menutext_s              challenges;
	menutext_s		teamArena;
	menutext_s		mods;
	menutext_s		exit;
	menuradiobutton_s		rus;
	menuradiobutton_s		rusv;
	menutext_s		sec1;
	menutext_s		sec2;
	menutext_s		sec3;
	menutext_s		sec4;
	menutext_s		sec5;
	menutext_s		sec6;

	qhandle_t		bannerModel;
} mainmenu_t;


static mainmenu_t s_main;

typedef struct {
	menuframework_s menu;
	char errorMessage[4096];
} errorMessage_t;

static errorMessage_t s_errorMessage;

/*
=================
MainMenu_ExitAction
=================
*/
/*static void MainMenu_ExitAction( qboolean result ) {
	if( !result ) {
		return;
	}
	UI_PopMenu();
	//UI_CreditMenu();
        trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
}*/

/*
=================
PlayerSettings_DrawPlayer
=================
*/
static void Menu_DrawPlayer( void *self ) {
	menubitmap_s	*b;
	vec3_t			viewangles;
	char			buf[MAX_QPATH];

	trap_Cvar_VariableStringBuffer( "model", buf, sizeof( buf ) );
	if ( strcmp( buf, s_main.playerModel ) != 0 ) {
		UI_PlayerInfo_SetModel( &s_main.playerinfo, buf );
		strcpy( s_main.playerModel, buf );

		viewangles[YAW]   = 180 - 10;
		viewangles[PITCH] = 0;
		viewangles[ROLL]  = 0;
		UI_PlayerInfo_SetInfo( &s_main.playerinfo, LEGS_IDLE, TORSO_STAND2, viewangles, vec3_origin, WP_NONE, qfalse );
	}

	b = (menubitmap_s*) self;
/*	UI_DrawProportionalString( 190, 70, "Model-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 70, UI_Cvar_VariableString("model"), UI_LEFT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 190, 85, "Head-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 85, UI_Cvar_VariableString("headmodel"), UI_LEFT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 190, 100, "Legs-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 100, UI_Cvar_VariableString("ui_mslegsskin"), UI_LEFT|UI_SMALLFONT, text_color_normal );*/
	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_main.playerinfo, uis.realtime/2 );
}

/*
=================
Setup_ResetDefaults_Draw
=================
*/
static void Setup_ResetDefaults_Drawl( void ) {
	if(!rus.integer){
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 0, "WARNING: Charaster buy", UI_CENTER|UI_SMALLFONT, color_yellow );
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 1, "This value 30 coins.", UI_CENTER|UI_SMALLFONT, color_yellow );
	}
	if(rus.integer){
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 0, "ВНИМАНИЕ: Купить персонажа", UI_CENTER|UI_SMALLFONT, color_yellow );
	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 1, "Это стоит 30 coins.", UI_CENTER|UI_SMALLFONT, color_yellow );
	}
}

/*
=================
Setup_Buy_Skin
=================
*/
static void Setup_Buy_Skin( qboolean result ) {
	if( !result ) {
		return;
	}
if(getChallenge(GENERAL_MONEY) > 29){
	challenges_buymenu();
	trap_Cvar_Set( "ui_char", "1" );
}
if(getChallenge(GENERAL_MONEY) > 29){
	if(!rus.integer){
		UI_ConfirmMenu( "Buy random skin?", Setup_ResetDefaults_Drawl, Setup_Buy_Skin );
	}
	if(rus.integer){
		UI_ConfirmMenu( "Купить случайный скин?", Setup_ResetDefaults_Drawl, Setup_Buy_Skin );
	}
}
}

/*
=================
Main_MenuEvent
=================
*/
void Main_MenuEvent (void* ptr, int event) {
	if( event != QM_ACTIVATED ) {
		return;
	}

//	trap_Cvar_Set( "cg_ch9slze", "0" );


	switch( ((menucommon_s*)ptr)->id ) {
	case ID_SINGLEPLAYER:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp01;" );
            if(ui_setupchecked.integer)
		UI_SPLevelMenu();
            else
                UI_FirstConnectMenu();
		break;

	case ID_MULTIPLAYER:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp02;" );
            if(ui_setupchecked.integer)
		UI_ArenaServersMenu();
            else
                UI_FirstConnectMenu();
		break;

	case ID_SETUP:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp03;" );
		UI_SetupMenu();
		break;

	case ID_DEMOS:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp04;" );
		UI_DemosMenu();
		break;

	/*case ID_CINEMATICS:
		UI_CinematicsMenu();
		break;*/

            case ID_CHALLENGES:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp05;" );
                UI_Challenges();
                break;

	case ID_MODS:
		trap_Cmd_ExecuteText( EXEC_APPEND, "music music/fla_mp06;" );
		UI_ModsMenu();
		break;

	case ID_TEAMARENA:
		trap_Cvar_Set( "fs_game", "missionpack");
		trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
		break;

	case ID_RUS:
		trap_Cvar_SetValue( "rus", s_main.rus.curvalue);
		if(s_main.rus.curvalue == 0){
		trap_Cmd_ExecuteText( EXEC_APPEND, "exec english.cfg\n" );
		}
		if(s_main.rus.curvalue == 1){
		trap_Cmd_ExecuteText( EXEC_APPEND, "exec russian.cfg\n" );
		}
		break;

	case ID_RUSV:
		trap_Cvar_SetValue( "ui_gamemodesall", s_main.rusv.curvalue);
		break;

	case ID_SECR1:
	trap_Cvar_Set( "headmodel", "beret/nohead" );
	trap_Cvar_Set( "team_headmodel", "beret/nohead" );
		break;

	case ID_SECR2:
	trap_Cvar_Set( "headmodel", "bones/bones" );
	trap_Cvar_Set( "team_headmodel", "bones/bones" );
		break;

	case ID_SECR3:
	trap_Cmd_ExecuteText( EXEC_APPEND, "map 593cube;" );
		break;

	case ID_SECR4:
	trap_Cmd_ExecuteText( EXEC_APPEND, "demo demo/video/demo/video;" );
		break;

	case ID_SECR5:
	trap_Cvar_Set( "g_music", "music/dangermax/music" );
		break;

	case ID_SECR6:
	if(!rus.integer){
		UI_ConfirmMenu( "Buy random skin?", Setup_ResetDefaults_Drawl, Setup_Buy_Skin );
	}
	if(rus.integer){
		UI_ConfirmMenu( "Купить случайный скин?", Setup_ResetDefaults_Drawl, Setup_Buy_Skin );
	}
		break;


	case ID_EXIT:
		//UI_ConfirmMenu( "EXIT GAME?", 0, MainMenu_ExitAction );
		trap_Cvar_Set( "ui_loaded", "0" );
        UI_CreditMenu();
		break;
	}
}

/*
=================
Clamp_Random

Returns a random number between 0 and r
=================
*/
int SelRandom(int r)
{
	int index;

	r += 1;
	do {
		index = r * random();
	} while (index == r);

	return index;
}



/*
===============
MainMenu_Cache
===============
*/
void MainMenu_Cache( void ) {
	s_main.bannerModel = trap_R_RegisterModel( MAIN_BANNER_MODEL );
}

sfxHandle_t ErrorMessage_Key(int key)
{
	trap_Cvar_Set( "com_errorMessage", "" );
	UI_MainMenu();
	return (menu_null_sound);
}

/*
===============
Main_MenuDraw
TTimo: this function is common to the main menu and errorMessage menu
===============
*/

static void Main_MenuDraw( void ) {
	refdef_t		refdef;
	refEntity_t		ent;
	vec3_t			origin;
	vec3_t			angles;
	float			adjust;
	char			home[256];
	float			x, y, w, h;
	vec4_t			color = {0.2, 0.2, 1.0, 1};

	// setup the refdef

	memset( &refdef, 0, sizeof( refdef ) );

	refdef.rdflags = RDF_NOWORLDMODEL;

	AxisClear( refdef.viewaxis );

	x = 0;
	y = 0;
	w = 640;
	h = 120;
	UI_AdjustFrom640( &x, &y, &w, &h );
	refdef.x = x;
	refdef.y = y;
	refdef.width = w;
	refdef.height = h;

	adjust = 0; // JDC: Kenneth asked me to stop this 1.0 * sin( (float)uis.realtime / 1000 );
	refdef.fov_x = 60 + adjust;
	refdef.fov_y = 19.6875 + adjust;

	refdef.time = uis.realtime;

	origin[0] = 300;
	origin[1] = 0;
	origin[2] = -32;

	trap_R_ClearScene();

	// add the model

	memset( &ent, 0, sizeof(ent) );

	adjust = 5.0 * sin( (float)uis.realtime / 5000 );
	VectorSet( angles, 0, 180 + adjust, 0 );
	AnglesToAxis( angles, ent.axis );
	ent.hModel = s_main.bannerModel;
	VectorCopy( origin, ent.origin );
	VectorCopy( origin, ent.lightingOrigin );
	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
	VectorCopy( ent.origin, ent.oldorigin );

	trap_R_AddRefEntityToScene( &ent );

	trap_R_RenderScene( &refdef );

	if (strlen(s_errorMessage.errorMessage))
	{
		UI_DrawProportionalString_AutoWrapped( 320, 192, 600, 20, s_errorMessage.errorMessage, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
	}
	else
	{
		// standard menu drawing
		Menu_Draw( &s_main.menu );
	}

		UI_DrawProportionalString( 320, 372, "", UI_CENTER|UI_SMALLFONT, color );
		if(ui_secretcode.integer != 123456){
if(onnextarena.integer == 0){
if(IsGame.integer){
		UI_DrawString( 320, 0, "OpenArenaPlus by ^5Danil_Dm", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 400, "OpenArenaPlus 2018-2022", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 414, "You can create your games through CustomMod", UI_CENTER|UI_SMALLFONT, color );
}
if(!IsGame.integer){
		UI_DrawString( 320, 0, "OALauncher by ^5Danil_Dm", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 400, "OpenArenaPlus 2018-2022", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 414, "You can create your games through CustomMod", UI_CENTER|UI_SMALLFONT, color );
}
		UI_DrawString( 320, 16, "NextEngine v4.0", UI_CENTER|UI_BIGFONT, color );
}
if(onnextarena.integer == 1){
		UI_DrawString( 320, 0, "NextArena by ^5Danil_Dm", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 16, "NextEngine v3.8", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 400, "OpenArenaPlus 2018-2021", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 414, "NextArena by Danil_Dm 2021", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 428, "You can download OpenArenaPlus from 4pda.to", UI_CENTER|UI_SMALLFONT, color );
}
		}
		if(ui_secretcode.integer == 123456){
		if(!rus.integer){
		UI_DrawString( 320, 0, "Danil_Dm Secret", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 400, "My favorite games:Stalker,Gta,Quake,OpenArena.", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 414, "Free fire,Brawl Stars,Roblox-F**ked Games", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 428, "Developers-Danil_Dm,Vovan_Vm", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 444, "ioquake3 is best engine.", UI_CENTER|UI_SMALLFONT, color );
		}
		if(rus.integer){
		UI_DrawString( 320, 0, "Danil_Dm Secret", UI_CENTER|UI_BIGFONT, color );
		UI_DrawString( 320, 400, "Мои любимые игры:Stalker,Gta,Quake,OpenArena.", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 414, "Free fire,Brawl Stars,Roblox-К**ченые Игры", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 428, "Разработчики-Danil_Dm,Vovan_Vm", UI_CENTER|UI_SMALLFONT, color );
		UI_DrawString( 320, 444, "ioquake3 is best engine.", UI_CENTER|UI_SMALLFONT, color );
		}
		}
		UI_DrawString( 0, 450-14, ui_modname.string, UI_SMALLFONT, color);

                //Draw version.
                UI_DrawString( 640-40, 480-14, "^7v4.0", UI_SMALLFONT, color );
                if((int)trap_Cvar_VariableValue("protocol")!=71)
                    UI_DrawString( 0, 480-14, va("^7Protocol: %i",(int)trap_Cvar_VariableValue("protocol")), UI_SMALLFONT, color);
                if((int)trap_Cvar_VariableValue("protocol")==68)
                    UI_DrawString( 0, 480-24, va("^7ioquake3 detected",(int)trap_Cvar_VariableValue("protocol")), UI_SMALLFONT, color);
                if(onandroid.integer == 1){
                    UI_DrawString( 0, 400-14, va("^7Android Edition"), UI_SMALLFONT, color);
				}
                if(onandroid.integer == 0){
                    UI_DrawString( 0, 400-14, va("^7Pc Edition"), UI_SMALLFONT, color);
				}
}


/*
===============
UI_TeamArenaExists
===============
*/
static qboolean UI_TeamArenaExists( void ) {
	int		numdirs;
	char	dirlist[2048];
	char	*dirptr;
  char  *descptr;
	int		i;
	int		dirlen;

	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
	dirptr  = dirlist;
	for( i = 0; i < numdirs; i++ ) {
		dirlen = strlen( dirptr ) + 1;
    descptr = dirptr + dirlen;
		if (Q_stricmp(dirptr, "missionpack") == 0) {
			return qtrue;
		}
    dirptr += dirlen + strlen(descptr) + 1;
	}
	return qfalse;
}


/*
===============
UI_MainMenu

The main menu only comes up when not in a game,
so make sure that the attract loop server is down
and that local cinematics are killed
===============
*/
void UI_MainMenu( void ) {
	int		y;
	int		r;
	qboolean teamArena = qfalse;
	int		style = UI_CENTER | UI_DROPSHADOW;

	trap_Cvar_Set( "ui_coop", 0 );
	trap_Cvar_Set( "sv_killserver", "1" );
        trap_Cvar_SetValue( "handicap", 100 ); //Reset handicap during server change, it must be ser per game

	memset( &s_main, 0 ,sizeof(mainmenu_t) );
	memset( &s_errorMessage, 0 ,sizeof(errorMessage_t) );

	// com_errorMessage would need that too
	MainMenu_Cache();

	trap_Cvar_VariableStringBuffer( "com_errorMessage", s_errorMessage.errorMessage, sizeof(s_errorMessage.errorMessage) );
	if (strlen(s_errorMessage.errorMessage))
	{
		s_errorMessage.menu.draw = Main_MenuDraw;
		s_errorMessage.menu.key = ErrorMessage_Key;
		s_errorMessage.menu.fullscreen = qtrue;
		s_errorMessage.menu.wrapAround = qtrue;
		s_errorMessage.menu.showlogo = qtrue;

		trap_Key_SetCatcher( KEYCATCH_UI );
		uis.menusp = 0;
		UI_PushMenu ( &s_errorMessage.menu );

		return;
	}

	s_main.menu.draw = Main_MenuDraw;
	s_main.menu.fullscreen = qtrue;
	s_main.menu.wrapAround = qtrue;
	s_main.menu.showlogo = qtrue;

	s_main.player.generic.type		= MTYPE_BITMAP;
	s_main.player.generic.flags		= QMF_INACTIVE;
	s_main.player.generic.ownerdraw	= Menu_DrawPlayer;
	s_main.player.generic.x			= 420;
	s_main.player.generic.y			= 0;
	s_main.player.width				= 32*10;
	s_main.player.height				= 56*10;


	y = 134;
if(ui_singleplayer.integer == 1){
	s_main.singleplayer.generic.type		= MTYPE_PTEXT;
	s_main.singleplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.singleplayer.generic.x			= ui_singleplayer_x.integer;
	s_main.singleplayer.generic.y			= ui_singleplayer_y.integer;
	s_main.singleplayer.generic.id			= ID_SINGLEPLAYER;
	s_main.singleplayer.generic.callback	= Main_MenuEvent;
	s_main.singleplayer.string				= ui_singleplayer_text.string;
if(rus.integer){
	s_main.singleplayer.string				= "ОДИНОЧНАЯ ИГРА";
}
	s_main.singleplayer.color				= color_red;
	s_main.singleplayer.style				= style;
}

if(ui_multiplayer.integer == 1){
	y += MAIN_MENU_VERTICAL_SPACING;
	s_main.multiplayer.generic.type			= MTYPE_PTEXT;
	s_main.multiplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.multiplayer.generic.x			= ui_multiplayer_x.integer;
	s_main.multiplayer.generic.y			= ui_multiplayer_y.integer;
	s_main.multiplayer.generic.id			= ID_MULTIPLAYER;
	s_main.multiplayer.generic.callback		= Main_MenuEvent;
	s_main.multiplayer.string				= ui_multiplayer_text.string;
if(rus.integer){
	s_main.multiplayer.string				= "СЕТЕВАЯ ИГРА";
}
	s_main.multiplayer.color				= color_red;
	s_main.multiplayer.style				= style;
}

if(ui_settings.integer == 1){
	y += MAIN_MENU_VERTICAL_SPACING;
	s_main.setup.generic.type				= MTYPE_PTEXT;
	s_main.setup.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.setup.generic.x					= ui_settings_x.integer;
	s_main.setup.generic.y					= 236;
if(IsGame.integer){
	s_main.setup.generic.y					= ui_settings_y.integer;
}
	s_main.setup.generic.id					= ID_SETUP;
	s_main.setup.generic.callback			= Main_MenuEvent;
	s_main.setup.string						= ui_settings_text.string;
if(rus.integer){
	s_main.setup.string						= "НАСТРОЙКИ";
}
	s_main.setup.color						= color_red;
	s_main.setup.style						= style;
}

if(ui_demos.integer == 1){
	y += MAIN_MENU_VERTICAL_SPACING;
	s_main.demos.generic.type				= MTYPE_PTEXT;
	s_main.demos.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.demos.generic.x					= ui_demos_x.integer;
	s_main.demos.generic.y					= ui_demos_y.integer;
	s_main.demos.generic.id					= ID_DEMOS;
	s_main.demos.generic.callback			= Main_MenuEvent;
	s_main.demos.string						= ui_demos_text.string;
if(rus.integer){
	s_main.demos.string						= "ЗАПИСИ";
}
	s_main.demos.color						= color_red;
	s_main.demos.style						= style;
}

if(ui_statistics.integer == 1){
    y += MAIN_MENU_VERTICAL_SPACING;
	s_main.challenges.generic.type			= MTYPE_PTEXT;
	s_main.challenges.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.challenges.generic.x				= ui_statistics_x.integer;
	s_main.challenges.generic.y				= ui_statistics_y.integer;
	s_main.challenges.generic.id			= ID_CHALLENGES;
	s_main.challenges.generic.callback		= Main_MenuEvent;
	s_main.challenges.string				= ui_statistics_text.string;
if(rus.integer){
	s_main.challenges.string						= "СТАТИСТИКА";
}
	s_main.challenges.color					= color_red;
	s_main.challenges.style					= style;
}

if(ui_mods.integer == 1){
	y += MAIN_MENU_VERTICAL_SPACING;
	s_main.mods.generic.type			= MTYPE_PTEXT;
	s_main.mods.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.mods.generic.x				= ui_mods_x.integer;
	s_main.mods.generic.y				= 134;
	if(IsGame.integer){
	s_main.mods.generic.y				= ui_mods_y.integer;
}
	s_main.mods.generic.id				= ID_MODS;
	s_main.mods.generic.callback		= Main_MenuEvent;
	s_main.mods.string					= "Play OpenArenaPlus!";
if(rus.integer){
	s_main.mods.string						= "Играть OpenArenaPlus!";
}
if(IsGame.integer){
	s_main.mods.string					= ui_mods_text.string;
if(rus.integer){
	s_main.mods.string						= "МОДЫ";
}
}
	s_main.mods.color					= color_red;
	s_main.mods.style					= style;
}

if(ui_exit.integer == 1){
	y += MAIN_MENU_VERTICAL_SPACING;
	s_main.exit.generic.type				= MTYPE_PTEXT;
	s_main.exit.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.exit.generic.x					= ui_exit_x.integer;
	s_main.exit.generic.y					= ui_exit_y.integer;
	s_main.exit.generic.id					= ID_EXIT;
	s_main.exit.generic.callback			= Main_MenuEvent;
	s_main.exit.string						= ui_exit_text.string;
if(rus.integer){
	s_main.exit.string						= "ВЫХОД";
}
	s_main.exit.color						= color_red;
	s_main.exit.style						= style;
}

	s_main.sec6.generic.type			= MTYPE_PTEXT;
	s_main.sec6.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec6.generic.x				= 550;
	s_main.sec6.generic.y				= 40;
	s_main.sec6.generic.id				= ID_SECR6;
	s_main.sec6.generic.callback		= Main_MenuEvent;
	s_main.sec6.string					= "Charasters";
if(rus.integer){
	s_main.sec6.string					= "Персонажи";
}
	s_main.sec6.color					= color_yellow;
	s_main.sec6.style					= style;


if(ui_secretcode.integer == 382840){

	s_main.sec1.generic.type			= MTYPE_PTEXT;
	s_main.sec1.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec1.generic.x				= 520;
	s_main.sec1.generic.y				= 300;
	s_main.sec1.generic.id				= ID_SECR1;
	s_main.sec1.generic.callback		= Main_MenuEvent;
	s_main.sec1.string					= "No Head";
if(rus.integer){
	s_main.sec1.string					= "Без головы";
}
	s_main.sec1.color					= color_yellow;
	s_main.sec1.style					= style;

	s_main.sec2.generic.type			= MTYPE_PTEXT;
	s_main.sec2.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec2.generic.x				= 520;
	s_main.sec2.generic.y				= 250;
	s_main.sec2.generic.id				= ID_SECR2;
	s_main.sec2.generic.callback		= Main_MenuEvent;
	s_main.sec2.string					= "Skull";
if(rus.integer){
	s_main.sec2.string					= "Череп";
}
	s_main.sec2.color					= color_yellow;
	s_main.sec2.style					= style;

	s_main.sec3.generic.type			= MTYPE_PTEXT;
	s_main.sec3.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec3.generic.x				= 520;
	s_main.sec3.generic.y				= 200;
	s_main.sec3.generic.id				= ID_SECR3;
	s_main.sec3.generic.callback		= Main_MenuEvent;
	s_main.sec3.string					= "Secret Level";
if(rus.integer){
	s_main.sec3.string					= "Куб";
}
	s_main.sec3.color					= color_yellow;
	s_main.sec3.style					= style;
}

if(ui_secretcode.integer == 947295){

	s_main.sec4.generic.type			= MTYPE_PTEXT;
	s_main.sec4.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec4.generic.x				= 520;
	s_main.sec4.generic.y				= 300;
	s_main.sec4.generic.id				= ID_SECR4;
	s_main.sec4.generic.callback		= Main_MenuEvent;
	s_main.sec4.string					= "Video";
if(rus.integer){
	s_main.sec4.string					= "Видео";
}
	s_main.sec4.color					= color_yellow;
	s_main.sec4.style					= style;

	s_main.sec5.generic.type			= MTYPE_PTEXT;
	s_main.sec5.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_main.sec5.generic.x				= 520;
	s_main.sec5.generic.y				= 250;
	s_main.sec5.generic.id				= ID_SECR5;
	s_main.sec5.generic.callback		= Main_MenuEvent;
	s_main.sec5.string					= "Music";
if(rus.integer){
	s_main.sec5.string					= "Музыка";
}
	s_main.sec5.color					= color_yellow;
	s_main.sec5.style					= style;
}

	s_main.rus.generic.type     	= MTYPE_RADIOBUTTON;
	if(rus.integer){
	s_main.rus.generic.name	   		= "Русский Язык:";
	}
	if(!rus.integer){
	s_main.rus.generic.name	   		= "Russian Language:";
	}
	s_main.rus.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_main.rus.generic.callback 	= Main_MenuEvent;
	s_main.rus.generic.id       	= ID_RUS;
	s_main.rus.generic.x	       	= 150;
	s_main.rus.generic.y	        = 40;

	s_main.rusv.generic.type     	= MTYPE_RADIOBUTTON;
	if(!rus.integer){
	s_main.rusv.generic.name	   	= "All Gamemodes Maps:";
	}
	if(rus.integer){
	s_main.rusv.generic.name	   	= "Все режимы игры на картах:";
	}
	s_main.rusv.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_main.rusv.generic.callback 	= Main_MenuEvent;
	s_main.rusv.generic.id       	= ID_RUSV;
	s_main.rusv.generic.x	       	= 150;
	s_main.rusv.generic.y	        = 65;
if(IsGame.integer){
if(ui_singleplayer.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.singleplayer );
}
if(ui_multiplayer.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.multiplayer );
}
if(ui_demos.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.demos );
}
if(ui_statistics.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.challenges );
}
if(ui_secretcode.integer == 382840){
Menu_AddItem( &s_main.menu,	&s_main.sec1 );
Menu_AddItem( &s_main.menu,	&s_main.sec2 );
Menu_AddItem( &s_main.menu,	&s_main.sec3 );
}
if(ui_secretcode.integer == 947295){
Menu_AddItem( &s_main.menu,	&s_main.sec4 );
Menu_AddItem( &s_main.menu,	&s_main.sec5 );
}
Menu_AddItem( &s_main.menu,	&s_main.sec6 );

Menu_AddItem( &s_main.menu, &s_main.player );
Menu_AddItem( &s_main.menu,	&s_main.rusv );
}
if(ui_settings.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.setup );
}
if(ui_mods.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.mods );
}
if(ui_exit.integer == 1){
Menu_AddItem( &s_main.menu,	&s_main.exit );
}
Menu_AddItem( &s_main.menu,	&s_main.rus );

s_main.rus.curvalue  = trap_Cvar_VariableValue( "rus");
s_main.rusv.curvalue  = trap_Cvar_VariableValue( "ui_gamemodesall");

	trap_Key_SetCatcher( KEYCATCH_UI );
	uis.menusp = 0;
	UI_PushMenu ( &s_main.menu );
	trap_Cvar_Set( "ui_loaded", "0" );
}
