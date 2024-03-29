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
//
// ui_team.c
//

#include "ui_local.h"


#define TEAMMAIN_FRAME	"menu/art_blueish/addbotframe"
#define ART_FX_BASE			"menu/art/fx_base"
#define ART_FX_BLUE			"menu/art/fx_blue"
#define ART_FX_CYAN			"menu/art/fx_cyan"
#define ART_FX_GREEN		"menu/art/fx_grn"
#define ART_FX_RED			"menu/art/fx_red"
#define ART_FX_TEAL			"menu/art/fx_teal"
#define ART_FX_WHITE		"menu/art/fx_white"
#define ART_FX_YELLOW		"menu/art/fx_yel"

#define ID_JOINRED		100
#define ID_JOINBLUE		101
#define ID_JOINGAME		102
#define ID_SPECTATE		103
#define ID_BOTNAME		104
#define ID_BOTNAMA		106
#define ID_BOTOK		105



typedef struct
{
	menuframework_s	menu;
	menubitmap_s	frame;
	menutext_s		joinred;
	menutext_s		joinblue;
	menutext_s		joingame;
	menutext_s		spectate;
	menufield_s		botname;
	menufield_s		botnama;
	menutext_s		botok;
} teammain_t;

static teammain_t	s_teammain;

// bk001204 - unused
//static menuframework_s	s_teammain_menu;
//static menuaction_s		s_teammain_orders;
//static menuaction_s		s_teammain_voice;
//static menuaction_s		s_teammain_joinred;
//static menuaction_s		s_teammain_joinblue;
//static menuaction_s		s_teammain_joingame;
//static menuaction_s		s_teammain_spectate;


/*
===============
TeamMain_MenuEvent
===============
*/
static void TeamMain_MenuEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_JOINRED:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team red\n" );
		UI_ForceMenuOff();
		break;

	case ID_JOINBLUE:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team blue\n" );
		UI_ForceMenuOff();
		break;

	case ID_JOINGAME:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team free\n" );
		UI_ForceMenuOff();
		break;

	case ID_SPECTATE:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd team spectator\n" );
		UI_ForceMenuOff();
		break;

	case ID_BOTOK:
		trap_Cmd_ExecuteText( EXEC_APPEND, s_teammain.botnama.field.buffer );
		break;
	}
}

static void Instruction( void *self ) {


if(!rus.integer){
	UI_DrawProportionalString( 320, 90, "CommandList", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 105, "@-botname-Everyone-allbots", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 120, "#-targetname", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 135, "$-itemname", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 150, "say_team @ Follow Me", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 165, "say_team @ Follow @", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 180, "say_team @ Defend the Base", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 195, "say_team @ Get The Flag", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 210, "say_team @ Camp Here", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 225, "say_team @ Report", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 240, "say_team @ Attack the Enemy Base", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 255, "say_team @ Roam", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 270, "say_team @ Dominate Point A", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 285, "say_team @ Dominate Point B", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 300, "say_team @ Kill #", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 315, "say_team @ Grab the $", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 330, "say_team @ Go to $", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 350, "Press F1 for open ActionMenu", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 365, "Xp status in statistics", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 380, "Config files in CustomMod Folder", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 395, "Activate building for bulding F1", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 410, "Press Enter for place blocks", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 425, "Game Options in Ingame Menu v357", UI_CENTER|UI_SMALLFONT, colorYellow );
}
if(rus.integer){
	UI_DrawProportionalString( 320, 90, "Приказы", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 105, "@-имя бота-Everyone-все боты", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 120, "#-имя цели", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 135, "$-имя предмета", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 150, "иди за мной - say_team @ Follow Me", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 165, "иди за кем-то - say_team @ Follow @", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 180, "охраняй базу - say_team @ Defend the Base", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 195, "принеси флаг - say_team @ Get The Flag", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 210, "сиди здесь - say_team @ Camp Here", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 225, "репорт - say_team @ Report", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 240, "атакуй базу - say_team @ Attack the Enemy Base", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 255, "свободен - say_team @ Roam", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 270, "возьми А - say_team @ Dominate Point A", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 285, "возьми B - say_team @ Dominate Point B", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 300, "убей - say_team @ Kill #", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 315, "возьми - say_team @ Grab the $", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 330, "иди к - say_team @ Go to $", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 350, "Нажмите F1 для открытия ActionMenu", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 365, "Количество опыта смотреть в статистике", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 380, "Файлы конфигурации игры в папке CustomMod", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 395, "Для строительства надо активировать стройку F1", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 410, "Жмите Enter для поставки блоков", UI_CENTER|UI_SMALLFONT, colorYellow );
	UI_DrawProportionalString( 320, 425, "Игровые опции в игровом меню v357", UI_CENTER|UI_SMALLFONT, colorYellow );
}
}

/*
===============
TeamMain_MenuInit
===============
*/
void TeamMain_MenuInit( void ) {
	int		y;
	int		gametype;
	char	info[MAX_INFO_STRING];

	memset( &s_teammain, 0, sizeof(s_teammain) );

	if(onandroid.integer == 1){
	trap_Cvar_Set("r_ambientScale","15");
	trap_Cvar_Set("r_directedScale","15");
	trap_Cvar_Set("cl_run","0");
	}
	trap_Cvar_Set("r_znear","0.1");
	trap_Cvar_Set("ui_loaded","1");
		if ( onandroid.integer ) {
		trap_Cvar_Set("sensitivity","0");
		}
	trap_Cvar_Set( "cg_ch9slze", "0" );

if((int)trap_Cvar_VariableValue("protocol")==68){
	trap_Cvar_Set("r_forceSun","1");
}

	TeamMain_Cache();

	s_teammain.menu.wrapAround = qtrue;
	s_teammain.menu.fullscreen = qfalse;

	s_teammain.frame.generic.type   = MTYPE_BITMAP;
	s_teammain.frame.generic.flags	= QMF_INACTIVE;
	s_teammain.frame.generic.name   = TEAMMAIN_FRAME;
	s_teammain.frame.generic.x		= -10000000;
	s_teammain.frame.generic.y		= -1000;
	s_teammain.frame.width			= 46600000;
	s_teammain.frame.height			= 33200000;

	y = 5;
if(!rus.integer){
	s_teammain.joinred.generic.type     = MTYPE_PTEXT;
	s_teammain.joinred.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joinred.generic.id       = ID_JOINRED;
	s_teammain.joinred.generic.callback = TeamMain_MenuEvent;
	s_teammain.joinred.generic.x        = 320;
	s_teammain.joinred.generic.y        = y;
	s_teammain.joinred.string           = "JOIN RED";
	s_teammain.joinred.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joinred.color            = colorRed;
	y += 20;

	s_teammain.joinblue.generic.type     = MTYPE_PTEXT;
	s_teammain.joinblue.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joinblue.generic.id       = ID_JOINBLUE;
	s_teammain.joinblue.generic.callback = TeamMain_MenuEvent;
	s_teammain.joinblue.generic.x        = 320;
	s_teammain.joinblue.generic.y        = y;
	s_teammain.joinblue.string           = "JOIN BLUE";
	s_teammain.joinblue.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joinblue.color            = colorBlue;
	y += 20;

	s_teammain.joingame.generic.type     = MTYPE_PTEXT;
	s_teammain.joingame.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joingame.generic.id       = ID_JOINGAME;
	s_teammain.joingame.generic.callback = TeamMain_MenuEvent;
	s_teammain.joingame.generic.x        = 320;
	s_teammain.joingame.generic.y        = y;
	s_teammain.joingame.string           = "JOIN GAME";
	s_teammain.joingame.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joingame.color            = colorYellow;
	y += 20;

	s_teammain.spectate.generic.type     = MTYPE_PTEXT;
	s_teammain.spectate.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.spectate.generic.id       = ID_SPECTATE;
	s_teammain.spectate.generic.callback = TeamMain_MenuEvent;
	s_teammain.spectate.generic.x        = 320;
	s_teammain.spectate.generic.y        = y;
	s_teammain.spectate.string           = "SPECTATE";
	s_teammain.spectate.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.spectate.color            = colorGreen;
	y += 30;
}
if(rus.integer){
	s_teammain.joinred.generic.type     = MTYPE_PTEXT;
	s_teammain.joinred.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joinred.generic.id       = ID_JOINRED;
	s_teammain.joinred.generic.callback = TeamMain_MenuEvent;
	s_teammain.joinred.generic.x        = 320;
	s_teammain.joinred.generic.y        = y;
	s_teammain.joinred.string           = "ИГРАТЬ ЗА КРАСНЫХ";
	s_teammain.joinred.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joinred.color            = colorRed;
	y += 20;

	s_teammain.joinblue.generic.type     = MTYPE_PTEXT;
	s_teammain.joinblue.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joinblue.generic.id       = ID_JOINBLUE;
	s_teammain.joinblue.generic.callback = TeamMain_MenuEvent;
	s_teammain.joinblue.generic.x        = 320;
	s_teammain.joinblue.generic.y        = y;
	s_teammain.joinblue.string           = "ИГРАТЬ ЗА СИНИХ";
	s_teammain.joinblue.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joinblue.color            = colorBlue;
	y += 20;

	s_teammain.joingame.generic.type     = MTYPE_PTEXT;
	s_teammain.joingame.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.joingame.generic.id       = ID_JOINGAME;
	s_teammain.joingame.generic.callback = TeamMain_MenuEvent;
	s_teammain.joingame.generic.x        = 320;
	s_teammain.joingame.generic.y        = y;
	s_teammain.joingame.string           = "ВСТУПИТЬ В ИГРУ";
	s_teammain.joingame.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.joingame.color            = colorYellow;
	y += 20;

	s_teammain.spectate.generic.type     = MTYPE_PTEXT;
	s_teammain.spectate.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.spectate.generic.id       = ID_SPECTATE;
	s_teammain.spectate.generic.callback = TeamMain_MenuEvent;
	s_teammain.spectate.generic.x        = 320;
	s_teammain.spectate.generic.y        = y;
	s_teammain.spectate.string           = "СЛЕДИТЬ ЗА ИГРОЙ";
	s_teammain.spectate.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.spectate.color            = colorGreen;
	y += 30;
}
	s_teammain.botname.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	s_teammain.botname.generic.name		= "Command:";
	}
	if(rus.integer){
	s_teammain.botname.generic.name		= "Приказ:";
	}
	s_teammain.botname.generic.ownerdraw		= Instruction;
	s_teammain.botname.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_teammain.botname.generic.x			= 110;
	s_teammain.botname.generic.y			= 450;
	s_teammain.botname.field.widthInChars = 64;
	s_teammain.botname.field.maxchars     = 64;

	s_teammain.botnama.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	s_teammain.botnama.generic.name		= "Command:";
	}
	if(rus.integer){
	s_teammain.botnama.generic.name		= "Приказ:";
	}
	s_teammain.botnama.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_teammain.botnama.generic.x			= 110;
	s_teammain.botnama.generic.y			= 450;
	s_teammain.botnama.field.widthInChars = 64;
	s_teammain.botnama.field.maxchars     = 64;

	s_teammain.botok.generic.type     = MTYPE_PTEXT;
	s_teammain.botok.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_teammain.botok.generic.id       = ID_BOTOK;
	s_teammain.botok.generic.callback = TeamMain_MenuEvent;
	s_teammain.botok.generic.x        = 320;
	s_teammain.botok.generic.y        = 430;
	if(!rus.integer){
	s_teammain.botok.string           = "Send Command";
	}
	if(rus.integer){
	s_teammain.botok.string           = "Отправить Приказ";
	}
	s_teammain.botok.style            = UI_CENTER|UI_SMALLFONT;
	s_teammain.botok.color            = colorGreen;

	trap_GetConfigString(CS_SERVERINFO, info, MAX_INFO_STRING);
	gametype = atoi( Info_ValueForKey( info,"g_gametype" ) );

	// set initial states
	switch( gametype ) {
	case GT_SINGLE_PLAYER:
	case GT_FFA:
	case GT_LMS:
	case GT_TOURNAMENT:
		s_teammain.joinred.generic.flags  |= QMF_GRAYED;
		s_teammain.joinblue.generic.flags |= QMF_GRAYED;
		break;

	default:
	case GT_TEAM:
	case GT_CTF:
	case GT_ELIMINATION:
	case GT_CTF_ELIMINATION:
		//s_teammain.joingame.generic.flags |= QMF_GRAYED;
		if(!rus.integer){
		s_teammain.joingame.string           = "AUTO JOIN GAME";
		}
		if(rus.integer){
		s_teammain.joingame.string           = "АВТО ВХОД В ИГРУ";
		}
		break;
	}

	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.frame );
	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joinred );
	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joinblue );
	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.joingame );
	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.spectate );
	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.botname );
