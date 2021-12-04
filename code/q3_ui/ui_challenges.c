/*
===========================================================================
Copyright (C) 2008-2009 Poul Sander

This file is part of the Open Arena source code.

Open Arena source code is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

Open Arena source code is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Open Arena source code; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/

#include "ui_local.h"
#include "../game/challenges.h"

//This is an ugly way of syncing to cgame but it is platform compatible
#define PARTofUI 1
#include "../cgame/cg_challenges.c"

#define ID_BACK                         1

//Main menu:
#define ID_GENERAL			100
#define ID_GAMETYPES                    101
#define ID_WEAPONS                      102
#define ID_AWARDS                       103
#define ID_POWERUPS                     104
#define ID_FFA                          105
#define ID_CWRITE                          166
#define ID_CVARLIST1                          106
#define ID_CVARLIST2                          107
#define ID_CVARLIST3                          108
#define ID_CVARLIST4                          109
#define ID_CVARLIST5                          110
#define ID_CVARLIST6                          111
#define ID_CVARLIST7                          112
#define ID_CVARLIST8                          113
#define ID_CVARLIST9                          114
#define ID_CVARLIST10                          115

#define ART_BACK0		"menu/art_blueish/back_0"
#define ART_BACK1		"menu/art_blueish/back_1"
#define ART_FRAMEL		"menu/art_blueish/frame2_l"
#define ART_FRAMER		"menu/art_blueish/frame1_r"

#define MAX_ENTRIES                     18
#define MAX_INT_AS_STRING               8

typedef struct {
	menuframework_s	menu;

	menutext_s	banner;
	menubitmap_s	framel;
	menubitmap_s	framer;

	menutext_s	general;
	menutext_s	gametypes;
	menutext_s      weapons;
        menutext_s      awards;
        menutext_s      powerups;
        menutext_s      cvarlist1;
        menutext_s      cvarlist2;
        menutext_s      cvarlist3;
        menutext_s      cvarlist4;
        menutext_s      cvarlist5;
        menutext_s      cvarlist6;
        menutext_s      cvarlist7;
        menutext_s      cvarlist8;
        menutext_s      cvarlist9;
        menutext_s      cvarlist10;

        int             numberOfEntries;
        menutext_s	entry[MAX_ENTRIES];
        menutext_s	entryIntText[MAX_ENTRIES];
        char            entryIntString[MAX_ENTRIES][MAX_INT_AS_STRING];
        int             entryInt[MAX_ENTRIES];

        menutext_s      notice;
        menutext_s      notice2;
		menufield_s			cname;
		menufield_s			cvalue;
		menutext_s      	cwrite;
	menubitmap_s	back;
} challenges_t;

static challenges_t challenges;

static int             mainSelection;

//This should only be accessed locally
void UI_ChallengesLocal( void );

/*
=================
UI_Challenges_Event
=================
*/
static void UI_Challenges_Event( void* ptr, int event ) {
	if( event != QM_ACTIVATED ) {
		return;
	}

	switch( ((menucommon_s*)ptr)->id ) {
	case ID_GENERAL:
            mainSelection = 0;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

	case ID_GAMETYPES:
            mainSelection = 1;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

	case ID_WEAPONS:
            mainSelection = 2;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

	case ID_AWARDS:
            mainSelection = 3;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_POWERUPS:
            mainSelection = 4;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CWRITE:
		challengeswritecvar();
		break;

        case ID_CVARLIST1:
            mainSelection = 5;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST2:
            mainSelection = 6;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST3:
            mainSelection = 7;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST4:
            mainSelection = 8;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST5:
            mainSelection = 9;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST6:
            mainSelection = 10;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST7:
            mainSelection = 11;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST8:
            mainSelection = 12;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST9:
            mainSelection = 13;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;

        case ID_CVARLIST10:
            mainSelection = 14;
            UI_PopMenu();
            UI_ChallengesLocal();
		break;


        case ID_FFA:
		break;

	case ID_BACK:
		UI_PopMenu();
		break;
	}
}

/*
===============
UI_Challenges_Cache
===============
*/
void UI_Challenges_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_FRAMEL );
	trap_R_RegisterShaderNoMip( ART_FRAMER );
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
}

static void challengeswritecvar( void ) {

	trap_Cvar_Set( challenges.cname.field.buffer, challenges.cvalue.field.buffer );

}

