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
=============================================================================

LOAD CONFIG MENU

=============================================================================
*/

#include "ui_local.h"


#define ART_BACK0			"menu/art_blueish/back_0"
#define ART_BACK1			"menu/art_blueish/back_1"
#define ART_FIGHT0			"menu/art_blueish/load_0"
#define ART_FIGHT1			"menu/art_blueish/load_1"
#define ART_FRAMEL			"menu/art_blueish/frame2_l"
#define ART_FRAMER			"menu/art_blueish/frame1_r"
#define ART_ARROWS			"menu/art_blueish/arrows_horz_0"
#define ART_ARROWLEFT		"menu/art_blueish/arrows_horz_left"
#define ART_ARROWRIGHT		"menu/art_blueish/arrows_horz_right"

#define MAX_MAPFILES		512
#define MAPNAMEBUFSIZE			( MAX_MAPFILES * 16 )

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

	char			names[MAPNAMEBUFSIZE];
	char*			configlist[MAX_MAPFILES];
} s_loadMapEd_t;

static s_loadMapEd_t	s_loadMapEd;


/*
===============
loadMapEd_MenuEvent
===============
*/
static void loadMapEd_MenuEvent( void *ptr, int event ) {
	
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch ( ((menucommon_s*)ptr)->id ) {
	case ID_GO:
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "loadmapc maps/%s.ent\n", s_loadMapEd.list.itemnames[s_loadMapEd.list.curvalue] ) );
		UI_PopMenu();
		break;

	case ID_BACK:
		UI_PopMenu();
		break;

	case ID_LEFT:
		ScrollList_Key( &s_loadMapEd.list, K_LEFTARROW );
		break;

	case ID_RIGHT:
		ScrollList_Key( &s_loadMapEd.list, K_RIGHTARROW );
		break;
	}
}