//	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.botnama );
//	Menu_AddItem( &s_teammain.menu, (void*) &s_teammain.botok );

}


/*
===============
TeamMain_Cache
===============
*/
void TeamMain_Cache( void ) {
	trap_R_RegisterShaderNoMip( TEAMMAIN_FRAME );
}


/*
===============
UI_TeamMainMenu
===============
*/
void UI_TeamMainMenu( void ) {
	TeamMain_MenuInit();
	UI_PushMenu ( &s_teammain.menu );
}






//
// ui_actions.c
//

#define ID_DROPAMMO			106
#define ID_DROPHEALTH		107
#define ID_DROPARMOR		108
#define ID_DROPWEAPON		109
#define ID_DROPFLAG			112
#define ID_DROPHOLDABLE		113
#define ID_TAUNT			110
#define ID_TAUNTK			124
#define ID_KILL				111
#define ID_MUSIC			114
#define ID_SOUND			115
#define ID_PLAYER			116
#define ID_MUSICPREV			117
#define ID_MUSICNEXT			118
#define ID_HUDMOV	119
#define ID_BUILDING	120
#define ID_OASBID 	121
#define ID_OASBHEIGHT 	125
#define ID_OASBTOOL 	129
#define ID_OASBMODIFIER 	130
#define ID_OASBMODSAV 	131
#define ID_OASBMEMORY 	132
#define ID_SAVEMAP 	126
#define ID_LOADMAP 	127
#define ID_MINIGAME 128
#define ID_BOFF 	122
#define ID_BON 	123







typedef struct
{
	menuframework_s	menu;
	menubitmap_s	frame;
	menutext_s		dropammo;
	menutext_s		drophealth;
	menutext_s		savemap;
	menutext_s		loadmap;
	menutext_s		droparmor;
	menutext_s		dropweapon;
	menutext_s		dropflag;
	menutext_s		dropholdable;
	menutext_s		taunt;
	menutext_s		tauntk;
	menutext_s		kill;
	menutext_s		music;
	menutext_s		musicnext;
	menutext_s		musicprev;
	menutext_s		sound;
	menutext_s		player;
	menutext_s		oasbmodsav;
	menuslider_s	hudmov;
	menuslider_s	building;
	menuslider_s	oasbid;
	menuslider_s	oasbheight;
	menuslider_s	oasbtool;
	menuslider_s	oasbmemory;
	menufield_s	oasbmodifier;
	menuslider_s	minigame;
	menutext_s	boff;
	menutext_s	bon;

} actmain_t;

static actmain_t	s_actmain;




/*
===============
ActMain_MenuEvent
===============
*/
static void ActMain_MenuEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_DROPAMMO:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd ammo\n" );
//		UI_ForceMenuOff();
		break;

	case ID_DROPHEALTH:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd health\n" );
//		UI_ForceMenuOff();
		break;

	case ID_SAVEMAP:
		UI_saveMapEdMenu();
//		UI_ForceMenuOff();
		break;

	case ID_LOADMAP:
		UI_loadMapEdMenu();
//		UI_ForceMenuOff();
		break;

	case ID_DROPARMOR:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd armor\n" );
//		UI_ForceMenuOff();
		break;
	case ID_DROPWEAPON:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd dropweapon\n" );
//		UI_ForceMenuOff();
		break;
	case ID_DROPFLAG:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd dropflag\n" );
//		UI_ForceMenuOff();
		break;
	case ID_DROPHOLDABLE:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd dropholdable\n" );
//		UI_ForceMenuOff();
		break;
	case ID_TAUNT:
		trap_Cmd_ExecuteText( EXEC_APPEND, "vstr taunt\n" );
		UI_ForceMenuOff();
		break;
	case ID_TAUNTK:
		UI_selecttoolEdMenu();
		break;
	case ID_KILL:
		trap_Cmd_ExecuteText( EXEC_APPEND, "cmd kill\n" );
		UI_ForceMenuOff();
		break;
	case ID_MUSIC:
		UI_LoadConfigMenu();
//		UI_ForceMenuOff();
		break;
	case ID_MUSICNEXT:
		trap_Cmd_ExecuteText( EXEC_APPEND, "setup1 oasb_modifiers\n" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "setup1 oasb_modifier\n" );
//		UI_ForceMenuOff();
		break;
	case ID_MUSICPREV:
		trap_Cmd_ExecuteText( EXEC_APPEND, "setdown1 oasb_modifiers\n" );
		trap_Cmd_ExecuteText( EXEC_APPEND, "setdown1 oasb_modifier\n" );
//		UI_ForceMenuOff();
		break;
	case ID_SOUND:
		UI_SoundOptionsMenu();