/*
===============
UI_Challenges_Init
===============
*/
static void UI_Challenges_Init( void ) {
    int y,i;

	memset( &challenges, 0, sizeof(challenges) );

	UI_DisplayOptionsMenu_Cache();
	challenges.menu.wrapAround = qtrue;
	challenges.menu.fullscreen = qtrue;

	challenges.banner.generic.type		= MTYPE_BTEXT;
	challenges.banner.generic.flags		= QMF_CENTER_JUSTIFY;
	challenges.banner.generic.x			= 320;
	challenges.banner.generic.y			= 16;
	challenges.banner.string			= "STATISTICS";
	challenges.banner.color				= color_white;
	challenges.banner.style				= UI_CENTER;

	challenges.framel.generic.type		= MTYPE_BITMAP;
	challenges.framel.generic.name		= ART_FRAMEL;
	challenges.framel.generic.flags		= QMF_INACTIVE;
	challenges.framel.generic.x			= 0;
	challenges.framel.generic.y			= 78;
	challenges.framel.width				= 256;
	challenges.framel.height			= 329;

	challenges.framer.generic.type		= MTYPE_BITMAP;
	challenges.framer.generic.name		= ART_FRAMER;
	challenges.framer.generic.flags		= QMF_INACTIVE;
	challenges.framer.generic.x			= 376;
	challenges.framer.generic.y			= 76;
	challenges.framer.width				= 256;
	challenges.framer.height			= 334;

    challenges.cvarlist1.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist1.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist1.generic.id			= ID_CVARLIST1;
	challenges.cvarlist1.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist1.generic.x			= 216;
	challenges.cvarlist1.generic.y			= 25;
	challenges.cvarlist1.string				= "CVARLIST 1";
	challenges.cvarlist1.style				= UI_RIGHT;
	challenges.cvarlist1.color				= color_red;

    challenges.cvarlist2.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist2.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist2.generic.id			= ID_CVARLIST2;
	challenges.cvarlist2.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist2.generic.x			= 216;
	challenges.cvarlist2.generic.y			= 50;
	challenges.cvarlist2.string				= "CVARLIST 2";
	challenges.cvarlist2.style				= UI_RIGHT;
	challenges.cvarlist2.color				= color_red;

    challenges.cvarlist3.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist3.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist3.generic.id			= ID_CVARLIST3;
	challenges.cvarlist3.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist3.generic.x			= 216;
	challenges.cvarlist3.generic.y			= 75;
	challenges.cvarlist3.string				= "CVARLIST 3";
	challenges.cvarlist3.style				= UI_RIGHT;
	challenges.cvarlist3.color				= color_red;

    challenges.cvarlist4.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist4.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist4.generic.id			= ID_CVARLIST4;
	challenges.cvarlist4.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist4.generic.x			= 216;
	challenges.cvarlist4.generic.y			= 100;
	challenges.cvarlist4.string				= "CVARLIST 4";
	challenges.cvarlist4.style				= UI_RIGHT;
	challenges.cvarlist4.color				= color_red;

    challenges.cvarlist5.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist5.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist5.generic.id			= ID_CVARLIST5;
	challenges.cvarlist5.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist5.generic.x			= 216;
	challenges.cvarlist5.generic.y			= 125;
	challenges.cvarlist5.string				= "CVARLIST 5";
	challenges.cvarlist5.style				= UI_RIGHT;
	challenges.cvarlist5.color				= color_red;

    challenges.cvarlist6.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist6.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist6.generic.id			= ID_CVARLIST6;
	challenges.cvarlist6.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist6.generic.x			= 216;
	challenges.cvarlist6.generic.y			= 150;
	challenges.cvarlist6.string				= "CVARLIST 6";
	challenges.cvarlist6.style				= UI_RIGHT;
	challenges.cvarlist6.color				= color_red;

    challenges.cvarlist7.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist7.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist7.generic.id			= ID_CVARLIST7;
	challenges.cvarlist7.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist7.generic.x			= 216;
	challenges.cvarlist7.generic.y			= 175;
	challenges.cvarlist7.string				= "CVARLIST 7";
	challenges.cvarlist7.style				= UI_RIGHT;
	challenges.cvarlist7.color				= color_red;

    challenges.cvarlist8.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist8.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist8.generic.id			= ID_CVARLIST8;
	challenges.cvarlist8.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist8.generic.x			= 216;
	challenges.cvarlist8.generic.y			= 200;
	challenges.cvarlist8.string				= "CVARLIST 8";
	challenges.cvarlist8.style				= UI_RIGHT;
	challenges.cvarlist8.color				= color_red;

    challenges.cvarlist9.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist9.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist9.generic.id			= ID_CVARLIST9;
	challenges.cvarlist9.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist9.generic.x			= 216;
	challenges.cvarlist9.generic.y			= 225;
	challenges.cvarlist9.string				= "CVARLIST 9";
	challenges.cvarlist9.style				= UI_RIGHT;
	challenges.cvarlist9.color				= color_red;

    challenges.cvarlist10.generic.type		= MTYPE_PTEXT;
	challenges.cvarlist10.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cvarlist10.generic.id			= ID_CVARLIST10;
	challenges.cvarlist10.generic.callback	= UI_Challenges_Event;
	challenges.cvarlist10.generic.x			= 216;
	challenges.cvarlist10.generic.y			= 250;
	challenges.cvarlist10.string			= "CVARLIST 10";
	challenges.cvarlist10.style				= UI_RIGHT;
	challenges.cvarlist10.color				= color_red;

        challenges.general.generic.type		= MTYPE_PTEXT;
	challenges.general.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.general.generic.id			= ID_GENERAL;
	challenges.general.generic.callback	= UI_Challenges_Event;
	challenges.general.generic.x			= 216;
	challenges.general.generic.y			= 270;
	challenges.general.string				= "GENERAL";
	challenges.general.style				= UI_RIGHT;
	challenges.general.color				= color_red;

	challenges.gametypes.generic.type			= MTYPE_PTEXT;
	challenges.gametypes.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.gametypes.generic.id			= ID_GAMETYPES;
	challenges.gametypes.generic.callback		= UI_Challenges_Event;
	challenges.gametypes.generic.x			= 216;
	challenges.gametypes.generic.y			= 390;
	challenges.gametypes.string				= "INFORMATION";
	challenges.gametypes.style				= UI_RIGHT;
	challenges.gametypes.color				= color_red;

	challenges.weapons.generic.type			= MTYPE_PTEXT;
	challenges.weapons.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.weapons.generic.id				= ID_WEAPONS;
	challenges.weapons.generic.callback		= UI_Challenges_Event;
	challenges.weapons.generic.x				= 216;
	challenges.weapons.generic.y				= 360;
	challenges.weapons.string					= "WEAPONS";
	challenges.weapons.style					= UI_RIGHT;
	challenges.weapons.color					= color_red;

	challenges.awards.generic.type			= MTYPE_PTEXT;
	challenges.awards.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.awards.generic.id			= ID_AWARDS;
	challenges.awards.generic.callback		= UI_Challenges_Event;
	challenges.awards.generic.x			= 216;
	challenges.awards.generic.y			= 330;
	challenges.awards.string				= "AWARDS";
	challenges.awards.style				= UI_RIGHT;
	challenges.awards.color				= color_red;

    challenges.powerups.generic.type			= MTYPE_PTEXT;
	challenges.powerups.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.powerups.generic.id			= ID_POWERUPS;
	challenges.powerups.generic.callback		= UI_Challenges_Event;
	challenges.powerups.generic.x			= 216;
	challenges.powerups.generic.y			= 300;
	challenges.powerups.string				= "POWERUPS";
	challenges.powerups.style				= UI_RIGHT;
	challenges.powerups.color				= color_red;

	challenges.cname.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	challenges.cname.generic.name		= "Cvar name:";
	}
	if(rus.integer){
	challenges.cname.generic.name		= "Cvar имя:";
	}
	challenges.cname.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	challenges.cname.generic.x			= 300;
	challenges.cname.generic.y			= 410;
	challenges.cname.field.widthInChars = 32;
	challenges.cname.field.maxchars     = 32;

	challenges.cvalue.generic.type		= MTYPE_FIELD;
	if(!rus.integer){
	challenges.cvalue.generic.name		= "Cvar value:";
	}
	if(rus.integer){
	challenges.cvalue.generic.name		= "Cvar значение:";
	}
	challenges.cvalue.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
	challenges.cvalue.generic.x			= 300;
	challenges.cvalue.generic.y			= 425;
	challenges.cvalue.field.widthInChars = 32;
	challenges.cvalue.field.maxchars     = 32;

	challenges.cwrite.generic.type			= MTYPE_PTEXT;
	challenges.cwrite.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.cwrite.generic.id			= ID_CWRITE;
	challenges.cwrite.generic.callback		= UI_Challenges_Event;
	challenges.cwrite.generic.x			= 300;
	challenges.cwrite.generic.y			= 445;
	if(!rus.integer){
	challenges.cwrite.string				= "WRITE CVAR";
	}
	if(rus.integer){
	challenges.cwrite.string				= "ЗАПИСАТЬ CVAR";
	}
	challenges.cwrite.style				= UI_RIGHT;
	challenges.cwrite.color				= color_red;

        /*challenges.notice.generic.type          = MTYPE_TEXT;
        challenges.notice.generic.flags	= QMF_CENTER_JUSTIFY|QMF_INACTIVE|QMF_SMALLFONT;
        challenges.notice.generic.x     = 160;
        challenges.notice.generic.y     = 430;
        challenges.notice.string        = "Only results against";

        challenges.notice2.generic.type          = MTYPE_TEXT;
        challenges.notice2.generic.flags	= QMF_CENTER_JUSTIFY|QMF_INACTIVE|QMF_SMALLFONT;
        challenges.notice2.generic.x     = 160;
        challenges.notice2.generic.y     = 430+PROP_HEIGHT-10;
        challenges.notice2.string        = "humans are counted";*/

        challenges.back.generic.type		= MTYPE_BITMAP;
	challenges.back.generic.name		= ART_BACK0;
	challenges.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	challenges.back.generic.callback	= UI_Challenges_Event;
	challenges.back.generic.id			= ID_BACK;
	challenges.back.generic.x			= 0;
	challenges.back.generic.y			= 480-64;
	challenges.back.width				= 128;
	challenges.back.height				= 64;
	challenges.back.focuspic			= ART_BACK1;

