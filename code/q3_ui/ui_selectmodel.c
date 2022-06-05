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

#define MAX_MAPFILES		128000
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
} s_selectModelEd_t;

static s_selectModelEd_t	s_selectModelEd;


/*
===============
selectModelEd_MenuEvent
===============
*/
static void selectModelEd_MenuEvent( void *ptr, int event ) {

	if( event != QM_ACTIVATED ) {
		return;
	}

	switch ( ((menucommon_s*)ptr)->id ) {
	case ID_GO:
		trap_Cmd_ExecuteText( EXEC_APPEND, va( "set oasb_modifiers %s\n", s_selectModelEd.list.itemnames[s_selectModelEd.list.curvalue] ) );
		UI_PopMenu();
		break;

	case ID_BACK:
		UI_PopMenu();
		break;

	case ID_LEFT:
		ScrollList_Key( &s_selectModelEd.list, K_LEFTARROW );
		break;

	case ID_RIGHT:
		ScrollList_Key( &s_selectModelEd.list, K_RIGHTARROW );
		break;
	}
}


/*
===============
selectModelEd_MenuInit
===============
*/
static void selectModelEd_MenuInit( void ) {
	int		i;
	int		len;
	char	*configname;

	UI_selectModelEd_Cache();

	memset( &s_selectModelEd, 0 ,sizeof(s_selectModelEd_t) );
	s_selectModelEd.menu.wrapAround = qtrue;
	s_selectModelEd.menu.fullscreen = qtrue;

	s_selectModelEd.banner.generic.type	= MTYPE_BTEXT;
	s_selectModelEd.banner.generic.x		= 320;
	s_selectModelEd.banner.generic.y		= 16;
	if(!rus.integer){
	s_selectModelEd.banner.string			= "Select object";
	}
	if(rus.integer){
	s_selectModelEd.banner.string			= "Выбор обьекта";
	}
	s_selectModelEd.banner.color			= color_white;
	s_selectModelEd.banner.style			= UI_CENTER;

	s_selectModelEd.framel.generic.type	= MTYPE_BITMAP;
	s_selectModelEd.framel.generic.name	= ART_FRAMEL;
	s_selectModelEd.framel.generic.flags	= QMF_INACTIVE;
	s_selectModelEd.framel.generic.x		= 0;
	s_selectModelEd.framel.generic.y		= 78;
	s_selectModelEd.framel.width			= 256;
	s_selectModelEd.framel.height			= 329;

	s_selectModelEd.framer.generic.type	= MTYPE_BITMAP;
	s_selectModelEd.framer.generic.name	= ART_FRAMER;
	s_selectModelEd.framer.generic.flags	= QMF_INACTIVE;
	s_selectModelEd.framer.generic.x		= 376;
	s_selectModelEd.framer.generic.y		= 76;
	s_selectModelEd.framer.width			= 256;
	s_selectModelEd.framer.height			= 334;

	s_selectModelEd.arrows.generic.type	= MTYPE_BITMAP;
	s_selectModelEd.arrows.generic.name	= ART_ARROWS;
	s_selectModelEd.arrows.generic.flags	= QMF_INACTIVE;
	s_selectModelEd.arrows.generic.x		= 320-ARROWS_WIDTH/2;
	s_selectModelEd.arrows.generic.y		= 400;
	s_selectModelEd.arrows.width			= ARROWS_WIDTH;
	s_selectModelEd.arrows.height			= ARROWS_HEIGHT;

	s_selectModelEd.left.generic.type		= MTYPE_BITMAP;
	s_selectModelEd.left.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_selectModelEd.left.generic.x		= 320-ARROWS_WIDTH/2;
	s_selectModelEd.left.generic.y		= 400;
	s_selectModelEd.left.generic.id		= ID_LEFT;
	s_selectModelEd.left.generic.callback	= selectModelEd_MenuEvent;
	s_selectModelEd.left.width			= ARROWS_WIDTH/2;
	s_selectModelEd.left.height			= ARROWS_HEIGHT;
	s_selectModelEd.left.focuspic			= ART_ARROWLEFT;

	s_selectModelEd.right.generic.type	= MTYPE_BITMAP;
	s_selectModelEd.right.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
	s_selectModelEd.right.generic.x		= 320;
	s_selectModelEd.right.generic.y		= 400;
	s_selectModelEd.right.generic.id		= ID_RIGHT;
	s_selectModelEd.right.generic.callback = selectModelEd_MenuEvent;
	s_selectModelEd.right.width			= ARROWS_WIDTH/2;
	s_selectModelEd.right.height			= ARROWS_HEIGHT;
	s_selectModelEd.right.focuspic		= ART_ARROWRIGHT;

	s_selectModelEd.back.generic.type		= MTYPE_BITMAP;
	s_selectModelEd.back.generic.name		= ART_BACK0;
	s_selectModelEd.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_selectModelEd.back.generic.id		= ID_BACK;
	s_selectModelEd.back.generic.callback	= selectModelEd_MenuEvent;
	s_selectModelEd.back.generic.x		= 0;
	s_selectModelEd.back.generic.y		= 480-64;
	s_selectModelEd.back.width			= 128;
	s_selectModelEd.back.height			= 64;
	s_selectModelEd.back.focuspic			= ART_BACK1;

	s_selectModelEd.go.generic.type		= MTYPE_BITMAP;
	s_selectModelEd.go.generic.name		= ART_FIGHT0;
	s_selectModelEd.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_selectModelEd.go.generic.id			= ID_GO;
	s_selectModelEd.go.generic.callback	= selectModelEd_MenuEvent;
	s_selectModelEd.go.generic.x			= 640;
	s_selectModelEd.go.generic.y			= 480-64;
	s_selectModelEd.go.width				= 128;
	s_selectModelEd.go.height				= 64;
	s_selectModelEd.go.focuspic			= ART_FIGHT1;

	// scan for configs
	s_selectModelEd.list.generic.type		= MTYPE_SCROLLLIST;
	s_selectModelEd.list.generic.flags	= QMF_PULSEIFFOCUS;
	s_selectModelEd.list.generic.callback	= selectModelEd_MenuEvent;
	s_selectModelEd.list.generic.id		= ID_LIST;
	s_selectModelEd.list.generic.x		= 118;
	s_selectModelEd.list.generic.y		= 130;
	s_selectModelEd.list.width			= 16;
	s_selectModelEd.list.height			= 14;
	s_selectModelEd.list.numitems			= trap_FS_GetFileList( "models", "md3", s_selectModelEd.names, 8388608 );
	s_selectModelEd.list.itemnames		= (const char **)s_selectModelEd.configlist;
	s_selectModelEd.list.columns			= 1;

	if (!s_selectModelEd.list.numitems) {
	if(!rus.integer){
		strcpy(s_selectModelEd.names,"No Models Found.");
	}
	if(rus.integer){
		strcpy(s_selectModelEd.names,"Нет моделей.");
	}
		s_selectModelEd.list.numitems = 1;

		//degenerate case, not selectable
		s_selectModelEd.go.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
	}
	else if (s_selectModelEd.list.numitems > MAX_MAPFILES)
		s_selectModelEd.list.numitems = MAX_MAPFILES;

	configname = s_selectModelEd.names;
	for ( i = 0; i < s_selectModelEd.list.numitems; i++ ) {
		s_selectModelEd.list.itemnames[i] = configname;

		// strip extension
		len = strlen( configname );
		if (!Q_stricmp(configname +  len - 4,".md3"))
			configname[len-4] = '\0';

		Q_strupr(configname);

		configname += len + 1;
	}

	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.banner );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.framel );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.framer );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.list );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.arrows );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.left );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.right );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.back );
	Menu_AddItem( &s_selectModelEd.menu, &s_selectModelEd.go );
}

/*
=================
UI_selectModelEd_Cache
=================
*/
void UI_selectModelEd_Cache( void ) {
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
UI_selectModelEdMenu
===============
*/
void UI_selectModelEdMenu( void ) {
	selectModelEd_MenuInit();
	UI_PushMenu( &s_selectModelEd.menu );
}