//		UI_ForceMenuOff();
		break;
	case ID_PLAYER:
		trap_Cvar_Set( "ui_actionmenu", "1");
		UI_PlayerSettingsMenu();
		UI_SPPlayerxp();
		break;
	case ID_HUDMOV:
		trap_Cvar_SetValue( "cg_hudcord", s_actmain.hudmov.curvalue);
		break;
	case ID_BUILDING:
		trap_Cvar_SetValue( "g_building", s_actmain.building.curvalue);
		break;
	case ID_OASBID:
		trap_Cvar_SetValue( "oasb_idi", s_actmain.oasbid.curvalue);
		break;
	case ID_OASBHEIGHT:
		trap_Cvar_SetValue( "oasb_height", s_actmain.oasbheight.curvalue);
		break;
	case ID_OASBTOOL:
			trap_Cvar_SetValue( "oasb_tool", s_actmain.oasbtool.curvalue);
			trap_Cmd_ExecuteText( EXEC_APPEND, "OpenActions\n" );
			break;
	case ID_OASBMEMORY:
			trap_Cvar_SetValue( "oasb_modifiersel", s_actmain.oasbmemory.curvalue);
			trap_Cmd_ExecuteText( EXEC_APPEND, "OpenActions\n" );
			break;
	case ID_OASBMODSAV:
				trap_Cvar_Set( "oasb_modifier", s_actmain.oasbmodifier.field.buffer);
				trap_Cvar_Set( "oasb_modifiers", s_actmain.oasbmodifier.field.buffer);
if(trap_Cvar_VariableValue("oasb_tool")==69){
		trap_Cmd_ExecuteText( EXEC_APPEND, "noclip\n" );
}
if(trap_Cvar_VariableValue("oasb_idi")!=-1){
		trap_Cmd_ExecuteText( EXEC_APPEND,  va( "set oasbtool%s %s\n", s_actmain.oasbid.curvalue, s_actmain.oasbtool.curvalue ) );
}
	break;
	case ID_MINIGAME:
		trap_Cvar_SetValue( "g_minigame", s_actmain.minigame.curvalue);
		break;
	case ID_BON:
	if(onandroid.integer == 0){
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind enter block\n" );
	}
	if(onandroid.integer == 1){
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f4 block\n" );
	}
		break;
	case ID_BOFF:
	if(onandroid.integer == 0){
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind enter +button2\n" );
	}
	if(onandroid.integer == 1){
		trap_Cmd_ExecuteText( EXEC_APPEND, "bind f4 exec f9\n" );
	}
		break;

	}
}

