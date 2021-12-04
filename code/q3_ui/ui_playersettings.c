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
#include "ui_local.h"

#define ART_FRAMEL			"menu/art_blueish/frame2_l"
#define ART_FRAMER			"menu/art_blueish/frame1_r"
#define ART_MODEL0			"menu/art_blueish/model_0"
#define ART_MODEL1			"menu/art_blueish/model_1"
#define ART_BACK0			"menu/art_blueish/back_0"
#define ART_BACK1			"menu/art_blueish/back_1"
#define ART_FX_BASE			"menu/art/fx_base"
#define ART_FX_BLUE			"menu/art/fx_blue"
#define ART_FX_CYAN			"menu/art/fx_cyan"
#define ART_FX_GREEN		"menu/art/fx_grn"
#define ART_FX_RED			"menu/art/fx_red"
#define ART_FX_TEAL			"menu/art/fx_teal"
#define ART_FX_WHITE		"menu/art/fx_white"
#define ART_FX_YELLOW		"menu/art/fx_yel"

#define ID_NAME			10
#define ID_HANDICAP		11
#define ID_EFFECTS		12
#define ID_EFFECTS2		13
#define ID_BACK			14
#define ID_MODEL		15
#define ID_HEAD			16
#define ID_LEGS			17
#define ID_RESET			28
#define ID_FLASHRED			18
#define ID_FLASHGREEN			19
#define ID_FLASHBLUE			20
#define ID_FLASHRADIUS			21
#define ID_HEFLASHRED			22
#define ID_HEFLASHGREEN			23
#define ID_HEFLASHBLUE			24
#define ID_TOFLASHRED			25
#define ID_TOFLASHGREEN			26
#define ID_TOFLASHBLUE			27
#define ID_PLAYERANGLE			29
#define ID_HETEX			30
#define ID_TOTEX			31
#define ID_PTEX			32
	
#define MAX_NAMELENGTH	32


typedef struct {
	menuframework_s		menu;

	menutext_s			banner;
	menubitmap_s		framel;
	menubitmap_s		framer;
	menubitmap_s		player;

	menufield_s			name;
	menufield_s			code;
	menufield_s			hudmov;
	menutext_s			head;
	menutext_s			legs;
	menutext_s			reset;
/*	menulist_s			handicap;*/
	menulist_s			effects;
	menuslider_s  		flashred;
	menuslider_s  		flashgreen;
	menuslider_s  		flashblue;
	menuslider_s  		heflashred;
	menuslider_s  		heflashgreen;
	menuslider_s  		heflashblue;
	menuslider_s  		toflashred;
	menuslider_s  		toflashgreen;
	menuslider_s  		toflashblue;
	menuslider_s  		hetex;
	menuslider_s  		totex;
	menuslider_s  		ptex;
	menuslider_s  		flashradius;
	menuslider_s  		playerangle;
        
        //Added in beta 29
        menulist_s              effects2;

	menubitmap_s		back;
	menubitmap_s		model;
	menubitmap_s		item_null;

	qhandle_t			fxBasePic;
	qhandle_t			fxPic[7];
	playerInfo_t		playerinfo;
	int					current_fx;
	char				playerModel[MAX_QPATH];
} playersettings_t;

static playersettings_t	s_playersettings;

static int gamecodetoui[] = {4,2,3,0,5,1,6};
static int uitogamecode[] = {4,6,2,3,1,5,7};

/*static const char *handicap_items[] = {
	"100",
	"95",
	"90",
	"85",
	"80",
	"75",
	"70",
	"65",
	"60",
	"55",
	"50",
	"45",
	"40",
	"35",
	"30",
	"25",
	"20",
	"15",
	"10",
	"5",
	NULL
};*/


/*
=================
PlayerSettings_DrawName
=================
*/
static void PlayerSettings_DrawName( void *self ) {
	menufield_s		*f;
	qboolean		focus;
	int				style;
	char			*txt;
	char			c;
	float			*color;
	int				n;
	int				basex, x, y;
	char			name[32];

	f = (menufield_s*)self;
	basex = f->generic.x;
	y = f->generic.y;
	focus = (f->generic.parent->cursor == f->generic.menuPosition);

	style = UI_LEFT|UI_SMALLFONT;
	color = text_color_normal;
	if( focus ) {
		style |= UI_PULSE;
		color = text_color_highlight;
	}
if(!rus.integer){
	UI_DrawProportionalString( basex, y, "Name", style, color );
}
if(rus.integer){
	UI_DrawProportionalString( basex, y, "Имя", style, color );
}

	// draw the actual name
	basex += 64;
	//y += PROP_HEIGHT;
	txt = f->field.buffer;
	color = g_color_table[ColorIndex(COLOR_WHITE)];
	x = basex;
	while ( (c = *txt) != 0 ) {
		if ( !focus && Q_IsColorString( txt ) ) {
			n = ColorIndex( *(txt+1) );
			if( n == 0 ) {
				n = 7;
			}
			color = g_color_table[n];
			txt += 2;
			continue;
		}
		UI_DrawChar( x, y, c, style, color );
		txt++;
		x += SMALLCHAR_WIDTH;
	}

	// draw cursor if we have focus
	if( focus ) {
		if ( trap_Key_GetOverstrikeMode() ) {
			c = 11;
		} else {
			c = 10;
		}

		style &= ~UI_PULSE;
		style |= UI_BLINK;

		UI_DrawChar( basex + f->field.cursor * SMALLCHAR_WIDTH, y, c, style, color_white );
	}

	// draw at bottom also using proportional font
	Q_strncpyz( name, f->field.buffer, sizeof(name) );
	Q_CleanStr( name );
//	UI_DrawProportionalString( 320, 440, name, UI_CENTER|UI_BIGFONT, text_color_normal );
}


