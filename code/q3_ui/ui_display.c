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

DISPLAY OPTIONS MENU

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
#define ID_BRIGHTNESS		14
#define ID_SCREENSIZE		15
#define ID_BACK				16
#define ID_FOV				17
#define ID_CROSSSIZE		18
#define ID_THIRDPERSON			19
#define ID_THIRDPERSONRANGE		20
#define ID_THIRDPERSONOFFSET	21


typedef struct {
	menuframework_s	menu;

	menutext_s		banner;
	menubitmap_s	framel;
	menubitmap_s	framer;

	menutext_s		graphics;
	menutext_s		display;
	menutext_s		sound;
	menutext_s		network;

	menuslider_s	brightness;
	menuslider_s	screensize;
	menuslider_s	fov;
	menuslider_s	crosssize;
    menuradiobutton_s  thirdperson;
	menuslider_s	thirdpersonrange;
	menuslider_s	thirdpersonoffset;


	menubitmap_s	back;
} displayOptionsInfo_t;

static displayOptionsInfo_t	displayOptionsInfo;


/*
=================
UI_DisplayOptionsMenu_Event
=================
*/
static void UI_DisplayOptionsMenu_Event( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_GRAPHICS:
		UI_PopMenu();
		UI_GraphicsOptionsMenu();
		break;

	case ID_DISPLAY:
		break;

	case ID_SOUND:
		UI_PopMenu();
		UI_SoundOptionsMenu();
		break;

	case ID_NETWORK:
		UI_PopMenu();
		UI_NetworkOptionsMenu();
		break;

	case ID_BRIGHTNESS:
		trap_Cvar_SetValue( "r_gamma", displayOptionsInfo.brightness.curvalue / 10.0f );
		break;
	
	case ID_SCREENSIZE:
		trap_Cvar_SetValue( "cg_viewsize", displayOptionsInfo.screensize.curvalue * 10 );
		break;

	case ID_FOV:
		trap_Cvar_SetValue( "cg_fov", displayOptionsInfo.fov.curvalue * 10 );
		break;

	case ID_CROSSSIZE:
		trap_Cvar_SetValue( "cg_crosshairsize", displayOptionsInfo.crosssize.curvalue);
		break;
	
	case ID_THIRDPERSON:
		trap_Cvar_SetValue( "cg_thirdperson", displayOptionsInfo.thirdperson.curvalue);
		break;
		
	case ID_THIRDPERSONRANGE:
		trap_Cvar_SetValue( "cg_thirdpersonrange", displayOptionsInfo.thirdpersonrange.curvalue);
		break;
		
	case ID_THIRDPERSONOFFSET:
		trap_Cvar_SetValue( "cg_thirdpersonoffset", displayOptionsInfo.thirdpersonoffset.curvalue);
		break;
		
	case ID_BACK:
		UI_PopMenu();
		break;
	}
}