/*
===============
ActMain_MenuInit
===============
*/
void ActMain_MenuInit( void ) {
	int		y;
	int		gametype;
	char	info[MAX_INFO_STRING];
	vec4_t			color = {0.2, 0.2, 1.0, 1};

	memset( &s_actmain, 0, sizeof(s_actmain) );

	if(onandroid.integer == 1){
	trap_Cvar_Set("r_ambientScale","15");
	trap_Cvar_Set("r_directedScale","15");
	trap_Cvar_Set("cl_run","0");
	}
	trap_Cvar_Set("r_znear","0.1");
	trap_Cvar_Set("ui_loaded","1");
		if ( onandroid.integer ) {
		trap_Cvar_Set("sensitivity","0");
		}
	trap_Cvar_Set( "cg_ch9slze", "0" );

if((int)trap_Cvar_VariableValue("protocol")==68){
	trap_Cvar_Set("r_forceSun","1");
}


	ActMain_Cache();

	s_actmain.menu.wrapAround = qtrue;
	s_actmain.menu.fullscreen = qfalse;

	s_actmain.frame.generic.type   = MTYPE_BITMAP;
	s_actmain.frame.generic.flags	= QMF_INACTIVE;
	s_actmain.frame.generic.name   = TEAMMAIN_FRAME;
	s_actmain.frame.generic.x		= -10000000;
	s_actmain.frame.generic.y		= -1000;
	s_actmain.frame.width			= 46600000;
	s_actmain.frame.height			= 33200000;

	y = 5;
if(!rus.integer){
	s_actmain.dropammo.generic.type     = MTYPE_PTEXT;
	s_actmain.dropammo.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropammo.generic.id       = ID_DROPAMMO;
	s_actmain.dropammo.generic.callback = ActMain_MenuEvent;
	s_actmain.dropammo.generic.x        = 120;
	s_actmain.dropammo.generic.y        = y;
	s_actmain.dropammo.string           = "Drop Ammo";
	s_actmain.dropammo.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropammo.color            = colorYellow;
	y += 20;

	s_actmain.drophealth.generic.type     = MTYPE_PTEXT;
	s_actmain.drophealth.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.drophealth.generic.id       = ID_DROPHEALTH;
	s_actmain.drophealth.generic.callback = ActMain_MenuEvent;
	s_actmain.drophealth.generic.x        = 120;
	s_actmain.drophealth.generic.y        = y;
	s_actmain.drophealth.string           = "Drop Health";
	s_actmain.drophealth.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.drophealth.color            = colorYellow;
	y += 20;

	s_actmain.droparmor.generic.type     = MTYPE_PTEXT;
	s_actmain.droparmor.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.droparmor.generic.id       = ID_DROPARMOR;
	s_actmain.droparmor.generic.callback = ActMain_MenuEvent;
	s_actmain.droparmor.generic.x        = 120;
	s_actmain.droparmor.generic.y        = y;
	s_actmain.droparmor.string           = "Drop Armor";
	s_actmain.droparmor.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.droparmor.color            = colorYellow;
	y += 20;

	s_actmain.dropweapon.generic.type     = MTYPE_PTEXT;
	s_actmain.dropweapon.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropweapon.generic.id       = ID_DROPWEAPON;
	s_actmain.dropweapon.generic.callback = ActMain_MenuEvent;
	s_actmain.dropweapon.generic.x        = 120;
	s_actmain.dropweapon.generic.y        = y;
	s_actmain.dropweapon.string           = "Drop Weapon";
	s_actmain.dropweapon.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropweapon.color            = colorYellow;
	y += 20;

	s_actmain.dropflag.generic.type     = MTYPE_PTEXT;
	s_actmain.dropflag.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropflag.generic.id       = ID_DROPFLAG;
	s_actmain.dropflag.generic.callback = ActMain_MenuEvent;
	s_actmain.dropflag.generic.x        = 120;
	s_actmain.dropflag.generic.y        = y;
	s_actmain.dropflag.string           = "Drop Flag";
	s_actmain.dropflag.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropflag.color            = colorYellow;
	y += 20;

	s_actmain.dropholdable.generic.type     = MTYPE_PTEXT;
	s_actmain.dropholdable.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropholdable.generic.id       = ID_DROPHOLDABLE;
	s_actmain.dropholdable.generic.callback = ActMain_MenuEvent;
	s_actmain.dropholdable.generic.x        = 120;
	s_actmain.dropholdable.generic.y        = y;
	s_actmain.dropholdable.string           = "Drop Holdable";
	s_actmain.dropholdable.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropholdable.color            = colorYellow;
	y = 80;

	s_actmain.taunt.generic.type     = MTYPE_PTEXT;
	s_actmain.taunt.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.taunt.generic.id       = ID_TAUNT;
	s_actmain.taunt.generic.callback = ActMain_MenuEvent;
	s_actmain.taunt.generic.x        = 300;
	s_actmain.taunt.generic.y        = y;
	s_actmain.taunt.string           = "Taunt";
	s_actmain.taunt.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.taunt.color            = colorRed;
	y += 25;

	s_actmain.tauntk.generic.type     = MTYPE_PTEXT;
	s_actmain.tauntk.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.tauntk.generic.id       = ID_TAUNTK;
	s_actmain.tauntk.generic.callback = ActMain_MenuEvent;
	s_actmain.tauntk.generic.x        = 300;
	s_actmain.tauntk.generic.y        = y;
	s_actmain.tauntk.string           = "Tools";
	s_actmain.tauntk.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.tauntk.color            = colorRed;
	y += 25;

	s_actmain.kill.generic.type     = MTYPE_PTEXT;
	s_actmain.kill.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.kill.generic.id       = ID_KILL;
	s_actmain.kill.generic.callback = ActMain_MenuEvent;
	s_actmain.kill.generic.x        = 300;
	s_actmain.kill.generic.y        = y;
	s_actmain.kill.string           = "Suicide";
	s_actmain.kill.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.kill.color            = colorRed;
	y += 25;

	s_actmain.music.generic.type     = MTYPE_PTEXT;
	s_actmain.music.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.music.generic.id       = ID_MUSIC;
	s_actmain.music.generic.callback = ActMain_MenuEvent;
	s_actmain.music.generic.x        = 300;
	s_actmain.music.generic.y        = y;
	s_actmain.music.string           = "Music Player";
	s_actmain.music.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.music.color            = colorRed;
//	y += 50;

	s_actmain.musicnext.generic.type     = MTYPE_PTEXT;
	s_actmain.musicnext.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.musicnext.generic.id       = ID_MUSICNEXT;
	s_actmain.musicnext.generic.callback = ActMain_MenuEvent;
	s_actmain.musicnext.generic.x        = 550;
	s_actmain.musicnext.generic.y        = y;
	s_actmain.musicnext.string           = "->";
	s_actmain.musicnext.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.musicnext.color            = colorRed;
//	y += 50;

	s_actmain.musicprev.generic.type     = MTYPE_PTEXT;
	s_actmain.musicprev.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.musicprev.generic.id       = ID_MUSICPREV;
	s_actmain.musicprev.generic.callback = ActMain_MenuEvent;
	s_actmain.musicprev.generic.x        = 50;
	s_actmain.musicprev.generic.y        = y;
	s_actmain.musicprev.string           = "<-";
	s_actmain.musicprev.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.musicprev.color            = colorRed;
	y += 25;

	s_actmain.sound.generic.type     = MTYPE_PTEXT;
	s_actmain.sound.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.sound.generic.id       = ID_SOUND;
	s_actmain.sound.generic.callback = ActMain_MenuEvent;
	s_actmain.sound.generic.x        = 300;
	s_actmain.sound.generic.y        = y;
	s_actmain.sound.string           = "Sound Volume";
	s_actmain.sound.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.sound.color            = colorRed;
	y += 25;

	s_actmain.player.generic.type     = MTYPE_PTEXT;
	s_actmain.player.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.player.generic.id       = ID_PLAYER;
	s_actmain.player.generic.callback = ActMain_MenuEvent;
	s_actmain.player.generic.x        = 300;
	s_actmain.player.generic.y        = y;
	s_actmain.player.string           = "Player Setting";
	s_actmain.player.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.player.color            = colorRed;
	y += 25;
}
if(rus.integer){
	s_actmain.dropammo.generic.type     = MTYPE_PTEXT;
	s_actmain.dropammo.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropammo.generic.id       = ID_DROPAMMO;
	s_actmain.dropammo.generic.callback = ActMain_MenuEvent;
	s_actmain.dropammo.generic.x        = 120;
	s_actmain.dropammo.generic.y        = y;
	s_actmain.dropammo.string           = "Кинуть Патроны";
	s_actmain.dropammo.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropammo.color            = colorYellow;
	y += 20;

	s_actmain.drophealth.generic.type     = MTYPE_PTEXT;
	s_actmain.drophealth.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.drophealth.generic.id       = ID_DROPHEALTH;
	s_actmain.drophealth.generic.callback = ActMain_MenuEvent;
	s_actmain.drophealth.generic.x        = 120;
	s_actmain.drophealth.generic.y        = y;
	s_actmain.drophealth.string           = "Кинуть Жизни";
	s_actmain.drophealth.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.drophealth.color            = colorYellow;
	y += 20;

	s_actmain.droparmor.generic.type     = MTYPE_PTEXT;
	s_actmain.droparmor.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.droparmor.generic.id       = ID_DROPARMOR;
	s_actmain.droparmor.generic.callback = ActMain_MenuEvent;
	s_actmain.droparmor.generic.x        = 120;
	s_actmain.droparmor.generic.y        = y;
	s_actmain.droparmor.string           = "Кинуть Броню";
	s_actmain.droparmor.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.droparmor.color            = colorYellow;
	y += 20;

	s_actmain.dropweapon.generic.type     = MTYPE_PTEXT;
	s_actmain.dropweapon.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropweapon.generic.id       = ID_DROPWEAPON;
	s_actmain.dropweapon.generic.callback = ActMain_MenuEvent;
	s_actmain.dropweapon.generic.x        = 120;
	s_actmain.dropweapon.generic.y        = y;
	s_actmain.dropweapon.string           = "Кинуть Оружие";
	s_actmain.dropweapon.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropweapon.color            = colorYellow;
	y += 20;

	s_actmain.dropflag.generic.type     = MTYPE_PTEXT;
	s_actmain.dropflag.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropflag.generic.id       = ID_DROPFLAG;
	s_actmain.dropflag.generic.callback = ActMain_MenuEvent;
	s_actmain.dropflag.generic.x        = 120;
	s_actmain.dropflag.generic.y        = y;
	s_actmain.dropflag.string           = "Кинуть флаг";
	s_actmain.dropflag.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropflag.color            = colorYellow;
	y += 20;

	s_actmain.dropholdable.generic.type     = MTYPE_PTEXT;
	s_actmain.dropholdable.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.dropholdable.generic.id       = ID_DROPHOLDABLE;
	s_actmain.dropholdable.generic.callback = ActMain_MenuEvent;
	s_actmain.dropholdable.generic.x        = 120;
	s_actmain.dropholdable.generic.y        = y;
	s_actmain.dropholdable.string           = "Кинуть предмет";
	s_actmain.dropholdable.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.dropholdable.color            = colorYellow;
	y = 80;

	s_actmain.taunt.generic.type     = MTYPE_PTEXT;
	s_actmain.taunt.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.taunt.generic.id       = ID_TAUNT;
	s_actmain.taunt.generic.callback = ActMain_MenuEvent;
	s_actmain.taunt.generic.x        = 320;
	s_actmain.taunt.generic.y        = y;
	s_actmain.taunt.string           = "Жест";
	s_actmain.taunt.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.taunt.color            = colorRed;
	y += 25;

	s_actmain.tauntk.generic.type     = MTYPE_PTEXT;
	s_actmain.tauntk.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.tauntk.generic.id       = ID_TAUNTK;
	s_actmain.tauntk.generic.callback = ActMain_MenuEvent;
	s_actmain.tauntk.generic.x        = 300;
	s_actmain.tauntk.generic.y        = y;
	s_actmain.tauntk.string           = "Инструменты";
	s_actmain.tauntk.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.tauntk.color            = colorRed;
	y += 25;

	s_actmain.kill.generic.type     = MTYPE_PTEXT;
	s_actmain.kill.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.kill.generic.id       = ID_KILL;
	s_actmain.kill.generic.callback = ActMain_MenuEvent;
	s_actmain.kill.generic.x        = 320;
	s_actmain.kill.generic.y        = y;
	s_actmain.kill.string           = "Самоубийство";
	s_actmain.kill.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.kill.color            = colorRed;
	y += 25;

	s_actmain.music.generic.type     = MTYPE_PTEXT;
	s_actmain.music.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.music.generic.id       = ID_MUSIC;
	s_actmain.music.generic.callback = ActMain_MenuEvent;
	s_actmain.music.generic.x        = 300;
	s_actmain.music.generic.y        = y;
	s_actmain.music.string           = "Музыкальный плеер";
	s_actmain.music.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.music.color            = colorRed;
//	y += 50;

	s_actmain.musicnext.generic.type     = MTYPE_PTEXT;
	s_actmain.musicnext.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.musicnext.generic.id       = ID_MUSICNEXT;
	s_actmain.musicnext.generic.callback = ActMain_MenuEvent;
	s_actmain.musicnext.generic.x        = 550;
	s_actmain.musicnext.generic.y        = y;
	s_actmain.musicnext.string           = "->";
	s_actmain.musicnext.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.musicnext.color            = colorRed;
//	y += 50;

	s_actmain.musicprev.generic.type     = MTYPE_PTEXT;
	s_actmain.musicprev.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.musicprev.generic.id       = ID_MUSICPREV;
	s_actmain.musicprev.generic.callback = ActMain_MenuEvent;
	s_actmain.musicprev.generic.x        = 50;
	s_actmain.musicprev.generic.y        = y;
	s_actmain.musicprev.string           = "<-";
	s_actmain.musicprev.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.musicprev.color            = colorRed;
	y += 25;

	s_actmain.sound.generic.type     = MTYPE_PTEXT;
	s_actmain.sound.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.sound.generic.id       = ID_SOUND;
	s_actmain.sound.generic.callback = ActMain_MenuEvent;
	s_actmain.sound.generic.x        = 300;
	s_actmain.sound.generic.y        = y;
	s_actmain.sound.string           = "Громкость звука";
	s_actmain.sound.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.sound.color            = colorRed;
	y += 25;

	s_actmain.player.generic.type     = MTYPE_PTEXT;
	s_actmain.player.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.player.generic.id       = ID_PLAYER;
	s_actmain.player.generic.callback = ActMain_MenuEvent;
	s_actmain.player.generic.x        = 300;
	s_actmain.player.generic.y        = y;
	s_actmain.player.string           = "Настройка игрока";
	s_actmain.player.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.player.color            = colorRed;
	y += 25;
}
	s_actmain.bon.generic.type     = MTYPE_PTEXT;
	s_actmain.bon.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.bon.generic.id       = ID_BON;
	s_actmain.bon.generic.callback = ActMain_MenuEvent;
	s_actmain.bon.generic.x        = 300;
	s_actmain.bon.generic.y        = y;
	if(!rus.integer){
	s_actmain.bon.string           = "Activate Building";
	}
	if(rus.integer){
	s_actmain.bon.string           = "Включить Стройку";
	}
	s_actmain.bon.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.bon.color            = colorRed;
	y += 25;

	s_actmain.boff.generic.type     = MTYPE_PTEXT;
	s_actmain.boff.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.boff.generic.id       = ID_BOFF;
	s_actmain.boff.generic.callback = ActMain_MenuEvent;
	s_actmain.boff.generic.x        = 300;
	s_actmain.boff.generic.y        = y;
	if(!rus.integer){
	s_actmain.boff.string           = "Disable Building";
	}
	if(rus.integer){
	s_actmain.boff.string           = "Отключить Стройку";
	}
	s_actmain.boff.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.boff.color            = colorRed;
	y += 25;

	s_actmain.hudmov.generic.type			= MTYPE_SLIDER;
	s_actmain.hudmov.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_actmain.hudmov.generic.callback		= ActMain_MenuEvent;
	s_actmain.hudmov.generic.id			= ID_HUDMOV;
	if(!rus.integer){
	s_actmain.hudmov.generic.name		= "Hud Move:";
	}
	if(rus.integer){
	s_actmain.hudmov.generic.name	= "Передвижение Hud:";
	}
	s_actmain.hudmov.generic.x			= 320;
	s_actmain.hudmov.generic.y			= y;
	s_actmain.hudmov.minvalue			= 0;
    s_actmain.hudmov.maxvalue			= 1000;
	y += 25;

	s_actmain.building.generic.type			= MTYPE_SLIDER;
	s_actmain.building.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_actmain.building.generic.callback		= ActMain_MenuEvent;
	s_actmain.building.generic.id			= ID_BUILDING;
	if(!rus.integer){
	s_actmain.building.generic.name		= "Sandbox 0-no 1-simple 2-sandbox rp:";
	}
	if(rus.integer){
	s_actmain.building.generic.name		= "Sandbox 0-no 1-simple 2-sandbox rp:";
	}
	s_actmain.building.generic.x			= 320;
	s_actmain.building.generic.y			= y;
	s_actmain.building.minvalue			= 0;
    s_actmain.building.maxvalue			= 2;

	y += 25;

	s_actmain.oasbid.generic.type			= MTYPE_SLIDER;
	s_actmain.oasbid.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_actmain.oasbid.generic.callback		= ActMain_MenuEvent;
	s_actmain.oasbid.generic.id			= ID_OASBID;
	if(!rus.integer){
	s_actmain.oasbid.generic.name		= "Button Number:";
	}
	if(rus.integer){
	s_actmain.oasbid.generic.name		= "Номер Кнопки:";
	}
	s_actmain.oasbid.generic.x			= 320;
	s_actmain.oasbid.generic.y			= y;
	s_actmain.oasbid.minvalue			= -1;
    s_actmain.oasbid.maxvalue			= 9;

	y += 18;

	s_actmain.oasbheight.generic.type			= MTYPE_SLIDER;
	s_actmain.oasbheight.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_actmain.oasbheight.generic.callback		= ActMain_MenuEvent;
	s_actmain.oasbheight.generic.id			= ID_OASBHEIGHT;
	if(!rus.integer){
	s_actmain.oasbheight.generic.name		= "Block Height:";
	}
	if(rus.integer){
	s_actmain.oasbheight.generic.name		= "Высота Блока:";
	}
	s_actmain.oasbheight.generic.x			= 320;
	s_actmain.oasbheight.generic.y			= y;
	s_actmain.oasbheight.minvalue			= 0;
    s_actmain.oasbheight.maxvalue			= 100;

		y += 18;

		s_actmain.oasbtool.generic.type			= MTYPE_SLIDER;
		s_actmain.oasbtool.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_actmain.oasbtool.generic.callback		= ActMain_MenuEvent;
		s_actmain.oasbtool.generic.id			= ID_OASBTOOL;
if(trap_Cvar_VariableValue("oasb_tool")==0){
		s_actmain.oasbtool.generic.name		= "Build Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==1){
		s_actmain.oasbtool.generic.name		= "Delete Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==2){
		s_actmain.oasbtool.generic.name		= "Gravity Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==3){
		s_actmain.oasbtool.generic.name		= "Freeze Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==4){
		s_actmain.oasbtool.generic.name		= "Linear Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==5){
		s_actmain.oasbtool.generic.name		= "Wait Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==6){
		s_actmain.oasbtool.generic.name		= "Model Tool (1 to 500+):";
}
if(trap_Cvar_VariableValue("oasb_tool")==7){
		s_actmain.oasbtool.generic.name		= "Spawnflags Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==8){
		s_actmain.oasbtool.generic.name		= "Speed Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==9){
		s_actmain.oasbtool.generic.name		= "Count Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==10){
		s_actmain.oasbtool.generic.name		= "Health Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==11){
		s_actmain.oasbtool.generic.name		= "Damage Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==12){
		s_actmain.oasbtool.generic.name		= "Target Tool (1 to 100):";
}
if(trap_Cvar_VariableValue("oasb_tool")==13){
		s_actmain.oasbtool.generic.name		= "Targetname Tool (1 to 100):";
}
if(trap_Cvar_VariableValue("oasb_tool")==14){
		s_actmain.oasbtool.generic.name		= "Door Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==15){
		s_actmain.oasbtool.generic.name		= "Button Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==16){
		s_actmain.oasbtool.generic.name		= "Pendulum Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==17){
		s_actmain.oasbtool.generic.name		= "Bobbing Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==18){
		s_actmain.oasbtool.generic.name		= "Rotating Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==19){
		s_actmain.oasbtool.generic.name		= "Static Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==20){
		s_actmain.oasbtool.generic.name		= "Plat Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==21){
		s_actmain.oasbtool.generic.name		= "Height Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==22){
		s_actmain.oasbtool.generic.name		= "Random Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==23){
		s_actmain.oasbtool.generic.name		= "Set Speed Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==24){
		s_actmain.oasbtool.generic.name		= "Bounce Reset Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==25){
		s_actmain.oasbtool.generic.name		= "Half Bounce Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==26){
		s_actmain.oasbtool.generic.name		= "Full Bounce Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==27){
		s_actmain.oasbtool.generic.name		= "Rocket Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==28){
		s_actmain.oasbtool.generic.name		= "Grenade Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==29){
		s_actmain.oasbtool.generic.name		= "Plasma Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==30){
		s_actmain.oasbtool.generic.name		= "Remove Powerups Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==31){
		s_actmain.oasbtool.generic.name		= "Score Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==32){
		s_actmain.oasbtool.generic.name		= "Sound Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==33){
		s_actmain.oasbtool.generic.name		= "Music Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==34){
		s_actmain.oasbtool.generic.name		= "Cmd Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==35){
		s_actmain.oasbtool.generic.name		= "Model Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==36){
		s_actmain.oasbtool.generic.name		= "Legs Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==37){
		s_actmain.oasbtool.generic.name		= "Head Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==38){
		s_actmain.oasbtool.generic.name		= "Teleporter Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==39){
		s_actmain.oasbtool.generic.name		= "Kill Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==40){
		s_actmain.oasbtool.generic.name		= "Push Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==41){
		s_actmain.oasbtool.generic.name		= "Give Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==42){
		s_actmain.oasbtool.generic.name		= "Print Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==43){
		s_actmain.oasbtool.generic.name		= "Teleporter Dest Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==44){
		s_actmain.oasbtool.generic.name		= "FFA Spawn Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==45){
		s_actmain.oasbtool.generic.name		= "Red Spawn Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==46){
		s_actmain.oasbtool.generic.name		= "Blue Spawn Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==47){
		s_actmain.oasbtool.generic.name		= "Red Base Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==48){
		s_actmain.oasbtool.generic.name		= "Blue Base Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==49){
		s_actmain.oasbtool.generic.name		= "Neutral Base Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==50){
		s_actmain.oasbtool.generic.name		= "Domination Point Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==51){
		s_actmain.oasbtool.generic.name		= "Message Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==52){
		s_actmain.oasbtool.generic.name		= "Create Collision Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==53){
		s_actmain.oasbtool.generic.name		= "Delete Collision Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==54){
		s_actmain.oasbtool.generic.name		= "Respawn Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==55){
		s_actmain.oasbtool.generic.name		= "Move X Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==56){
		s_actmain.oasbtool.generic.name		= "Move Y Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==57){
		s_actmain.oasbtool.generic.name		= "Move Z Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==58){
		s_actmain.oasbtool.generic.name		= "Replace Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==59){
		s_actmain.oasbtool.generic.name		= "Get Classname Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==60){
		s_actmain.oasbtool.generic.name		= "Get Target Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==61){
		s_actmain.oasbtool.generic.name		= "Get Targetname Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==62){
		s_actmain.oasbtool.generic.name		= "Position Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==63){
		s_actmain.oasbtool.generic.name		= "T Multiple Tool (1 to 9):";
}
if(trap_Cvar_VariableValue("oasb_tool")==64){
		s_actmain.oasbtool.generic.name		= "T Push Tool (1 to 9):";
}
if(trap_Cvar_VariableValue("oasb_tool")==65){
		s_actmain.oasbtool.generic.name		= "T Teleport Tool (1 to 9):";
}
if(trap_Cvar_VariableValue("oasb_tool")==66){
		s_actmain.oasbtool.generic.name		= "T Hurt Tool (1 to 9):";
}
if(trap_Cvar_VariableValue("oasb_tool")==67){
		s_actmain.oasbtool.generic.name		= "Size Collision Tool(1 to 11):";
}
if(trap_Cvar_VariableValue("oasb_tool")==68){
		s_actmain.oasbtool.generic.name		= "Targetname Tool Player (1 to 100):";
}
if(trap_Cvar_VariableValue("oasb_tool")==69){
		s_actmain.oasbtool.generic.name		= "Noclip Tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==70){
		s_actmain.oasbtool.generic.name		= "Material Tool (1 to 169):";
}
if(trap_Cvar_VariableValue("oasb_tool")==71){
		s_actmain.oasbtool.generic.name		= "Armor Shard:";
}
if(trap_Cvar_VariableValue("oasb_tool")==72){
		s_actmain.oasbtool.generic.name		= "Armor:";
}
if(trap_Cvar_VariableValue("oasb_tool")==73){
		s_actmain.oasbtool.generic.name		= "Heavy Armor:";
}
if(trap_Cvar_VariableValue("oasb_tool")==74){
		s_actmain.oasbtool.generic.name		= "5 Health:";
}
if(trap_Cvar_VariableValue("oasb_tool")==75){
		s_actmain.oasbtool.generic.name		= "25 Health:";
}
if(trap_Cvar_VariableValue("oasb_tool")==76){
		s_actmain.oasbtool.generic.name		= "50 Health:";
}
if(trap_Cvar_VariableValue("oasb_tool")==77){
		s_actmain.oasbtool.generic.name		= "Mega Health:";
}
if(trap_Cvar_VariableValue("oasb_tool")==78){
		s_actmain.oasbtool.generic.name		= "Shotgun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==79){
		s_actmain.oasbtool.generic.name		= "Machinegun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==80){
		s_actmain.oasbtool.generic.name		= "Grenade Launcher:";
}
if(trap_Cvar_VariableValue("oasb_tool")==81){
		s_actmain.oasbtool.generic.name		= "Rocket Launcher:";
}
if(trap_Cvar_VariableValue("oasb_tool")==82){
		s_actmain.oasbtool.generic.name		= "Lightning Gun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==83){
		s_actmain.oasbtool.generic.name		= "Railgun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==84){
		s_actmain.oasbtool.generic.name		= "Plasma Gun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==85){
		s_actmain.oasbtool.generic.name		= "BFG10K:";
}
if(trap_Cvar_VariableValue("oasb_tool")==86){
		s_actmain.oasbtool.generic.name		= "Grappling Hook:";
}
if(trap_Cvar_VariableValue("oasb_tool")==87){
		s_actmain.oasbtool.generic.name		= "Shells:";
}
if(trap_Cvar_VariableValue("oasb_tool")==88){
		s_actmain.oasbtool.generic.name		= "Bullets:";
}
if(trap_Cvar_VariableValue("oasb_tool")==89){
		s_actmain.oasbtool.generic.name		= "Grenades:";
}
if(trap_Cvar_VariableValue("oasb_tool")==90){
		s_actmain.oasbtool.generic.name		= "Cells:";
}
if(trap_Cvar_VariableValue("oasb_tool")==91){
		s_actmain.oasbtool.generic.name		= "Lightning:";
}
if(trap_Cvar_VariableValue("oasb_tool")==92){
		s_actmain.oasbtool.generic.name		= "Rockets:";
}
if(trap_Cvar_VariableValue("oasb_tool")==93){
		s_actmain.oasbtool.generic.name		= "Slugs:";
}
if(trap_Cvar_VariableValue("oasb_tool")==94){
		s_actmain.oasbtool.generic.name		= "Bfg Ammo:";
}
if(trap_Cvar_VariableValue("oasb_tool")==95){
		s_actmain.oasbtool.generic.name		= "Personal Teleporter:";
}
if(trap_Cvar_VariableValue("oasb_tool")==96){
		s_actmain.oasbtool.generic.name		= "Medkit:";
}
if(trap_Cvar_VariableValue("oasb_tool")==97){
		s_actmain.oasbtool.generic.name		= "Quad Damage:";
}
if(trap_Cvar_VariableValue("oasb_tool")==98){
		s_actmain.oasbtool.generic.name		= "Battle Suit:";
}
if(trap_Cvar_VariableValue("oasb_tool")==99){
		s_actmain.oasbtool.generic.name		= "Speed:";
}
if(trap_Cvar_VariableValue("oasb_tool")==100){
		s_actmain.oasbtool.generic.name		= "Invisibility:";
}
if(trap_Cvar_VariableValue("oasb_tool")==101){
		s_actmain.oasbtool.generic.name		= "Regeneration:";
}
if(trap_Cvar_VariableValue("oasb_tool")==102){
		s_actmain.oasbtool.generic.name		= "Flight:";
}
if(trap_Cvar_VariableValue("oasb_tool")==103){
		s_actmain.oasbtool.generic.name		= "Red Flag:";
}
if(trap_Cvar_VariableValue("oasb_tool")==104){
		s_actmain.oasbtool.generic.name		= "Blue Flag:";
}
if(trap_Cvar_VariableValue("oasb_tool")==105){
		s_actmain.oasbtool.generic.name		= "Kamikaze:";
}
if(trap_Cvar_VariableValue("oasb_tool")==106){
		s_actmain.oasbtool.generic.name		= "Portal:";
}
if(trap_Cvar_VariableValue("oasb_tool")==107){
		s_actmain.oasbtool.generic.name		= "Invulnerability:";
}
if(trap_Cvar_VariableValue("oasb_tool")==108){
		s_actmain.oasbtool.generic.name		= "Nails:";
}
if(trap_Cvar_VariableValue("oasb_tool")==109){
		s_actmain.oasbtool.generic.name		= "Proximity Mines:";
}
if(trap_Cvar_VariableValue("oasb_tool")==110){
		s_actmain.oasbtool.generic.name		= "Chaingun Belt:";
}
if(trap_Cvar_VariableValue("oasb_tool")==111){
		s_actmain.oasbtool.generic.name		= "Scout:";
}
if(trap_Cvar_VariableValue("oasb_tool")==112){
		s_actmain.oasbtool.generic.name		= "Guard:";
}
if(trap_Cvar_VariableValue("oasb_tool")==113){
		s_actmain.oasbtool.generic.name		= "Doubler:";
}
if(trap_Cvar_VariableValue("oasb_tool")==114){
		s_actmain.oasbtool.generic.name		= "Ammo Regen:";
}
if(trap_Cvar_VariableValue("oasb_tool")==115){
		s_actmain.oasbtool.generic.name		= "Neutral Flag:";
}
if(trap_Cvar_VariableValue("oasb_tool")==116){
		s_actmain.oasbtool.generic.name		= "Nailgun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==117){
		s_actmain.oasbtool.generic.name		= "Prox Launcher:";
}
if(trap_Cvar_VariableValue("oasb_tool")==118){
		s_actmain.oasbtool.generic.name		= "Chaingun:";
}
if(trap_Cvar_VariableValue("oasb_tool")==119){
		s_actmain.oasbtool.generic.name		= "Flamethrower:";
}
if(trap_Cvar_VariableValue("oasb_tool")==120){
		s_actmain.oasbtool.generic.name		= "Flame:";
}
if(trap_Cvar_VariableValue("oasb_tool")==121){
		s_actmain.oasbtool.generic.name		= "Dark Flare:";
}
if(trap_Cvar_VariableValue("oasb_tool")==122){
		s_actmain.oasbtool.generic.name		= "Point A:";
}
if(trap_Cvar_VariableValue("oasb_tool")==123){
		s_actmain.oasbtool.generic.name		= "Point B:";
}
if(trap_Cvar_VariableValue("oasb_tool")==124){
		s_actmain.oasbtool.generic.name		= "Neutral domination point:";
}
if(trap_Cvar_VariableValue("oasb_tool")==125){
		s_actmain.oasbtool.generic.name		= "Noise tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==126){
		s_actmain.oasbtool.generic.name		= "Restore Model tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==127){
		s_actmain.oasbtool.generic.name		= "Object permissions tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==128){
		s_actmain.oasbtool.generic.name		= "Get object permissions:";
}
if(trap_Cvar_VariableValue("oasb_tool")==129){
		s_actmain.oasbtool.generic.name		= "Prop locker tool:";
}
if(trap_Cvar_VariableValue("oasb_tool")==130){
		s_actmain.oasbtool.generic.name		= "Set Point 1:";
}
if(trap_Cvar_VariableValue("oasb_tool")==131){
		s_actmain.oasbtool.generic.name		= "Set Point 2:";
}
if(trap_Cvar_VariableValue("oasb_tool")==132){
		s_actmain.oasbtool.generic.name		= "Set Point 3:";
}
if(trap_Cvar_VariableValue("oasb_tool")==133){
		s_actmain.oasbtool.generic.name		= "Teleport Point 1:";
}
if(trap_Cvar_VariableValue("oasb_tool")==134){
		s_actmain.oasbtool.generic.name		= "Teleport Point 2:";
}
if(trap_Cvar_VariableValue("oasb_tool")==135){
		s_actmain.oasbtool.generic.name		= "Teleport Point 3:";
}
if(trap_Cvar_VariableValue("oasb_tool")==136){
		s_actmain.oasbtool.generic.name		= "Teleport Me Point 1:";
}
if(trap_Cvar_VariableValue("oasb_tool")==137){
		s_actmain.oasbtool.generic.name		= "Teleport Me Point 2:";
}
if(trap_Cvar_VariableValue("oasb_tool")==138){
		s_actmain.oasbtool.generic.name		= "Teleport Me Point 3:";
}
if(trap_Cvar_VariableValue("oasb_tool")==139){
		s_actmain.oasbtool.generic.name		= "Grab Item:";
}
if(trap_Cvar_VariableValue("oasb_tool")==140){
		s_actmain.oasbtool.generic.name		= "Grab Items and weapons:";
}
if(trap_Cvar_VariableValue("oasb_tool")==141){
		s_actmain.oasbtool.generic.name		= "Targetname Tool Me (1 to 20):";
}
		s_actmain.oasbtool.generic.x			= 320;
		s_actmain.oasbtool.generic.y			= y;
		s_actmain.oasbtool.minvalue			= 0;
	    s_actmain.oasbtool.maxvalue			= 141;

			y += 18;
			
			
		s_actmain.oasbmemory.generic.type			= MTYPE_SLIDER;
		s_actmain.oasbmemory.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		s_actmain.oasbmemory.generic.callback		= ActMain_MenuEvent;
		s_actmain.oasbmemory.generic.id			= ID_OASBMEMORY;
		s_actmain.oasbmemory.generic.name		= "Memory Tool:";
		s_actmain.oasbmemory.generic.x			= 320;
		s_actmain.oasbmemory.generic.y			= y;
		s_actmain.oasbmemory.minvalue			= 0;
	    s_actmain.oasbmemory.maxvalue			= 30;


			/*s_actmain.oasbmodifier.generic.type			= MTYPE_SLIDER;
			s_actmain.oasbmodifier.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
			s_actmain.oasbmodifier.generic.callback		= ActMain_MenuEvent;
			s_actmain.oasbmodifier.generic.id			= ID_OASBMODIFIER;
			if(!rus.integer){
			s_actmain.oasbmodifier.generic.name		= "Tool Modifier:";
			}
			if(rus.integer){
			s_actmain.oasbmodifier.generic.name		= "Модификатор инструмента:";
			}
			s_actmain.oasbmodifier.generic.x			= 320;
			s_actmain.oasbmodifier.generic.y			= y;
			s_actmain.oasbmodifier.minvalue			= 0;
		    s_actmain.oasbmodifier.maxvalue			= 500;*/


				s_actmain.oasbmodifier.generic.type		= MTYPE_FIELD;
				if(!rus.integer){
				s_actmain.oasbmodifier.generic.name		= "Tool Modifier:";
				}
				if(rus.integer){
				s_actmain.oasbmodifier.generic.name		= "Модификатор инструмента:";
				}
				s_actmain.oasbmodifier.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
				s_actmain.oasbmodifier.generic.x			= 320;
				s_actmain.oasbmodifier.generic.y			= y;
				s_actmain.oasbmodifier.field.widthInChars = 50;
				s_actmain.oasbmodifier.field.maxchars     = 50;

				s_actmain.oasbmodsav.generic.type     = MTYPE_PTEXT;
				s_actmain.oasbmodsav.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
				s_actmain.oasbmodsav.generic.id       = ID_OASBMODSAV;
				s_actmain.oasbmodsav.generic.callback = ActMain_MenuEvent;
				s_actmain.oasbmodsav.generic.x        = 630;
				s_actmain.oasbmodsav.generic.y        = y + 15;
				s_actmain.oasbmodsav.string           = "Save";
if(trap_Cvar_VariableValue("oasb_tool")==69){
		s_actmain.oasbmodsav.string           = "Noclip";
}
if(trap_Cvar_VariableValue("oasb_idi")!=-1){
		s_actmain.oasbmodsav.string           = "Bind button";
}
				s_actmain.oasbmodsav.style            = UI_CENTER|UI_SMALLFONT;
				s_actmain.oasbmodsav.color            = colorRed;

	y += 25;

	s_actmain.minigame.generic.type			= MTYPE_SLIDER;
	s_actmain.minigame.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_actmain.minigame.generic.callback		= ActMain_MenuEvent;
	s_actmain.minigame.generic.id			= ID_MINIGAME;
	if(!rus.integer){
	s_actmain.minigame.generic.name		= "Race Mode:";
	}
	if(rus.integer){
	s_actmain.minigame.generic.name		= "Режим гонки:";
	}
	s_actmain.minigame.generic.x			= 320;
	s_actmain.minigame.generic.y			= y;
	s_actmain.minigame.minvalue			= 0;
    s_actmain.minigame.maxvalue			= 1;

	s_actmain.savemap.generic.type     = MTYPE_PTEXT;
	s_actmain.savemap.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.savemap.generic.id       = ID_SAVEMAP;
	s_actmain.savemap.generic.callback = ActMain_MenuEvent;
	s_actmain.savemap.generic.x        = 450;
	s_actmain.savemap.generic.y        = 5;
	if(!rus.integer){
	s_actmain.savemap.string		= "Save map";
	}
	if(rus.integer){
	s_actmain.savemap.string		= "Сохранить карту";
	}
	s_actmain.savemap.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.savemap.color            = colorYellow;
//	y += 20;

	s_actmain.loadmap.generic.type     = MTYPE_PTEXT;
	s_actmain.loadmap.generic.flags    = QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	s_actmain.loadmap.generic.id       = ID_LOADMAP;
	s_actmain.loadmap.generic.callback = ActMain_MenuEvent;
	s_actmain.loadmap.generic.x        = 450;
	s_actmain.loadmap.generic.y        = 25;
	if(!rus.integer){
	s_actmain.loadmap.string		= "Load map";
	}
	if(rus.integer){
	s_actmain.loadmap.string		= "Загрузить карту";
	}
	s_actmain.loadmap.style            = UI_CENTER|UI_SMALLFONT;
	s_actmain.loadmap.color            = colorYellow;
//	y += 20;



	trap_GetConfigString(CS_SERVERINFO, info, MAX_INFO_STRING);



	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.frame );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.dropammo );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.drophealth );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.savemap );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.loadmap );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.droparmor );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.dropweapon );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.dropflag );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.dropholdable );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.taunt );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.tauntk );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.kill );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.music );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.musicprev );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.musicnext );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.sound );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.player );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.hudmov );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.building );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbid );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbheight );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbtool );
	//Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbmemory );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbmodifier );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.oasbmodsav );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.minigame );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.boff );
	Menu_AddItem( &s_actmain.menu, (void*) &s_actmain.bon );

	s_actmain.hudmov.curvalue  = trap_Cvar_VariableValue( "cg_hudcord");
	s_actmain.building.curvalue  = trap_Cvar_VariableValue( "g_building");
	s_actmain.oasbid.curvalue  = trap_Cvar_VariableValue( "oasb_idi");
	s_actmain.oasbheight.curvalue  = trap_Cvar_VariableValue( "oasb_height");
	s_actmain.oasbtool.curvalue  = trap_Cvar_VariableValue( "oasb_tool");
	s_actmain.oasbmemory.curvalue  = trap_Cvar_VariableValue( "oasb_modifiersel");
	//s_actmain.oasbmodifier.field.buffer  = trap_Cvar_VariableValue( "oasb_modifier");
	Q_strncpyz( s_actmain.oasbmodifier.field.buffer, UI_Cvar_VariableString("oasb_modifiers"), sizeof(s_actmain.oasbmodifier.field.buffer) );
	s_actmain.minigame.curvalue  = trap_Cvar_VariableValue( "g_minigame");

}