/*
=================
PlayerSettings_DrawHandicap
=================
*/
/*static void PlayerSettings_DrawHandicap( void *self ) {
	menulist_s		*item;
	qboolean		focus;
	int				style;
	float			*color;

	item = (menulist_s *)self;
	focus = (item->generic.parent->cursor == item->generic.menuPosition);

	style = UI_LEFT|UI_SMALLFONT;
	color = text_color_normal;
	if( focus ) {
		style |= UI_PULSE;
		color = text_color_highlight;
	}
if(!rus.integer){
	UI_DrawProportionalString( item->generic.x, item->generic.y, "Handicap", style, color );
}
if(rus.integer){
	UI_DrawProportionalString( item->generic.x, item->generic.y, "Гандикап", style, color );
}
	UI_DrawProportionalString( item->generic.x + 64, item->generic.y + PROP_HEIGHT, handicap_items[item->curvalue], style, color );
}
*/

/*
=================
PlayerSettings_DrawEffects
=================
*/
static void PlayerSettings_DrawEffects( void *self ) {
	menulist_s		*item;
	qboolean		focus;
	int				style;
	float			*color;

	item = (menulist_s *)self;
	focus = (item->generic.parent->cursor == item->generic.menuPosition);

	style = UI_LEFT|UI_SMALLFONT;
	color = text_color_normal;
	if( focus ) {
		style |= UI_PULSE;
		color = text_color_highlight;
	}

if(!rus.integer){
	UI_DrawProportionalString( item->generic.x, item->generic.y, "Effects", style, color );
}
if(rus.integer){
	UI_DrawProportionalString( item->generic.x, item->generic.y, "Эффекты", style, color );
}

	UI_DrawHandlePic( item->generic.x + 64, item->generic.y + 8, 128, 8, s_playersettings.fxBasePic );
	UI_DrawHandlePic( item->generic.x + 64 + item->curvalue * 16 + 8, item->generic.y + 6, 16, 12, s_playersettings.fxPic[item->curvalue] );
}

/*
=================
PlayerSettings_DrawEffects
=================
*/
static void PlayerSettings_DrawEffects2( void *self ) {
	menulist_s		*item;
	qboolean		focus;

	item = (menulist_s *)self;
	focus = (item->generic.parent->cursor == item->generic.menuPosition);

	UI_DrawHandlePic( item->generic.x + 64, item->generic.y + 8, 128, 8, s_playersettings.fxBasePic );
	UI_DrawHandlePic( item->generic.x + 64 + item->curvalue * 16 + 8, item->generic.y + 6, 16, 12, s_playersettings.fxPic[item->curvalue] );
}


/*
=================
PlayerSettings_DrawPlayer
=================
*/
static void PlayerSettings_DrawPlayer( void *self ) {
	menubitmap_s	*b;
	vec3_t			viewangles;
	char			buf[MAX_QPATH];

	trap_Cvar_VariableStringBuffer( "model", buf, sizeof( buf ) );
	if ( strcmp( buf, s_playersettings.playerModel ) != 0 ) {
		UI_PlayerInfo_SetModel( &s_playersettings.playerinfo, buf );
		strcpy( s_playersettings.playerModel, buf );

		viewangles[YAW]   = ui_playerangle.integer;
		viewangles[PITCH] = 0;
		viewangles[ROLL]  = 0;
		UI_PlayerInfo_SetInfo( &s_playersettings.playerinfo, LEGS_IDLE, TORSO_STAND2, viewangles, vec3_origin, WP_NONE, qfalse );
	}

	b = (menubitmap_s*) self;
/*	UI_DrawProportionalString( 190, 70, "Model-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 70, UI_Cvar_VariableString("model"), UI_LEFT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 190, 85, "Head-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 85, UI_Cvar_VariableString("headmodel"), UI_LEFT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 190, 100, "Legs-", UI_RIGHT|UI_SMALLFONT, text_color_normal );
	UI_DrawProportionalString( 210, 100, UI_Cvar_VariableString("ui_mslegsskin"), UI_LEFT|UI_SMALLFONT, text_color_normal );*/
	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_playersettings.playerinfo, uis.realtime/2 );
}