/*
===============
loadMapEd_MenuInit
===============
*/
static void loadMapEd_MenuInit( void ) {
	int		i;
	int		len;
	char	*configname;

	UI_loadMapEd_Cache();

	memset( &s_loadMapEd, 0 ,sizeof(s_loadMapEd_t) );
	s_loadMapEd.menu.wrapAround = qtrue;
	s_loadMapEd.menu.fullscreen = qtrue;

	s_loadMapEd.banner.generic.type	= MTYPE_BTEXT;
	s_loadMapEd.banner.generic.x		= 320;
	s_loadMapEd.banner.generic.y		= 16;
	if(!rus.integer){
	s_loadMapEd.banner.string			= "Load Map";
	}
	if(rus.integer){
	s_loadMapEd.banner.string			= "Загрузка карты";
	}
	s_loadMapEd.banner.color			= color_white;
	s_loadMapEd.banner.style			= UI_CENTER;

	s_loadMapEd.framel.generic.type	= MTYPE_BITMAP;
	s_loadMapEd.framel.generic.name	= ART_FRAMEL;
	s_loadMapEd.framel.generic.flags	= QMF_INACTIVE;
	s_loadMapEd.framel.generic.x		= 0;  
	s_loadMapEd.framel.generic.y		= 78;
	s_loadMapEd.framel.width			= 256;
	s_loadMapEd.framel.height			= 329;

	s_loadMapEd.framer.generic.type	= MTYPE_BITMAP;
	s_loadMapEd.framer.generic.name	= ART_FRAMER;
	s_loadMapEd.framer.generic.flags	= QMF_INACTIVE;
	s_loadMapEd.framer.generic.x		= 376;
	s_loadMapEd.framer.generic.y		= 76;
	s_loadMapEd.framer.width			= 256;
	s_loadMapEd.framer.height			= 334;

	s_loadMapEd.arrows.generic.type	= MTYPE_BITMAP;
	s_loadMapEd.arrows.generic.name	= ART_ARROWS;
	s_loadMapEd.arrows.generic.flags	= QMF_INACTIVE;
	s_loadMapEd.arrows.generic.x		= 320-ARROWS_WIDTH/2;
	s_loadMapEd.arrows.generic.y		= 400;
	s_loadMapEd.arrows.width			= ARROWS_WIDTH;
	s_loadMapEd.arrows.height			= ARROWS_HEIGHT;

	s_loadMapEd.left.generic.type		= MTYPE_BITMAP;
	s_loadMapEd.left.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_loadMapEd.left.generic.x		= 320-ARROWS_WIDTH/2;
	s_loadMapEd.left.generic.y		= 400;
	s_loadMapEd.left.generic.id		= ID_LEFT;
	s_loadMapEd.left.generic.callback	= loadMapEd_MenuEvent;
	s_loadMapEd.left.width			= ARROWS_WIDTH/2;
	s_loadMapEd.left.height			= ARROWS_HEIGHT;
	s_loadMapEd.left.focuspic			= ART_ARROWLEFT;

	s_loadMapEd.right.generic.type	= MTYPE_BITMAP;
	s_loadMapEd.right.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_loadMapEd.right.generic.x		= 320;
	s_loadMapEd.right.generic.y		= 400;
	s_loadMapEd.right.generic.id		= ID_RIGHT;
	s_loadMapEd.right.generic.callback = loadMapEd_MenuEvent;
	s_loadMapEd.right.width			= ARROWS_WIDTH/2;
	s_loadMapEd.right.height			= ARROWS_HEIGHT;
	s_loadMapEd.right.focuspic		= ART_ARROWRIGHT;

	s_loadMapEd.back.generic.type		= MTYPE_BITMAP;
	s_loadMapEd.back.generic.name		= ART_BACK0;
	s_loadMapEd.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_loadMapEd.back.generic.id		= ID_BACK;
	s_loadMapEd.back.generic.callback	= loadMapEd_MenuEvent;
	s_loadMapEd.back.generic.x		= 0;
	s_loadMapEd.back.generic.y		= 480-64;
	s_loadMapEd.back.width			= 128;
	s_loadMapEd.back.height			= 64;
	s_loadMapEd.back.focuspic			= ART_BACK1;

	s_loadMapEd.go.generic.type		= MTYPE_BITMAP;
	s_loadMapEd.go.generic.name		= ART_FIGHT0;
	s_loadMapEd.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_loadMapEd.go.generic.id			= ID_GO;
	s_loadMapEd.go.generic.callback	= loadMapEd_MenuEvent;
	s_loadMapEd.go.generic.x			= 640;
	s_loadMapEd.go.generic.y			= 480-64;
	s_loadMapEd.go.width				= 128;
	s_loadMapEd.go.height				= 64;
	s_loadMapEd.go.focuspic			= ART_FIGHT1;

	// scan for configs
	s_loadMapEd.list.generic.type		= MTYPE_SCROLLLIST;
	s_loadMapEd.list.generic.flags	= QMF_PULSEIFFOCUS;
	s_loadMapEd.list.generic.callback	= loadMapEd_MenuEvent;
	s_loadMapEd.list.generic.id		= ID_LIST;
	s_loadMapEd.list.generic.x		= 118;
	s_loadMapEd.list.generic.y		= 130;
	s_loadMapEd.list.width			= 16;
	s_loadMapEd.list.height			= 14;
	s_loadMapEd.list.numitems			= trap_FS_GetFileList( "maps", "ent", s_loadMapEd.names, MAPNAMEBUFSIZE );
	s_loadMapEd.list.itemnames		= (const char **)s_loadMapEd.configlist;
	s_loadMapEd.list.columns			= 3;

	if (!s_loadMapEd.list.numitems) {
	if(!rus.integer){
		strcpy(s_loadMapEd.names,"No MapFiles Found.");
	}
	if(rus.integer){
		strcpy(s_loadMapEd.names,"Нет сохраненных карт.");
	}
		s_loadMapEd.list.numitems = 1;

		//degenerate case, not selectable
		s_loadMapEd.go.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
	}
	else if (s_loadMapEd.list.numitems > MAX_MAPFILES)
		s_loadMapEd.list.numitems = MAX_MAPFILES;
	
	configname = s_loadMapEd.names;
	for ( i = 0; i < s_loadMapEd.list.numitems; i++ ) {
		s_loadMapEd.list.itemnames[i] = configname;
		
		// strip extension
		len = strlen( configname );
		if (!Q_stricmp(configname +  len - 4,".ent"))
			configname[len-4] = '\0';

		Q_strupr(configname);

		configname += len + 1;
	}

	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.banner );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.framel );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.framer );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.list );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.arrows );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.left );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.right );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.back );
	Menu_AddItem( &s_loadMapEd.menu, &s_loadMapEd.go );
}

/*
=================
UI_loadMapEd_Cache
=================
*/
void UI_loadMapEd_Cache( void ) {
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
UI_loadMapEdMenu
===============
*/
void UI_loadMapEdMenu( void ) {
	loadMapEd_MenuInit();
	UI_PushMenu( &s_loadMapEd.menu );
}