/*
===============
ActMain_Cache
===============
*/
void ActMain_Cache( void ) {
	trap_R_RegisterShaderNoMip( TEAMMAIN_FRAME );
}


/*
===============
UI_ActMainMenu
===============
*/
void UI_ActMainMenu( void ) {
	ActMain_MenuInit();
	UI_PushMenu ( &s_actmain.menu );
}


#define ART_BACK0			"menu/art_blueish/back_0"
#define ART_BACK1			"menu/art_blueish/back_1"
#define ART_FIGHT0			"menu/art_blueish/load_0"
#define ART_FIGHT1			"menu/art_blueish/load_1"
#define ART_FRAMEL			"menu/art_blueish/frame2_l"
#define ART_FRAMER			"menu/art_blueish/frame1_r"
#define ART_ARROWS			"menu/art_blueish/arrows_horz_0"
#define ART_ARROWLEFT		"menu/art_blueish/arrows_horz_left"
#define ART_ARROWRIGHT		"menu/art_blueish/arrows_horz_right"

#define MAX_CONFIGS			2048
#define NAMEBUFSIZE			( MAX_CONFIGS * 16 )

#define ID_BACK				10
#define ID_GO				11
#define ID_LIST				12
#define ID_LEFT				13
#define ID_RIGHT			14