/*
=================
PlayerSettings_SaveChanges
=================
*/
static void PlayerSettings_SaveChanges( void ) {
	// name
	trap_Cvar_Set( "name", s_playersettings.name.field.buffer );
	
	//secret code
	trap_Cvar_Set( "ui_secretcode", s_playersettings.code.field.buffer );
	
	//hudmov
	trap_Cvar_Set( "cg_hudcord", s_playersettings.hudmov.field.buffer );

/*	// handicap
	trap_Cvar_SetValue( "handicap", 100 - s_playersettings.handicap.curvalue * 5 );*/

	// effects color
	trap_Cvar_SetValue( "color1", uitogamecode[s_playersettings.effects.curvalue] );
        
        // effects2 color
	trap_Cvar_SetValue( "color2", uitogamecode[s_playersettings.effects2.curvalue] );
}


/*
=================
PlayerSettings_MenuKey
=================
*/
static sfxHandle_t PlayerSettings_MenuKey( int key ) {
	if( key == K_MOUSE2 || key == K_ESCAPE ) {
		PlayerSettings_SaveChanges();
	}
	return Menu_DefaultKey( &s_playersettings.menu, key );
}


/*
=================
PlayerSettings_SetMenuItems
=================
*/
static void PlayerSettings_SetMenuItems( void ) {
	vec3_t	viewangles;
	int		c;
	int		h;

	// name
	Q_strncpyz( s_playersettings.name.field.buffer, UI_Cvar_VariableString("name"), sizeof(s_playersettings.name.field.buffer) );
	
	// secret code
	Q_strncpyz( s_playersettings.code.field.buffer, UI_Cvar_VariableString("ui_secretcode"), sizeof(s_playersettings.code.field.buffer) );
	
	s_playersettings.heflashred.curvalue  = trap_Cvar_VariableValue( "cg_helightred");
	
	s_playersettings.heflashgreen.curvalue  = trap_Cvar_VariableValue( "cg_helightgreen");
	
	s_playersettings.heflashblue.curvalue  = trap_Cvar_VariableValue( "cg_helightblue");

	s_playersettings.toflashred.curvalue  = trap_Cvar_VariableValue( "cg_tolightred");
	
	s_playersettings.toflashgreen.curvalue  = trap_Cvar_VariableValue( "cg_tolightgreen");
	
	s_playersettings.toflashblue.curvalue  = trap_Cvar_VariableValue( "cg_tolightblue");

	s_playersettings.flashred.curvalue  = trap_Cvar_VariableValue( "cg_plightred");
	
	s_playersettings.flashgreen.curvalue  = trap_Cvar_VariableValue( "cg_plightgreen");
	
	s_playersettings.flashblue.curvalue  = trap_Cvar_VariableValue( "cg_plightblue");
	
	s_playersettings.hetex.curvalue  = trap_Cvar_VariableValue( "cg_hetex");
	
	s_playersettings.totex.curvalue  = trap_Cvar_VariableValue( "cg_totex");
	
	s_playersettings.ptex.curvalue  = trap_Cvar_VariableValue( "cg_ptex");
	
	s_playersettings.flashradius.curvalue  = trap_Cvar_VariableValue( "cg_plightradius");
	
	s_playersettings.playerangle.curvalue  = trap_Cvar_VariableValue( "ui_playerangle");
	
	// hud moving
	Q_strncpyz( s_playersettings.hudmov.field.buffer, UI_Cvar_VariableString("cg_hudcord"), sizeof(s_playersettings.hudmov.field.buffer) );

	// effects color
	c = trap_Cvar_VariableValue( "color1" ) - 1;
	if( c < 0 || c > 6 ) {
		c = 6;
	}
	s_playersettings.effects.curvalue = gamecodetoui[c];
        
        // effects2 color
	c = trap_Cvar_VariableValue( "color2" ) - 1;
	if( c < 0 || c > 6 ) {
		c = 6;
	}
	s_playersettings.effects2.curvalue = gamecodetoui[c];

	// model/skin
	memset( &s_playersettings.playerinfo, 0, sizeof(playerInfo_t) );
	
	viewangles[YAW]   = 180 - 10;
	viewangles[PITCH] = 0;
	viewangles[ROLL]  = 0;

	UI_PlayerInfo_SetModel( &s_playersettings.playerinfo, UI_Cvar_VariableString( "model" ) );
	UI_PlayerInfo_SetInfo( &s_playersettings.playerinfo, LEGS_IDLE, TORSO_STAND2, viewangles, vec3_origin, WP_NONE, qfalse );

/*	// handicap
	h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
	s_playersettings.handicap.curvalue = 20 - h / 5;*/
}