if(!rus.integer){
        switch(mainSelection)
        {
            case 0:
                //generel
                challenges.entry[0].string          = "Kills:";
                challenges.entry[1].string          = "Deaths:";
                challenges.entry[2].string          = "Active:";
                challenges.entry[3].string          = "Money:";
                challenges.numberOfEntries = 4;
                challenges.entryInt[0]              = getChallenge(GENERAL_TOTALKILLS);
                challenges.entryInt[1]              = getChallenge(GENERAL_TOTALDEATHS);
                challenges.entryInt[2]              = getChallenge(GENERAL_TEST);
                challenges.entryInt[3]              = getChallenge(GENERAL_MONEY);
                challenges.general.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 1:
                //gametypes
                challenges.numberOfEntries = 13;
								challenges.entry[0].string          = "Play Single Player";
                challenges.entry[1].string          = "to unlock player skins";
                challenges.entry[2].string          = "Secret codes";
                challenges.entry[3].string          = "finding in map";
                challenges.entry[4].string          = "zzzsecret1 and zzzsecret2.";
                challenges.entry[5].string          = "Play multiplayer";
                challenges.entry[6].string          = "using internet,lan cable";
                challenges.entry[7].string          = "Wi-Fi,Usb cable for";
                challenges.entry[8].string          = "android phone.";
                challenges.entry[9].string          = "UserTracks is folder for";
                challenges.entry[10].string          = "you music,music must be WAV";
                challenges.entry[11].string          = "rename like 1.wav 2.wav 3.wav";
                challenges.entry[12].string          = "1-50 tracks.";
                challenges.gametypes.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 2:
                //weapons
                challenges.entry[0].string          = "Gauntlet kills:";
                challenges.entry[1].string          = "Machinegun kills:";
                challenges.entry[2].string          = "Shotgun kills:";
                challenges.entry[3].string          = "Granade kills:";
                challenges.entry[4].string          = "Rocket kills:";
                challenges.entry[5].string          = "Lightning kills:";
                challenges.entry[6].string          = "Plasmagun kills:";
                challenges.entry[7].string          = "Railgun kills:";
                challenges.entry[8].string          = "Instant rail kills:";
                challenges.entry[9].string          = "BFG kills:";
                challenges.entry[10].string          = "Flamethrower kills:";
                challenges.entry[11].string          = "Chaingun kills:";
                challenges.entry[12].string          = "Nailgun kills:";
                challenges.entry[13].string          = "Proxy mine kills:";
                challenges.entry[14].string          = "Darkflare kills:";
                challenges.entry[15].string          = "Telefrags:";
                challenges.entry[16].string          = "Push kills:";
                challenges.entry[17].string          = "Crush kills:";
                challenges.numberOfEntries = 18;
                challenges.entryInt[0]              = getChallenge(WEAPON_GAUNTLET_KILLS);
                challenges.entryInt[1]              = getChallenge(WEAPON_MACHINEGUN_KILLS);
                challenges.entryInt[2]              = getChallenge(WEAPON_SHOTGUN_KILLS);
                challenges.entryInt[3]              = getChallenge(WEAPON_GRANADE_KILLS);
                challenges.entryInt[4]              = getChallenge(WEAPON_ROCKET_KILLS);
                challenges.entryInt[5]              = getChallenge(WEAPON_LIGHTNING_KILLS);
                challenges.entryInt[6]              = getChallenge(WEAPON_PLASMA_KILLS);
                challenges.entryInt[7]              = getChallenge(WEAPON_RAIL_KILLS);
                challenges.entryInt[8]              = getChallenge(WEAPON_INSTANT_RAIL_KILLS);
                challenges.entryInt[9]              = getChallenge(WEAPON_BFG_KILLS);
                challenges.entryInt[10]              = getChallenge(WEAPON_FLAMETHROWER_KILLS);
                challenges.entryInt[11]              = getChallenge(WEAPON_CHAINGUN_KILLS);
                challenges.entryInt[12]              = getChallenge(WEAPON_NAILGUN_KILLS);
                challenges.entryInt[13]              = getChallenge(WEAPON_MINE_KILLS);
                challenges.entryInt[14]              = getChallenge(WEAPON_DARKFLARE_KILLS);
                challenges.entryInt[15]              = getChallenge(WEAPON_TELEFRAG_KILLS);
                challenges.entryInt[16]              = getChallenge(WEAPON_PUSH_KILLS);
                challenges.entryInt[17]              = getChallenge(WEAPON_CRUSH_KILLS);
                challenges.weapons.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 3:
                //awards
                challenges.entry[0].string          = "Gauntlet";
                challenges.entry[1].string          = "Impressive";
                challenges.entry[2].string          = "Excellent";
                challenges.entry[3].string          = "Capture";
                challenges.entry[4].string          = "Assist";
                challenges.entry[5].string          = "Defend";
                challenges.numberOfEntries = 6;
                challenges.entryInt[0]              = getChallenge(WEAPON_GAUNTLET_KILLS);
                challenges.entryInt[1]              = getChallenge(AWARD_IMPRESSIVE);
                challenges.entryInt[2]              = getChallenge(AWARD_EXCELLENT);
                challenges.entryInt[3]              = getChallenge(AWARD_CAPTURE);
                challenges.entryInt[4]              = getChallenge(AWARD_ASSIST);
                challenges.entryInt[5]              = getChallenge(AWARD_DEFENCE);
                challenges.awards.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 4:
                challenges.entry[0].string          = "Quad kills";
                challenges.entry[1].string          = "2 fast 4 U";
                challenges.entry[2].string          = "They didn't see me";
                challenges.entry[3].string          = "I'm flying";
                challenges.entry[4].string          = "Killing machine";
                challenges.entry[5].string          = "Counter Quad";
                challenges.entry[6].string          = "Not fast enough";
                challenges.entry[7].string          = "You cannot hide";
                challenges.entry[8].string          = "Fall deep";
                challenges.entry[9].string          = "Counter battlesuit";
                challenges.entry[10].string          = "Counter regen";
                challenges.entry[11].string          = "Counter multi";
                challenges.numberOfEntries  = 12;

                challenges.entryInt[0]              = getChallenge(POWERUP_QUAD_KILL);
                challenges.entryInt[1]              = getChallenge(POWERUP_SPEED_KILL);
                challenges.entryInt[2]              = getChallenge(POWERUP_INVIS_KILL);
                challenges.entryInt[3]              = getChallenge(POWERUP_FLIGHT_KILL);
                challenges.entryInt[4]              = getChallenge(POWERUP_MULTI_KILL);
                challenges.entryInt[5]              = getChallenge(POWERUP_COUNTER_QUAD);
                challenges.entryInt[6]              = getChallenge(POWERUP_COUNTER_SPEED);
                challenges.entryInt[7]              = getChallenge(POWERUP_COUNTER_INVIS);
                challenges.entryInt[8]              = getChallenge(POWERUP_COUNTER_FLIGHT);
                challenges.entryInt[9]              = getChallenge(POWERUP_COUNTER_ENVIR);
                challenges.entryInt[10]              = getChallenge(POWERUP_COUNTER_REGEN);
                challenges.entryInt[11]              = getChallenge(POWERUP_COUNTER_MULTI);
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 5:
                challenges.entry[0].string          = "g_vampire_max_health";
                challenges.entry[1].string          = "g_autonextmap";
                challenges.entry[2].string          = "g_locationdamage";
                challenges.entry[3].string          = "g_allowvote";
                challenges.entry[4].string          = "g_kill";
                challenges.entry[5].string          = "g_vampire";
                challenges.entry[6].string          = "g_regen";
                challenges.entry[7].string          = "g_randomitems";
                challenges.entry[8].string          = "g_accelerate";
                challenges.entry[9].string          = "g_overlay";
                challenges.entry[10].string          = "g_spawnselect";
                challenges.entry[11].string          = "g_elimination";
                challenges.entry[12].string          = "elimination_items";
                challenges.entry[13].string          = "elimination_warmup";
                challenges.entry[14].string          = "elimination_activewarmup";
                challenges.entry[15].string          = "elimination_ctf_oneway";
                challenges.entry[16].string          = "elimination_roundtime";
                challenges.entry[17].string          = "g_music";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 6:
                challenges.entry[0].string          = "g_proxminetimeout";
                challenges.entry[1].string          = "g_obeliskrespawndelay";
                challenges.entry[2].string          = "g_obeliskregenamount";
                challenges.entry[3].string          = "g_obeliskregenperiod";
                challenges.entry[4].string          = "g_obeliskhealth";
                challenges.entry[5].string          = "g_drowndamage";
                challenges.entry[6].string          = "g_cubetimeout";
                challenges.entry[7].string          = "g_quadfactor";
                challenges.entry[8].string          = "g_knockback";
                challenges.entry[9].string          = "g_damagemodifier";
                challenges.entry[10].string          = "g_gravitymodifier";
                challenges.entry[11].string          = "g_lms_lives";
                challenges.entry[12].string          = "g_speed";
                challenges.entry[13].string          = "g_runes";
                challenges.entry[14].string          = "g_spawnprotect";
                challenges.entry[15].string          = "g_respawntime";
                challenges.entry[16].string          = "g_respawnwait";
                challenges.entry[17].string          = "g_forcerespawn";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 7:
                challenges.entry[0].string          = "g_friendlyfire";
                challenges.entry[1].string          = "fraglimit";
                challenges.entry[2].string          = "capturelimit";
                challenges.entry[3].string          = "timelimit";
                challenges.entry[4].string          = "g_jumpheight";
                challenges.entry[5].string          = "g_jumpmode";
                challenges.entry[6].string          = "g_ammolimit";
                challenges.entry[7].string          = "g_droppeditemtime";
                challenges.entry[8].string          = "g_autoflagreturn";
                challenges.entry[9].string          = "g_armorprotect";
                challenges.entry[10].string          = "g_noplayerclip";
                challenges.entry[11].string          = "g_falldamagesmall";
                challenges.entry[12].string          = "g_falldamagebig";
                challenges.entry[13].string          = "g_randomteleport";
                challenges.entry[14].string          = "g_maxweaponpickup";
                challenges.entry[15].string          = "g_lavadamage";
                challenges.entry[16].string          = "g_slimedamage";
                challenges.entry[17].string          = "g_waterdamage";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 8:
                challenges.entry[0].string          = "g_spectatorspeed";
                challenges.entry[1].string          = "g_flagrespawn";
                challenges.entry[2].string          = "g_poweruprespawn";
                challenges.entry[3].string          = "g_megahealthrespawn";
                challenges.entry[4].string          = "g_holdablerespawn";
                challenges.entry[5].string          = "g_healthrespawn";
                challenges.entry[6].string          = "g_armorrespawn";
                challenges.entry[7].string          = "g_ammorespawn";
                challenges.entry[8].string          = "g_weaponrespawn";
                challenges.entry[9].string          = "g_weaponteamrespawn";
                challenges.entry[10].string          = "g_quadtime";
                challenges.entry[11].string          = "g_bsuittime";
                challenges.entry[12].string          = "g_hastetime";
                challenges.entry[13].string          = "g_invistime";
                challenges.entry[14].string          = "g_regentime";
                challenges.entry[15].string          = "g_flighttime";
                challenges.entry[16].string          = "g_fasthealthregen";
                challenges.entry[17].string          = "g_slowhealthregen";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 9:
                challenges.entry[0].string          = "g_speedfactor";
                challenges.entry[1].string          = "g_hastefirespeed";
                challenges.entry[2].string          = "g_portalhealth";
                challenges.entry[3].string          = "g_portaltimeout";
                challenges.entry[4].string          = "g_medkitinf";
                challenges.entry[5].string          = "g_teleporterinf";
                challenges.entry[6].string          = "g_invulinf";
                challenges.entry[7].string          = "g_kamikazeinf";
                challenges.entry[8].string          = "g_portalinf";
                challenges.entry[9].string          = "g_medkitlimit";
                challenges.entry[10].string          = "g_medkitmodifier";
                challenges.entry[11].string          = "g_scoutspeedfactor";
                challenges.entry[12].string          = "g_scoutfirespeed";
                challenges.entry[13].string          = "g_scoutdamagefactor";
                challenges.entry[14].string          = "g_scoutgravitymodifier";
                challenges.entry[15].string          = "g_scouthealthmodifier";
                challenges.entry[16].string          = "g_scout_infammo";
                challenges.entry[17].string          = "g_doublerspeedfactor";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 10:
                challenges.entry[0].string          = "g_doublerfirespeed";
                challenges.entry[1].string          = "g_doublerdamagefactor";
                challenges.entry[2].string          = "g_doublergravitymodifier";
                challenges.entry[3].string          = "g_doublerhealthmodifier";
                challenges.entry[4].string          = "g_doubler_infammo";
                challenges.entry[5].string          = "g_guardspeedfactor";
                challenges.entry[6].string          = "g_guardfirespeed";
                challenges.entry[7].string          = "g_guarddamagefactor";
                challenges.entry[8].string          = "g_guardhealthmodifier";
                challenges.entry[9].string          = "g_guardgravitymodifier";
                challenges.entry[10].string          = "g_guard_infammo";
                challenges.entry[11].string          = "g_ammoregenspeedfactor";
                challenges.entry[12].string          = "g_ammoregenfirespeed";
                challenges.entry[13].string          = "g_ammoregendamagefactor";
                challenges.entry[14].string          = "g_ammoregen_infammo";
                challenges.entry[15].string          = "g_ammoregengravitymodifier";
                challenges.entry[16].string          = "g_ammoregenhealthmodifier";
                challenges.entry[17].string          = "g_invultime";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 11:
                challenges.entry[0].string          = "g_invulmove";
                challenges.entry[1].string          = "bot_rocketjump";
                challenges.entry[2].string          = "bot_grapple";
                challenges.entry[3].string          = "g_teamred_speed";
                challenges.entry[4].string          = "g_teamred_gravityModifier";
                challenges.entry[5].string          = "g_teamred_firespeed";
                challenges.entry[6].string          = "g_teamred_damage";
                challenges.entry[7].string          = "g_teamred_infammo";
                challenges.entry[8].string          = "g_teamred_respawnwait";
                challenges.entry[9].string          = "g_teamred_pickupitems";
                challenges.entry[10].string          = "g_teamblue_speed";
                challenges.entry[11].string          = "g_teamblue_gravityModifier";
                challenges.entry[12].string          = "g_teamblue_firespeed";
                challenges.entry[13].string          = "g_teamblue_damage";
                challenges.entry[14].string          = "g_teamblue_infammo";
                challenges.entry[15].string          = "g_teamblue_respawnwait";
                challenges.entry[16].string          = "g_teamblue_pickupitems";
                challenges.entry[17].string          = "";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 12:
                challenges.entry[0].string          = "g_*damage";
                challenges.entry[1].string          = "g_*sdamage";
                challenges.entry[2].string          = "g_*delay";
                challenges.entry[3].string          = "g_*speed";
                challenges.entry[4].string          = "g_*bounce";
                challenges.entry[5].string          = "g_*spread";
                challenges.entry[6].string          = "g_*gravity";
                challenges.entry[7].string          = "g_*radius";
                challenges.entry[8].string          = "g_*timeout";
                challenges.entry[9].string          = "g_*range";
                challenges.entry[10].string          = "g_*inf";
                challenges.entry[11].string          = "g_*vampire";
                challenges.entry[12].string          = "g_*count";
                challenges.entry[13].string          = "g_*explode";
                challenges.entry[14].string          = "g_*ammocount";
                challenges.entry[15].string          = "g_*weaponcount";
                challenges.entry[16].string          = "g_*bouncemodifier";
                challenges.entry[17].string          = "g_*knockback";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 13:
                challenges.entry[0].string          = "*-weaponname";
                challenges.entry[1].string          = "weaponnames:";
                challenges.entry[2].string          = "gh|g|mg|sg|gl|rl|lg|";
                challenges.entry[3].string          = "rg|pg|bfg|ng|pl|cg|";
                challenges.entry[4].string          = "ft|am";
                challenges.numberOfEntries  = 5;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;


            case 14:
                challenges.entry[0].string          = "g_speedfactor";
                challenges.entry[1].string          = "g_hastefirespeed";
                challenges.entry[2].string          = "g_portalhealth";
                challenges.entry[3].string          = "g_portaltimeout";
                challenges.entry[4].string          = "g_medkitinf";
                challenges.entry[5].string          = "g_teleporterinf";
                challenges.entry[6].string          = "g_invulinf";
                challenges.entry[7].string          = "g_kamikazeinf";
                challenges.entry[8].string          = "g_portalinf";
                challenges.entry[9].string          = "g_medkitlimit";
                challenges.entry[10].string          = "g_medkitmodifier";
                challenges.entry[11].string          = "g_scoutspeedfactor";
                challenges.entry[12].string          = "g_scoutfirespeed";
                challenges.entry[13].string          = "g_scoutdamagefactor";
                challenges.entry[14].string          = "g_scoutgravitymodifier";
                challenges.entry[15].string          = "g_scouthealthmodifier";
                challenges.entry[16].string          = "g_scout_infammo";
                challenges.entry[17].string          = "g_doublerspeedfactor";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            default:
                challenges.numberOfEntries = 0;
        };
}
if(rus.integer){
        switch(mainSelection)
        {
            case 0:
                //generel
                challenges.entry[0].string          = "Убийства:";
                challenges.entry[1].string          = "Смерти:";
                challenges.entry[2].string          = "Активность:";
                challenges.entry[3].string          = "Деньги:";
                challenges.numberOfEntries = 4;
                challenges.entryInt[0]              = getChallenge(GENERAL_TOTALKILLS);
                challenges.entryInt[1]              = getChallenge(GENERAL_TOTALDEATHS);
                challenges.entryInt[2]              = getChallenge(GENERAL_TEST);
                challenges.entryInt[3]              = getChallenge(GENERAL_MONEY);
                challenges.general.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 1:
                //gametypes
                challenges.numberOfEntries = 17;
				challenges.entry[0].string          = "Чтобы разблокировать персонажей";
                challenges.entry[1].string          = "нужно проходить уровни";
                challenges.entry[2].string          = "в одиночной игре.";
                challenges.entry[3].string          = "Секретные коды можно";
                challenges.entry[4].string          = "найти в уровнях";
                challenges.entry[5].string          = "zzzsecret1 и zzzsecret2.";
                challenges.entry[6].string          = "Для игры по сети";
                challenges.entry[7].string          = "можно использовать";
                challenges.entry[8].string          = "Интернет,lan кабель";
                challenges.entry[9].string          = "Wi-Fi,Usb кабель для";
                challenges.entry[10].string          = "телефона android.";
                challenges.entry[11].string          = "UserTracks это своя";
                challenges.entry[12].string          = "музыка эта папка находится";
                challenges.entry[13].string          = "в папке baseoa музыка должна";
                challenges.entry[14].string          = "быть в формате WAV и названа";
                challenges.entry[15].string          = "числом от 1 до 50 например";
                challenges.entry[16].string          = "1.wav,2.wav и так далее";
                challenges.gametypes.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 2:
								//weapons
								challenges.entry[0].string          = "Пила-убийства:";
                challenges.entry[1].string          = "Автомат-убийства:";
                challenges.entry[2].string          = "Дробовик-убийства:";
                challenges.entry[3].string          = "Гранатомёт-убийства:";
                challenges.entry[4].string          = "Базука-убийства:";
                challenges.entry[5].string          = "Молния-убийства:";
                challenges.entry[6].string          = "Плазмаган-убийства:";
                challenges.entry[7].string          = "Рэйлган-убийства:";
                challenges.entry[8].string          = "Инстант-Рэйл-убийства:";
                challenges.entry[9].string          = "БФГ-убийства:";
                challenges.entry[10].string          = "Огнемёт-убийства:";
                challenges.entry[11].string          = "Пулемёт-убийства:";
                challenges.entry[12].string          = "Гвоздомёт-убийства:";
                challenges.entry[13].string          = "Мины-убийства:";
                challenges.entry[14].string          = "Черная вспышка-убийства:";
                challenges.entry[15].string          = "Спавн-убийства:";
                challenges.entry[16].string          = "Сталкивания-убийства:";
                challenges.entry[17].string          = "Раздавление-убийства:";
                challenges.numberOfEntries = 18;
                challenges.entryInt[0]              = getChallenge(WEAPON_GAUNTLET_KILLS);
                challenges.entryInt[1]              = getChallenge(WEAPON_MACHINEGUN_KILLS);
                challenges.entryInt[2]              = getChallenge(WEAPON_SHOTGUN_KILLS);
                challenges.entryInt[3]              = getChallenge(WEAPON_GRANADE_KILLS);
                challenges.entryInt[4]              = getChallenge(WEAPON_ROCKET_KILLS);
                challenges.entryInt[5]              = getChallenge(WEAPON_LIGHTNING_KILLS);
                challenges.entryInt[6]              = getChallenge(WEAPON_PLASMA_KILLS);
                challenges.entryInt[7]              = getChallenge(WEAPON_RAIL_KILLS);
                challenges.entryInt[8]              = getChallenge(WEAPON_INSTANT_RAIL_KILLS);
                challenges.entryInt[9]              = getChallenge(WEAPON_BFG_KILLS);
                challenges.entryInt[10]              = getChallenge(WEAPON_FLAMETHROWER_KILLS);
                challenges.entryInt[11]              = getChallenge(WEAPON_CHAINGUN_KILLS);
                challenges.entryInt[12]              = getChallenge(WEAPON_NAILGUN_KILLS);
                challenges.entryInt[13]              = getChallenge(WEAPON_MINE_KILLS);
                challenges.entryInt[14]              = getChallenge(WEAPON_DARKFLARE_KILLS);
                challenges.entryInt[15]              = getChallenge(WEAPON_TELEFRAG_KILLS);
                challenges.entryInt[16]              = getChallenge(WEAPON_PUSH_KILLS);
                challenges.entryInt[17]              = getChallenge(WEAPON_CRUSH_KILLS);
                challenges.weapons.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 3:
                //awards
                challenges.entry[0].string          = "Gauntlet";
                challenges.entry[1].string          = "Impressive";
                challenges.entry[2].string          = "Excellent";
                challenges.entry[3].string          = "Capture";
                challenges.entry[4].string          = "Assist";
                challenges.entry[5].string          = "Defend";
                challenges.numberOfEntries = 6;
                challenges.entryInt[0]              = getChallenge(WEAPON_GAUNTLET_KILLS);
                challenges.entryInt[1]              = getChallenge(AWARD_IMPRESSIVE);
                challenges.entryInt[2]              = getChallenge(AWARD_EXCELLENT);
                challenges.entryInt[3]              = getChallenge(AWARD_CAPTURE);
                challenges.entryInt[4]              = getChallenge(AWARD_ASSIST);
                challenges.entryInt[5]              = getChallenge(AWARD_DEFENCE);
                challenges.awards.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 4:
                challenges.entry[0].string          = "Quad kills";
                challenges.entry[1].string          = "2 fast 4 U";
                challenges.entry[2].string          = "They didn't see me";
                challenges.entry[3].string          = "I'm flying";
                challenges.entry[4].string          = "Killing machine";
                challenges.entry[5].string          = "Counter Quad";
                challenges.entry[6].string          = "Not fast enough";
                challenges.entry[7].string          = "You cannot hide";
                challenges.entry[8].string          = "Fall deep";
                challenges.entry[9].string          = "Counter battlesuit";
                challenges.entry[10].string          = "Counter regen";
                challenges.entry[11].string          = "Counter multi";
                challenges.numberOfEntries  = 12;

                challenges.entryInt[0]              = getChallenge(POWERUP_QUAD_KILL);
                challenges.entryInt[1]              = getChallenge(POWERUP_SPEED_KILL);
                challenges.entryInt[2]              = getChallenge(POWERUP_INVIS_KILL);
                challenges.entryInt[3]              = getChallenge(POWERUP_FLIGHT_KILL);
                challenges.entryInt[4]              = getChallenge(POWERUP_MULTI_KILL);
                challenges.entryInt[5]              = getChallenge(POWERUP_COUNTER_QUAD);
                challenges.entryInt[6]              = getChallenge(POWERUP_COUNTER_SPEED);
                challenges.entryInt[7]              = getChallenge(POWERUP_COUNTER_INVIS);
                challenges.entryInt[8]              = getChallenge(POWERUP_COUNTER_FLIGHT);
                challenges.entryInt[9]              = getChallenge(POWERUP_COUNTER_ENVIR);
                challenges.entryInt[10]              = getChallenge(POWERUP_COUNTER_REGEN);
                challenges.entryInt[11]              = getChallenge(POWERUP_COUNTER_MULTI);
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;
            case 5:
                challenges.entry[0].string          = "g_vampire_max_health";
                challenges.entry[1].string          = "g_autonextmap";
                challenges.entry[2].string          = "g_locationdamage";
                challenges.entry[3].string          = "g_allowvote";
                challenges.entry[4].string          = "g_kill";
                challenges.entry[5].string          = "g_vampire";
                challenges.entry[6].string          = "g_regen";
                challenges.entry[7].string          = "g_randomitems";
                challenges.entry[8].string          = "g_accelerate";
                challenges.entry[9].string          = "g_overlay";
                challenges.entry[10].string          = "g_spawnselect";
                challenges.entry[11].string          = "g_elimination";
                challenges.entry[12].string          = "elimination_items";
                challenges.entry[13].string          = "elimination_warmup";
                challenges.entry[14].string          = "elimination_activewarmup";
                challenges.entry[15].string          = "elimination_ctf_oneway";
                challenges.entry[16].string          = "elimination_roundtime";
                challenges.entry[17].string          = "g_music";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 6:
                challenges.entry[0].string          = "g_proxminetimeout";
                challenges.entry[1].string          = "g_obeliskrespawndelay";
                challenges.entry[2].string          = "g_obeliskregenamount";
                challenges.entry[3].string          = "g_obeliskregenperiod";
                challenges.entry[4].string          = "g_obeliskhealth";
                challenges.entry[5].string          = "g_drowndamage";
                challenges.entry[6].string          = "g_cubetimeout";
                challenges.entry[7].string          = "g_quadfactor";
                challenges.entry[8].string          = "g_knockback";
                challenges.entry[9].string          = "g_damagemodifier";
                challenges.entry[10].string          = "g_gravitymodifier";
                challenges.entry[11].string          = "g_lms_lives";
                challenges.entry[12].string          = "g_speed";
                challenges.entry[13].string          = "g_runes";
                challenges.entry[14].string          = "g_spawnprotect";
                challenges.entry[15].string          = "g_respawntime";
                challenges.entry[16].string          = "g_respawnwait";
                challenges.entry[17].string          = "g_forcerespawn";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 7:
                challenges.entry[0].string          = "g_friendlyfire";
                challenges.entry[1].string          = "fraglimit";
                challenges.entry[2].string          = "capturelimit";
                challenges.entry[3].string          = "timelimit";
                challenges.entry[4].string          = "g_jumpheight";
                challenges.entry[5].string          = "g_jumpmode";
                challenges.entry[6].string          = "g_ammolimit";
                challenges.entry[7].string          = "g_droppeditemtime";
                challenges.entry[8].string          = "g_autoflagreturn";
                challenges.entry[9].string          = "g_armorprotect";
                challenges.entry[10].string          = "g_noplayerclip";
                challenges.entry[11].string          = "g_falldamagesmall";
                challenges.entry[12].string          = "g_falldamagebig";
                challenges.entry[13].string          = "g_randomteleport";
                challenges.entry[14].string          = "g_maxweaponpickup";
                challenges.entry[15].string          = "g_lavadamage";
                challenges.entry[16].string          = "g_slimedamage";
                challenges.entry[17].string          = "g_waterdamage";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 8:
                challenges.entry[0].string          = "g_spectatorspeed";
                challenges.entry[1].string          = "g_flagrespawn";
                challenges.entry[2].string          = "g_poweruprespawn";
                challenges.entry[3].string          = "g_megahealthrespawn";
                challenges.entry[4].string          = "g_holdablerespawn";
                challenges.entry[5].string          = "g_healthrespawn";
                challenges.entry[6].string          = "g_armorrespawn";
                challenges.entry[7].string          = "g_ammorespawn";
                challenges.entry[8].string          = "g_weaponrespawn";
                challenges.entry[9].string          = "g_weaponteamrespawn";
                challenges.entry[10].string          = "g_quadtime";
                challenges.entry[11].string          = "g_bsuittime";
                challenges.entry[12].string          = "g_hastetime";
                challenges.entry[13].string          = "g_invistime";
                challenges.entry[14].string          = "g_regentime";
                challenges.entry[15].string          = "g_flighttime";
                challenges.entry[16].string          = "g_fasthealthregen";
                challenges.entry[17].string          = "g_slowhealthregen";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 9:
                challenges.entry[0].string          = "g_speedfactor";
                challenges.entry[1].string          = "g_hastefirespeed";
                challenges.entry[2].string          = "g_portalhealth";
                challenges.entry[3].string          = "g_portaltimeout";
                challenges.entry[4].string          = "g_medkitinf";
                challenges.entry[5].string          = "g_teleporterinf";
                challenges.entry[6].string          = "g_invulinf";
                challenges.entry[7].string          = "g_kamikazeinf";
                challenges.entry[8].string          = "g_portalinf";
                challenges.entry[9].string          = "g_medkitlimit";
                challenges.entry[10].string          = "g_medkitmodifier";
                challenges.entry[11].string          = "g_scoutspeedfactor";
                challenges.entry[12].string          = "g_scoutfirespeed";
                challenges.entry[13].string          = "g_scoutdamagefactor";
                challenges.entry[14].string          = "g_scoutgravitymodifier";
                challenges.entry[15].string          = "g_scouthealthmodifier";
                challenges.entry[16].string          = "g_scout_infammo";
                challenges.entry[17].string          = "g_doublerspeedfactor";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 10:
                challenges.entry[0].string          = "g_doublerfirespeed";
                challenges.entry[1].string          = "g_doublerdamagefactor";
                challenges.entry[2].string          = "g_doublergravitymodifier";
                challenges.entry[3].string          = "g_doublerhealthmodifier";
                challenges.entry[4].string          = "g_doubler_infammo";
                challenges.entry[5].string          = "g_guardspeedfactor";
                challenges.entry[6].string          = "g_guardfirespeed";
                challenges.entry[7].string          = "g_guarddamagefactor";
                challenges.entry[8].string          = "g_guardhealthmodifier";
                challenges.entry[9].string          = "g_guardgravitymodifier";
                challenges.entry[10].string          = "g_guard_infammo";
                challenges.entry[11].string          = "g_ammoregenspeedfactor";
                challenges.entry[12].string          = "g_ammoregenfirespeed";
                challenges.entry[13].string          = "g_ammoregendamagefactor";
                challenges.entry[14].string          = "g_ammoregen_infammo";
                challenges.entry[15].string          = "g_ammoregengravitymodifier";
                challenges.entry[16].string          = "g_ammoregenhealthmodifier";
                challenges.entry[17].string          = "g_invultime";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 11:
                challenges.entry[0].string          = "g_invulmove";
                challenges.entry[1].string          = "bot_rocketjump";
                challenges.entry[2].string          = "bot_grapple";
                challenges.entry[3].string          = "g_teamred_speed";
                challenges.entry[4].string          = "g_teamred_gravityModifier";
                challenges.entry[5].string          = "g_teamred_firespeed";
                challenges.entry[6].string          = "g_teamred_damage";
                challenges.entry[7].string          = "g_teamred_infammo";
                challenges.entry[8].string          = "g_teamred_respawnwait";
                challenges.entry[9].string          = "g_teamred_pickupitems";
                challenges.entry[10].string          = "g_teamblue_speed";
                challenges.entry[11].string          = "g_teamblue_gravityModifier";
                challenges.entry[12].string          = "g_teamblue_firespeed";
                challenges.entry[13].string          = "g_teamblue_damage";
                challenges.entry[14].string          = "g_teamblue_infammo";
                challenges.entry[15].string          = "g_teamblue_respawnwait";
                challenges.entry[16].string          = "g_teamblue_pickupitems";
                challenges.entry[17].string          = "";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 12:
                challenges.entry[0].string          = "g_*damage";
                challenges.entry[1].string          = "g_*sdamage";
                challenges.entry[2].string          = "g_*delay";
                challenges.entry[3].string          = "g_*speed";
                challenges.entry[4].string          = "g_*bounce";
                challenges.entry[5].string          = "g_*spread";
                challenges.entry[6].string          = "g_*gravity";
                challenges.entry[7].string          = "g_*radius";
                challenges.entry[8].string          = "g_*timeout";
                challenges.entry[9].string          = "g_*range";
                challenges.entry[10].string          = "g_*inf";
                challenges.entry[11].string          = "g_*vampire";
                challenges.entry[12].string          = "g_*count";
                challenges.entry[13].string          = "g_*explode";
                challenges.entry[14].string          = "g_*ammocount";
                challenges.entry[15].string          = "g_*weaponcount";
                challenges.entry[16].string          = "g_*bouncemodifier";
                challenges.entry[17].string          = "g_*knockback";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            case 13:
                challenges.entry[0].string          = "* это имя оружия";
                challenges.entry[1].string          = "имена оружий:";
                challenges.entry[2].string          = "gh|g|mg|sg|gl|rl|lg|";
                challenges.entry[3].string          = "rg|pg|bfg|ng|pl|cg|";
                challenges.entry[4].string          = "ft|am";
                challenges.numberOfEntries  = 5;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;


            case 14:
                challenges.entry[0].string          = "g_speedfactor";
                challenges.entry[1].string          = "g_hastefirespeed";
                challenges.entry[2].string          = "g_portalhealth";
                challenges.entry[3].string          = "g_portaltimeout";
                challenges.entry[4].string          = "g_medkitinf";
                challenges.entry[5].string          = "g_teleporterinf";
                challenges.entry[6].string          = "g_invulinf";
                challenges.entry[7].string          = "g_kamikazeinf";
                challenges.entry[8].string          = "g_portalinf";
                challenges.entry[9].string          = "g_medkitlimit";
                challenges.entry[10].string          = "g_medkitmodifier";
                challenges.entry[11].string          = "g_scoutspeedfactor";
                challenges.entry[12].string          = "g_scoutfirespeed";
                challenges.entry[13].string          = "g_scoutdamagefactor";
                challenges.entry[14].string          = "g_scoutgravitymodifier";
                challenges.entry[15].string          = "g_scouthealthmodifier";
                challenges.entry[16].string          = "g_scout_infammo";
                challenges.entry[17].string          = "g_doublerspeedfactor";
                challenges.numberOfEntries  = 18;

                challenges.entryInt[0]              = 0;
                challenges.entryInt[1]              = 0;
                challenges.entryInt[2]              = 0;
                challenges.entryInt[3]              = 0;
                challenges.entryInt[4]              = 0;
                challenges.entryInt[5]              = 0;
                challenges.entryInt[6]              = 0;
                challenges.entryInt[7]              = 0;
                challenges.entryInt[8]              = 0;
                challenges.entryInt[9]              = 0;
                challenges.entryInt[10]              = 0;
                challenges.entryInt[11]              = 0;
                challenges.entryInt[12]              = 0;
                challenges.entryInt[13]              = 0;
                challenges.entryInt[14]              = 0;
                challenges.entryInt[15]              = 0;
                challenges.entryInt[16]              = 0;
                challenges.entryInt[17]              = 0;
                challenges.powerups.generic.flags     = QMF_RIGHT_JUSTIFY|QMF_INACTIVE;
                break;

            default:
                challenges.numberOfEntries = 0;
        };
}

        //Now write the challenges
        y = 240 - (int)((((float)challenges.numberOfEntries)/2.0) * (float)(BIGCHAR_HEIGHT + 2));
        for(i=0;i<MAX_ENTRIES && i < challenges.numberOfEntries;i++)
        {
            challenges.entry[i].color = color_white;
            challenges.entry[i].generic.type = MTYPE_TEXT;
            challenges.entry[i].generic.x        = 230;
            challenges.entry[i].generic.y        = y;

            challenges.entryIntText[i].color = color_white;
            challenges.entryIntText[i].generic.type = MTYPE_TEXT;
            challenges.entryIntText[i].generic.x        = 630;
            challenges.entryIntText[i].generic.y        = y;
            challenges.entryIntText[i].style = UI_RIGHT;
            challenges.entryIntText[i].string           = challenges.entryIntString[i];
            strncpy(challenges.entryIntString[i],va("%u",challenges.entryInt[i]),MAX_INT_AS_STRING);
            y += BIGCHAR_HEIGHT+2;
        }

        Menu_AddItem( &challenges.menu, ( void * ) &challenges.banner );
	Menu_AddItem( &challenges.menu, ( void * ) &challenges.framel );
	Menu_AddItem( &challenges.menu, ( void * ) &challenges.framer );

        Menu_AddItem( &challenges.menu, ( void * ) &challenges.general );
    //    Menu_AddItem( &challenges.menu, ( void * ) &challenges.gametypes );
        Menu_AddItem( &challenges.menu, ( void * ) &challenges.weapons );
        Menu_AddItem( &challenges.menu, ( void * ) &challenges.awards );
        Menu_AddItem( &challenges.menu, ( void * ) &challenges.powerups );
        //Menu_AddItem( &challenges.menu, ( void * ) &challenges.cwrite );
        //Menu_AddItem( &challenges.menu, ( void * ) &challenges.cname );
        //Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvalue );
        //Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist1 );
      //  Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist2 );
      //  Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist3 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist4 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist5 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist6 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist7 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist8 );
	//	Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist9 );
//		Menu_AddItem( &challenges.menu, ( void * ) &challenges.cvarlist10 );
        for(i=0;i<MAX_ENTRIES && i<challenges.numberOfEntries;i++)
        {
            Menu_AddItem( &challenges.menu, ( void * ) &challenges.entry[i] );
            Menu_AddItem( &challenges.menu, ( void * ) &challenges.entryIntText[i] );
        }
//        Menu_AddItem( &challenges.menu, (void *) &challenges.notice);
//        Menu_AddItem( &challenges.menu, (void *) &challenges.notice2);
	Menu_AddItem( &challenges.menu, ( void * ) &challenges.back );
}

/*
===============
UI_Challenges
===============
*/
void UI_Challenges( void ) {
    mainSelection = 0;
	UI_Challenges_Init();
	UI_PushMenu( &challenges.menu );
	Menu_SetCursorToItem( &challenges.menu, &challenges.back );
}

/*
===============
UI_ChallengesLocal
 *This is only used locally. Remembers selection
===============
*/
void UI_ChallengesLocal( void ) {
	UI_Challenges_Init();
	UI_PushMenu( &challenges.menu );
	Menu_SetCursorToItem( &challenges.menu, &challenges.back );
}