#define ARROWS_WIDTH		128
#define ARROWS_HEIGHT		48


typedef struct {
	menuframework_s	menu;

	menutext_s		banner;
	menubitmap_s	framel;
	menubitmap_s	framer;

	menulist_s		list;

	menubitmap_s	arrows;
	menubitmap_s	left;
	menubitmap_s	right;
	menubitmap_s	back;
	menubitmap_s	go;

	char			names[NAMEBUFSIZE];
	char*			configlist[MAX_CONFIGS];
} configs_t;

static configs_t	s_configs;


/*
===============
LoadConfig_MenuEvent
===============
*/
static void LoadConfig_MenuEvent( void *ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch ( ((menucommon_s*)ptr)->id ) {
	case ID_GO:
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "music UserTracks/%s\n", s_configs.list.itemnames[s_configs.list.curvalue] ) );
		trap_Cvar_SetValue("MusicplayerMusic", s_configs.list.curvalue);
		trap_Cmd_ExecuteText( EXEC_APPEND,  "exec MusicplayerAdd\n" );
		UI_PopMenu();
		break;

	case ID_BACK:
		UI_PopMenu();
		break;

	case ID_LEFT:
		ScrollList_Key( &s_configs.list, K_LEFTARROW );
		break;

	case ID_RIGHT:
		ScrollList_Key( &s_configs.list, K_RIGHTARROW );
		break;
	}
}