/*
=================
PlayerSettings_MenuEvent
=================
*/
static void PlayerSettings_MenuEvent( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
/*	case ID_HANDICAP:
		trap_Cvar_Set( "handicap", va( "%i", 100 - 25 * s_playersettings.handicap.curvalue ) );
		break;*/

	case ID_MODEL:
	if( !trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "0" );
		trap_Cvar_Set( "ui_legsmodel", "0" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
	if( trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "0" );
		trap_Cvar_Set( "ui_legsmodel", "0" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
		break;
		
	case ID_HEAD:
	if( !trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "1" );
		trap_Cvar_Set( "ui_legsmodel", "0" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
	if( trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "1" );
		trap_Cvar_Set( "ui_legsmodel", "0" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
		break;
		
	case ID_LEGS:
	if( !trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "0" );
		trap_Cvar_Set( "ui_legsmodel", "1" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
	if( trap_Cvar_VariableValue( "ui_actionmenu" ) ) {
		trap_Cvar_Set( "ui_headmodel", "0" );
		trap_Cvar_Set( "ui_legsmodel", "1" );
		PlayerSettings_SaveChanges();
		UI_PlayerModelMenu(1);
	}
		break;
		
	case ID_RESET:
if(!rus.integer){
	UI_ConfirmMenu( "RESET GAME?", UI_SPLevelMenu_ResetDraw, UI_SPLevelMenu_ResetAction );
}
if(rus.integer){
	UI_ConfirmMenu( "СБРОСИТЬ ИГРУ?", UI_SPLevelMenu_ResetDraw, UI_SPLevelMenu_ResetAction );
}
		break;
		
	case ID_FLASHRED:
		trap_Cvar_SetValue( "cg_plightred", s_playersettings.flashred.curvalue);
		break;
		
	case ID_FLASHGREEN:
		trap_Cvar_SetValue( "cg_plightgreen", s_playersettings.flashgreen.curvalue);
		break;
		
	case ID_FLASHBLUE:
		trap_Cvar_SetValue( "cg_plightblue", s_playersettings.flashblue.curvalue);
		break;
		
	case ID_TOFLASHRED:
		trap_Cvar_SetValue( "cg_tolightred", s_playersettings.toflashred.curvalue);
		break;
		
	case ID_TOFLASHGREEN:
		trap_Cvar_SetValue( "cg_tolightgreen", s_playersettings.toflashgreen.curvalue);
		break;
		
	case ID_TOFLASHBLUE:
		trap_Cvar_SetValue( "cg_tolightblue", s_playersettings.toflashblue.curvalue);
		break;
		
	case ID_HETEX:
		trap_Cvar_SetValue( "cg_hetex", s_playersettings.hetex.curvalue);
		break;
		
	case ID_TOTEX:
		trap_Cvar_SetValue( "cg_totex", s_playersettings.totex.curvalue);
		break;
		
	case ID_PTEX:
		trap_Cvar_SetValue( "cg_ptex", s_playersettings.ptex.curvalue);
		break;
		
	case ID_HEFLASHRED:
		trap_Cvar_SetValue( "cg_helightred", s_playersettings.heflashred.curvalue);
		break;
		
	case ID_HEFLASHGREEN:
		trap_Cvar_SetValue( "cg_helightgreen", s_playersettings.heflashgreen.curvalue);
		break;
		
	case ID_HEFLASHBLUE:
		trap_Cvar_SetValue( "cg_helightblue", s_playersettings.heflashblue.curvalue);
		break;
		
	case ID_FLASHRADIUS:
		trap_Cvar_SetValue( "cg_plightradius", s_playersettings.flashradius.curvalue);
		break;
		
	case ID_PLAYERANGLE:
		trap_Cvar_SetValue( "ui_playerangle", s_playersettings.playerangle.curvalue);
		break;

	case ID_BACK:
		PlayerSettings_SaveChanges();
		UI_PopMenu();
		break;
	}
}

/*
=================
PlayerSettings_StatusBar
=================
*/
/*static void PlayerSettings_StatusBar( void* ptr ) {
if(!rus.integer){
	UI_DrawString( 320, 400, "Lower handicap makes you weaker", UI_CENTER|UI_SMALLFONT, colorWhite );
    UI_DrawString( 320, 420, "giving you more challenge", UI_CENTER|UI_SMALLFONT, colorWhite );
}
if(rus.integer){
	UI_DrawString( 320, 400, "Низкий гандикап делает вас слабее", UI_CENTER|UI_SMALLFONT, colorWhite );
    UI_DrawString( 320, 420, "давая вам больше сложности в игре", UI_CENTER|UI_SMALLFONT, colorWhite );
}
}*/

/*
=================
PlayerSettings_MenuInit
=================
*/
static void PlayerSettings_MenuInit( void ) {
	int		y;

	memset(&s_playersettings,0,sizeof(playersettings_t));
//	trap_Cvar_SetValue( "handicap", "100" );

	PlayerSettings_Cache();

	s_playersettings.menu.key        = PlayerSettings_MenuKey;
	s_playersettings.menu.wrapAround = qtrue;
	s_playersettings.menu.fullscreen = qtrue;

	s_playersettings.banner.generic.type  = MTYPE_BTEXT;
	s_playersettings.banner.generic.x     = 320;
	s_playersettings.banner.generic.y     = 5;
if(!rus.integer){
	s_playersettings.banner.string        = "PLAYER SETTINGS";
}
if(rus.integer){
	s_playersettings.banner.string        = "НАСТРОЙКИ ИГРОКА";
}
	s_playersettings.banner.color         = color_white;
	s_playersettings.banner.style         = UI_CENTER;
	

	s_playersettings.framel.generic.type  = MTYPE_BITMAP;
	s_playersettings.framel.generic.name  = ART_FRAMEL;
	s_playersettings.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_playersettings.framel.generic.x     = 0;
	s_playersettings.framel.generic.y     = 78;
	s_playersettings.framel.width         = 256;
	s_playersettings.framel.height        = 329;

	s_playersettings.framer.generic.type  = MTYPE_BITMAP;
	s_playersettings.framer.generic.name  = ART_FRAMER;
	s_playersettings.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_playersettings.framer.generic.x     = 376;
	s_playersettings.framer.generic.y     = 76;
	s_playersettings.framer.width         = 256;
	s_playersettings.framer.height        = 334;

	y = 110;
	s_playersettings.name.generic.type			= MTYPE_FIELD;
	s_playersettings.name.generic.flags			= QMF_NODEFAULTINIT;
	s_playersettings.name.generic.ownerdraw		= PlayerSettings_DrawName;
	s_playersettings.name.field.widthInChars	= MAX_NAMELENGTH;
	s_playersettings.name.field.maxchars		= MAX_NAMELENGTH;
	s_playersettings.name.generic.x				= 192;
	s_playersettings.name.generic.y				= y;
	s_playersettings.name.generic.left			= 192 - 8;
	s_playersettings.name.generic.top			= y;
	s_playersettings.name.generic.right			= 192 + 200;
	s_playersettings.name.generic.bottom		= y + 25;
	
	s_playersettings.code.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	s_playersettings.code.generic.name		= "Secret Code:";
	}
	if(rus.integer){
	s_playersettings.code.generic.name		= "Секретный код:";
	}
	s_playersettings.code.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.code.generic.x			= 400;
	s_playersettings.code.generic.y			= 25;
	s_playersettings.code.field.widthInChars = 6;
	s_playersettings.code.field.maxchars     = 6;
		
	s_playersettings.head.generic.type			= MTYPE_PTEXT;
	if(!rus.integer){
	s_playersettings.head.string		= "Select head";
	}
	if(rus.integer){
	s_playersettings.head.string		= "Выбор головы";
	}
	s_playersettings.head.generic.flags		= QMF_CENTER_JUSTIFY;
	s_playersettings.head.generic.id			= ID_HEAD;
	s_playersettings.head.generic.callback		= PlayerSettings_MenuEvent;
	s_playersettings.head.generic.x			= 400;
	s_playersettings.head.generic.y			= 45;
	s_playersettings.head.color				= color_red;
	

	s_playersettings.legs.generic.type			= MTYPE_PTEXT;
	if(!rus.integer){
	s_playersettings.legs.string		= "Select legs";
	}
	if(rus.integer){
	s_playersettings.legs.string		= "Выбор ног";
	}
	s_playersettings.legs.generic.flags		= QMF_CENTER_JUSTIFY;
	s_playersettings.legs.generic.id			= ID_LEGS;
	s_playersettings.legs.generic.callback		= PlayerSettings_MenuEvent;
	s_playersettings.legs.generic.x			= 50;
	s_playersettings.legs.generic.y			= 45;
	s_playersettings.legs.color				= color_red;
	
	
	s_playersettings.reset.generic.type			= MTYPE_PTEXT;
	if(!rus.integer){
	s_playersettings.reset.string		= "Progress reset";
	}
	if(rus.integer){
	s_playersettings.reset.string		= "Сброс прогресса";
	}
	s_playersettings.reset.generic.flags		= QMF_CENTER_JUSTIFY;
	s_playersettings.reset.generic.id			= ID_RESET;
	s_playersettings.reset.generic.callback		= PlayerSettings_MenuEvent;
	s_playersettings.reset.generic.x			= 50;
	s_playersettings.reset.generic.y			= 70;
	s_playersettings.reset.color				= color_red;
	
	

/*	y += 3 * PROP_HEIGHT;
	s_playersettings.handicap.generic.type		= MTYPE_SPINCONTROL;
	s_playersettings.handicap.generic.flags		= QMF_NODEFAULTINIT;
	s_playersettings.handicap.generic.id		= ID_HANDICAP;
	s_playersettings.handicap.generic.ownerdraw	= PlayerSettings_DrawHandicap;
	s_playersettings.handicap.generic.x			= 192;
	s_playersettings.handicap.generic.y			= y;
	s_playersettings.handicap.generic.left		= 192 - 8;
	s_playersettings.handicap.generic.top		= y - 8;
	s_playersettings.handicap.generic.right		= 192 + 200;
	s_playersettings.handicap.generic.bottom	= y + 2 * PROP_HEIGHT;
        s_playersettings.handicap.generic.statusbar     = PlayerSettings_StatusBar;
	s_playersettings.handicap.numitems			= 20;*/

	y += 30;
	s_playersettings.effects.generic.type		= MTYPE_SPINCONTROL;
	s_playersettings.effects.generic.flags		= QMF_NODEFAULTINIT;
	s_playersettings.effects.generic.id			= ID_EFFECTS;
	s_playersettings.effects.generic.ownerdraw	= PlayerSettings_DrawEffects;
	s_playersettings.effects.generic.x			= 192;
	s_playersettings.effects.generic.y			= y;
	s_playersettings.effects.generic.left		= 192 - 8;
	s_playersettings.effects.generic.top		= y;
	s_playersettings.effects.generic.right		= 192 + 200;
	s_playersettings.effects.generic.bottom		= y + 25;
	s_playersettings.effects.numitems			= 7;
        
        y += 20;
	s_playersettings.effects2.generic.type		= MTYPE_SPINCONTROL;
	s_playersettings.effects2.generic.flags		= QMF_NODEFAULTINIT;
	s_playersettings.effects2.generic.id			= ID_EFFECTS2;
	s_playersettings.effects2.generic.ownerdraw	= PlayerSettings_DrawEffects2;
	s_playersettings.effects2.generic.x			= 192;
	s_playersettings.effects2.generic.y			= y;
	s_playersettings.effects2.generic.left		= 192 - 8;
	s_playersettings.effects2.generic.top		= y;
	s_playersettings.effects2.generic.right		= 192 + 200;
	s_playersettings.effects2.generic.bottom		= y + 25;
	s_playersettings.effects2.numitems			= 7;

	s_playersettings.model.generic.type			= MTYPE_BITMAP;
	s_playersettings.model.generic.name			= ART_MODEL0;
	s_playersettings.model.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_playersettings.model.generic.id			= ID_MODEL;
	s_playersettings.model.generic.callback		= PlayerSettings_MenuEvent;
	s_playersettings.model.generic.x			= 640;
	s_playersettings.model.generic.y			= 480-64;
	s_playersettings.model.width				= 128;
	s_playersettings.model.height				= 64;
	s_playersettings.model.focuspic				= ART_MODEL1;

y = 190;
	s_playersettings.hudmov.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	s_playersettings.hudmov.generic.name		= "Hud Move:";
	}
	if(rus.integer){
	s_playersettings.hudmov.generic.name		= "Передвижение Hud:";
	}
	s_playersettings.hudmov.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.hudmov.generic.x			= 320;
	s_playersettings.hudmov.generic.y			= y;
	s_playersettings.hudmov.field.widthInChars = 4;
	s_playersettings.hudmov.field.maxchars     = 4;
	
//    y += BIGCHAR_HEIGHT+2;
    s_playersettings.flashred.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.flashred.generic.name		= "Legs cpm red:";
	}
	if(rus.integer){
	s_playersettings.flashred.generic.name		= "Ноги cpm красный:";
	}
	s_playersettings.flashred.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.flashred.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.flashred.generic.id		= ID_FLASHRED;
	s_playersettings.flashred.generic.x			= 320;
	s_playersettings.flashred.generic.y			= y;
	s_playersettings.flashred.minvalue			= 0.0f;
	s_playersettings.flashred.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.flashgreen.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.flashgreen.generic.name		= "Legs cpm green:";
	}
	if(rus.integer){
	s_playersettings.flashgreen.generic.name		= "Ноги cpm зелёный:";
	}
	s_playersettings.flashgreen.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.flashgreen.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.flashgreen.generic.id			= ID_FLASHGREEN;
	s_playersettings.flashgreen.generic.x			= 320;
	s_playersettings.flashgreen.generic.y			= y;
	s_playersettings.flashgreen.minvalue			= 0.0f;
	s_playersettings.flashgreen.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.flashblue.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.flashblue.generic.name		= "Legs cpm blue:";
	}
	if(rus.integer){
	s_playersettings.flashblue.generic.name		= "Ноги cpm синий:";
	}
	s_playersettings.flashblue.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.flashblue.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.flashblue.generic.id		= ID_FLASHBLUE;
	s_playersettings.flashblue.generic.x			= 320;
	s_playersettings.flashblue.generic.y			= y;
	s_playersettings.flashblue.minvalue			= 0;
	s_playersettings.flashblue.maxvalue			= 255;
	
    y += BIGCHAR_HEIGHT+2;
    s_playersettings.toflashred.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.toflashred.generic.name		= "Torso cpm red:";
	}
	if(rus.integer){
	s_playersettings.toflashred.generic.name		= "Торс cpm красный:";
	}
	s_playersettings.toflashred.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.toflashred.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.toflashred.generic.id		= ID_TOFLASHRED;
	s_playersettings.toflashred.generic.x			= 320;
	s_playersettings.toflashred.generic.y			= y;
	s_playersettings.toflashred.minvalue			= 0.0f;
	s_playersettings.toflashred.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.toflashgreen.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.toflashgreen.generic.name		= "Torso cpm green:";
	}
	if(rus.integer){
	s_playersettings.toflashgreen.generic.name		= "Торс cpm зелёный:";
	}
	s_playersettings.toflashgreen.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.toflashgreen.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.toflashgreen.generic.id			= ID_TOFLASHGREEN;
	s_playersettings.toflashgreen.generic.x			= 320;
	s_playersettings.toflashgreen.generic.y			= y;
	s_playersettings.toflashgreen.minvalue			= 0.0f;
	s_playersettings.toflashgreen.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.toflashblue.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.toflashblue.generic.name		= "Torso cpm blue:";
	}
	if(rus.integer){
	s_playersettings.toflashblue.generic.name		= "Торс cpm синий:";
	}
	s_playersettings.toflashblue.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.toflashblue.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.toflashblue.generic.id		= ID_TOFLASHBLUE;
	s_playersettings.toflashblue.generic.x			= 320;
	s_playersettings.toflashblue.generic.y			= y;
	s_playersettings.toflashblue.minvalue			= 0;
	s_playersettings.toflashblue.maxvalue			= 255;
	
    y += BIGCHAR_HEIGHT+2;
    s_playersettings.heflashred.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.heflashred.generic.name		= "Head cpm red:";
	}
	if(rus.integer){
	s_playersettings.heflashred.generic.name		= "Голова cpm красный:";
	}
	s_playersettings.heflashred.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.heflashred.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.heflashred.generic.id		= ID_HEFLASHRED;
	s_playersettings.heflashred.generic.x			= 320;
	s_playersettings.heflashred.generic.y			= y;
	s_playersettings.heflashred.minvalue			= 0.0f;
	s_playersettings.heflashred.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.heflashgreen.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.heflashgreen.generic.name		= "Head cpm green:";
	}
	if(rus.integer){
	s_playersettings.heflashgreen.generic.name		= "Голова cpm зелёный:";
	}
	s_playersettings.heflashgreen.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.heflashgreen.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.heflashgreen.generic.id			= ID_HEFLASHGREEN;
	s_playersettings.heflashgreen.generic.x			= 320;
	s_playersettings.heflashgreen.generic.y			= y;
	s_playersettings.heflashgreen.minvalue			= 0.0f;
	s_playersettings.heflashgreen.maxvalue			= 255;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.heflashblue.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.heflashblue.generic.name		= "Head cpm blue:";
	}
	if(rus.integer){
	s_playersettings.heflashblue.generic.name		= "Голова cpm синий:";
	}
	s_playersettings.heflashblue.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.heflashblue.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.heflashblue.generic.id		= ID_HEFLASHBLUE;
	s_playersettings.heflashblue.generic.x			= 320;
	s_playersettings.heflashblue.generic.y			= y;
	s_playersettings.heflashblue.minvalue			= 0;
	s_playersettings.heflashblue.maxvalue			= 255;
	
    y += BIGCHAR_HEIGHT+2;
    s_playersettings.hetex.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.hetex.generic.name		= "Head tex:";
	}
	if(rus.integer){
	s_playersettings.hetex.generic.name		= "Голова tex:";
	}
	s_playersettings.hetex.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.hetex.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.hetex.generic.id		= ID_HETEX;
	s_playersettings.hetex.generic.x			= 320;
	s_playersettings.hetex.generic.y			= y;
	s_playersettings.hetex.minvalue			= 0.0f;
	s_playersettings.hetex.maxvalue			= 153;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.totex.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.totex.generic.name		= "Torso tex:";
	}
	if(rus.integer){
	s_playersettings.totex.generic.name		= "Торс tex:";
	}
	s_playersettings.totex.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.totex.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.totex.generic.id			= ID_TOTEX;
	s_playersettings.totex.generic.x			= 320;
	s_playersettings.totex.generic.y			= y;
	s_playersettings.totex.minvalue			= 0.0f;
	s_playersettings.totex.maxvalue			= 153;

        y += BIGCHAR_HEIGHT+2;
    s_playersettings.ptex.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.ptex.generic.name		= "Legs tex:";
	}
	if(rus.integer){
	s_playersettings.ptex.generic.name		= "Ноги tex:";
	}
	s_playersettings.ptex.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.ptex.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.ptex.generic.id		= ID_PTEX;
	s_playersettings.ptex.generic.x			= 320;
	s_playersettings.ptex.generic.y			= y;
	s_playersettings.ptex.minvalue			= 0;
	s_playersettings.ptex.maxvalue			= 153;
	
        y += BIGCHAR_HEIGHT+5;
    s_playersettings.flashradius.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.flashradius.generic.name		= "Flashlight radius:";
	}
	if(rus.integer){
	s_playersettings.flashradius.generic.name		= "Фонарик мощность:";
	}
	s_playersettings.flashradius.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.flashradius.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.flashradius.generic.id		= ID_FLASHRADIUS;
	s_playersettings.flashradius.generic.x			= 320;
	s_playersettings.flashradius.generic.y			= y;
	s_playersettings.flashradius.minvalue			= 0;
	s_playersettings.flashradius.maxvalue			= 100;

	s_playersettings.player.generic.type		= MTYPE_BITMAP;
	s_playersettings.player.generic.flags		= QMF_INACTIVE;
	s_playersettings.player.generic.ownerdraw	= PlayerSettings_DrawPlayer;
	s_playersettings.player.generic.x			= 400;
	s_playersettings.player.generic.y			= -40;
	s_playersettings.player.width				= 32*10;
	s_playersettings.player.height				= 56*10;
	
        y += BIGCHAR_HEIGHT+12;
    s_playersettings.playerangle.generic.type		= MTYPE_SLIDER;
	if(!rus.integer){
	s_playersettings.playerangle.generic.name		= "Angle:";
	}
	if(rus.integer){
	s_playersettings.playerangle.generic.name		= "Угол поворота:";
	}
	s_playersettings.playerangle.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	s_playersettings.playerangle.generic.callback	= PlayerSettings_MenuEvent;
	s_playersettings.playerangle.generic.id		= ID_PLAYERANGLE;
	s_playersettings.playerangle.generic.x			= 400;
	s_playersettings.playerangle.generic.y			= 390;
	s_playersettings.playerangle.minvalue			= 0;
	s_playersettings.playerangle.maxvalue			= 360;

	s_playersettings.back.generic.type			= MTYPE_BITMAP;
	s_playersettings.back.generic.name			= ART_BACK0;
	s_playersettings.back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_playersettings.back.generic.id			= ID_BACK;
	s_playersettings.back.generic.callback		= PlayerSettings_MenuEvent;
	s_playersettings.back.generic.x				= 0;
	s_playersettings.back.generic.y				= 480-64;
	s_playersettings.back.width					= 128;
	s_playersettings.back.height				= 64;
	s_playersettings.back.focuspic				= ART_BACK1;

	s_playersettings.item_null.generic.type		= MTYPE_BITMAP;
	s_playersettings.item_null.generic.flags	= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
	s_playersettings.item_null.generic.x		= 0;
	s_playersettings.item_null.generic.y		= 0;
	s_playersettings.item_null.width			= 640;
	s_playersettings.item_null.height			= 480;

	Menu_AddItem( &s_playersettings.menu, &s_playersettings.banner );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.framel );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.framer );

	Menu_AddItem( &s_playersettings.menu, &s_playersettings.name );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.code );
