export Use_Target_Give
code
proc Use_Target_Give 64 12
file "../../../code/game/g_target.c"
line 30
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Quake III Arena source code.
;6:
;7:Quake III Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Quake III Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Quake III Arena source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22://
;23:#include "g_local.h"
;24:
;25://==========================================================
;26:
;27:/*QUAKED target_give (1 0 0) (-8 -8 -8) (8 8 8)
;28:Gives the activator all the items pointed to.
;29:*/
;30:void Use_Target_Give( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 34
;31:	gentity_t	*t;
;32:	trace_t		trace;
;33:
;34:	if ( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $61
line 35
;35:		return;
ADDRGP4 $60
JUMPV
LABELV $61
line 38
;36:	}
;37:
;38:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $63
line 39
;39:		return;
ADDRGP4 $60
JUMPV
LABELV $63
line 42
;40:	}
;41:
;42:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 43
;43:	t = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $66
JUMPV
LABELV $65
line 44
;44:	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
line 45
;45:		if ( !t->item ) {
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $68
line 46
;46:			continue;
ADDRGP4 $66
JUMPV
LABELV $68
line 48
;47:		}
;48:		Touch_Item( t, activator, &trace );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 51
;49:
;50:		// make sure it isn't going to respawn or show any events
;51:		t->nextthink = 0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 52
;52:		trap_UnlinkEntity( t );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 53
;53:	}
LABELV $66
line 44
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $65
line 54
;54:}
LABELV $60
endproc Use_Target_Give 64 12
export SP_target_give
proc SP_target_give 0 0
line 56
;55:
;56:void SP_target_give( gentity_t *ent ) {
line 57
;57:	ent->use = Use_Target_Give;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Give
ASGNP4
line 58
;58:}
LABELV $70
endproc SP_target_give 0 0
export Use_target_remove_powerups
proc Use_target_remove_powerups 0 12
line 67
;59:
;60:
;61://==========================================================
;62:
;63:/*QUAKED target_remove_powerups (1 0 0) (-8 -8 -8) (8 8 8)
;64:takes away all the activators powerups.
;65:Used to drop flight powerups into death puts.
;66:*/
;67:void Use_target_remove_powerups( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 68
;68:	if( !activator->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $72
line 69
;69:		return;
ADDRGP4 $71
JUMPV
LABELV $72
line 72
;70:	}
;71:
;72:	if( activator->client->ps.powerups[PW_REDFLAG] ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $74
line 73
;73:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 74
;74:	} else if( activator->client->ps.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $75
JUMPV
LABELV $74
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $76
line 75
;75:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 76
;76:	} else if( activator->client->ps.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $77
JUMPV
LABELV $76
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $78
line 77
;77:		Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 78
;78:	}
LABELV $78
LABELV $77
LABELV $75
line 80
;79:
;80:	memset( activator->client->ps.powerups, 0, sizeof( activator->client->ps.powerups ) );
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 81
;81:}
LABELV $71
endproc Use_target_remove_powerups 0 12
export SP_target_remove_powerups
proc SP_target_remove_powerups 0 0
line 83
;82:
;83:void SP_target_remove_powerups( gentity_t *ent ) {
line 84
;84:	ent->use = Use_target_remove_powerups;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_target_remove_powerups
ASGNP4
line 85
;85:}
LABELV $80
endproc SP_target_remove_powerups 0 0
export Think_Target_Delay
proc Think_Target_Delay 4 8
line 94
;86:
;87:
;88://==========================================================
;89:
;90:/*QUAKED target_delay (1 0 0) (-8 -8 -8) (8 8 8)
;91:"wait" seconds to pause before firing targets.
;92:"random" delay variance, total delay = delay +/- random seconds
;93:*/
;94:void Think_Target_Delay( gentity_t *ent ) {
line 95
;95:	G_UseTargets( ent, ent->activator );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 96
;96:}
LABELV $81
endproc Think_Target_Delay 4 8
export Use_Target_Delay
proc Use_Target_Delay 8 0
line 98
;97:
;98:void Use_Target_Delay( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 99
;99:	ent->nextthink = level.time + ( ent->wait + ent->random * crandom() ) * 1000;
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 0
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ADDF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 100
;100:	ent->think = Think_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_Target_Delay
ASGNP4
line 101
;101:	ent->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 102
;102:}
LABELV $82
endproc Use_Target_Delay 8 0
export SP_target_delay
proc SP_target_delay 4 12
line 104
;103:
;104:void SP_target_delay( gentity_t *ent ) {
line 106
;105:	// check delay for backwards compatability
;106:	if ( !G_SpawnFloat( "delay", "0", &ent->wait ) ) {
ADDRGP4 $87
ARGP4
ADDRGP4 $88
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 G_SpawnFloat
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $85
line 107
;107:		G_SpawnFloat( "wait", "1", &ent->wait );
ADDRGP4 $89
ARGP4
ADDRGP4 $90
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 108
;108:	}
LABELV $85
line 110
;109:
;110:	if ( !ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 0
NEF4 $91
line 111
;111:		ent->wait = 1;
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
CNSTF4 1065353216
ASGNF4
line 112
;112:	}
LABELV $91
line 113
;113:	ent->use = Use_Target_Delay;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Delay
ASGNP4
line 114
;114:}
LABELV $84
endproc SP_target_delay 4 12
export Use_Target_Score
proc Use_Target_Score 4 12
line 124
;115:
;116:
;117://==========================================================
;118:
;119:/*QUAKED target_score (1 0 0) (-8 -8 -8) (8 8 8)
;120:"count" number of points to add, default 1
;121:
;122:The activator is given this many points.
;123:*/
;124:void Use_Target_Score (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 125
;125:	AddScore( activator, ent->r.currentOrigin, ent->count );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 126
;126:}
LABELV $93
endproc Use_Target_Score 4 12
export SP_target_score
proc SP_target_score 0 0
line 128
;127:
;128:void SP_target_score( gentity_t *ent ) {
line 129
;129:	if ( !ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $95
line 130
;130:		ent->count = 1;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 131
;131:	}
LABELV $95
line 132
;132:	ent->use = Use_Target_Score;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Score
ASGNP4
line 133
;133:}
LABELV $94
endproc SP_target_score 0 0
export Use_Target_Print
proc Use_Target_Print 4 8
line 142
;134:
;135:
;136://==========================================================
;137:
;138:/*QUAKED target_print (1 0 0) (-8 -8 -8) (8 8 8) redteam blueteam private
;139:"message"	text to print
;140:If "private", only the activator gets the message.  If no checks, all clients get the message.
;141:*/
;142:void Use_Target_Print (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 143
;143:	if ( activator->client && ( ent->spawnflags & 4 ) ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $98
line 144
;144:		trap_SendServerCommand( activator-g_entities, va("cp \"%s\"", ent->message ));
ADDRGP4 $100
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 145
;145:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 148
;146:	}
;147:
;148:	if ( ent->spawnflags & 3 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $101
line 149
;149:		if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $103
line 150
;150:			G_TeamCommand( TEAM_RED, va("cp \"%s\"", ent->message) );
ADDRGP4 $100
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 151
;151:		}
LABELV $103
line 152
;152:		if ( ent->spawnflags & 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $97
line 153
;153:			G_TeamCommand( TEAM_BLUE, va("cp \"%s\"", ent->message) );
ADDRGP4 $100
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_TeamCommand
CALLV
pop
line 154
;154:		}
line 155
;155:		return;
ADDRGP4 $97
JUMPV
LABELV $101
line 158
;156:	}
;157:
;158:	trap_SendServerCommand( -1, va("cp \"%s\"", ent->message ));
ADDRGP4 $100
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 159
;159:}
LABELV $97
endproc Use_Target_Print 4 8
export SP_target_print
proc SP_target_print 0 0
line 161
;160:
;161:void SP_target_print( gentity_t *ent ) {
line 162
;162:	ent->use = Use_Target_Print;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Print
ASGNP4
line 163
;163:}
LABELV $107
endproc SP_target_print 0 0
export Use_Target_Speaker
proc Use_Target_Speaker 4 12
line 181
;164:
;165:
;166://==========================================================
;167:
;168:
;169:/*QUAKED target_speaker (1 0 0) (-8 -8 -8) (8 8 8) looped-on looped-off global activator
;170:"noise"		wav file to play
;171:
;172:A global sound will play full volume throughout the level.
;173:Activator sounds will play on the player that activated the target.
;174:Global and activator sounds can't be combined with looping.
;175:Normal sounds play each time the target is used.
;176:Looped sounds will be toggled by use functions.
;177:Multiple identical looping sounds will just increase volume without any speed cost.
;178:"wait" : Seconds between auto triggerings, 0 = don't auto trigger
;179:"random"	wait variance, default is 0
;180:*/
;181:void Use_Target_Speaker (gentity_t *ent, gentity_t *other, gentity_t *activator) {
line 182
;182:	if (ent->spawnflags & 3) {	// looping sound toggles
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $109
line 183
;183:		if (ent->s.loopSound)
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $111
line 184
;184:			ent->s.loopSound = 0;	// turn it off
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $110
JUMPV
LABELV $111
line 186
;185:		else
;186:			ent->s.loopSound = ent->noise_index;	// start it
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ASGNI4
line 187
;187:	}else {	// normal sound
ADDRGP4 $110
JUMPV
LABELV $109
line 188
;188:		if ( ent->spawnflags & 8 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $113
line 189
;189:			G_AddEvent( activator, EV_GENERAL_SOUND, ent->noise_index );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 190
;190:		} else if (ent->spawnflags & 4) {
ADDRGP4 $114
JUMPV
LABELV $113
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $115
line 191
;191:			G_AddEvent( ent, EV_GLOBAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 192
;192:		} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 193
;193:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->noise_index );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 194
;194:		}
LABELV $116
LABELV $114
line 195
;195:	}
LABELV $110
line 196
;196:}
LABELV $108
endproc Use_Target_Speaker 4 12
export SP_target_speaker
proc SP_target_speaker 96 16
line 198
;197:
;198:void SP_target_speaker( gentity_t *ent ) {
line 202
;199:	char	buffer[MAX_QPATH];
;200:	char	*s;
;201:
;202:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $89
ARGP4
ADDRGP4 $88
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 203
;203:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $118
ARGP4
ADDRGP4 $88
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 205
;204:
;205:	if ( !G_SpawnString( "noise", "NOSOUND", &s ) ) {
ADDRGP4 $121
ARGP4
ADDRGP4 $122
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $119
line 206
;206:		G_Error( "target_speaker without a noise key at %s", vtos( ent->s.origin ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $123
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 207
;207:	}
LABELV $119
line 211
;208:
;209:	// force all client reletive sounds to be "activator" speakers that
;210:	// play on the entity that activates it
;211:	if ( s[0] == '*' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $124
line 212
;212:		ent->spawnflags |= 8;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 213
;213:	}
LABELV $124
line 215
;214:
;215:	if (!strstr( s, ".wav" )) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRLP4 72
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $126
line 216
;216:		Com_sprintf (buffer, sizeof(buffer), "%s.wav", s );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $129
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 217
;217:	} else {
ADDRGP4 $127
JUMPV
LABELV $126
line 218
;218:		Q_strncpyz( buffer, s, sizeof(buffer) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 219
;219:	}
LABELV $127
line 220
;220:	ent->noise_index = G_SoundIndex(buffer);
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 223
;221:
;222:	// a repeating speaker can be done completely client side
;223:	ent->s.eType = ET_SPEAKER;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 7
ASGNI4
line 224
;224:	ent->s.eventParm = ent->noise_index;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ASGNI4
line 225
;225:	ent->s.frame = ent->wait * 10;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 1092616192
ADDRLP4 84
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 226
;226:	ent->s.clientNum = ent->random * 10;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 168
ADDP4
CNSTF4 1092616192
ADDRLP4 88
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 230
;227:
;228:
;229:	// check for prestarted looping sound
;230:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $130
line 231
;231:		ent->s.loopSound = ent->noise_index;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ASGNI4
line 232
;232:	}
LABELV $130
line 234
;233:
;234:	ent->use = Use_Target_Speaker;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Target_Speaker
ASGNP4
line 236
;235:
;236:	if (ent->spawnflags & 4) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $132
line 237
;237:		ent->r.svFlags |= SVF_BROADCAST;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 238
;238:	}
LABELV $132
line 240
;239:
;240:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 244
;241:
;242:	// must link the entity so we get areas and clusters so
;243:	// the server can determine who to send updates to
;244:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 245
;245:}
LABELV $117
endproc SP_target_speaker 96 16
export target_laser_think
proc target_laser_think 120 32
line 254
;246:
;247:
;248:
;249://==========================================================
;250:
;251:/*QUAKED target_laser (0 .5 .8) (-8 -8 -8) (8 8 8) START_ON
;252:When triggered, fires a laser.  You can either set a target or a direction.
;253:*/
;254:void target_laser_think (gentity_t *self) {
line 260
;255:	vec3_t	end;
;256:	trace_t	tr;
;257:	vec3_t	point;
;258:
;259:	// if pointed at another entity, set movedir to point at it
;260:	if ( self->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $135
line 261
;261:		VectorMA (self->enemy->s.origin, 0.5, self->enemy->r.mins, point);
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTF4 1056964608
ASGNF4
ADDRLP4 0
ADDRLP4 84
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
ADDRLP4 80
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 92
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 96
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 96
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 262
;262:		VectorMA (point, 0.5, self->enemy->r.maxs, point);
ADDRLP4 100
CNSTF4 1056964608
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 100
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 263
;263:		VectorSubtract (point, self->s.origin, self->movedir);
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 684
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 264
;264:		VectorNormalize (self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 265
;265:	}
LABELV $135
line 268
;266:
;267:	// fire forward and see what we hit
;268:	VectorMA (self->s.origin, 2048, self->movedir, end);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1157627904
ASGNF4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1157627904
ADDRLP4 88
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 270
;269:
;270:	trap_Trace( &tr, self->s.origin, NULL, NULL, end, self->s.number, CONTENTS_SOLID|CONTENTS_BODY|CONTENTS_CORPSE);
ADDRLP4 24
ARGP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 96
CNSTP4 0
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 92
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 272
;271:
;272:	if ( tr.entityNum ) {
ADDRLP4 24+52
INDIRI4
CNSTI4 0
EQI4 $147
line 274
;273:		// hurt it if we can
;274:		G_Damage ( &g_entities[tr.entityNum], self, self->activator, self->movedir, 
CNSTI4 816
ADDRLP4 24+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRLP4 24+12
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 276
;275:			tr.endpos, self->damage, DAMAGE_NO_KNOCKBACK, MOD_TARGET_LASER);
;276:	}
LABELV $147
line 278
;277:
;278:	VectorCopy (tr.endpos, self->s.origin2);
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 24+12
INDIRB
ASGNB 12
line 280
;279:
;280:	trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 281
;281:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 282
;282:}
LABELV $134
endproc target_laser_think 120 32
export target_laser_on
proc target_laser_on 4 4
line 285
;283:
;284:void target_laser_on (gentity_t *self)
;285:{
line 286
;286:	if (!self->activator)
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $155
line 287
;287:		self->activator = self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $155
line 288
;288:	target_laser_think (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_think
CALLV
pop
line 289
;289:}
LABELV $154
endproc target_laser_on 4 4
export target_laser_off
proc target_laser_off 0 4
line 292
;290:
;291:void target_laser_off (gentity_t *self)
;292:{
line 293
;293:	trap_UnlinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 294
;294:	self->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 295
;295:}
LABELV $157
endproc target_laser_off 0 4
export target_laser_use
proc target_laser_use 0 4
line 298
;296:
;297:void target_laser_use (gentity_t *self, gentity_t *other, gentity_t *activator)
;298:{
line 299
;299:	self->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 300
;300:	if ( self->nextthink > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 0
LEI4 $159
line 301
;301:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
ADDRGP4 $160
JUMPV
LABELV $159
line 303
;302:	else
;303:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
LABELV $160
line 304
;304:}
LABELV $158
endproc target_laser_use 0 4
export target_laser_start
proc target_laser_start 16 16
line 307
;305:
;306:void target_laser_start (gentity_t *self)
;307:{
line 310
;308:	gentity_t *ent;
;309:
;310:	self->s.eType = ET_BEAM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 312
;311:
;312:	if (self->target) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $162
line 313
;313:		ent = G_Find (NULL, FOFS(targetname), self->target);
CNSTP4 0
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 314
;314:		if (!ent) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $164
line 315
;315:			G_Printf ("%s at %s: %s is a bad target\n", self->classname, vtos(self->s.origin), self->target);
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $166
ARGP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 316
;316:		}
LABELV $164
line 317
;317:		self->enemy = ent;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 318
;318:	} else {
ADDRGP4 $163
JUMPV
LABELV $162
line 319
;319:		G_SetMovedir (self->s.angles, self->movedir);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 320
;320:	}
LABELV $163
line 322
;321:
;322:	self->use = target_laser_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_laser_use
ASGNP4
line 323
;323:	self->think = target_laser_think;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_laser_think
ASGNP4
line 325
;324:
;325:	if ( !self->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $167
line 326
;326:		self->damage = 1;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 1
ASGNI4
line 327
;327:	}
LABELV $167
line 329
;328:
;329:	if (self->spawnflags & 1)
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $169
line 330
;330:		target_laser_on (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_on
CALLV
pop
ADDRGP4 $170
JUMPV
LABELV $169
line 332
;331:	else
;332:		target_laser_off (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 target_laser_off
CALLV
pop
LABELV $170
line 333
;333:}
LABELV $161
endproc target_laser_start 16 16
export SP_target_laser
proc SP_target_laser 0 0
line 336
;334:
;335:void SP_target_laser (gentity_t *self)
;336:{
line 338
;337:	// let everything else get spawned before we start firing
;338:	self->think = target_laser_start;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_laser_start
ASGNP4
line 339
;339:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 340
;340:}
LABELV $171
endproc SP_target_laser 0 0
export target_teleporter_use
proc target_teleporter_use 12 12
line 345
;341:
;342:
;343://==========================================================
;344:
;345:void target_teleporter_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 348
;346:	gentity_t	*dest;
;347:
;348:	if (!activator->client)
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $174
line 349
;349:		return;
ADDRGP4 $173
JUMPV
LABELV $174
line 350
;350:	dest = 	G_PickTarget( self->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 351
;351:	if (!dest) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $176
line 352
;352:		G_Printf ("Couldn't find teleporter destination\n");
ADDRGP4 $178
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 353
;353:		return;
ADDRGP4 $173
JUMPV
LABELV $176
line 356
;354:	}
;355:
;356:	TeleportPlayer( activator, dest->s.origin, dest->s.angles );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 357
;357:}
LABELV $173
endproc target_teleporter_use 12 12
export SP_target_teleporter
proc SP_target_teleporter 4 12
line 362
;358:
;359:/*QUAKED target_teleporter (1 0 0) (-8 -8 -8) (8 8 8)
;360:The activator will be teleported away.
;361:*/
;362:void SP_target_teleporter( gentity_t *self ) {
line 363
;363:	if (!self->targetname) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $180
line 364
;364:		G_Printf("untargeted %s at %s\n", self->classname, vtos(self->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $182
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 365
;365:	}
LABELV $180
line 367
;366:
;367:	self->use = target_teleporter_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_teleporter_use
ASGNP4
line 368
;368:}
LABELV $179
endproc SP_target_teleporter 4 12
export target_relay_use
proc target_relay_use 36 12
line 378
;369:
;370://==========================================================
;371:
;372:
;373:/*QUAKED target_relay (.5 .5 .5) (-8 -8 -8) (8 8 8) RED_ONLY BLUE_ONLY RANDOM
;374:This doesn't perform any actions except fire its targets.
;375:The activator can be forced to be from a certain team.
;376:if RANDOM is checked, only one of the targets will be fired, not all of them
;377:*/
;378:void target_relay_use (gentity_t *self, gentity_t *other, gentity_t *activator) {
line 379
;379:	if ( ( self->spawnflags & 1 ) && activator->client 
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
BANDI4
CNSTI4 0
EQI4 $184
ADDRLP4 4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $184
ADDRLP4 4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $184
line 380
;380:		&& activator->client->sess.sessionTeam != TEAM_RED ) {
line 381
;381:		return;
ADDRGP4 $183
JUMPV
LABELV $184
line 383
;382:	}
;383:	if ( ( self->spawnflags & 2 ) && activator->client 
ADDRLP4 8
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
BANDI4
CNSTI4 0
EQI4 $186
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $186
ADDRLP4 12
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $186
line 384
;384:		&& activator->client->sess.sessionTeam != TEAM_BLUE ) {
line 385
;385:		return;
ADDRGP4 $183
JUMPV
LABELV $186
line 387
;386:	}
;387:	if ( self->spawnflags & 4 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $188
line 390
;388:		gentity_t	*ent;
;389:
;390:		ent = G_PickTarget( self->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 391
;391:		if ( ent && ent->use ) {
ADDRLP4 24
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $183
ADDRLP4 24
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $183
line 392
;392:			ent->use( ent, self, activator );
ADDRLP4 32
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 393
;393:		}
line 394
;394:		return;
ADDRGP4 $183
JUMPV
LABELV $188
line 396
;395:	}
;396:	G_UseTargets (self, activator);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 397
;397:}
LABELV $183
endproc target_relay_use 36 12
export SP_target_relay
proc SP_target_relay 0 0
line 399
;398:
;399:void SP_target_relay (gentity_t *self) {
line 400
;400:	self->use = target_relay_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_relay_use
ASGNP4
line 401
;401:}
LABELV $192
endproc SP_target_relay 0 0
export target_kill_use
proc target_kill_use 8 32
line 409
;402:
;403:
;404://==========================================================
;405:
;406:/*QUAKED target_kill (.5 .5 .5) (-8 -8 -8) (8 8 8)
;407:Kills the activator.
;408:*/
;409:void target_kill_use( gentity_t *self, gentity_t *other, gentity_t *activator ) {
line 410
;410:	G_Damage ( activator, NULL, NULL, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTP4 0
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 411
;411:}
LABELV $193
endproc target_kill_use 8 32
export SP_target_kill
proc SP_target_kill 0 0
line 413
;412:
;413:void SP_target_kill( gentity_t *self ) {
line 414
;414:	self->use = target_kill_use;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 target_kill_use
ASGNP4
line 415
;415:}
LABELV $194
endproc SP_target_kill 0 0
export SP_target_position
proc SP_target_position 4 8
line 420
;416:
;417:/*QUAKED target_position (0 0.5 0) (-4 -4 -4) (4 4 4)
;418:Used as a positional target for in-game calculation, like jumppad targets.
;419:*/
;420:void SP_target_position( gentity_t *self ){
line 421
;421:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 422
;422:}
LABELV $195
endproc SP_target_position 4 8
proc target_location_linkup 16 8
line 425
;423:
;424:static void target_location_linkup(gentity_t *ent)
;425:{
line 430
;426:	int i;
;427:	int n;
;428:        //static char *gametypeNames[] = {"ffa", "tournament", "single", "team", "ctf", "oneflag", "obelisk", "harvester", "elimination", "ctf", "lms", "dd", "dom"};
;429:
;430:	if (level.locationLinked) 
ADDRGP4 level+9184
INDIRI4
CNSTI4 0
EQI4 $197
line 431
;431:		return;
ADDRGP4 $196
JUMPV
LABELV $197
line 433
;432:
;433:	level.locationLinked = qtrue;
ADDRGP4 level+9184
CNSTI4 1
ASGNI4
line 435
;434:
;435:	level.locationHead = NULL;
ADDRGP4 level+9188
CNSTP4 0
ASGNP4
line 437
;436:
;437:	trap_SetConfigstring( CS_LOCATIONS, "unknown" );
CNSTI4 608
ARGI4
ADDRGP4 $202
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 439
;438:
;439:	for (i = 0, ent = g_entities, n = 1;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $206
JUMPV
LABELV $203
line 441
;440:		i < level.num_entities;
;441:		i++, ent++) {
line 442
;442:		if (ent->classname && Q_strequal(ent->classname, "target_location") ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $208
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $208
line 444
;443:			// lets overload some variables!
;444:			ent->health = n; // use for location marking
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 445
;445:			trap_SetConfigstring( CS_LOCATIONS + n, ent->message );
ADDRLP4 4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 446
;446:			n++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 447
;447:			ent->nextTrain = level.locationHead;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+9188
INDIRP4
ASGNP4
line 448
;448:			level.locationHead = ent;
ADDRGP4 level+9188
ADDRFP4 0
INDIRP4
ASGNP4
line 449
;449:		}
LABELV $208
line 450
;450:	}
LABELV $204
line 441
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $206
line 440
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $203
line 453
;451:
;452:	// All linked together now
;453:}
LABELV $196
endproc target_location_linkup 16 8
export SP_target_location
proc SP_target_location 4 8
line 463
;454:
;455:/*QUAKED target_location (0 0.5 0) (-8 -8 -8) (8 8 8)
;456:Set "message" to the name of this location.
;457:Set "count" to 0-7 for color.
;458:0:white 1:red 2:green 3:yellow 4:blue 5:cyan 6:magenta 7:white
;459:
;460:Closest target_location in sight used for the location, if none
;461:in site, closest in distance
;462:*/
;463:void SP_target_location( gentity_t *self ){
line 464
;464:	self->think = target_location_linkup;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 target_location_linkup
ASGNP4
line 465
;465:	self->nextthink = level.time + 200;  // Let them all spawn first
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 467
;466:
;467:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 468
;468:}
LABELV $213
endproc SP_target_location 4 8
import G_IsARoundBasedGametype
import G_UsesTheWhiteFlag
import G_UsesTeamFlags
import G_IsATeamGametype
import monster_die
import MapInfoPrint
import G_admin_namelog_cleanup
import G_admin_cleanup
import G_admin_duration
import G_admin_buffer_end
import G_admin_buffer_begin
import G_admin_buffer_print
import G_admin_print
import G_admin_warn
import G_admin_slap
import G_admin_orient
import G_admin_disorient
import G_admin_unlock
import G_admin_lock
import G_admin_namelog
import G_admin_nextmap
import G_admin_restart
import G_admin_rename
import G_admin_spec999
import G_admin_passvote
import G_admin_cancelvote
import G_admin_allready
import G_admin_admintest
import G_admin_help
import G_admin_showbans
import G_admin_mute
import G_admin_map
import G_admin_listplayers
import G_admin_listadmins
import G_admin_putteam
import G_admin_unban
import G_admin_ban
import G_admin_adjustban
import G_admin_kick
import G_admin_setlevel
import G_admin_time
import G_admin_parse_time
import G_admin_level
import G_admin_namelog_update
import G_admin_name_check
import G_admin_permission
import G_admin_readconfig
import G_admin_cmd_check
import G_admin_ban_check
import G_ConfigClientExcellent
import G_checkForMultiKill
import G_CheckForSpree
import G_RunStreakLogic
import G_ReadAltKillSettings
import Svcmd_MessageWrapper
import Svcmd_ListIP_f
import Svcmd_Chat_f
import Svcmd_DumpUser_f
import Svcmd_EjectClient_f
import Svcmd_BannerPrint_f
import Svcmd_CenterPrint_f
import Svcmd_TeamMessage_f
import Svcmd_Status_f
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_bot_noChat
import g_spSkill
import g_developer
import g_ddRespawnDelay
import g_ddCaptureTime
import g_harvesterFromBodies
import g_grapple
import g_maxNameChanges
import g_minNameChangePeriod
import g_warningExpire
import g_maxWarnings
import g_publicAdminMessages
import g_specChat
import g_adminMaxBan
import g_adminTempBan
import g_adminNameProtect
import g_adminParseSay
import g_adminLog
import g_admin
import g_floodMinTime
import g_floodMaxDemerits
import g_spreeDiv
import g_altExcellent
import g_sprees
import g_lagLightning
import sv_fps
import g_truePing
import g_delagHitscan
import g_blueTeamClientNumbers
import g_redTeamClientNumbers
import g_humanplayers
import g_maxvotes
import g_voteMaxFraglimit
import g_voteMinFraglimit
import g_voteMaxTimelimit
import g_voteMinTimelimit
import g_voteGametypes
import g_voteBan
import g_voteNames
import g_mappools
import g_autonextmap
import g_catchup
import g_runes
import g_awardpushing
import g_elimination_ctf_oneway
import g_lms_mode
import g_lms_lives
import g_regen
import g_vampireMaxHealth
import g_vampire
import g_instantgib
import g_rockets
import g_elimination_lockspectator
import g_elimination_items
import g_elimination_nail
import g_elimination_mine
import g_elimination_chain
import g_elimination_plasmagun
import g_elimination_lightning
import g_elimination_railgun
import g_elimination_rocket
import g_elimination_grenade
import g_elimination_shotgun
import g_elimination_machinegun
import g_elimination_allgametypes
import g_elimination_activewarmup
import g_elimination_warmup
import g_elimination_roundtime
import g_elimination_bfg
import g_elimination_startArmor
import g_elimination_startHealth
import g_elimination_selfdamage
import g_spawnprotect
import g_music
import g_localTeamPref
import g_proxMineTimeout
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_float
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_votecustom
import g_votemaps
import g_motdfile
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_respawntime
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_damageModifier
import g_gravityModifier
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_voteflags
import g_elimflags
import g_videoflags
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_poweruprespawn
import g_megahealthrespawn
import g_holdablerespawn
import g_ammorespawn
import g_healthrespawn
import g_armorrespawn
import g_ammolimit
import g_lavadamage
import g_drowndamage
import g_spawnselect
import g_speedfactor
import g_jumpheight
import g_respawnwait
import g_armorprotect
import g_medkitmodifier
import g_hastefirespeed
import g_autoflagreturn
import g_droppeditemtime
import g_poweruptime
import g_slowhealthregen
import g_fasthealthregen
import g_invultime
import g_ammoregenspeedfactor
import g_ammoregendamagefactor
import g_ammoregen_infammo
import g_ammoregenfirespeed
import g_guardspeedfactor
import g_guarddamagefactor
import g_guardfirespeed
import g_guardhealthmodifier
import g_doublerspeedfactor
import g_doublerdamagefactor
import g_doublerfirespeed
import g_scoutdamagefactor
import g_scoutfirespeed
import g_scoutspeedfactor
import g_cginf
import g_cgvampire
import g_cgspread
import g_cgdamage
import g_cgdelay
import g_plinf
import g_plvampire
import g_plgravity
import g_pldamage
import g_plsdamage
import g_plsradius
import g_pltimeout
import g_plspeed
import g_pldelay
import g_nginf
import g_ngvampire
import g_nggravity
import g_ngbounce
import g_ngcount
import g_ngtimeout
import g_ngdamage
import g_ngspread
import g_ngspeed
import g_ngdelay
import g_bfginf
import g_bfgvampire
import g_bfggravity
import g_bfgbounce
import g_bfgdamage
import g_bfgsdamage
import g_bfgsradius
import g_bfgtimeout
import g_bfgspeed
import g_bfgdelay
import g_pginf
import g_pgvampire
import g_pggravity
import g_pgbounce
import g_pgtimeout
import g_pgdamage
import g_pgsdamage
import g_pgspeed
import g_pgsradius
import g_pgdelay
import g_rginf
import g_rgvampire
import g_rgdamage
import g_rgdelay
import g_lginf
import g_lgvampire
import g_lgrange
import g_lgdelay
import g_lgdamage
import g_rlinf
import g_rlvampire
import g_rlgravity
import g_rlbounce
import g_rldamage
import g_rlsdamage
import g_rlsradius
import g_rltimeout
import g_rlspeed
import g_rldelay
import g_glinf
import g_glvampire
import g_glgravity
import g_glbounce
import g_gldamage
import g_glsdamage
import g_glsradius
import g_gltimeout
import g_glspeed
import g_gldelay
import g_sginf
import g_sgvampire
import g_sgcount
import g_sgspread
import g_sgdamage
import g_sgdelay
import g_mginf
import g_mgvampire
import g_mgspread
import g_mgdamage
import g_mgdelay
import g_grange
import g_gdamage
import g_gdelay
import mod_ghtimeout
import g_ghtimeout
import g_ghspeed
import mod_doublerfirespeed
import mod_guardfirespeed
import mod_poweruptime
import mod_scoutfirespeed
import mod_ammoregenfirespeed
import mod_hastefirespeed
import mod_vampire_max_health
import mod_cgspread
import mod_cgdelay
import mod_pldelay
import mod_ngdelay
import mod_bfgdelay
import mod_rgdelay
import mod_pgdelay
import mod_lgrange
import mod_lgdelay
import mod_rldelay
import mod_gldelay
import mod_sgcount
import mod_sgspread
import mod_sgdelay
import mod_mgspread
import mod_mgdelay
import mod_gdelay
import mod_jumpheight
import mod_ammolimit
import Newmodcommands
import nailgun_think
import bfg_think
import grenade_think
import rocket_think
import plasma_think
import G_SendWeaponProperties
import g_entities
import level
import Team_ForceGesture
import Team_DD_bonusAtPoints
import Team_RemoveDoubleDominationPoints
import Team_SpawnDoubleDominationPoints
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import Team_Dom_SpawnPoints
import SelectDominationSpawnPoint
import SelectDoubleDominationSpawnPoint
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import getCustomVote
import VoteParseCustomVotes
import allowedFraglimit
import allowedTimelimit
import allowedGametype
import allowedMap
import getMappage
import custom_vote_info
import whiteListedStr
import ClientLeaving
import CountVotes
import CheckVote
import allowedVote
import Possession_TouchFlag
import Possession_SpawnFlag
import PlayerStore_restore
import PlayerStore_store
import PlayerStoreInit
import LogAcc
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import Team_SetFlagStatus
import SelectRandomEntity
import SelectRandomEntityFilter
import G_TeamFromString
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import CheckTeamVote
import LogExit
import G_Error
import G_Printf
import SendYourTeamMessageToTeam
import SendDominationPointsStatusMessageToAllClients
import SendDDtimetakenMessageToAllClients
import SendEliminationMessageToAllClients
import SendScoreboardMessageToAllClients
import G_LogPrintf
import ExitLevel
import AddTournamentQueue
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import SendCustomVoteCommands
import ChallengeMessage
import DominationPointStatusMessage
import DominationPointNamesMessage
import RespawnTimeMessage
import EliminationMessage
import DeathmatchScoreboardMessage
import ObeliskHealthMessage
import AttackingTeamMessage
import YourTeamMessage
import DoubleDominationScoreTimeMessage
import G_SetStats
import MoveClientToIntermission
import G_StartKamikaze
import FireWeapon
import ClientForString
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import ClientRespawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import LMSpoint
import EndEliminationRound
import DisableWeapons
import EnableWeapons
import RespawnDead
import RespawnAll
import TeamHumanParticipantsCount
import TeamLivingHumanCount
import TeamHealthCount
import TeamLivingCount
import TeamCount
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import MinSpawnpointCount
import DropPortalDestination
import DropPortalSource
import TeleportPlayer
import trigger_teleporter_touch
import MatchTeam
import Touch_DoorTrigger
import G_RunMover
import fire_prox
import fire_nail
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import ProximityMine_RemoveAll
import G_RunMissile
import TossClientCubes
import TossClientCubesValues
import TossClientPersistantPowerups
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_GlobalSound
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import writeFile_string
import writeFile_int
import readFile_string
import readFile_int
import WarmupEliminationRound
import StartLMSRound
import SendAttackingTeamMessageToAllClients
import RestartEliminationRound
import CheckLMS
import CheckElimination
import SanitizeString
import G_ClientIsLagging
import G_ClientNumberFromString
import Cmd_AdminMessage_f
import G_FloodLimited
import G_ClientNumbersFromString
import G_SanitiseString
import G_MatchOnePlayer
import G_DecolorString
import G_SayConcatArgs
import G_SayArgv
import G_SayArgc
import G_Say
import ConcatArgs
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import enableq
import MapInfoGet
import MatchesGametype
import BG_TeamName
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_DefragmentMemory
import BG_Free
import BG_InitMemory
import BG_Alloc
import BG_CanAlloc
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import Com_TruncateLongString
import va
import Q_CountChar
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_stristr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Q_StrToLower
import Com_RandomBytes
import Com_SkipCharset
import Com_SkipTokens
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_GetExtension
import COM_SkipPath
import Com_Clamp
import Q_isnan
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoundsIntersectPoint
import BoundsIntersectSphere
import BoundsIntersect
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import Q_snprintf
import Q_vsnprintf
import strtol
import _atoi
import atoi
import strtod
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strrchr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $210
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $202
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $182
byte 1 117
byte 1 110
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $178
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $129
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $128
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $123
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 78
byte 1 79
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $121
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $118
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $100
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $90
byte 1 49
byte 1 0
align 1
LABELV $89
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $88
byte 1 48
byte 1 0
align 1
LABELV $87
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
