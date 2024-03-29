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

NETWORK OPTIONS MENU

=======================================================================
*/

#include "ui_local.h"


#define ART_FRAMEL			"menu/art_blueish/frame2_l"
#define ART_FRAMER			"menu/art_blueish/frame1_r"
#define ART_BACK0			"menu/art_blueish/back_0"
#define ART_BACK1			"menu/art_blueish/back_1"

#define ID_GRAPHICS			10
#define ID_DISPLAY			11
#define ID_SOUND			12
#define ID_NETWORK			13
#define ID_RATE				14
#define ID_BACK				15
#define ID_REALVIEW			16
#define ID_REALVIEWF			17
#define ID_REALVIEWU			18


const char *rate_items[] = {
	"<= 28.8K",
	"33.6K",
	"56K",
	"ISDN",
	"LAN/Cable/xDSL",
	NULL
};

typedef struct {
	menuframework_s	menu;

	menutext_s		banner;
	menubitmap_s	framel;
	menubitmap_s	framer;

	menutext_s		graphics;
	menutext_s		display;
	menutext_s		sound;
	menutext_s		network;
	
	menuslider_s  rview;
	menuslider_s  rviewf;
	menuslider_s  rviewu;

	menulist_s		rate;

	menubitmap_s	back;
} networkOptionsInfo_t;

static networkOptionsInfo_t	networkOptionsInfo;


/*
=================
UI_NetworkOptionsMenu_Event
=================
*/
static void UI_NetworkOptionsMenu_Event( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_GRAPHICS:
		UI_PopMenu();
		UI_GraphicsOptionsMenu();
		break;

	case ID_DISPLAY:
		UI_PopMenu();
		UI_DisplayOptionsMenu();
		break;

	case ID_SOUND:
		UI_PopMenu();
		UI_SoundOptionsMenu();
		break;

	case ID_NETWORK:
		break;

	case ID_RATE:
		if( networkOptionsInfo.rate.curvalue == 0 ) {
			trap_Cvar_SetValue( "rate", 2500 );
		}
		else if( networkOptionsInfo.rate.curvalue == 1 ) {
			trap_Cvar_SetValue( "rate", 3000 );
		}
		else if( networkOptionsInfo.rate.curvalue == 2 ) {
			trap_Cvar_SetValue( "rate", 4000 );
		}
		else if( networkOptionsInfo.rate.curvalue == 3 ) {
			trap_Cvar_SetValue( "rate", 5000 );
		}
		else if( networkOptionsInfo.rate.curvalue == 4 ) {
			trap_Cvar_SetValue( "rate", 25000 );
		}
		break;
		
	case ID_REALVIEW:
		trap_Cvar_SetValue( "ui_mapiconsizeq", networkOptionsInfo.rview.curvalue  / 10);
		break;
		
	case ID_REALVIEWF:
		trap_Cvar_SetValue( "ui_maprowsq", networkOptionsInfo.rviewf.curvalue);
		break;
		
	case ID_REALVIEWU:
		trap_Cvar_SetValue( "ui_mapcolsq", networkOptionsInfo.rviewu.curvalue);
		break;

	case ID_BACK:
		UI_PopMenu();
		break;
	}
}