//	Menu_AddItem( &s_playersettings.menu, &s_playersettings.hudmov );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.head );
//	if(trap_Cvar_VariableValue( "cg_forcemodel" ) == 1){
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.legs );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.reset );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.flashred );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.flashgreen );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.flashblue );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.heflashred );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.heflashgreen );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.heflashblue );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.toflashred );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.toflashgreen );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.toflashblue );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.hetex );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.totex );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.ptex );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.flashradius );
//	Menu_AddItem( &s_playersettings.menu, &s_playersettings.playerangle );
//}
//	Menu_AddItem( &s_playersettings.menu, &s_playersettings.handicap );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.effects );
    Menu_AddItem( &s_playersettings.menu, &s_playersettings.effects2 );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.model );
	Menu_AddItem( &s_playersettings.menu, &s_playersettings.back );

	Menu_AddItem( &s_playersettings.menu, &s_playersettings.player );

	Menu_AddItem( &s_playersettings.menu, &s_playersettings.item_null );

	PlayerSettings_SetMenuItems();
}


/*
=================
PlayerSettings_Cache
=================
*/
void PlayerSettings_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
	trap_R_RegisterShaderNoMip( ART_MODEL0 );
	trap_R_RegisterShaderNoMip( ART_MODEL1 );
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );

	s_playersettings.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
	s_playersettings.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
	s_playersettings.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
	s_playersettings.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
	s_playersettings.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
	s_playersettings.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
	s_playersettings.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
	s_playersettings.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
}


/*
=================
UI_PlayerSettingsMenu
=================
*/
void UI_PlayerSettingsMenu( void ) {
	PlayerSettings_MenuInit();
	UI_PushMenu( &s_playersettings.menu );
}