/*
===============
MusicPlayerNext
===============
*/
static void MusicPlayerNext( void ) {
	int i;

//trap_Cmd_ExecuteText( EXEC_APPEND, "setup1 MusicplayerMusic\n" );

/*if(MusicplayerMusic.integer < 0){
trap_Cmd_ExecuteText( EXEC_APPEND, "set MusicplayerMusic 0\n" );
}
if(MusicplayerMusic.integer > s_configs.list.numitems){
trap_Cmd_ExecuteText( EXEC_APPEND, "set MusicplayerMusic 0\n" );
}*/
		i = MusicplayerMusic.integer;
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "music UserTracks/%s\n", s_configs.list.itemnames[i] ) );
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "echoo UserTracks: %s\n", s_configs.list.itemnames[i] ) );

}

/*
===============
MusicPlayerPrev
===============
*/
static void MusicPlayerPrev( void ) {
	int i;

//trap_Cmd_ExecuteText( EXEC_APPEND, "setdown1 MusicplayerMusic\n" );

/*if(MusicplayerMusic.integer < 0){
trap_Cmd_ExecuteText( EXEC_APPEND, "set MusicplayerMusic 0\n" );
}
if(MusicplayerMusic.integer > s_configs.list.numitems){
trap_Cmd_ExecuteText( EXEC_APPEND, "set MusicplayerMusic 0\n" );
}*/
		i = MusicplayerMusic.integer;
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "music UserTracks/%s\n", s_configs.list.itemnames[i] ) );
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "echoo UserTracks: %s\n", s_configs.list.itemnames[i] ) );

}