/*
===============
UI_NetworkOptionsMenu_Init
===============
*/
static void UI_NetworkOptionsMenu_Init( void ) {
	int		y;
	int		rate;

	memset( &networkOptionsInfo, 0, sizeof(networkOptionsInfo) );

	UI_NetworkOptionsMenu_Cache();
	networkOptionsInfo.menu.wrapAround = qtrue;
	networkOptionsInfo.menu.fullscreen = qtrue;

	networkOptionsInfo.banner.generic.type		= MTYPE_BTEXT;
	networkOptionsInfo.banner.generic.flags		= QMF_CENTER_JUSTIFY;
	networkOptionsInfo.banner.generic.x			= 320;
	networkOptionsInfo.banner.generic.y			= 16;
	networkOptionsInfo.banner.color				= color_white;
	networkOptionsInfo.banner.style				= UI_CENTER;

	networkOptionsInfo.framel.generic.type		= MTYPE_BITMAP;
	networkOptionsInfo.framel.generic.name		= ART_FRAMEL;
	networkOptionsInfo.framel.generic.flags		= QMF_INACTIVE;
	networkOptionsInfo.framel.generic.x			= 0;  
	networkOptionsInfo.framel.generic.y			= 78;
	networkOptionsInfo.framel.width				= 256;
	networkOptionsInfo.framel.height			= 329;

	networkOptionsInfo.framer.generic.type		= MTYPE_BITMAP;
	networkOptionsInfo.framer.generic.name		= ART_FRAMER;
	networkOptionsInfo.framer.generic.flags		= QMF_INACTIVE;
	networkOptionsInfo.framer.generic.x			= 376;
	networkOptionsInfo.framer.generic.y			= 76;
	networkOptionsInfo.framer.width				= 256;
	networkOptionsInfo.framer.height			= 334;

if(!rus.integer){
	networkOptionsInfo.graphics.generic.type		= MTYPE_PTEXT;
	networkOptionsInfo.graphics.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.graphics.generic.id			= ID_GRAPHICS;
	networkOptionsInfo.graphics.generic.callback	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.graphics.generic.x			= 216;
	networkOptionsInfo.graphics.generic.y			= 240 - 2 * PROP_HEIGHT;
	networkOptionsInfo.graphics.style				= UI_RIGHT;
	networkOptionsInfo.graphics.color				= color_red;

	networkOptionsInfo.display.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.display.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.display.generic.id			= ID_DISPLAY;
	networkOptionsInfo.display.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.display.generic.x			= 216;
	networkOptionsInfo.display.generic.y			= 240 - PROP_HEIGHT;
	networkOptionsInfo.display.style				= UI_RIGHT;
	networkOptionsInfo.display.color				= color_red;

	networkOptionsInfo.sound.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.sound.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.sound.generic.id				= ID_SOUND;
	networkOptionsInfo.sound.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.sound.generic.x				= 216;
	networkOptionsInfo.sound.generic.y				= 240;
	networkOptionsInfo.sound.style					= UI_RIGHT;
	networkOptionsInfo.sound.color					= color_red;

	networkOptionsInfo.network.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.network.generic.flags		= QMF_RIGHT_JUSTIFY;
	networkOptionsInfo.network.generic.id			= ID_NETWORK;
	networkOptionsInfo.network.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.network.generic.x			= 216;
	networkOptionsInfo.network.generic.y			= 240 + PROP_HEIGHT;
	networkOptionsInfo.network.style				= UI_RIGHT;
	networkOptionsInfo.network.color				= color_red;
}
if(rus.integer){
	networkOptionsInfo.graphics.generic.type		= MTYPE_PTEXT;
	networkOptionsInfo.graphics.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.graphics.generic.id			= ID_GRAPHICS;
	networkOptionsInfo.graphics.generic.callback	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.graphics.generic.x			= 32;
	networkOptionsInfo.graphics.generic.y			= 240 - 2 * PROP_HEIGHT;
//	networkOptionsInfo.graphics.style				= UI_RIGHT;
	networkOptionsInfo.graphics.color				= color_red;

	networkOptionsInfo.display.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.display.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.display.generic.id			= ID_DISPLAY;
	networkOptionsInfo.display.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.display.generic.x			= 32;
	networkOptionsInfo.display.generic.y			= 240 - PROP_HEIGHT;
//	networkOptionsInfo.display.style				= UI_RIGHT;
	networkOptionsInfo.display.color				= color_red;

	networkOptionsInfo.sound.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.sound.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.sound.generic.id				= ID_SOUND;
	networkOptionsInfo.sound.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.sound.generic.x				= 32;
	networkOptionsInfo.sound.generic.y				= 240;
//	networkOptionsInfo.sound.style					= UI_RIGHT;
	networkOptionsInfo.sound.color					= color_red;

	networkOptionsInfo.network.generic.type			= MTYPE_PTEXT;
	networkOptionsInfo.network.generic.flags		= QMF_CENTER_JUSTIFY;
	networkOptionsInfo.network.generic.id			= ID_NETWORK;
	networkOptionsInfo.network.generic.callback		= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.network.generic.x			= 32;
	networkOptionsInfo.network.generic.y			= 240 + PROP_HEIGHT;
//	networkOptionsInfo.network.style				= UI_RIGHT;
	networkOptionsInfo.network.color				= color_red;
}

	y = 240 - 1 * (BIGCHAR_HEIGHT+2);
	networkOptionsInfo.rate.generic.type		= MTYPE_SPINCONTROL;
	networkOptionsInfo.rate.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	networkOptionsInfo.rate.generic.callback	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.rate.generic.id			= ID_RATE;
	networkOptionsInfo.rate.generic.x			= 400;
	networkOptionsInfo.rate.generic.y			= y;
	networkOptionsInfo.rate.itemnames			= rate_items;
	
	y += BIGCHAR_HEIGHT+2;
	networkOptionsInfo.rview.generic.type     	= MTYPE_SLIDER;
	networkOptionsInfo.rview.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	networkOptionsInfo.rview.generic.callback 	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.rview.generic.id       	= ID_REALVIEW;
	networkOptionsInfo.rview.generic.x	       	= 400;
	networkOptionsInfo.rview.generic.y	        = y;
	networkOptionsInfo.rview.minvalue			= 1;
    networkOptionsInfo.rview.maxvalue			= 20;
	
	y += BIGCHAR_HEIGHT+2;
	networkOptionsInfo.rviewf.generic.type     	= MTYPE_SLIDER;
	networkOptionsInfo.rviewf.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	networkOptionsInfo.rviewf.generic.callback 	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.rviewf.generic.id       	= ID_REALVIEWF;
	networkOptionsInfo.rviewf.generic.x	       	= 400;
	networkOptionsInfo.rviewf.generic.y	        = y;
	networkOptionsInfo.rviewf.minvalue			= 1;
    networkOptionsInfo.rviewf.maxvalue			= 13;
	
	y += BIGCHAR_HEIGHT+2;
	networkOptionsInfo.rviewu.generic.type     	= MTYPE_SLIDER;
	networkOptionsInfo.rviewu.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	networkOptionsInfo.rviewu.generic.callback 	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.rviewu.generic.id       	= ID_REALVIEWU;
	networkOptionsInfo.rviewu.generic.x	       	= 400;
	networkOptionsInfo.rviewu.generic.y	        = y;
	networkOptionsInfo.rviewu.minvalue			= 1;
    networkOptionsInfo.rviewu.maxvalue			= 3;

	networkOptionsInfo.back.generic.type		= MTYPE_BITMAP;
	networkOptionsInfo.back.generic.name		= ART_BACK0;
	networkOptionsInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	networkOptionsInfo.back.generic.callback	= UI_NetworkOptionsMenu_Event;
	networkOptionsInfo.back.generic.id			= ID_BACK;
	networkOptionsInfo.back.generic.x			= 0;
	networkOptionsInfo.back.generic.y			= 480-64;
	networkOptionsInfo.back.width				= 128;
	networkOptionsInfo.back.height				= 64;
	networkOptionsInfo.back.focuspic			= ART_BACK1;
	
if(!rus.integer){
networkOptionsInfo.banner.string			= "SYSTEM SETUP";
networkOptionsInfo.graphics.string				= "GRAPHICS";
networkOptionsInfo.display.string				= "DISPLAY";
networkOptionsInfo.sound.string					= "SOUND";
networkOptionsInfo.network.string				= "OTHER";
networkOptionsInfo.rate.generic.name		= "Data Rate:";
networkOptionsInfo.rview.generic.name	   		= "Map Select Icon Size:";
networkOptionsInfo.rviewf.generic.name	   		= "Map Select Icon Rows:";
networkOptionsInfo.rviewu.generic.name	   		= "Map Select Icon Cols:";
}
if(rus.integer){
networkOptionsInfo.banner.string			= "СИСТЕМНЫЕ НАСТРОЙКИ";
networkOptionsInfo.graphics.string				= "ГРАФИКА";
networkOptionsInfo.display.string				= "ЭКРАН";
networkOptionsInfo.sound.string					= "ЗВУК";
networkOptionsInfo.network.string				= "ДРУГОЕ";
networkOptionsInfo.rate.generic.name		= "Скорость сети:";
networkOptionsInfo.rview.generic.name	   		= "Выбор карты размер значка:";
networkOptionsInfo.rviewf.generic.name	   		= "Выбор карты ширина значков:";
networkOptionsInfo.rviewu.generic.name	   		= "Выбор карты высота значков:";
}

	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.banner );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.framel );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.framer );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.graphics );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.display );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.sound );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.network );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.rate );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.rview );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.rviewf );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.rviewu );
	Menu_AddItem( &networkOptionsInfo.menu, ( void * ) &networkOptionsInfo.back );

	rate = trap_Cvar_VariableValue( "rate" );
	if( rate <= 2500 ) {
		networkOptionsInfo.rate.curvalue = 0;
	}
	else if( rate <= 3000 ) {
		networkOptionsInfo.rate.curvalue = 1;
	}
	else if( rate <= 4000 ) {
		networkOptionsInfo.rate.curvalue = 2;
	}
	else if( rate <= 5000 ) {
		networkOptionsInfo.rate.curvalue = 3;
	}
	else {
		networkOptionsInfo.rate.curvalue = 4;
	}
	
	networkOptionsInfo.rview.curvalue  = trap_Cvar_VariableValue( "ui_mapiconsizeq") * 10;
		networkOptionsInfo.rviewf.curvalue  = trap_Cvar_VariableValue( "ui_maprowsq");
			networkOptionsInfo.rviewu.curvalue  = trap_Cvar_VariableValue( "ui_mapcolsq");
	
}


/*
===============
UI_NetworkOptionsMenu_Cache
===============
*/
void UI_NetworkOptionsMenu_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
}


/*
===============
UI_NetworkOptionsMenu
===============
*/
void UI_NetworkOptionsMenu( void ) {
	UI_NetworkOptionsMenu_Init();
	UI_PushMenu( &networkOptionsInfo.menu );
	Menu_SetCursorToItem( &networkOptionsInfo.menu, &networkOptionsInfo.network );
}
