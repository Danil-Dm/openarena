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
#include "../game/challenges.h"

#define MODEL_BACK0			"menu/art_blueish/back_0"
#define MODEL_BACK1			"menu/art_blueish/back_1"
#define MODEL_SELECT		"menu/art/opponents_select"
#define MODEL_SELECTED		"menu/art/opponents_selected"
#define MODEL_FRAMEL		"menu/art_blueish/frame1_l"
#define MODEL_FRAMER		"menu/art_blueish/frame1_r"
#define MODEL_PORTS			"menu/art_blueish/player_models_ports"
#define MODEL_ARROWS		"menu/art_blueish/gs_arrows_0"
#define MODEL_ARROWSL		"menu/art_blueish/gs_arrows_l"
#define MODEL_ARROWSR		"menu/art_blueish/gs_arrows_r"

#define LOW_MEMORY			(2 * 1024 * 1024)

static char* playermodel_artlist[] =
{
	MODEL_BACK0,	
	MODEL_BACK1,	
	MODEL_SELECT,
	MODEL_SELECTED,
	MODEL_FRAMEL,
	MODEL_FRAMER,
	MODEL_PORTS,	
	MODEL_ARROWS,
	MODEL_ARROWSL,
	MODEL_ARROWSR,
	NULL
};

#define PLAYERGRID_COLS		6
#define PLAYERGRID_ROWS		4
#define MAX_MODELSPERPAGE	(PLAYERGRID_ROWS*PLAYERGRID_COLS)

#define MAX_PLAYERMODELS	1024

#define ID_PLAYERPIC0		0
#define ID_PLAYERPIC1		1
#define ID_PLAYERPIC2		2
#define ID_PLAYERPIC3		3
#define ID_PLAYERPIC4		4
#define ID_PLAYERPIC5		5
#define ID_PLAYERPIC6		6
#define ID_PLAYERPIC7		7
#define ID_PLAYERPIC8		8
#define ID_PLAYERPIC9		9
#define ID_PLAYERPIC10		10
#define ID_PLAYERPIC11		11
#define ID_PLAYERPIC12		12
#define ID_PLAYERPIC13		13
#define ID_PLAYERPIC14		14
#define ID_PLAYERPIC15		15
#define ID_PREVPAGE			100
#define ID_NEXTPAGE			101
#define ID_BACK				102

typedef struct
{
	menuframework_s	menu;
	menubitmap_s	pics[MAX_MODELSPERPAGE];
	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
	menubitmap_s	framel;
	menubitmap_s	framer;
	menubitmap_s	ports;
	menutext_s		banner;
	menubitmap_s	back;
	menubitmap_s	player;
	menubitmap_s	arrows;
	menubitmap_s	left;
	menubitmap_s	right;
	menutext_s		modelname;
	menutext_s		skinname;
	menutext_s		playername;
	playerInfo_t	playerinfo;
	int				nummodels;
	char			modelnames[MAX_PLAYERMODELS][128];
	int				modelpage;
	int				numpages;
	char			modelskin[64];
	int				selectedmodel;
} playermodel_t;

static playermodel_t s_playermodel;