/*
===============
LoadConfig_MenuInit
===============
*/
static void LoadConfig_MenuInit( void ) {
	int		i;
	int		len;
	char	*configname;

	UI_LoadConfig_Cache();

	memset( &s_configs, 0 ,sizeof(configs_t) );
	s_configs.menu.wrapAround = qtrue;
	s_configs.menu.fullscreen = qtrue;

	s_configs.banner.generic.type	= MTYPE_BTEXT;
	s_configs.banner.generic.x		= 320;
	s_configs.banner.generic.y		= 16;
	s_configs.banner.string			= "Music";
	s_configs.banner.color			= color_white;
	s_configs.banner.style			= UI_CENTER;

	s_configs.framel.generic.type	= MTYPE_BITMAP;
	s_configs.framel.generic.name	= ART_FRAMEL;
	s_configs.framel.generic.flags	= QMF_INACTIVE;
	s_configs.framel.generic.x		= 0;
	s_configs.framel.generic.y		= 78;
	s_configs.framel.width			= 256;
	s_configs.framel.height			= 329;

	s_configs.framer.generic.type	= MTYPE_BITMAP;
	s_configs.framer.generic.name	= ART_FRAMER;
	s_configs.framer.generic.flags	= QMF_INACTIVE;
	s_configs.framer.generic.x		= 376;
	s_configs.framer.generic.y		= 76;
	s_configs.framer.width			= 256;
	s_configs.framer.height			= 334;

	s_configs.arrows.generic.type	= MTYPE_BITMAP;
	s_configs.arrows.generic.name	= ART_ARROWS;
	s_configs.arrows.generic.flags	= QMF_INACTIVE;
	s_configs.arrows.generic.x		= 320-ARROWS_WIDTH/2;
	s_configs.arrows.generic.y		= 400;
	s_configs.arrows.width			= ARROWS_WIDTH;
	s_configs.arrows.height			= ARROWS_HEIGHT;

	s_configs.left.generic.type		= MTYPE_BITMAP;
	s_configs.left.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_configs.left.generic.x		= 320-ARROWS_WIDTH/2;
	s_configs.left.generic.y		= 400;
	s_configs.left.generic.id		= ID_LEFT;
	s_configs.left.generic.callback	= LoadConfig_MenuEvent;
	s_configs.left.width			= ARROWS_WIDTH/2;
	s_configs.left.height			= ARROWS_HEIGHT;
	s_configs.left.focuspic			= ART_ARROWLEFT;

	s_configs.right.generic.type	= MTYPE_BITMAP;
	s_configs.right.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_configs.right.generic.x		= 320;
	s_configs.right.generic.y		= 400;
	s_configs.right.generic.id		= ID_RIGHT;
	s_configs.right.generic.callback = LoadConfig_MenuEvent;
	s_configs.right.width			= ARROWS_WIDTH/2;
	s_configs.right.height			= ARROWS_HEIGHT;
	s_configs.right.focuspic		= ART_ARROWRIGHT;

	s_configs.back.generic.type		= MTYPE_BITMAP;
	s_configs.back.generic.name		= ART_BACK0;
	s_configs.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_configs.back.generic.id		= ID_BACK;
	s_configs.back.generic.callback	= LoadConfig_MenuEvent;
	s_configs.back.generic.x		= 0;
	s_configs.back.generic.y		= 480-64;
	s_configs.back.width			= 128;
	s_configs.back.height			= 64;
	s_configs.back.focuspic			= ART_BACK1;

	s_configs.go.generic.type		= MTYPE_BITMAP;
	s_configs.go.generic.name		= ART_FIGHT0;
	s_configs.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_configs.go.generic.id			= ID_GO;
	s_configs.go.generic.callback	= LoadConfig_MenuEvent;
	s_configs.go.generic.x			= 640;
	s_configs.go.generic.y			= 480-64;
	s_configs.go.width				= 128;
	s_configs.go.height				= 64;
	s_configs.go.focuspic			= ART_FIGHT1;

	// scan for configs
	s_configs.list.generic.type		= MTYPE_SCROLLLIST;
	s_configs.list.generic.flags	= QMF_PULSEIFFOCUS;
	s_configs.list.generic.callback	= LoadConfig_MenuEvent;
	s_configs.list.generic.id		= ID_LIST;
	s_configs.list.generic.x		= 118;
	s_configs.list.generic.y		= 50;
	s_configs.list.width			= 32;
	s_configs.list.height			= 28;
	s_configs.list.numitems			= trap_FS_GetFileList( "UserTracks", "wav", s_configs.names, 131072 );
	s_configs.list.itemnames		= (const char **)s_configs.configlist;
	s_configs.list.columns			= 2;

	if (!s_configs.list.numitems) {
if(!rus.integer){
		strcpy(s_configs.names,"No Music Drop wav music in baseoa/UserTracks folder");
}
if(rus.integer){
		strcpy(s_configs.names,"Нет музыки Поместите музыку в формате wav в папку baseoa/UserTracks");
}
		s_configs.list.numitems = 1;

		//degenerate case, not selectable
		s_configs.go.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
	}
	else if (s_configs.list.numitems > MAX_CONFIGS)
		s_configs.list.numitems = MAX_CONFIGS;

	configname = s_configs.names;
	for ( i = 0; i < s_configs.list.numitems; i++ ) {
		s_configs.list.itemnames[i] = configname;

		// strip extension
		len = strlen( configname );
		if (!Q_stricmp(configname +  len - 4,".wav"))
			configname[len-4] = '\0';

		Q_strupr(configname);

		configname += len + 1;
	}

	Menu_AddItem( &s_configs.menu, &s_configs.banner );
	Menu_AddItem( &s_configs.menu, &s_configs.framel );
	Menu_AddItem( &s_configs.menu, &s_configs.framer );
	Menu_AddItem( &s_configs.menu, &s_configs.list );
	Menu_AddItem( &s_configs.menu, &s_configs.arrows );
	Menu_AddItem( &s_configs.menu, &s_configs.left );
	Menu_AddItem( &s_configs.menu, &s_configs.right );
	Menu_AddItem( &s_configs.menu, &s_configs.back );
	Menu_AddItem( &s_configs.menu, &s_configs.go );
}

/*
=================
UI_LoadConfig_Cache
=================
*/
void UI_LoadConfig_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
	trap_R_RegisterShaderNoMip( ART_ARROWS );
	trap_R_RegisterShaderNoMip( ART_ARROWLEFT );
	trap_R_RegisterShaderNoMip( ART_ARROWRIGHT );
}


/*
===============
UI_LoadConfigMenu
===============
*/
void UI_LoadConfigMenu( void ) {
	LoadConfig_MenuInit();
	UI_PushMenu( &s_configs.menu );
}