/*
===============
UI_DisplayOptionsMenu_Init
===============
*/
static void UI_DisplayOptionsMenu_Init( void ) {
	int		y;

	memset( &displayOptionsInfo, 0, sizeof(displayOptionsInfo) );

	UI_DisplayOptionsMenu_Cache();
	displayOptionsInfo.menu.wrapAround = qtrue;
	displayOptionsInfo.menu.fullscreen = qtrue;

	displayOptionsInfo.banner.generic.type		= MTYPE_BTEXT;
	displayOptionsInfo.banner.generic.flags		= QMF_CENTER_JUSTIFY;
	displayOptionsInfo.banner.generic.x			= 320;
	displayOptionsInfo.banner.generic.y			= 16;
	displayOptionsInfo.banner.string			= "SYSTEM SETUP";
	displayOptionsInfo.banner.color				= color_white;
	displayOptionsInfo.banner.style				= UI_CENTER;

	displayOptionsInfo.framel.generic.type		= MTYPE_BITMAP;
	displayOptionsInfo.framel.generic.name		= ART_FRAMEL;
	displayOptionsInfo.framel.generic.flags		= QMF_INACTIVE;
	displayOptionsInfo.framel.generic.x			= 0;  
	displayOptionsInfo.framel.generic.y			= 78;
	displayOptionsInfo.framel.width				= 256;
	displayOptionsInfo.framel.height			= 329;

	displayOptionsInfo.framer.generic.type		= MTYPE_BITMAP;
	displayOptionsInfo.framer.generic.name		= ART_FRAMER;
	displayOptionsInfo.framer.generic.flags		= QMF_INACTIVE;
	displayOptionsInfo.framer.generic.x			= 376;
	displayOptionsInfo.framer.generic.y			= 76;
	displayOptionsInfo.framer.width				= 256;
	displayOptionsInfo.framer.height			= 334;

	displayOptionsInfo.graphics.generic.type		= MTYPE_PTEXT;
	displayOptionsInfo.graphics.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	displayOptionsInfo.graphics.generic.id			= ID_GRAPHICS;
	displayOptionsInfo.graphics.generic.callback	= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.graphics.generic.x			= 216;
	displayOptionsInfo.graphics.generic.y			= 240 - 2 * PROP_HEIGHT;
	displayOptionsInfo.graphics.string				= "GRAPHICS";
	displayOptionsInfo.graphics.style				= UI_RIGHT;
	displayOptionsInfo.graphics.color				= color_red;

	displayOptionsInfo.display.generic.type			= MTYPE_PTEXT;
	displayOptionsInfo.display.generic.flags		= QMF_RIGHT_JUSTIFY;
	displayOptionsInfo.display.generic.id			= ID_DISPLAY;
	displayOptionsInfo.display.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.display.generic.x			= 216;
	displayOptionsInfo.display.generic.y			= 240 - PROP_HEIGHT;
	displayOptionsInfo.display.string				= "DISPLAY";
	displayOptionsInfo.display.style				= UI_RIGHT;
	displayOptionsInfo.display.color				= color_red;

	displayOptionsInfo.sound.generic.type			= MTYPE_PTEXT;
	displayOptionsInfo.sound.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	displayOptionsInfo.sound.generic.id				= ID_SOUND;
	displayOptionsInfo.sound.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.sound.generic.x				= 216;
	displayOptionsInfo.sound.generic.y				= 240;
	displayOptionsInfo.sound.string					= "SOUND";
	displayOptionsInfo.sound.style					= UI_RIGHT;
	displayOptionsInfo.sound.color					= color_red;

	displayOptionsInfo.network.generic.type			= MTYPE_PTEXT;
	displayOptionsInfo.network.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	displayOptionsInfo.network.generic.id			= ID_NETWORK;
	displayOptionsInfo.network.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.network.generic.x			= 216;
	displayOptionsInfo.network.generic.y			= 240 + PROP_HEIGHT;
	displayOptionsInfo.network.string				= "NETWORK";
	displayOptionsInfo.network.style				= UI_RIGHT;
	displayOptionsInfo.network.color				= color_red;

	y = 240 - 1 * (BIGCHAR_HEIGHT+2);
	displayOptionsInfo.brightness.generic.type		= MTYPE_SLIDER;
	displayOptionsInfo.brightness.generic.name		= "Brightness:";
	displayOptionsInfo.brightness.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.brightness.generic.callback	= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.brightness.generic.id		= ID_BRIGHTNESS;
	displayOptionsInfo.brightness.generic.x			= 400;
	displayOptionsInfo.brightness.generic.y			= y;
	displayOptionsInfo.brightness.minvalue			= 5;
	displayOptionsInfo.brightness.maxvalue			= 20;

	y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.screensize.generic.type		= MTYPE_SLIDER;
	displayOptionsInfo.screensize.generic.name		= "Screen Size:";
	displayOptionsInfo.screensize.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.screensize.generic.callback	= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.screensize.generic.id		= ID_SCREENSIZE;
	displayOptionsInfo.screensize.generic.x			= 400;
	displayOptionsInfo.screensize.generic.y			= y;
	displayOptionsInfo.screensize.minvalue			= 3;
    displayOptionsInfo.screensize.maxvalue			= 10;

	y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.fov.generic.type			= MTYPE_SLIDER;
	displayOptionsInfo.fov.generic.name			= "Field of view:";
	displayOptionsInfo.fov.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.fov.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.fov.generic.id			= ID_FOV;
	displayOptionsInfo.fov.generic.x			= 400;
	displayOptionsInfo.fov.generic.y			= y;
	displayOptionsInfo.fov.minvalue				= 4;
    displayOptionsInfo.fov.maxvalue				= 12;
	
	y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.crosssize.generic.type			= MTYPE_SLIDER;
	displayOptionsInfo.crosssize.generic.name			= "Croshair size:";
	displayOptionsInfo.crosssize.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.crosssize.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.crosssize.generic.id		= ID_CROSSSIZE;
	displayOptionsInfo.crosssize.generic.x			= 400;
	displayOptionsInfo.crosssize.generic.y			= y;
	displayOptionsInfo.crosssize.minvalue				= 1;
    displayOptionsInfo.crosssize.maxvalue				= 30;
	
	        y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.thirdperson.generic.type     	= MTYPE_RADIOBUTTON;
	displayOptionsInfo.thirdperson.generic.name	   		= "Third person:";
	displayOptionsInfo.thirdperson.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.thirdperson.generic.callback 	= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.thirdperson.generic.id       	= ID_THIRDPERSON;
	displayOptionsInfo.thirdperson.generic.x	       	= 400;
	displayOptionsInfo.thirdperson.generic.y	        = y;
	
	y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.thirdpersonrange.generic.type			= MTYPE_SLIDER;
	displayOptionsInfo.thirdpersonrange.generic.name			= "Third person range:";
	displayOptionsInfo.thirdpersonrange.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.thirdpersonrange.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.thirdpersonrange.generic.id		= ID_THIRDPERSONRANGE;
	displayOptionsInfo.thirdpersonrange.generic.x			= 400;
	displayOptionsInfo.thirdpersonrange.generic.y			= y;
	displayOptionsInfo.thirdpersonrange.minvalue				= 10;
    displayOptionsInfo.thirdpersonrange.maxvalue				= 150;
	
	y += BIGCHAR_HEIGHT+2;
	displayOptionsInfo.thirdpersonoffset.generic.type			= MTYPE_SLIDER;
	displayOptionsInfo.thirdpersonoffset.generic.name			= "Third person offset:";
	displayOptionsInfo.thirdpersonoffset.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	displayOptionsInfo.thirdpersonoffset.generic.callback		= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.thirdpersonoffset.generic.id		= ID_THIRDPERSONOFFSET;
	displayOptionsInfo.thirdpersonoffset.generic.x			= 400;
	displayOptionsInfo.thirdpersonoffset.generic.y			= y;
	displayOptionsInfo.thirdpersonoffset.minvalue				= -50;
    displayOptionsInfo.thirdpersonoffset.maxvalue				= 50;

	displayOptionsInfo.back.generic.type		= MTYPE_BITMAP;
	displayOptionsInfo.back.generic.name		= ART_BACK0;
	displayOptionsInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	displayOptionsInfo.back.generic.callback	= UI_DisplayOptionsMenu_Event;
	displayOptionsInfo.back.generic.id			= ID_BACK;
	displayOptionsInfo.back.generic.x			= 0;
	displayOptionsInfo.back.generic.y			= 480-64;
	displayOptionsInfo.back.width				= 128;
	displayOptionsInfo.back.height				= 64;
	displayOptionsInfo.back.focuspic			= ART_BACK1;

	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.banner );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.framel );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.framer );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.graphics );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.display );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.sound );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.network );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.brightness );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.screensize );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.fov );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.crosssize );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.thirdperson );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.thirdpersonrange );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.thirdpersonoffset );
	Menu_AddItem( &displayOptionsInfo.menu, ( void * ) &displayOptionsInfo.back );

	displayOptionsInfo.brightness.curvalue  = trap_Cvar_VariableValue("r_gamma") * 10;
	displayOptionsInfo.screensize.curvalue  = trap_Cvar_VariableValue( "cg_viewsize")/10;
	displayOptionsInfo.fov.curvalue  = trap_Cvar_VariableValue( "cg_fov")/10;
	displayOptionsInfo.crosssize.curvalue  = trap_Cvar_VariableValue( "cg_crosshairsize");
	displayOptionsInfo.thirdperson.curvalue  = trap_Cvar_VariableValue( "cg_thirdperson");
	displayOptionsInfo.thirdpersonrange.curvalue  = trap_Cvar_VariableValue( "cg_thirdpersonrange");
	displayOptionsInfo.thirdpersonoffset.curvalue  = trap_Cvar_VariableValue( "cg_thirdpersonoffset");
}


/*
===============
UI_DisplayOptionsMenu_Cache
===============
*/
void UI_DisplayOptionsMenu_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
}


/*
===============
UI_DisplayOptionsMenu
===============
*/
void UI_DisplayOptionsMenu( void ) {
	UI_DisplayOptionsMenu_Init();
	UI_PushMenu( &displayOptionsInfo.menu );
	Menu_SetCursorToItem( &displayOptionsInfo.menu, &displayOptionsInfo.display );
}