/*
=================
PlayerModel_UpdateGrid
=================
*/
static void PlayerModel_UpdateGrid( void )
{
	int	i;
    int	j;

	j = s_playermodel.modelpage * MAX_MODELSPERPAGE;
	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++,j++)
	{
		if (j < s_playermodel.nummodels)
		{ 
			// model/skin portrait
 			s_playermodel.pics[i].generic.name         = s_playermodel.modelnames[j];
			s_playermodel.picbuttons[i].generic.flags &= ~QMF_INACTIVE;	
if(j == 0	){	
	if(getChallenge(SKIN1	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}	
if(j == 	1	){	
	if(getChallenge(SKIN1	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	2	){	
	if(getChallenge(SKIN2	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	3	){	
	if(getChallenge(SKIN3	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	4	){	
	if(getChallenge(SKIN4	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	5	){	
	if(getChallenge(SKIN5	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	6	){	
	if(getChallenge(SKIN6	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	7	){	
	if(getChallenge(SKIN7	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	8	){	
	if(getChallenge(SKIN8	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	9	){	
	if(getChallenge(SKIN9	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	10	){	
	if(getChallenge(SKIN10	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	11	){	
	if(getChallenge(SKIN11	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	12	){	
	if(getChallenge(SKIN12	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	13	){	
	if(getChallenge(SKIN13	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	14	){	
	if(getChallenge(SKIN14	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	15	){	
	if(getChallenge(SKIN15	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	16	){	
	if(getChallenge(SKIN16	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	17	){	
	if(getChallenge(SKIN17	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	18	){	
	if(getChallenge(SKIN18	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	19	){	
	if(getChallenge(SKIN19	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	20	){	
	if(getChallenge(SKIN20	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	21	){	
	if(getChallenge(SKIN21	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	22	){	
	if(getChallenge(SKIN22	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	23	){	
	if(getChallenge(SKIN23	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	24	){	
	if(getChallenge(SKIN24	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	25	){	
	if(getChallenge(SKIN25	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	26	){	
	if(getChallenge(SKIN26	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	27	){	
	if(getChallenge(SKIN27	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	28	){	
	if(getChallenge(SKIN28	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	29	){	
	if(getChallenge(SKIN29	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	30	){	
	if(getChallenge(SKIN30	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	31	){	
	if(getChallenge(SKIN31	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	32	){	
	if(getChallenge(SKIN32	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	33	){	
	if(getChallenge(SKIN33	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	34	){	
	if(getChallenge(SKIN34	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	35	){	
	if(getChallenge(SKIN35	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	36	){	
	if(getChallenge(SKIN36	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	37	){	
	if(getChallenge(SKIN37	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	38	){	
	if(getChallenge(SKIN38	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	39	){	
	if(getChallenge(SKIN39	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	40	){	
	if(getChallenge(SKIN40	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	41	){	
	if(getChallenge(SKIN41	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	42	){	
	if(getChallenge(SKIN42	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	43	){	
	if(getChallenge(SKIN43	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	44	){	
	if(getChallenge(SKIN44	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	45	){	
	if(getChallenge(SKIN45	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	46	){	
	if(getChallenge(SKIN46	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	47	){	
	if(getChallenge(SKIN47	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	48	){	
	if(getChallenge(SKIN48	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	49	){	
	if(getChallenge(SKIN49	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	50	){	
	if(getChallenge(SKIN50	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	51	){	
	if(getChallenge(SKIN51	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	52	){	
	if(getChallenge(SKIN52	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	53	){	
	if(getChallenge(SKIN53	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	54	){	
	if(getChallenge(SKIN54	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	55	){	
	if(getChallenge(SKIN55	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	56	){	
	if(getChallenge(SKIN56	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	57	){	
	if(getChallenge(SKIN57	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	58	){	
	if(getChallenge(SKIN58	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	59	){	
	if(getChallenge(SKIN59	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	60	){	
	if(getChallenge(SKIN60	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	61	){	
	if(getChallenge(SKIN61	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	62	){	
	if(getChallenge(SKIN62	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	63	){	
	if(getChallenge(SKIN63	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	64	){	
	if(getChallenge(SKIN64	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	65	){	
	if(getChallenge(SKIN65	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	66	){	
	if(getChallenge(SKIN66	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	67	){	
	if(getChallenge(SKIN67	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	68	){	
	if(getChallenge(SKIN68	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	69	){	
	if(getChallenge(SKIN69	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	70	){	
	if(getChallenge(SKIN70	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	71	){	
	if(getChallenge(SKIN71	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	72	){	
	if(getChallenge(SKIN72	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	73	){	
	if(getChallenge(SKIN73	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	74	){	
	if(getChallenge(SKIN74	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	75	){	
	if(getChallenge(SKIN75	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	76	){	
	if(getChallenge(SKIN76	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	77	){	
	if(getChallenge(SKIN77	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	78	){	
	if(getChallenge(SKIN78	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	79	){	
	if(getChallenge(SKIN79	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	80	){	
	if(getChallenge(SKIN80	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	81	){	
	if(getChallenge(SKIN81	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	82	){	
	if(getChallenge(SKIN82	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	83	){	
	if(getChallenge(SKIN83	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	84	){	
	if(getChallenge(SKIN84	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	85	){	
	if(getChallenge(SKIN85	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	86	){	
	if(getChallenge(SKIN86	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	87	){	
	if(getChallenge(SKIN87	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	88	){	
	if(getChallenge(SKIN88	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	89	){	
	if(getChallenge(SKIN89	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	90	){	
	if(getChallenge(SKIN90	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	91	){	
	if(getChallenge(SKIN91	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	92	){	
	if(getChallenge(SKIN92	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	93	){	
	if(getChallenge(SKIN93	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	94	){	
	if(getChallenge(SKIN94	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	95	){	
	if(getChallenge(SKIN95	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	96	){	
	if(getChallenge(SKIN96	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	97	){	
	if(getChallenge(SKIN97	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	98	){	
	if(getChallenge(SKIN98	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	99	){	
	if(getChallenge(SKIN99	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	100	){	
	if(getChallenge(SKIN100	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	101	){	
	if(getChallenge(SKIN101	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	102	){	
	if(getChallenge(SKIN102	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	103	){	
	if(getChallenge(SKIN103	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	104	){	
	if(getChallenge(SKIN104	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	105	){	
	if(getChallenge(SKIN105	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	106	){	
	if(getChallenge(SKIN106	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	107	){	
	if(getChallenge(SKIN107	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	108	){	
	if(getChallenge(SKIN108	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	109	){	
	if(getChallenge(SKIN109	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	110	){	
	if(getChallenge(SKIN110	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	111	){	
	if(getChallenge(SKIN111	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	112	){	
	if(getChallenge(SKIN112	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	113	){	
	if(getChallenge(SKIN113	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	114	){	
	if(getChallenge(SKIN114	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	115	){	
	if(getChallenge(SKIN115	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	116	){	
	if(getChallenge(SKIN116	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	117	){	
	if(getChallenge(SKIN117	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	118	){	
	if(getChallenge(SKIN118	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	119	){	
	if(getChallenge(SKIN119	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	120	){	
	if(getChallenge(SKIN120	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	121	){	
	if(getChallenge(SKIN121	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	122	){	
	if(getChallenge(SKIN122	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	123	){	
	if(getChallenge(SKIN123	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	124	){	
	if(getChallenge(SKIN124	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	125	){	
	if(getChallenge(SKIN125	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	126	){	
	if(getChallenge(SKIN126	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	127	){	
	if(getChallenge(SKIN127	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	128	){	
	if(getChallenge(SKIN128	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	129	){	
	if(getChallenge(SKIN129	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	130	){	
	if(getChallenge(SKIN130	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	131	){	
	if(getChallenge(SKIN131	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	132	){	
	if(getChallenge(SKIN132	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	133	){	
	if(getChallenge(SKIN133	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	134	){	
	if(getChallenge(SKIN134	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	135	){	
	if(getChallenge(SKIN135	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	136	){	
	if(getChallenge(SKIN136	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	137	){	
	if(getChallenge(SKIN137	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	138	){	
	if(getChallenge(SKIN138	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	139	){	
	if(getChallenge(SKIN139	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	140	){	
	if(getChallenge(SKIN140	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	141	){	
	if(getChallenge(SKIN141	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	142	){	
	if(getChallenge(SKIN142	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	143	){	
	if(getChallenge(SKIN143	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	144	){	
	if(getChallenge(SKIN144	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	145	){	
	if(getChallenge(SKIN145	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	146	){	
	if(getChallenge(SKIN146	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	147	){	
	if(getChallenge(SKIN147	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	148	){	
	if(getChallenge(SKIN148	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	149	){	
	if(getChallenge(SKIN149	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	150	){	
	if(getChallenge(SKIN150	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	151	){	
	if(getChallenge(SKIN151	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	152	){	
	if(getChallenge(SKIN152	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	153	){	
	if(getChallenge(SKIN153	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	154	){	
	if(getChallenge(SKIN154	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	155	){	
	if(getChallenge(SKIN155	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	156	){	
	if(getChallenge(SKIN156	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	157	){	
	if(getChallenge(SKIN157	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	158	){	
	if(getChallenge(SKIN158	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	159	){	
	if(getChallenge(SKIN159	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	160	){	
	if(getChallenge(SKIN160	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	161	){	
	if(getChallenge(SKIN161	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	162	){	
	if(getChallenge(SKIN162	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	163	){	
	if(getChallenge(SKIN163	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	164	){	
	if(getChallenge(SKIN164	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	165	){	
	if(getChallenge(SKIN165	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	166	){	
	if(getChallenge(SKIN166	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	167	){	
	if(getChallenge(SKIN167	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	168	){	
	if(getChallenge(SKIN168	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	169	){	
	if(getChallenge(SKIN169	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	170	){	
	if(getChallenge(SKIN170	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	171	){	
	if(getChallenge(SKIN171	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	172	){	
	if(getChallenge(SKIN172	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	173	){	
	if(getChallenge(SKIN173	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	174	){	
	if(getChallenge(SKIN174	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	175	){	
	if(getChallenge(SKIN175	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	176	){	
	if(getChallenge(SKIN176	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	177	){	
	if(getChallenge(SKIN177	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	178	){	
	if(getChallenge(SKIN178	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	179	){	
	if(getChallenge(SKIN179	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	180	){	
	if(getChallenge(SKIN180	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	181	){	
	if(getChallenge(SKIN181	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	182	){	
	if(getChallenge(SKIN182	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	183	){	
	if(getChallenge(SKIN183	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	184	){	
	if(getChallenge(SKIN184	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	185	){	
	if(getChallenge(SKIN185	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	186	){	
	if(getChallenge(SKIN186	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	187	){	
	if(getChallenge(SKIN187	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	188	){	
	if(getChallenge(SKIN188	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	189	){	
	if(getChallenge(SKIN189	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	190	){	
	if(getChallenge(SKIN190	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	191	){	
	if(getChallenge(SKIN191	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	192	){	
	if(getChallenge(SKIN192	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	193	){	
	if(getChallenge(SKIN193	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	194	){	
	if(getChallenge(SKIN194	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	195	){	
	if(getChallenge(SKIN195	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	196	){	
	if(getChallenge(SKIN196	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	197	){	
	if(getChallenge(SKIN197	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	198	){	
	if(getChallenge(SKIN198	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	199	){	
	if(getChallenge(SKIN199	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	200	){	
	if(getChallenge(SKIN200	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	201	){	
	if(getChallenge(SKIN201	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	202	){	
	if(getChallenge(SKIN202	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	203	){	
	if(getChallenge(SKIN203	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	204	){	
	if(getChallenge(SKIN204	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	205	){	
	if(getChallenge(SKIN205	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	206	){	
	if(getChallenge(SKIN206	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	207	){	
	if(getChallenge(SKIN207	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	208	){	
	if(getChallenge(SKIN208	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	209	){	
	if(getChallenge(SKIN209	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	210	){	
	if(getChallenge(SKIN210	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	211	){	
	if(getChallenge(SKIN211	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	212	){	
	if(getChallenge(SKIN212	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	213	){	
	if(getChallenge(SKIN213	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	214	){	
	if(getChallenge(SKIN214	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	215	){	
	if(getChallenge(SKIN215	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	216	){	
	if(getChallenge(SKIN216	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	217	){	
	if(getChallenge(SKIN217	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	218	){	
	if(getChallenge(SKIN218	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	219	){	
	if(getChallenge(SKIN219	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	220	){	
	if(getChallenge(SKIN220	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	221	){	
	if(getChallenge(SKIN221	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	222	){	
	if(getChallenge(SKIN222	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	223	){	
	if(getChallenge(SKIN223	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	224	){	
	if(getChallenge(SKIN224	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	225	){	
	if(getChallenge(SKIN225	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	226	){	
	if(getChallenge(SKIN226	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	227	){	
	if(getChallenge(SKIN227	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	228	){	
	if(getChallenge(SKIN228	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	229	){	
	if(getChallenge(SKIN229	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	230	){	
	if(getChallenge(SKIN230	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	231	){	
	if(getChallenge(SKIN231	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	232	){	
	if(getChallenge(SKIN232	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	233	){	
	if(getChallenge(SKIN233	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	234	){	
	if(getChallenge(SKIN234	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	235	){	
	if(getChallenge(SKIN235	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	236	){	
	if(getChallenge(SKIN236	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	237	){	
	if(getChallenge(SKIN237	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	238	){	
	if(getChallenge(SKIN238	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	239	){	
	if(getChallenge(SKIN239	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	240	){	
	if(getChallenge(SKIN240	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	241	){	
	if(getChallenge(SKIN241	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	242	){	
	if(getChallenge(SKIN242	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	243	){	
	if(getChallenge(SKIN243	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	244	){	
	if(getChallenge(SKIN244	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	245	){	
	if(getChallenge(SKIN245	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	246	){	
	if(getChallenge(SKIN246	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	247	){	
	if(getChallenge(SKIN247	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	248	){	
	if(getChallenge(SKIN248	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	249	){	
	if(getChallenge(SKIN249	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	250	){	
	if(getChallenge(SKIN250	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	251	){	
	if(getChallenge(SKIN251	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	252	){	
	if(getChallenge(SKIN252	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	253	){	
	if(getChallenge(SKIN253	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	254	){	
	if(getChallenge(SKIN254	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	255	){	
	if(getChallenge(SKIN255	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	256	){	
	if(getChallenge(SKIN256	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	257	){	
	if(getChallenge(SKIN257	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	258	){	
	if(getChallenge(SKIN258	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	259	){	
	if(getChallenge(SKIN259	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	260	){	
	if(getChallenge(SKIN260	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	261	){	
	if(getChallenge(SKIN261	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	262	){	
	if(getChallenge(SKIN262	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	263	){	
	if(getChallenge(SKIN263	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	264	){	
	if(getChallenge(SKIN264	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	265	){	
	if(getChallenge(SKIN265	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	266	){	
	if(getChallenge(SKIN266	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	267	){	
	if(getChallenge(SKIN267	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	268	){	
	if(getChallenge(SKIN268	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	269	){	
	if(getChallenge(SKIN269	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	270	){	
	if(getChallenge(SKIN270	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	271	){	
	if(getChallenge(SKIN271	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	272	){	
	if(getChallenge(SKIN272	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	273	){	
	if(getChallenge(SKIN273	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	274	){	
	if(getChallenge(SKIN274	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	275	){	
	if(getChallenge(SKIN275	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	276	){	
	if(getChallenge(SKIN276	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	277	){	
	if(getChallenge(SKIN277	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	278	){	
	if(getChallenge(SKIN278	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	279	){	
	if(getChallenge(SKIN279	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	280	){	
	if(getChallenge(SKIN280	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	281	){	
	if(getChallenge(SKIN281	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	282	){	
	if(getChallenge(SKIN282	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	283	){	
	if(getChallenge(SKIN283	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	284	){	
	if(getChallenge(SKIN284	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	285	){	
	if(getChallenge(SKIN285	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	286	){	
	if(getChallenge(SKIN286	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	287	){	
	if(getChallenge(SKIN287	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	288	){	
	if(getChallenge(SKIN288	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	289	){	
	if(getChallenge(SKIN289	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	290	){	
	if(getChallenge(SKIN290	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	291	){	
	if(getChallenge(SKIN291	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	292	){	
	if(getChallenge(SKIN292	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	293	){	
	if(getChallenge(SKIN293	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	294	){	
	if(getChallenge(SKIN294	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	295	){	
	if(getChallenge(SKIN295	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	296	){	
	if(getChallenge(SKIN296	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	297	){	
	if(getChallenge(SKIN297	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	298	){	
	if(getChallenge(SKIN298	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	299	){	
	if(getChallenge(SKIN299	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	300	){	
	if(getChallenge(SKIN300	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	301	){	
	if(getChallenge(SKIN301	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	302	){	
	if(getChallenge(SKIN302	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	303	){	
	if(getChallenge(SKIN303	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	304	){	
	if(getChallenge(SKIN304	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	305	){	
	if(getChallenge(SKIN305	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	306	){	
	if(getChallenge(SKIN306	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	307	){	
	if(getChallenge(SKIN307	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	308	){	
	if(getChallenge(SKIN308	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	309	){	
	if(getChallenge(SKIN309	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	310	){	
	if(getChallenge(SKIN310	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	311	){	
	if(getChallenge(SKIN311	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	312	){	
	if(getChallenge(SKIN312	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	313	){	
	if(getChallenge(SKIN313	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	314	){	
	if(getChallenge(SKIN314	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	315	){	
	if(getChallenge(SKIN315	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	316	){	
	if(getChallenge(SKIN316	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	317	){	
	if(getChallenge(SKIN317	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	318	){	
	if(getChallenge(SKIN318	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	319	){	
	if(getChallenge(SKIN319	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	320	){	
	if(getChallenge(SKIN320	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	321	){	
	if(getChallenge(SKIN321	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	322	){	
	if(getChallenge(SKIN322	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	323	){	
	if(getChallenge(SKIN323	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	324	){	
	if(getChallenge(SKIN324	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	325	){	
	if(getChallenge(SKIN325	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	326	){	
	if(getChallenge(SKIN326	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	327	){	
	if(getChallenge(SKIN327	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	328	){	
	if(getChallenge(SKIN328	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	329	){	
	if(getChallenge(SKIN329	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	330	){	
	if(getChallenge(SKIN330	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	331	){	
	if(getChallenge(SKIN331	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	332	){	
	if(getChallenge(SKIN332	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	333	){	
	if(getChallenge(SKIN333	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	334	){	
	if(getChallenge(SKIN334	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	335	){	
	if(getChallenge(SKIN335	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	336	){	
	if(getChallenge(SKIN336	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	337	){	
	if(getChallenge(SKIN337	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	338	){	
	if(getChallenge(SKIN338	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	339	){	
	if(getChallenge(SKIN339	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	340	){	
	if(getChallenge(SKIN340	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	341	){	
	if(getChallenge(SKIN341	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	342	){	
	if(getChallenge(SKIN342	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	343	){	
	if(getChallenge(SKIN343	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	344	){	
	if(getChallenge(SKIN344	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	345	){	
	if(getChallenge(SKIN345	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	346	){	
	if(getChallenge(SKIN346	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	347	){	
	if(getChallenge(SKIN347	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	348	){	
	if(getChallenge(SKIN348	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	349	){	
	if(getChallenge(SKIN349	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	350	){	
	if(getChallenge(SKIN350	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	351	){	
	if(getChallenge(SKIN351	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	352	){	
	if(getChallenge(SKIN352	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	353	){	
	if(getChallenge(SKIN353	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	354	){	
	if(getChallenge(SKIN354	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	355	){	
	if(getChallenge(SKIN355	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	356	){	
	if(getChallenge(SKIN356	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	357	){	
	if(getChallenge(SKIN357	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	358	){	
	if(getChallenge(SKIN358	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	359	){	
	if(getChallenge(SKIN359	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	360	){	
	if(getChallenge(SKIN360	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	361	){	
	if(getChallenge(SKIN361	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	362	){	
	if(getChallenge(SKIN362	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	363	){	
	if(getChallenge(SKIN363	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	364	){	
	if(getChallenge(SKIN364	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	365	){	
	if(getChallenge(SKIN365	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	366	){	
	if(getChallenge(SKIN366	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	367	){	
	if(getChallenge(SKIN367	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	368	){	
	if(getChallenge(SKIN368	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	369	){	
	if(getChallenge(SKIN369	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	370	){	
	if(getChallenge(SKIN370	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	371	){	
	if(getChallenge(SKIN371	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	372	){	
	if(getChallenge(SKIN372	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	373	){	
	if(getChallenge(SKIN373	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	374	){	
	if(getChallenge(SKIN374	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	375	){	
	if(getChallenge(SKIN375	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	376	){	
	if(getChallenge(SKIN376	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	377	){	
	if(getChallenge(SKIN377	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	378	){	
	if(getChallenge(SKIN378	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	379	){	
	if(getChallenge(SKIN379	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	380	){	
	if(getChallenge(SKIN380	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	381	){	
	if(getChallenge(SKIN381	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	382	){	
	if(getChallenge(SKIN382	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	383	){	
	if(getChallenge(SKIN383	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	384	){	
	if(getChallenge(SKIN384	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	385	){	
	if(getChallenge(SKIN385	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	386	){	
	if(getChallenge(SKIN386	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	387	){	
	if(getChallenge(SKIN387	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	388	){	
	if(getChallenge(SKIN388	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	389	){	
	if(getChallenge(SKIN389	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	390	){	
	if(getChallenge(SKIN390	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	391	){	
	if(getChallenge(SKIN391	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	392	){	
	if(getChallenge(SKIN392	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	393	){	
	if(getChallenge(SKIN393	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	394	){	
	if(getChallenge(SKIN394	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	395	){	
	if(getChallenge(SKIN395	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	396	){	
	if(getChallenge(SKIN396	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	397	){	
	if(getChallenge(SKIN397	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	398	){	
	if(getChallenge(SKIN398	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	399	){	
	if(getChallenge(SKIN399	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	400	){	
	if(getChallenge(SKIN400	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	401	){	
	if(getChallenge(SKIN401	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	402	){	
	if(getChallenge(SKIN402	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	403	){	
	if(getChallenge(SKIN403	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	404	){	
	if(getChallenge(SKIN404	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	405	){	
	if(getChallenge(SKIN405	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	406	){	
	if(getChallenge(SKIN406	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	407	){	
	if(getChallenge(SKIN407	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	408	){	
	if(getChallenge(SKIN408	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	409	){	
	if(getChallenge(SKIN409	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	410	){	
	if(getChallenge(SKIN410	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	411	){	
	if(getChallenge(SKIN411	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	412	){	
	if(getChallenge(SKIN412	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	413	){	
	if(getChallenge(SKIN413	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	414	){	
	if(getChallenge(SKIN414	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	415	){	
	if(getChallenge(SKIN415	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	416	){	
	if(getChallenge(SKIN416	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	417	){	
	if(getChallenge(SKIN417	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	418	){	
	if(getChallenge(SKIN418	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	419	){	
	if(getChallenge(SKIN419	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	420	){	
	if(getChallenge(SKIN420	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	421	){	
	if(getChallenge(SKIN421	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	422	){	
	if(getChallenge(SKIN422	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	423	){	
	if(getChallenge(SKIN423	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	424	){	
	if(getChallenge(SKIN424	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	425	){	
	if(getChallenge(SKIN425	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	426	){	
	if(getChallenge(SKIN426	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	427	){	
	if(getChallenge(SKIN427	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	428	){	
	if(getChallenge(SKIN428	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	429	){	
	if(getChallenge(SKIN429	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	430	){	
	if(getChallenge(SKIN430	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	431	){	
	if(getChallenge(SKIN431	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	432	){	
	if(getChallenge(SKIN432	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	433	){	
	if(getChallenge(SKIN433	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	434	){	
	if(getChallenge(SKIN434	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	435	){	
	if(getChallenge(SKIN435	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	436	){	
	if(getChallenge(SKIN436	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	437	){	
	if(getChallenge(SKIN437	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	438	){	
	if(getChallenge(SKIN438	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	439	){	
	if(getChallenge(SKIN439	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	440	){	
	if(getChallenge(SKIN440	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	441	){	
	if(getChallenge(SKIN441	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	442	){	
	if(getChallenge(SKIN442	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	443	){	
	if(getChallenge(SKIN443	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	444	){	
	if(getChallenge(SKIN444	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	445	){	
	if(getChallenge(SKIN445	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	446	){	
	if(getChallenge(SKIN446	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	447	){	
	if(getChallenge(SKIN447	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	448	){	
	if(getChallenge(SKIN448	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	449	){	
	if(getChallenge(SKIN449	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	450	){	
	if(getChallenge(SKIN450	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	451	){	
	if(getChallenge(SKIN451	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	452	){	
	if(getChallenge(SKIN452	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	453	){	
	if(getChallenge(SKIN453	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	454	){	
	if(getChallenge(SKIN454	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	455	){	
	if(getChallenge(SKIN455	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	456	){	
	if(getChallenge(SKIN456	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	457	){	
	if(getChallenge(SKIN457	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	458	){	
	if(getChallenge(SKIN458	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	459	){	
	if(getChallenge(SKIN459	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	460	){	
	if(getChallenge(SKIN460	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	461	){	
	if(getChallenge(SKIN461	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	462	){	
	if(getChallenge(SKIN462	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	463	){	
	if(getChallenge(SKIN463	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	464	){	
	if(getChallenge(SKIN464	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	465	){	
	if(getChallenge(SKIN465	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	466	){	
	if(getChallenge(SKIN466	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	467	){	
	if(getChallenge(SKIN467	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	468	){	
	if(getChallenge(SKIN468	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	469	){	
	if(getChallenge(SKIN469	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	470	){	
	if(getChallenge(SKIN470	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	471	){	
	if(getChallenge(SKIN471	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	472	){	
	if(getChallenge(SKIN472	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	473	){	
	if(getChallenge(SKIN473	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	474	){	
	if(getChallenge(SKIN474	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	475	){	
	if(getChallenge(SKIN475	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	476	){	
	if(getChallenge(SKIN476	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	477	){	
	if(getChallenge(SKIN477	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	478	){	
	if(getChallenge(SKIN478	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	479	){	
	if(getChallenge(SKIN479	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	480	){	
	if(getChallenge(SKIN480	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	481	){	
	if(getChallenge(SKIN481	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	482	){	
	if(getChallenge(SKIN482	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	483	){	
	if(getChallenge(SKIN483	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	484	){	
	if(getChallenge(SKIN484	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	485	){	
	if(getChallenge(SKIN485	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	486	){	
	if(getChallenge(SKIN486	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	487	){	
	if(getChallenge(SKIN487	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	488	){	
	if(getChallenge(SKIN488	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	489	){	
	if(getChallenge(SKIN489	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	490	){	
	if(getChallenge(SKIN490	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	491	){	
	if(getChallenge(SKIN491	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	492	){	
	if(getChallenge(SKIN492	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	493	){	
	if(getChallenge(SKIN493	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	494	){	
	if(getChallenge(SKIN494	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	495	){	
	if(getChallenge(SKIN495	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	496	){	
	if(getChallenge(SKIN496	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	497	){	
	if(getChallenge(SKIN497	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	498	){	
	if(getChallenge(SKIN498	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	499	){	
	if(getChallenge(SKIN499	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	500	){	
	if(getChallenge(SKIN500	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	501	){	
	if(getChallenge(SKIN501	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	502	){	
	if(getChallenge(SKIN502	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	503	){	
	if(getChallenge(SKIN503	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	504	){	
	if(getChallenge(SKIN504	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	505	){	
	if(getChallenge(SKIN505	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	506	){	
	if(getChallenge(SKIN506	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	507	){	
	if(getChallenge(SKIN507	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	508	){	
	if(getChallenge(SKIN508	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	509	){	
	if(getChallenge(SKIN509	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	510	){	
	if(getChallenge(SKIN510	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	511	){	
	if(getChallenge(SKIN511	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	512	){	
	if(getChallenge(SKIN512	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	513	){	
	if(getChallenge(SKIN513	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	514	){	
	if(getChallenge(SKIN514	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	515	){	
	if(getChallenge(SKIN515	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	516	){	
	if(getChallenge(SKIN516	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	517	){	
	if(getChallenge(SKIN517	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	518	){	
	if(getChallenge(SKIN518	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	519	){	
	if(getChallenge(SKIN519	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	520	){	
	if(getChallenge(SKIN520	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	521	){	
	if(getChallenge(SKIN521	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	522	){	
	if(getChallenge(SKIN522	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	523	){	
	if(getChallenge(SKIN523	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	524	){	
	if(getChallenge(SKIN524	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	525	){	
	if(getChallenge(SKIN525	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	526	){	
	if(getChallenge(SKIN526	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	527	){	
	if(getChallenge(SKIN527	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	528	){	
	if(getChallenge(SKIN528	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	529	){	
	if(getChallenge(SKIN529	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	530	){	
	if(getChallenge(SKIN530	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	531	){	
	if(getChallenge(SKIN531	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	532	){	
	if(getChallenge(SKIN532	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	533	){	
	if(getChallenge(SKIN533	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	534	){	
	if(getChallenge(SKIN534	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	535	){	
	if(getChallenge(SKIN535	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	536	){	
	if(getChallenge(SKIN536	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	537	){	
	if(getChallenge(SKIN537	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	538	){	
	if(getChallenge(SKIN538	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	539	){	
	if(getChallenge(SKIN539	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	540	){	
	if(getChallenge(SKIN540	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	541	){	
	if(getChallenge(SKIN541	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	542	){	
	if(getChallenge(SKIN542	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	543	){	
	if(getChallenge(SKIN543	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	544	){	
	if(getChallenge(SKIN544	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	545	){	
	if(getChallenge(SKIN545	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	546	){	
	if(getChallenge(SKIN546	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	547	){	
	if(getChallenge(SKIN547	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	548	){	
	if(getChallenge(SKIN548	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	549	){	
	if(getChallenge(SKIN549	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	550	){	
	if(getChallenge(SKIN550	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	551	){	
	if(getChallenge(SKIN551	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	552	){	
	if(getChallenge(SKIN552	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	553	){	
	if(getChallenge(SKIN553	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	554	){	
	if(getChallenge(SKIN554	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	555	){	
	if(getChallenge(SKIN555	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	556	){	
	if(getChallenge(SKIN556	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	557	){	
	if(getChallenge(SKIN557	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	558	){	
	if(getChallenge(SKIN558	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	559	){	
	if(getChallenge(SKIN559	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	560	){	
	if(getChallenge(SKIN560	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	561	){	
	if(getChallenge(SKIN561	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	562	){	
	if(getChallenge(SKIN562	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	563	){	
	if(getChallenge(SKIN563	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	564	){	
	if(getChallenge(SKIN564	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	565	){	
	if(getChallenge(SKIN565	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	566	){	
	if(getChallenge(SKIN566	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	567	){	
	if(getChallenge(SKIN567	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	568	){	
	if(getChallenge(SKIN568	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	569	){	
	if(getChallenge(SKIN569	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	570	){	
	if(getChallenge(SKIN570	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	571	){	
	if(getChallenge(SKIN571	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	572	){	
	if(getChallenge(SKIN572	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	573	){	
	if(getChallenge(SKIN573	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	574	){	
	if(getChallenge(SKIN574	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	575	){	
	if(getChallenge(SKIN575	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	576	){	
	if(getChallenge(SKIN576	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	577	){	
	if(getChallenge(SKIN577	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	578	){	
	if(getChallenge(SKIN578	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	579	){	
	if(getChallenge(SKIN579	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	580	){	
	if(getChallenge(SKIN580	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	581	){	
	if(getChallenge(SKIN581	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	582	){	
	if(getChallenge(SKIN582	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	583	){	
	if(getChallenge(SKIN583	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	584	){	
	if(getChallenge(SKIN584	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	585	){	
	if(getChallenge(SKIN585	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	586	){	
	if(getChallenge(SKIN586	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	587	){	
	if(getChallenge(SKIN587	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	588	){	
	if(getChallenge(SKIN588	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	589	){	
	if(getChallenge(SKIN589	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	590	){	
	if(getChallenge(SKIN590	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	591	){	
	if(getChallenge(SKIN591	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	592	){	
	if(getChallenge(SKIN592	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	593	){	
	if(getChallenge(SKIN593	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	594	){	
	if(getChallenge(SKIN594	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	595	){	
	if(getChallenge(SKIN595	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	596	){	
	if(getChallenge(SKIN596	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	597	){	
	if(getChallenge(SKIN597	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	598	){	
	if(getChallenge(SKIN598	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	599	){	
	if(getChallenge(SKIN599	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	600	){	
	if(getChallenge(SKIN600	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	601	){	
	if(getChallenge(SKIN601	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	602	){	
	if(getChallenge(SKIN602	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	603	){	
	if(getChallenge(SKIN603	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	604	){	
	if(getChallenge(SKIN604	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	605	){	
	if(getChallenge(SKIN605	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	606	){	
	if(getChallenge(SKIN606	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	607	){	
	if(getChallenge(SKIN607	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	608	){	
	if(getChallenge(SKIN608	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	609	){	
	if(getChallenge(SKIN609	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	610	){	
	if(getChallenge(SKIN610	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	611	){	
	if(getChallenge(SKIN611	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	612	){	
	if(getChallenge(SKIN612	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	613	){	
	if(getChallenge(SKIN613	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	614	){	
	if(getChallenge(SKIN614	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	615	){	
	if(getChallenge(SKIN615	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	616	){	
	if(getChallenge(SKIN616	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	617	){	
	if(getChallenge(SKIN617	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	618	){	
	if(getChallenge(SKIN618	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	619	){	
	if(getChallenge(SKIN619	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	620	){	
	if(getChallenge(SKIN620	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	621	){	
	if(getChallenge(SKIN621	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	622	){	
	if(getChallenge(SKIN622	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	623	){	
	if(getChallenge(SKIN623	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	624	){	
	if(getChallenge(SKIN624	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	625	){	
	if(getChallenge(SKIN625	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	626	){	
	if(getChallenge(SKIN626	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	627	){	
	if(getChallenge(SKIN627	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	628	){	
	if(getChallenge(SKIN628	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	629	){	
	if(getChallenge(SKIN629	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	630	){	
	if(getChallenge(SKIN630	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	631	){	
	if(getChallenge(SKIN631	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	632	){	
	if(getChallenge(SKIN632	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	633	){	
	if(getChallenge(SKIN633	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	634	){	
	if(getChallenge(SKIN634	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	635	){	
	if(getChallenge(SKIN635	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	636	){	
	if(getChallenge(SKIN636	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	637	){	
	if(getChallenge(SKIN637	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	638	){	
	if(getChallenge(SKIN638	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	639	){	
	if(getChallenge(SKIN639	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	640	){	
	if(getChallenge(SKIN640	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	641	){	
	if(getChallenge(SKIN641	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	642	){	
	if(getChallenge(SKIN642	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	643	){	
	if(getChallenge(SKIN643	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	644	){	
	if(getChallenge(SKIN644	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	645	){	
	if(getChallenge(SKIN645	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	646	){	
	if(getChallenge(SKIN646	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	647	){	
	if(getChallenge(SKIN647	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	648	){	
	if(getChallenge(SKIN648	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	649	){	
	if(getChallenge(SKIN649	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	650	){	
	if(getChallenge(SKIN650	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	651	){	
	if(getChallenge(SKIN651	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	652	){	
	if(getChallenge(SKIN652	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	653	){	
	if(getChallenge(SKIN653	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	654	){	
	if(getChallenge(SKIN654	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	655	){	
	if(getChallenge(SKIN655	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	656	){	
	if(getChallenge(SKIN656	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	657	){	
	if(getChallenge(SKIN657	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	658	){	
	if(getChallenge(SKIN658	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	659	){	
	if(getChallenge(SKIN659	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	660	){	
	if(getChallenge(SKIN660	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	661	){	
	if(getChallenge(SKIN661	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	662	){	
	if(getChallenge(SKIN662	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	663	){	
	if(getChallenge(SKIN663	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	664	){	
	if(getChallenge(SKIN664	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	665	){	
	if(getChallenge(SKIN665	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	666	){	
	if(getChallenge(SKIN666	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	667	){	
	if(getChallenge(SKIN667	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	668	){	
	if(getChallenge(SKIN668	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	669	){	
	if(getChallenge(SKIN669	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	670	){	
	if(getChallenge(SKIN670	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	671	){	
	if(getChallenge(SKIN671	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	672	){	
	if(getChallenge(SKIN672	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	673	){	
	if(getChallenge(SKIN673	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	674	){	
	if(getChallenge(SKIN674	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	675	){	
	if(getChallenge(SKIN675	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	676	){	
	if(getChallenge(SKIN676	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	677	){	
	if(getChallenge(SKIN677	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	678	){	
	if(getChallenge(SKIN678	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	679	){	
	if(getChallenge(SKIN679	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	680	){	
	if(getChallenge(SKIN680	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	681	){	
	if(getChallenge(SKIN681	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	682	){	
	if(getChallenge(SKIN682	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	683	){	
	if(getChallenge(SKIN683	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	684	){	
	if(getChallenge(SKIN684	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	685	){	
	if(getChallenge(SKIN685	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	686	){	
	if(getChallenge(SKIN686	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	687	){	
	if(getChallenge(SKIN687	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	688	){	
	if(getChallenge(SKIN688	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	689	){	
	if(getChallenge(SKIN689	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	690	){	
	if(getChallenge(SKIN690	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	691	){	
	if(getChallenge(SKIN691	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	692	){	
	if(getChallenge(SKIN692	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	693	){	
	if(getChallenge(SKIN693	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	694	){	
	if(getChallenge(SKIN694	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	695	){	
	if(getChallenge(SKIN695	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	696	){	
	if(getChallenge(SKIN696	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	697	){	
	if(getChallenge(SKIN697	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	698	){	
	if(getChallenge(SKIN698	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	699	){	
	if(getChallenge(SKIN699	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	700	){	
	if(getChallenge(SKIN700	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	701	){	
	if(getChallenge(SKIN701	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	702	){	
	if(getChallenge(SKIN702	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	703	){	
	if(getChallenge(SKIN703	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	704	){	
	if(getChallenge(SKIN704	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	705	){	
	if(getChallenge(SKIN705	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	706	){	
	if(getChallenge(SKIN706	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	707	){	
	if(getChallenge(SKIN707	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	708	){	
	if(getChallenge(SKIN708	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	709	){	
	if(getChallenge(SKIN709	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	710	){	
	if(getChallenge(SKIN710	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	711	){	
	if(getChallenge(SKIN711	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	712	){	
	if(getChallenge(SKIN712	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	713	){	
	if(getChallenge(SKIN713	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	714	){	
	if(getChallenge(SKIN714	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	715	){	
	if(getChallenge(SKIN715	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	716	){	
	if(getChallenge(SKIN716	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	717	){	
	if(getChallenge(SKIN717	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	718	){	
	if(getChallenge(SKIN718	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	719	){	
	if(getChallenge(SKIN719	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	720	){	
	if(getChallenge(SKIN720	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	721	){	
	if(getChallenge(SKIN721	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	722	){	
	if(getChallenge(SKIN722	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	723	){	
	if(getChallenge(SKIN723	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	724	){	
	if(getChallenge(SKIN724	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	725	){	
	if(getChallenge(SKIN725	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	726	){	
	if(getChallenge(SKIN726	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	727	){	
	if(getChallenge(SKIN727	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	728	){	
	if(getChallenge(SKIN728	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	729	){	
	if(getChallenge(SKIN729	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	730	){	
	if(getChallenge(SKIN730	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	731	){	
	if(getChallenge(SKIN731	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	732	){	
	if(getChallenge(SKIN732	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	733	){	
	if(getChallenge(SKIN733	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	734	){	
	if(getChallenge(SKIN734	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	735	){	
	if(getChallenge(SKIN735	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	736	){	
	if(getChallenge(SKIN736	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	737	){	
	if(getChallenge(SKIN737	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	738	){	
	if(getChallenge(SKIN738	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	739	){	
	if(getChallenge(SKIN739	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	740	){	
	if(getChallenge(SKIN740	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	741	){	
	if(getChallenge(SKIN741	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	742	){	
	if(getChallenge(SKIN742	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	743	){	
	if(getChallenge(SKIN743	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	744	){	
	if(getChallenge(SKIN744	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	745	){	
	if(getChallenge(SKIN745	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	746	){	
	if(getChallenge(SKIN746	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	747	){	
	if(getChallenge(SKIN747	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	748	){	
	if(getChallenge(SKIN748	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	749	){	
	if(getChallenge(SKIN749	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	750	){	
	if(getChallenge(SKIN750	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	751	){	
	if(getChallenge(SKIN751	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	752	){	
	if(getChallenge(SKIN752	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	753	){	
	if(getChallenge(SKIN753	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	754	){	
	if(getChallenge(SKIN754	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	755	){	
	if(getChallenge(SKIN755	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	756	){	
	if(getChallenge(SKIN756	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	757	){	
	if(getChallenge(SKIN757	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	758	){	
	if(getChallenge(SKIN758	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	759	){	
	if(getChallenge(SKIN759	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	760	){	
	if(getChallenge(SKIN760	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	761	){	
	if(getChallenge(SKIN761	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	762	){	
	if(getChallenge(SKIN762	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	763	){	
	if(getChallenge(SKIN763	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	764	){	
	if(getChallenge(SKIN764	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	765	){	
	if(getChallenge(SKIN765	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	766	){	
	if(getChallenge(SKIN766	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	767	){	
	if(getChallenge(SKIN767	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	768	){	
	if(getChallenge(SKIN768	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	769	){	
	if(getChallenge(SKIN769	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	770	){	
	if(getChallenge(SKIN770	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	771	){	
	if(getChallenge(SKIN771	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	772	){	
	if(getChallenge(SKIN772	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	773	){	
	if(getChallenge(SKIN773	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	774	){	
	if(getChallenge(SKIN774	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	775	){	
	if(getChallenge(SKIN775	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	776	){	
	if(getChallenge(SKIN776	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	777	){	
	if(getChallenge(SKIN777	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	778	){	
	if(getChallenge(SKIN778	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	779	){	
	if(getChallenge(SKIN779	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	780	){	
	if(getChallenge(SKIN780	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	781	){	
	if(getChallenge(SKIN781	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	782	){	
	if(getChallenge(SKIN782	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	783	){	
	if(getChallenge(SKIN783	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	784	){	
	if(getChallenge(SKIN784	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	785	){	
	if(getChallenge(SKIN785	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	786	){	
	if(getChallenge(SKIN786	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	787	){	
	if(getChallenge(SKIN787	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	788	){	
	if(getChallenge(SKIN788	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	789	){	
	if(getChallenge(SKIN789	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	790	){	
	if(getChallenge(SKIN790	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	791	){	
	if(getChallenge(SKIN791	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	792	){	
	if(getChallenge(SKIN792	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	793	){	
	if(getChallenge(SKIN793	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	794	){	
	if(getChallenge(SKIN794	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	795	){	
	if(getChallenge(SKIN795	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	796	){	
	if(getChallenge(SKIN796	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	797	){	
	if(getChallenge(SKIN797	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	798	){	
	if(getChallenge(SKIN798	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	799	){	
	if(getChallenge(SKIN799	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	800	){	
	if(getChallenge(SKIN800	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	801	){	
	if(getChallenge(SKIN801	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	802	){	
	if(getChallenge(SKIN802	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	803	){	
	if(getChallenge(SKIN803	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	804	){	
	if(getChallenge(SKIN804	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	805	){	
	if(getChallenge(SKIN805	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	806	){	
	if(getChallenge(SKIN806	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	807	){	
	if(getChallenge(SKIN807	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	808	){	
	if(getChallenge(SKIN808	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	809	){	
	if(getChallenge(SKIN809	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	810	){	
	if(getChallenge(SKIN810	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	811	){	
	if(getChallenge(SKIN811	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	812	){	
	if(getChallenge(SKIN812	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	813	){	
	if(getChallenge(SKIN813	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	814	){	
	if(getChallenge(SKIN814	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	815	){	
	if(getChallenge(SKIN815	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	816	){	
	if(getChallenge(SKIN816	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	817	){	
	if(getChallenge(SKIN817	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	818	){	
	if(getChallenge(SKIN818	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	819	){	
	if(getChallenge(SKIN819	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	820	){	
	if(getChallenge(SKIN820	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	821	){	
	if(getChallenge(SKIN821	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	822	){	
	if(getChallenge(SKIN822	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	823	){	
	if(getChallenge(SKIN823	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	824	){	
	if(getChallenge(SKIN824	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	825	){	
	if(getChallenge(SKIN825	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	826	){	
	if(getChallenge(SKIN826	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	827	){	
	if(getChallenge(SKIN827	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	828	){	
	if(getChallenge(SKIN828	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	829	){	
	if(getChallenge(SKIN829	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	830	){	
	if(getChallenge(SKIN830	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	831	){	
	if(getChallenge(SKIN831	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	832	){	
	if(getChallenge(SKIN832	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	833	){	
	if(getChallenge(SKIN833	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	834	){	
	if(getChallenge(SKIN834	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	835	){	
	if(getChallenge(SKIN835	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	836	){	
	if(getChallenge(SKIN836	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	837	){	
	if(getChallenge(SKIN837	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	838	){	
	if(getChallenge(SKIN838	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	839	){	
	if(getChallenge(SKIN839	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	840	){	
	if(getChallenge(SKIN840	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	841	){	
	if(getChallenge(SKIN841	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	842	){	
	if(getChallenge(SKIN842	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	843	){	
	if(getChallenge(SKIN843	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	844	){	
	if(getChallenge(SKIN844	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	845	){	
	if(getChallenge(SKIN845	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	846	){	
	if(getChallenge(SKIN846	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	847	){	
	if(getChallenge(SKIN847	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	848	){	
	if(getChallenge(SKIN848	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	849	){	
	if(getChallenge(SKIN849	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	850	){	
	if(getChallenge(SKIN850	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	851	){	
	if(getChallenge(SKIN851	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	852	){	
	if(getChallenge(SKIN852	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	853	){	
	if(getChallenge(SKIN853	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	854	){	
	if(getChallenge(SKIN854	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	855	){	
	if(getChallenge(SKIN855	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	856	){	
	if(getChallenge(SKIN856	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	857	){	
	if(getChallenge(SKIN857	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	858	){	
	if(getChallenge(SKIN858	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	859	){	
	if(getChallenge(SKIN859	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	860	){	
	if(getChallenge(SKIN860	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	861	){	
	if(getChallenge(SKIN861	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	862	){	
	if(getChallenge(SKIN862	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	863	){	
	if(getChallenge(SKIN863	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	864	){	
	if(getChallenge(SKIN864	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	865	){	
	if(getChallenge(SKIN865	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	866	){	
	if(getChallenge(SKIN866	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	867	){	
	if(getChallenge(SKIN867	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	868	){	
	if(getChallenge(SKIN868	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	869	){	
	if(getChallenge(SKIN869	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	870	){	
	if(getChallenge(SKIN870	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	871	){	
	if(getChallenge(SKIN871	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	872	){	
	if(getChallenge(SKIN872	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	873	){	
	if(getChallenge(SKIN873	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	874	){	
	if(getChallenge(SKIN874	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	875	){	
	if(getChallenge(SKIN875	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	876	){	
	if(getChallenge(SKIN876	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	877	){	
	if(getChallenge(SKIN877	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	878	){	
	if(getChallenge(SKIN878	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	879	){	
	if(getChallenge(SKIN879	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	880	){	
	if(getChallenge(SKIN880	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	881	){	
	if(getChallenge(SKIN881	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	882	){	
	if(getChallenge(SKIN882	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	883	){	
	if(getChallenge(SKIN883	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	884	){	
	if(getChallenge(SKIN884	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	885	){	
	if(getChallenge(SKIN885	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	886	){	
	if(getChallenge(SKIN886	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	887	){	
	if(getChallenge(SKIN887	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	888	){	
	if(getChallenge(SKIN888	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	889	){	
	if(getChallenge(SKIN889	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	890	){	
	if(getChallenge(SKIN890	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	891	){	
	if(getChallenge(SKIN891	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	892	){	
	if(getChallenge(SKIN892	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	893	){	
	if(getChallenge(SKIN893	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	894	){	
	if(getChallenge(SKIN894	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	895	){	
	if(getChallenge(SKIN895	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	896	){	
	if(getChallenge(SKIN896	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	897	){	
	if(getChallenge(SKIN897	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	898	){	
	if(getChallenge(SKIN898	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	899	){	
	if(getChallenge(SKIN899	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	900	){	
	if(getChallenge(SKIN900	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	901	){	
	if(getChallenge(SKIN901	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	902	){	
	if(getChallenge(SKIN902	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	903	){	
	if(getChallenge(SKIN903	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	904	){	
	if(getChallenge(SKIN904	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	905	){	
	if(getChallenge(SKIN905	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	906	){	
	if(getChallenge(SKIN906	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	907	){	
	if(getChallenge(SKIN907	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	908	){	
	if(getChallenge(SKIN908	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	909	){	
	if(getChallenge(SKIN909	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	910	){	
	if(getChallenge(SKIN910	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	911	){	
	if(getChallenge(SKIN911	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	912	){	
	if(getChallenge(SKIN912	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	913	){	
	if(getChallenge(SKIN913	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	914	){	
	if(getChallenge(SKIN914	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	915	){	
	if(getChallenge(SKIN915	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	916	){	
	if(getChallenge(SKIN916	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	917	){	
	if(getChallenge(SKIN917	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	918	){	
	if(getChallenge(SKIN918	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	919	){	
	if(getChallenge(SKIN919	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	920	){	
	if(getChallenge(SKIN920	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	921	){	
	if(getChallenge(SKIN921	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	922	){	
	if(getChallenge(SKIN922	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	923	){	
	if(getChallenge(SKIN923	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	924	){	
	if(getChallenge(SKIN924	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	925	){	
	if(getChallenge(SKIN925	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	926	){	
	if(getChallenge(SKIN926	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	927	){	
	if(getChallenge(SKIN927	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	928	){	
	if(getChallenge(SKIN928	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	929	){	
	if(getChallenge(SKIN929	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	930	){	
	if(getChallenge(SKIN930	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	931	){	
	if(getChallenge(SKIN931	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	932	){	
	if(getChallenge(SKIN932	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	933	){	
	if(getChallenge(SKIN933	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	934	){	
	if(getChallenge(SKIN934	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	935	){	
	if(getChallenge(SKIN935	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	936	){	
	if(getChallenge(SKIN936	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	937	){	
	if(getChallenge(SKIN937	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	938	){	
	if(getChallenge(SKIN938	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	939	){	
	if(getChallenge(SKIN939	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	940	){	
	if(getChallenge(SKIN940	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	941	){	
	if(getChallenge(SKIN941	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	942	){	
	if(getChallenge(SKIN942	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	943	){	
	if(getChallenge(SKIN943	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	944	){	
	if(getChallenge(SKIN944	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	945	){	
	if(getChallenge(SKIN945	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	946	){	
	if(getChallenge(SKIN946	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	947	){	
	if(getChallenge(SKIN947	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	948	){	
	if(getChallenge(SKIN948	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	949	){	
	if(getChallenge(SKIN949	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	950	){	
	if(getChallenge(SKIN950	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	951	){	
	if(getChallenge(SKIN951	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	952	){	
	if(getChallenge(SKIN952	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	953	){	
	if(getChallenge(SKIN953	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	954	){	
	if(getChallenge(SKIN954	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	955	){	
	if(getChallenge(SKIN955	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	956	){	
	if(getChallenge(SKIN956	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	957	){	
	if(getChallenge(SKIN957	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	958	){	
	if(getChallenge(SKIN958	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	959	){	
	if(getChallenge(SKIN959	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	960	){	
	if(getChallenge(SKIN960	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	961	){	
	if(getChallenge(SKIN961	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	962	){	
	if(getChallenge(SKIN962	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	963	){	
	if(getChallenge(SKIN963	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	964	){	
	if(getChallenge(SKIN964	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	965	){	
	if(getChallenge(SKIN965	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	966	){	
	if(getChallenge(SKIN966	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	967	){	
	if(getChallenge(SKIN967	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	968	){	
	if(getChallenge(SKIN968	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	969	){	
	if(getChallenge(SKIN969	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	970	){	
	if(getChallenge(SKIN970	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	971	){	
	if(getChallenge(SKIN971	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	972	){	
	if(getChallenge(SKIN972	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	973	){	
	if(getChallenge(SKIN973	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	974	){	
	if(getChallenge(SKIN974	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	975	){	
	if(getChallenge(SKIN975	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	976	){	
	if(getChallenge(SKIN976	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	977	){	
	if(getChallenge(SKIN977	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	978	){	
	if(getChallenge(SKIN978	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	979	){	
	if(getChallenge(SKIN979	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	980	){	
	if(getChallenge(SKIN980	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	981	){	
	if(getChallenge(SKIN981	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	982	){	
	if(getChallenge(SKIN982	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	983	){	
	if(getChallenge(SKIN983	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	984	){	
	if(getChallenge(SKIN984	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	985	){	
	if(getChallenge(SKIN985	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	986	){	
	if(getChallenge(SKIN986	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	987	){	
	if(getChallenge(SKIN987	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	988	){	
	if(getChallenge(SKIN988	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	989	){	
	if(getChallenge(SKIN989	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	990	){	
	if(getChallenge(SKIN990	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	991	){	
	if(getChallenge(SKIN991	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	992	){	
	if(getChallenge(SKIN992	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	993	){	
	if(getChallenge(SKIN993	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	994	){	
	if(getChallenge(SKIN994	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	995	){	
	if(getChallenge(SKIN995	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	996	){	
	if(getChallenge(SKIN996	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	997	){	
	if(getChallenge(SKIN997	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	998	){	
	if(getChallenge(SKIN998	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}			
if(j == 	999	){	
	if(getChallenge(SKIN999	) == 0){
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
	}		
}					
		}
		else
		{
			// dead slot
 			s_playermodel.pics[i].generic.name         = NULL;
			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
		}

 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
 		s_playermodel.pics[i].shader               = 0;
 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
	}

	if (s_playermodel.selectedmodel/MAX_MODELSPERPAGE == s_playermodel.modelpage)
	{
		// set selected model
		i = s_playermodel.selectedmodel % MAX_MODELSPERPAGE;

		s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
		s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
	}

	if (s_playermodel.numpages > 1)
	{
		if (s_playermodel.modelpage > 0)
			s_playermodel.left.generic.flags &= ~QMF_INACTIVE;
		else
			s_playermodel.left.generic.flags |= QMF_INACTIVE;

		if (s_playermodel.modelpage < s_playermodel.numpages-1)
			s_playermodel.right.generic.flags &= ~QMF_INACTIVE;
		else
			s_playermodel.right.generic.flags |= QMF_INACTIVE;
	}
	else
	{
		// hide left/right markers
		s_playermodel.left.generic.flags |= QMF_INACTIVE;
		s_playermodel.right.generic.flags |= QMF_INACTIVE;
	}
}

/*
=================
PlayerModel_UpdateModel
=================
*/
static void PlayerModel_UpdateModel( void )
{
	vec3_t	viewangles;
	vec3_t	moveangles;

	memset( &s_playermodel.playerinfo, 0, sizeof(playerInfo_t) );
	
	
	
	viewangles[YAW]   = 180 - 10;
	viewangles[PITCH] = 0;
	viewangles[ROLL]  = 0;
	VectorClear( moveangles );

	UI_PlayerInfo_SetModel( &s_playermodel.playerinfo, s_playermodel.modelskin );
	UI_PlayerInfo_SetInfo( &s_playermodel.playerinfo, LEGS_IDLE, TORSO_STAND2, viewangles, moveangles, WP_NONE, qfalse );
}

/*
=================
PlayerModel_SaveChanges
=================
*/
static void PlayerModel_SaveChanges( void )
{
	trap_Cvar_Set( "ui_char", "1" );
	trap_Cvar_Set( "ui_actionmenu", "0" );
if(ui_headmodel.integer == 0){
if(ui_legsmodel.integer == 0){
	trap_Cvar_Set( "model", s_playermodel.modelskin );
	trap_Cvar_Set( "team_model", s_playermodel.modelskin );
	trap_Cvar_Set( "headmodel", s_playermodel.modelskin );
	trap_Cvar_Set( "team_headmodel", s_playermodel.modelskin );
}
}
	
if(ui_legsmodel.integer == 1){
//	trap_Cvar_Set( "model", s_playermodel.modelskin );
//	trap_Cvar_Set( "team_model", s_playermodel.modelskin );
//	trap_Cvar_Set( "headmodel", s_playermodel.modelskin );
//	trap_Cvar_Set( "team_headmodel", s_playermodel.modelskin );
}

if(ui_headmodel.integer == 1){
//	trap_Cvar_Set( "model", s_playermodel.modelskin );
//	trap_Cvar_Set( "team_model", s_playermodel.modelskin );
	trap_Cvar_Set( "headmodel", s_playermodel.modelskin );
	trap_Cvar_Set( "team_headmodel", s_playermodel.modelskin );
}
	
/*if(ui_headmodel.integer == 0){
if(ui_legsmodel.integer == 0){
trap_Cvar_Set( "ui_msheadmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msheadskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
}
}
if(ui_headmodel.integer == 1){
trap_Cvar_Set( "ui_msheadmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msheadskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
//trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
}
if(ui_legsmodel.integer == 1){
//trap_Cvar_Set( "ui_msheadmodel", 	s_playermodel.modelname.string );
//trap_Cvar_Set( "ui_msheadskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
//trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
}*/

}

/*
=================
PlayerModel_MenuEvent
=================
*/
static void PlayerModel_MenuEvent( void* ptr, int event )
{
	if (event != QM_ACTIVATED)
		return;

	switch (((menucommon_s*)ptr)->id)
	{
		case ID_PREVPAGE:
			if (s_playermodel.modelpage > 0)
			{
				s_playermodel.modelpage--;
				PlayerModel_UpdateGrid();
			}
			break;

		case ID_NEXTPAGE:
			if (s_playermodel.modelpage < s_playermodel.numpages-1)
			{
				s_playermodel.modelpage++;
				PlayerModel_UpdateGrid();
			}
			break;

		case ID_BACK:
			PlayerModel_SaveChanges();
			UI_PopMenu();
			UI_PopMenu();
			break;
	}
}

/*
=================
PlayerModel_MenuKey
=================
*/
static sfxHandle_t PlayerModel_MenuKey( int key )
{
	menucommon_s*	m;
	int				picnum;

	switch (key)
	{
		case K_KP_LEFTARROW:
		case K_LEFTARROW:
			m = Menu_ItemAtCursor(&s_playermodel.menu);
			picnum = m->id - ID_PLAYERPIC0;
			if (picnum >= 0 && picnum <= 15)
			{
				if (picnum > 0)
				{
					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-1);
					return (menu_move_sound);
					
				}
				else if (s_playermodel.modelpage > 0)
				{
					s_playermodel.modelpage--;
					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+15);
					PlayerModel_UpdateGrid();
					return (menu_move_sound);
				}
				else
					return (menu_buzz_sound);
			}
			break;

		case K_KP_RIGHTARROW:
		case K_RIGHTARROW:
			m = Menu_ItemAtCursor(&s_playermodel.menu);
			picnum = m->id - ID_PLAYERPIC0;
			if (picnum >= 0 && picnum <= 15)
			{
				if ((picnum < 15) && (s_playermodel.modelpage*MAX_MODELSPERPAGE + picnum+1 < s_playermodel.nummodels))
				{
					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+1);
					return (menu_move_sound);
				}					
				else if ((picnum == 15) && (s_playermodel.modelpage < s_playermodel.numpages-1))
				{
					s_playermodel.modelpage++;
					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-15);
					PlayerModel_UpdateGrid();
					return (menu_move_sound);
				}
				else
					return (menu_buzz_sound);
			}
			break;
			
		case K_MOUSE2:
		case K_ESCAPE:
			PlayerModel_SaveChanges();
			UI_PopMenu();
			break;
	}

	return ( Menu_DefaultKey( &s_playermodel.menu, key ) );
}

/*
=================
PlayerModel_PicEvent
=================
*/
static void PlayerModel_PicEvent( void* ptr, int event )
{
	int				modelnum;
	int				maxlen;
	char*			buffptr;
	char*			pdest;
	int				i;

	if (event != QM_ACTIVATED)
		return;

	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++)
	{
		// reset
 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
	}
	
	// set selected
	i = ((menucommon_s*)ptr)->id - ID_PLAYERPIC0;
	s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
	s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;

	// get model and strip icon_
	modelnum = s_playermodel.modelpage*MAX_MODELSPERPAGE + i;
	buffptr  = s_playermodel.modelnames[modelnum] + strlen("models/players/");
	pdest    = strstr(buffptr,"icon_");
	if (pdest)
	{
		// track the whole model/skin name
		Q_strncpyz(s_playermodel.modelskin,buffptr,pdest-buffptr+1);
		strcat(s_playermodel.modelskin,pdest + 5);

		// seperate the model name
		maxlen = pdest-buffptr;
		if (maxlen > 16)
			maxlen = 16;
		Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
		Q_strupr( s_playermodel.modelname.string );

		// seperate the skin name
		maxlen = strlen(pdest+5)+1;
		if (maxlen > 16)
			maxlen = 16;
		Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
		Q_strupr( s_playermodel.skinname.string );

		s_playermodel.selectedmodel = modelnum;		

if(ui_headmodel.integer == 0){
if(ui_legsmodel.integer == 0){
trap_Cvar_Set( "ui_msheadmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msheadskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
}
}
if(ui_headmodel.integer == 1){
trap_Cvar_Set( "ui_msheadmodel", 	s_playermodel.modelname.string );
trap_Cvar_Set( "ui_msheadskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
//trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
}
if(ui_legsmodel.integer == 1){
//trap_Cvar_Set( "ui_msheadmodel", 	"BERET" );
//trap_Cvar_Set( "ui_msheadskin", 	"NOHEAD" );
//trap_Cvar_Set( "ui_msmodel", 	s_playermodel.modelname.string );
//trap_Cvar_Set( "ui_msskin", 	s_playermodel.skinname.string );
trap_Cvar_Set( "ui_mslegsskin", 	s_playermodel.skinname.string );
//trap_Cvar_Set( "headmodel", 	"beret/nohead" );
trap_Cvar_Set( "team_headmodel", 	"beret/nohead" );
}

		if( trap_MemoryRemaining() > LOW_MEMORY ) {
			PlayerModel_UpdateModel();
		}
	}
}

/*
=================
PlayerModel_DrawPlayer
=================
*/
static void PlayerModel_DrawPlayer( void *self )
{
	menubitmap_s*	b;

	b = (menubitmap_s*) self;

	if( trap_MemoryRemaining() <= LOW_MEMORY ) {
		UI_DrawProportionalString( b->generic.x, b->generic.y + b->height / 2, "LOW MEMORY", UI_LEFT, color_red );
		return;
	}

	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_playermodel.playerinfo, uis.realtime/2 );
	
	if(ui_headmodel.integer == 0){
if(ui_legsmodel.integer == 0){
if(!rus.integer){
	UI_DrawProportionalString( 320, 16, "PLAYER MODEL", UI_CENTER|UI_BIGFONT, text_color_normal );
}
if(rus.integer){
	UI_DrawProportionalString( 320, 16, "МОДЕЛЬ ИГРОКА", UI_CENTER|UI_BIGFONT, text_color_normal );
}
}
}

if(ui_legsmodel.integer == 1){
if(!rus.integer){
	UI_DrawProportionalString( 320, 16, "LEGS MODEL", UI_CENTER|UI_BIGFONT, text_color_normal );
}
if(rus.integer){
	UI_DrawProportionalString( 320, 16, "МОДЕЛЬ НОГ", UI_CENTER|UI_BIGFONT, text_color_normal );
}
}

if(ui_headmodel.integer == 1){
if(!rus.integer){
	UI_DrawProportionalString( 320, 16, "HEAD MODEL", UI_CENTER|UI_BIGFONT, text_color_normal );
}
if(rus.integer){
	UI_DrawProportionalString( 320, 16, "МОДЕЛЬ ГОЛОВЫ", UI_CENTER|UI_BIGFONT, text_color_normal );
}
}
	
}

/*
=================
PlayerModel_BuildList
=================
*/
static void PlayerModel_BuildList( int type )
{
	int		numdirs;
	int		numfiles;
	char	dirlist[2048];
	char	filelist[2048];
	char	skinname[MAX_QPATH];
	char*	dirptr;
	char*	fileptr;
	int		i;
	int		coin;
	int		j;
	int		dirlen;
	int		filelen;
	qboolean precache;

	precache = trap_Cvar_VariableValue("com_buildscript");

	s_playermodel.modelpage = 0;
	s_playermodel.nummodels = 0;

if(type == 1){
	// iterate directory of all player models
	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048 );
	dirptr  = dirlist;
	if(0 == 0){
	for (i=0; i<numdirs && s_playermodel.nummodels < 9999999; i++,dirptr+=dirlen+1)
	{
		dirlen = strlen(dirptr);
		
		if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';


		if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
			continue;
			
		// iterate all skin files in directory
		numfiles = trap_FS_GetFileList( va("models/players/%s",dirptr), "tga", filelist, 2048 );
		fileptr  = filelist;
		for (j=0; j<numfiles && s_playermodel.nummodels < 9999999;j++,fileptr+=filelen+1)
		{
			filelen = strlen(fileptr);

			COM_StripExtension(fileptr,skinname, sizeof(skinname));

			// look for icon_????
			if (!Q_stricmpn(skinname,"icon_",5))
			{
	
			Com_sprintf( s_playermodel.modelnames[s_playermodel.nummodels++],
					sizeof( s_playermodel.modelnames[s_playermodel.nummodels] ),
					"models/players/%s/%s", dirptr, skinname );
			//	coin = (playerxp.integer + ui_skinprice.integer) / ui_skinprice.integer / 2;
			//	if (numdirs >= coin)
			//		return;
			}

			if( precache ) {
				trap_S_RegisterSound( va( "sound/player/announce/%s_wins.wav", skinname), qfalse );
			}
		}
	}	
	}
}



	//APSFIXME - Degenerate no models case

	s_playermodel.numpages = s_playermodel.nummodels/MAX_MODELSPERPAGE;
	if (s_playermodel.nummodels % MAX_MODELSPERPAGE)
		s_playermodel.numpages++;
}










/*
=================
PlayerModel_BuildList
=================
*/
static void PlayerModel_Random( int type )
{
	int		numdirs;
	int		numfiles;
	char	dirlist[2048];
	char	filelist[2048];
	char	skinname[MAX_QPATH];
	char*	dirptr;
	char*	fileptr;
	int		i;
	int		coin;
	int		j;
	int		dirlen;
	int		filelen;
	qboolean precache;



}














/*
=================
PlayerModel_SetMenuItems
=================
*/
static void PlayerModel_SetMenuItems( void )
{
	int				i;
	int				maxlen;
	char			modelskin[64];
	char*			buffptr;
	char*			pdest;

	// name
	trap_Cvar_VariableStringBuffer( "name", s_playermodel.playername.string, 16 );
	Q_CleanStr( s_playermodel.playername.string );

	// model
	trap_Cvar_VariableStringBuffer( "model", s_playermodel.modelskin, 64 );
	
	// use default skin if none is set
	if (!strchr(s_playermodel.modelskin, '/')) {
		Q_strcat(s_playermodel.modelskin, 64, "/default");
	}
	
	// find model in our list
	for (i=0; i<s_playermodel.nummodels; i++)
	{
		// strip icon_
		buffptr  = s_playermodel.modelnames[i] + strlen("models/players/");
		pdest    = strstr(buffptr,"icon_");
		if (pdest)
		{
			Q_strncpyz(modelskin,buffptr,pdest-buffptr+1);
			strcat(modelskin,pdest + 5);
		}
		else
			continue;

		if (!Q_stricmp( s_playermodel.modelskin, modelskin ))
		{
			// found pic, set selection here		
			s_playermodel.selectedmodel = i;
			s_playermodel.modelpage     = i/MAX_MODELSPERPAGE;

			// seperate the model name
			maxlen = pdest-buffptr;
			if (maxlen > 16)
				maxlen = 16;
			Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
			Q_strupr( s_playermodel.modelname.string );

			// seperate the skin name
			maxlen = strlen(pdest+5)+1;
			if (maxlen > 16)
				maxlen = 16;
			Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
			Q_strupr( s_playermodel.skinname.string );
			break;
		}
	}
}

/*
=================
PlayerModel_MenuInit
=================
*/
static void PlayerModel_MenuInit( int type )
{
	int			i;
	int			j;
	int			k;
	int			x;
	int			y;
	static char	playername[32];
	static char	modelname[32];
	static char	skinname[32];

	// zero set all our globals
	memset( &s_playermodel, 0 ,sizeof(playermodel_t) );

	PlayerModel_Cache( type );

	s_playermodel.menu.key        = PlayerModel_MenuKey;
	s_playermodel.menu.wrapAround = qtrue;
	s_playermodel.menu.fullscreen = qtrue;

	s_playermodel.banner.generic.type  = MTYPE_BTEXT;
	s_playermodel.banner.generic.x     = 320;
	s_playermodel.banner.generic.y     = 16;
if(ui_headmodel.integer == 0){
if(!rus.integer){
	s_playermodel.banner.string        = "PLAYER MODEL";
}
if(rus.integer){
	s_playermodel.banner.string        = "МОДЕЛЬ ИГРОКА";
}
}
if(ui_headmodel.integer == 1){
if(!rus.integer){
	s_playermodel.banner.string        = "HEAD MODEL AND LEGS";
}
if(rus.integer){
	s_playermodel.banner.string        = "МОДЕЛЬ ГОЛОВЫ И НОГ";
}
}
if(ui_legsmodel.integer == 1){
if(!rus.integer){
	s_playermodel.banner.string        = "LEGS MODEL";
}
if(rus.integer){
	s_playermodel.banner.string        = "МОДЕЛЬ НОГ";
}
}
	s_playermodel.banner.color         = color_white;
	s_playermodel.banner.style         = UI_CENTER;

	s_playermodel.framel.generic.type  = MTYPE_BITMAP;
	s_playermodel.framel.generic.name  = MODEL_FRAMEL;
	s_playermodel.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_playermodel.framel.generic.x     = 0;
	s_playermodel.framel.generic.y     = 78;
	s_playermodel.framel.width         = 256;
	s_playermodel.framel.height        = 329;

	s_playermodel.framer.generic.type  = MTYPE_BITMAP;
	s_playermodel.framer.generic.name  = MODEL_FRAMER;
	s_playermodel.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_playermodel.framer.generic.x     = 376;
	s_playermodel.framer.generic.y     = 76;
	s_playermodel.framer.width         = 256;
	s_playermodel.framer.height        = 334;

	s_playermodel.ports.generic.type  = MTYPE_BITMAP;
	s_playermodel.ports.generic.name  = MODEL_PORTS;
	s_playermodel.ports.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
	s_playermodel.ports.generic.x     = 50;
	s_playermodel.ports.generic.y     = 59;
	s_playermodel.ports.width         = 274;
	s_playermodel.ports.height        = 274;

	y =	59;
	for (i=0,k=0; i<PLAYERGRID_ROWS; i++)
	{
		x =	20;
		for (j=0; j<PLAYERGRID_COLS; j++,k++)
		{
			s_playermodel.pics[k].generic.type	   = MTYPE_BITMAP;
			s_playermodel.pics[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
			s_playermodel.pics[k].generic.x		   = x;
			s_playermodel.pics[k].generic.y		   = y;
			s_playermodel.pics[k].width  		   = 64;
			s_playermodel.pics[k].height  		   = 64;
			s_playermodel.pics[k].focuspic         = MODEL_SELECTED;
			s_playermodel.pics[k].focuscolor       = colorRed;

			s_playermodel.picbuttons[k].generic.type	 = MTYPE_BITMAP;
			s_playermodel.picbuttons[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
			s_playermodel.picbuttons[k].generic.id	     = ID_PLAYERPIC0+k;
			s_playermodel.picbuttons[k].generic.callback = PlayerModel_PicEvent;
			s_playermodel.picbuttons[k].generic.x    	 = x - 16;
			s_playermodel.picbuttons[k].generic.y		 = y - 16;
			s_playermodel.picbuttons[k].generic.left	 = x;
			s_playermodel.picbuttons[k].generic.top		 = y;
			s_playermodel.picbuttons[k].generic.right	 = x + 64;
			s_playermodel.picbuttons[k].generic.bottom   = y + 64;
			s_playermodel.picbuttons[k].width  		     = 128;
			s_playermodel.picbuttons[k].height  		 = 128;
			s_playermodel.picbuttons[k].focuspic  		 = MODEL_SELECT;
			s_playermodel.picbuttons[k].focuscolor  	 = colorRed;

			x += 64+6;
		}
		y += 64+6;
	}

	s_playermodel.playername.generic.type  = MTYPE_PTEXT;
	s_playermodel.playername.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
	s_playermodel.playername.generic.x	   = 320;
	s_playermodel.playername.generic.y	   = 440;
	s_playermodel.playername.string	       = playername;
	s_playermodel.playername.style		   = UI_CENTER;
	s_playermodel.playername.color         = text_color_normal;

	s_playermodel.modelname.generic.type  = MTYPE_PTEXT;
	s_playermodel.modelname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
	s_playermodel.modelname.generic.x	  = 497;
	s_playermodel.modelname.generic.y	  = 54;
	s_playermodel.modelname.string	      = modelname;
	s_playermodel.modelname.style		  = UI_CENTER;
	s_playermodel.modelname.color         = text_color_normal;

	s_playermodel.skinname.generic.type   = MTYPE_PTEXT;
	s_playermodel.skinname.generic.flags  = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
	s_playermodel.skinname.generic.x	  = 497;
	s_playermodel.skinname.generic.y	  = 394;
	s_playermodel.skinname.string	      = skinname;
	s_playermodel.skinname.style		  = UI_CENTER;
	s_playermodel.skinname.color          = text_color_normal;

	s_playermodel.player.generic.type      = MTYPE_BITMAP;
	s_playermodel.player.generic.flags     = QMF_INACTIVE;
	s_playermodel.player.generic.ownerdraw = PlayerModel_DrawPlayer;
	s_playermodel.player.generic.x	       = 400;
	s_playermodel.player.generic.y	       = -40;
	s_playermodel.player.width	           = 32*10;
	s_playermodel.player.height            = 56*10;

	s_playermodel.arrows.generic.type		= MTYPE_BITMAP;
	s_playermodel.arrows.generic.name		= MODEL_ARROWS;
	s_playermodel.arrows.generic.flags		= QMF_INACTIVE;
	s_playermodel.arrows.generic.x			= 125;
	s_playermodel.arrows.generic.y			= 340;
	s_playermodel.arrows.width				= 128;
	s_playermodel.arrows.height				= 32;

	s_playermodel.left.generic.type			= MTYPE_BITMAP;
	s_playermodel.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_playermodel.left.generic.callback		= PlayerModel_MenuEvent;
	s_playermodel.left.generic.id			= ID_PREVPAGE;
	s_playermodel.left.generic.x			= 125;
	s_playermodel.left.generic.y			= 340;
	s_playermodel.left.width  				= 64;
	s_playermodel.left.height  				= 32;
	s_playermodel.left.focuspic				= MODEL_ARROWSL;

	s_playermodel.right.generic.type	    = MTYPE_BITMAP;
	s_playermodel.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_playermodel.right.generic.callback	= PlayerModel_MenuEvent;
	s_playermodel.right.generic.id			= ID_NEXTPAGE;
	s_playermodel.right.generic.x			= 125+61;
	s_playermodel.right.generic.y			= 340;
	s_playermodel.right.width  				= 64;
	s_playermodel.right.height  		    = 32;
	s_playermodel.right.focuspic			= MODEL_ARROWSR;

	s_playermodel.back.generic.type	    = MTYPE_BITMAP;
	s_playermodel.back.generic.name     = MODEL_BACK0;
	s_playermodel.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	s_playermodel.back.generic.callback = PlayerModel_MenuEvent;
	s_playermodel.back.generic.id	    = ID_BACK;
	s_playermodel.back.generic.x		= 0;
	s_playermodel.back.generic.y		= 480-64;
	s_playermodel.back.width  		    = 128;
	s_playermodel.back.height  		    = 64;
	s_playermodel.back.focuspic         = MODEL_BACK1;

//	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.banner );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framel );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framer );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.ports );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.playername );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.modelname );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.skinname );

	for (i=0; i<MAX_MODELSPERPAGE; i++)
	{
		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.pics[i] );
		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.picbuttons[i] );
	}

	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.player );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.arrows );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.left );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.right );
	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.back );

	// find all available models
//	PlayerModel_BuildList();

	// set initial states
	PlayerModel_SetMenuItems();

	// update user interface
	PlayerModel_UpdateGrid();
	PlayerModel_UpdateModel();
}

/*
=================
PlayerModel_Cache
=================
*/
void PlayerModel_Cache( int type )
{
	int	i;

	for( i = 0; playermodel_artlist[i]; i++ ) {
		trap_R_RegisterShaderNoMip( playermodel_artlist[i] );
	}

	PlayerModel_BuildList( type );
	for( i = 0; i < s_playermodel.nummodels; i++ ) {
		trap_R_RegisterShaderNoMip( s_playermodel.modelnames[i] );
	}
}

void UI_PlayerModelMenu(int type)
{
	PlayerModel_MenuInit( type );

	UI_PushMenu( &s_playermodel.menu );

	Menu_SetCursorToItem( &s_playermodel.menu, &s_playermodel.pics[s_playermodel.selectedmodel % MAX_MODELSPERPAGE] );
}


