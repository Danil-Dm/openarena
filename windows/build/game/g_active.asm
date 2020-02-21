export P_DamageFeedback
code
proc P_DamageFeedback 36 12
file "../../../code/game/g_active.c"
line 37
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
;23:
;24:#include "g_local.h"
;25:
;26:
;27:/*
;28:===============
;29:G_DamageFeedback
;30:
;31:Called just before a snapshot is sent to the given player.
;32:Totals up all damage and generates both the player_state_t
;33:damage values to that client for pain blends and kicks, and
;34:global pain sound events for all clients.
;35:===============
;36:*/
;37:void P_DamageFeedback( gentity_t *player ) {
line 42
;38:	gclient_t	*client;
;39:	float	count;
;40:	vec3_t	angles;
;41:
;42:	client = player->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 43
;43:	if ( client->ps.pm_type == PM_DEAD ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $61
line 44
;44:		return;
ADDRGP4 $60
JUMPV
LABELV $61
line 48
;45:	}
;46:
;47:	// total points of damage shot at the player this frame
;48:	count = client->damage_blood + client->damage_armor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1084
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 49
;49:	if ( count == 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $63
line 50
;50:		return;		// didn't take any damage
ADDRGP4 $60
JUMPV
LABELV $63
line 53
;51:	}
;52:
;53:	if ( count > 255 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
LEF4 $65
line 54
;54:		count = 255;
ADDRLP4 4
CNSTF4 1132396544
ASGNF4
line 55
;55:	}
LABELV $65
line 61
;56:
;57:	// send the information to the client
;58:
;59:	// world damage (falling, slime, etc) uses a special code
;60:	// to make the blend blob centered instead of positional
;61:	if ( client->damage_fromWorld ) {
ADDRLP4 0
INDIRP4
CNSTI4 1108
ADDP4
INDIRI4
CNSTI4 0
EQI4 $67
line 62
;62:		client->ps.damagePitch = 255;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 255
ASGNI4
line 63
;63:		client->ps.damageYaw = 255;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 255
ASGNI4
line 65
;64:
;65:		client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 1108
ADDP4
CNSTI4 0
ASGNI4
line 66
;66:	} else {
ADDRGP4 $68
JUMPV
LABELV $67
line 67
;67:		vectoangles( client->damage_from, angles );
ADDRLP4 0
INDIRP4
CNSTI4 1096
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 68
;68:		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 1132462080
ADDRLP4 8
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 69
;69:		client->ps.damageYaw = angles[YAW]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 1132462080
ADDRLP4 8+4
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 70
;70:	}
LABELV $68
line 73
;71:
;72:	// play an apropriate pain sound
;73:	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
LEI4 $70
ADDRLP4 24
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $70
line 74
;74:		player->pain_debounce_time = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 75
;75:		G_AddEvent( player, EV_PAIN, player->health );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 76
;76:		client->ps.damageEvent++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 77
;77:	}
LABELV $70
line 80
;78:
;79:
;80:	client->ps.damageCount = count;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 85
;81:
;82:	//
;83:	// clear totals
;84:	//
;85:	client->damage_blood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 0
ASGNI4
line 86
;86:	client->damage_armor = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1084
ADDP4
CNSTI4 0
ASGNI4
line 87
;87:	client->damage_knockback = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1092
ADDP4
CNSTI4 0
ASGNI4
line 88
;88:}
LABELV $60
endproc P_DamageFeedback 36 12
export P_WorldEffects
proc P_WorldEffects 32 32
line 99
;89:
;90:
;91:
;92:/*
;93:=============
;94:P_WorldEffects
;95:
;96:Check for lava / slime contents and drowning
;97:=============
;98:*/
;99:void P_WorldEffects( gentity_t *ent ) {
line 103
;100:	qboolean	envirosuit;
;101:	int			waterlevel;
;102:
;103:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $75
line 104
;104:		ent->client->airOutTime = level.time + 12000;	// don't need air
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1152
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 105
;105:		return;
ADDRGP4 $74
JUMPV
LABELV $75
line 108
;106:	}
;107:
;108:	waterlevel = ent->waterlevel;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ASGNI4
line 110
;109:
;110:	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $80
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $81
JUMPV
LABELV $80
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $81
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 115
;111:
;112:	//
;113:	// check for drowning
;114:	//
;115:	if (g_drowndamage.integer == 1)
ADDRGP4 g_drowndamage+12
INDIRI4
CNSTI4 1
NEI4 $82
line 116
;116:	if ( waterlevel == 3 ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $85
line 118
;117:		// envirosuit give air
;118:		if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $87
line 119
;119:			ent->client->airOutTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1152
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 120
;120:		}
LABELV $87
line 123
;121:
;122:		// if out of air, start drowning
;123:		if ( ent->client->airOutTime < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1152
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $86
line 125
;124:			// drown!
;125:			ent->client->airOutTime += 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1152
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 126
;126:			if ( ent->health > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $86
line 128
;127:				// take more damage the longer underwater
;128:				ent->damage += 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 129
;129:				if (ent->damage > 15)
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 15
LEI4 $95
line 130
;130:					ent->damage = 15;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 15
ASGNI4
LABELV $95
line 133
;131:
;132:				// don't play a normal pain sound
;133:				ent->pain_debounce_time = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 135
;134:
;135:				G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTP4 0
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 14
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 137
;136:					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
;137:			}
line 138
;138:		}
line 139
;139:	} else {
ADDRGP4 $86
JUMPV
LABELV $85
line 140
;140:		ent->client->airOutTime = level.time + 12000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1152
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 141
;141:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 142
;142:	}
LABELV $86
LABELV $82
line 147
;143:
;144:	//
;145:	// check for sizzle damage (move to pmove?)
;146:	//
;147:	if (waterlevel && 
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $99
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 24
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $99
line 148
;148:		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
line 149
;149:		if (ent->health > 0
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $101
ADDRLP4 16
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $101
line 150
;150:			&& ent->pain_debounce_time <= level.time	) {
line 151
;151:			if (g_lavadamage.integer)
ADDRGP4 g_lavadamage+12
INDIRI4
CNSTI4 0
EQI4 $104
line 152
;152:			if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $107
line 153
;153:				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 154
;154:			} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 155
;155:				if (ent->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $109
line 156
;156:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTP4 0
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 30
ADDRLP4 0
INDIRI4
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 158
;157:						30*waterlevel, 0, MOD_LAVA);
;158:				}
LABELV $109
line 160
;159:
;160:				if (ent->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $111
line 161
;161:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTP4 0
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 10
ADDRLP4 0
INDIRI4
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 15
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 163
;162:						10*waterlevel, 0, MOD_SLIME);
;163:				}
LABELV $111
line 164
;164:			}
LABELV $108
LABELV $104
line 165
;165:		}
LABELV $101
line 166
;166:	}
LABELV $99
line 167
;167:}
LABELV $74
endproc P_WorldEffects 32 32
export G_SetClientSound
proc G_SetClientSound 8 4
line 176
;168:
;169:
;170:
;171:/*
;172:===============
;173:G_SetClientSound
;174:===============
;175:*/
;176:void G_SetClientSound( gentity_t *ent ) {
line 177
;177:	if( ent->s.eFlags & EF_TICKING ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $114
line 178
;178:		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
ADDRGP4 $116
ARGP4
ADDRLP4 0
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 179
;179:	}
ADDRGP4 $115
JUMPV
LABELV $114
line 181
;180:	else
;181:	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $117
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
CNSTI4 24
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $117
line 182
;182:		ent->client->ps.loopSound = level.snd_fry;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 level+348
INDIRI4
ASGNI4
line 183
;183:	} else {
ADDRGP4 $118
JUMPV
LABELV $117
line 184
;184:		ent->client->ps.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 185
;185:	}
LABELV $118
LABELV $115
line 186
;186:}
LABELV $113
endproc G_SetClientSound 8 4
export ClientImpacts
proc ClientImpacts 76 12
line 197
;187:
;188:
;189:
;190://==============================================================
;191:
;192:/*
;193:==============
;194:ClientImpacts
;195:==============
;196:*/
;197:void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
line 202
;198:	int		i, j;
;199:	trace_t	trace;
;200:	gentity_t	*other;
;201:
;202:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 203
;203:	for (i=0 ; i<pm->numtouch ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 204
;204:		for (j=0 ; j<i ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $128
JUMPV
LABELV $125
line 205
;205:			if (pm->touchents[j] == pm->touchents[i] ) {
ADDRLP4 68
CNSTI4 2
ASGNI4
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRI4
NEI4 $129
line 206
;206:				break;
ADDRGP4 $127
JUMPV
LABELV $129
line 208
;207:			}
;208:		}
LABELV $126
line 204
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $128
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $125
LABELV $127
line 209
;209:		if (j != i) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $131
line 210
;210:			continue;	// duplicated
ADDRGP4 $122
JUMPV
LABELV $131
line 212
;211:		}
;212:		other = &g_entities[ pm->touchents[i] ];
ADDRLP4 8
CNSTI4 816
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 214
;213:
;214:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $133
ADDRLP4 68
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $133
line 215
;215:			ent->touch( ent, other, &trace );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 216
;216:		}
LABELV $133
line 218
;217:
;218:		if ( !other->touch ) {
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $135
line 219
;219:			continue;
ADDRGP4 $122
JUMPV
LABELV $135
line 222
;220:		}
;221:
;222:		other->touch( other, ent, &trace );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 223
;223:	}
LABELV $122
line 203
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
LTI4 $121
line 225
;224:
;225:}
LABELV $120
endproc ClientImpacts 76 12
data
align 4
LABELV $138
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
export G_TouchTriggers
code
proc G_TouchTriggers 4248 16
line 235
;226:
;227:/*
;228:============
;229:G_TouchTriggers
;230:
;231:Find all trigger entities that ent's current position touches.
;232:Spectators will only interact with teleporters.
;233:============
;234:*/
;235:void	G_TouchTriggers( gentity_t *ent ) {
line 243
;236:	int			i, num;
;237:	int			touch[MAX_GENTITIES];
;238:	gentity_t	*hit;
;239:	trace_t		trace;
;240:	vec3_t		mins, maxs;
;241:	static vec3_t	range = { 40, 40, 52 };
;242:
;243:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $139
line 244
;244:		return;
ADDRGP4 $137
JUMPV
LABELV $139
line 249
;245:	}
;246:
;247:	//ELIMINATION LMS
;248:	// dead clients don't activate triggers! The reason our pm_spectators can't do anything
;249:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 && ent->client->ps.pm_type != PM_SPECTATOR) {
ADDRLP4 4188
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4188
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $141
ADDRLP4 4188
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $141
line 250
;250:		return;
ADDRGP4 $137
JUMPV
LABELV $141
line 253
;251:	}
;252:
;253:	VectorSubtract( ent->client->ps.origin, range, mins );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 64
ADDRLP4 4192
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $138
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4192
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $138+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $138+8
INDIRF4
SUBF4
ASGNF4
line 254
;254:	VectorAdd( ent->client->ps.origin, range, maxs );
ADDRLP4 4196
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 76
ADDRLP4 4196
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $138
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4196
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $138+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $138+8
INDIRF4
ADDF4
ASGNF4
line 256
;255:
;256:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4200
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4200
INDIRI4
ASGNI4
line 259
;257:
;258:	// can't use ent->absmin, because that has a one unit pad
;259:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4208
ADDRLP4 4204
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 64
ADDRLP4 4208
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4208
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 260
;260:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 76
ADDRLP4 4220
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4216
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4220
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4216
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4224
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4224
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 262
;261:
;262:	for ( i=0 ; i<num ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $158
JUMPV
LABELV $155
line 263
;263:		hit = &g_entities[touch[i]];
ADDRLP4 0
CNSTI4 816
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 92
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 265
;264:
;265:		if ( !hit->touch && !ent->touch ) {
ADDRLP4 4228
CNSTI4 704
ASGNI4
ADDRLP4 4232
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
ADDRLP4 4228
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4232
INDIRU4
NEU4 $159
ADDRFP4 0
INDIRP4
ADDRLP4 4228
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4232
INDIRU4
NEU4 $159
line 266
;266:			continue;
ADDRGP4 $156
JUMPV
LABELV $159
line 268
;267:		}
;268:		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $161
line 269
;269:			continue;
ADDRGP4 $156
JUMPV
LABELV $161
line 273
;270:		}
;271:
;272:		// ignore most entities if a spectator
;273:		if ( (ent->client->sess.sessionTeam == TEAM_SPECTATOR) || ent->client->ps.pm_type == PM_SPECTATOR ) {
ADDRLP4 4236
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4236
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $165
ADDRLP4 4236
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $163
LABELV $165
line 274
;274:			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $166
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 Touch_DoorTrigger
CVPU4 4
EQU4 $166
line 278
;275:				// this is ugly but adding a new ET_? type will
;276:				// most likely cause network incompatibilities
;277:				//We need to stop eliminated players from opening doors somewhere else /Sago007 20070814
;278:				hit->touch != Touch_DoorTrigger ) {
line 279
;279:				continue;
ADDRGP4 $156
JUMPV
LABELV $166
line 281
;280:			}
;281:		}
LABELV $163
line 285
;282:
;283:		// use seperate code for determining if an item is picked up
;284:		// so you don't have to actually contact its bounding box
;285:		if ( hit->s.eType == ET_ITEM ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $168
line 286
;286:			if ( !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 4240
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4240
INDIRI4
CNSTI4 0
NEI4 $169
line 287
;287:				continue;
ADDRGP4 $156
JUMPV
line 289
;288:			}
;289:		} else {
LABELV $168
line 290
;290:			if ( !trap_EntityContact( mins, maxs, hit ) ) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4240
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4240
INDIRI4
CNSTI4 0
NEI4 $173
line 291
;291:				continue;
ADDRGP4 $156
JUMPV
LABELV $173
line 293
;292:			}
;293:		}
LABELV $169
line 295
;294:
;295:		memset( &trace, 0, sizeof(trace) );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 297
;296:
;297:		if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $175
line 298
;298:			hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 299
;299:		}
LABELV $175
line 301
;300:
;301:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 4240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4240
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $177
ADDRLP4 4240
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $177
line 302
;302:			ent->touch( ent, hit, &trace );
ADDRLP4 4244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4244
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4244
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 303
;303:		}
LABELV $177
line 304
;304:	}
LABELV $156
line 262
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $158
ADDRLP4 4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $155
line 307
;305:
;306:	// if we didn't touch a jump pad this pmove frame
;307:	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
ADDRLP4 4228
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4228
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 4228
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
EQI4 $179
line 308
;308:		ent->client->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 309
;309:		ent->client->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 310
;310:	}
LABELV $179
line 311
;311:}
LABELV $137
endproc G_TouchTriggers 4248 16
export SpectatorThink
proc SpectatorThink 292 12
line 318
;312:
;313:/*
;314:=================
;315:SpectatorThink
;316:=================
;317:*/
;318:void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
line 322
;319:	pmove_t	pm;
;320:	gclient_t	*client;
;321:
;322:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 324
;323:
;324:	if ( G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer) &&
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 244
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
EQI4 $182
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 248
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
EQI4 $182
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
EQI4 $182
ADDRGP4 g_elimination_lockspectator+12
INDIRI4
CNSTI4 1
LEI4 $182
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $182
line 327
;325:			client->sess.spectatorState != SPECTATOR_FOLLOW &&
;326:			g_elimination_lockspectator.integer>1 &&
;327:			ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 328
;328:		Cmd_FollowCycle_f(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 329
;329:	}
LABELV $182
line 331
;330:
;331:	if ( client->sess.spectatorState != SPECTATOR_FOLLOW || !( client->ps.pm_flags & PMF_FOLLOW ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $189
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $187
LABELV $189
line 332
;332:		if ( client->sess.spectatorState == SPECTATOR_FREE ) {
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1
NEI4 $190
line 333
;333:			if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $192
line 334
;334:				client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 335
;335:			} else {
ADDRGP4 $191
JUMPV
LABELV $192
line 336
;336:				client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 337
;337:			}
line 338
;338:		} else {
ADDRGP4 $191
JUMPV
LABELV $190
line 339
;339:			client->ps.pm_type = PM_FREEZE;
ADDRLP4 256
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 340
;340:		}
LABELV $191
line 342
;341:
;342:		client->ps.speed = 400;	// faster than normal
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 400
ASGNI4
line 345
;343:
;344:		// set up for pmove
;345:		memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 240
ARGI4
ADDRGP4 memset
CALLP4
pop
line 346
;346:		pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 347
;347:		pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 24
line 348
;348:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 349
;349:		pm.trace = trap_Trace;
ADDRLP4 4+232
ADDRGP4 trap_Trace
ASGNP4
line 350
;350:		pm.pointcontents = trap_PointContents;
ADDRLP4 4+236
ADDRGP4 trap_PointContents
ASGNP4
line 353
;351:
;352:		// perform a pmove
;353:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 355
;354:		// save results of pmove
;355:		VectorCopy( client->ps.origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 357
;356:
;357:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 358
;358:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 359
;359:	}
LABELV $187
line 361
;360:	
;361:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 1064
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
line 362
;362:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 366
;363:	
;364:	//KK-OAX Changed to keep followcycle functional
;365:	// attack button cycles through spectators
;366:	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
ADDRLP4 264
CNSTI4 1
ASGNI4
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ADDRLP4 264
INDIRI4
BANDI4
ADDRLP4 268
INDIRI4
EQI4 $198
ADDRLP4 0
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
ADDRLP4 264
INDIRI4
BANDI4
ADDRLP4 268
INDIRI4
NEI4 $198
line 367
;367:		Cmd_FollowCycle_f( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 368
;368:	}
LABELV $198
line 370
;369:
;370:	if ( ( client->buttons & BUTTON_USE_HOLDABLE ) && ! ( client->oldbuttons & BUTTON_USE_HOLDABLE ) ) {
ADDRLP4 276
CNSTI4 4
ASGNI4
ADDRLP4 280
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
BANDI4
ADDRLP4 280
INDIRI4
EQI4 $200
ADDRLP4 0
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
BANDI4
ADDRLP4 280
INDIRI4
NEI4 $200
line 371
;371:		if ( G_IsARoundBasedGametype(g_gametype.integer) && G_IsATeamGametype(g_gametype.integer) &&
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 284
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $202
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 288
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $202
ADDRGP4 g_elimination_lockspectator+12
INDIRI4
CNSTI4 1
LEI4 $202
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $202
line 373
;372:			g_elimination_lockspectator.integer>1 &&
;373:			ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 374
;374:			return;
ADDRGP4 $181
JUMPV
LABELV $202
line 376
;375:		}
;376:		StopFollowing(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 377
;377:	}
LABELV $200
line 378
;378:}
LABELV $181
endproc SpectatorThink 292 12
export ClientInactivityTimer
proc ClientInactivityTimer 12 8
line 389
;379:
;380:
;381:
;382:/*
;383:=================
;384:ClientInactivityTimer
;385:
;386:Returns qfalse if the client is dropped
;387:=================
;388:*/
;389:qboolean ClientInactivityTimer( gclient_t *client ) {
line 390
;390:	if ( ! g_inactivity.integer ) {
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 0
NEI4 $208
line 393
;391:		// give everyone some time, so if the operator sets g_inactivity during
;392:		// gameplay, everyone isn't kicked
;393:		client->inactivityTime = level.time + 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 1140
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 60000
ADDI4
ASGNI4
line 394
;394:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
CNSTI4 0
ASGNI4
line 395
;395:	} else if ( client->pers.cmd.forwardmove || 
ADDRGP4 $209
JUMPV
LABELV $208
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 493
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $216
ADDRLP4 0
INDIRP4
CNSTI4 494
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $216
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $216
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $212
LABELV $216
line 398
;396:		client->pers.cmd.rightmove || 
;397:		client->pers.cmd.upmove ||
;398:		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
line 399
;399:		client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 1140
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_inactivity+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 400
;400:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
CNSTI4 0
ASGNI4
line 401
;401:	} else if ( !client->pers.localClient ) {
ADDRGP4 $213
JUMPV
LABELV $212
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $219
line 402
;402:		if ( level.time > client->inactivityTime ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1140
ADDP4
INDIRI4
LEI4 $221
line 403
;403:			trap_DropClient( client - level.clients, "Dropped due to inactivity" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ARGI4
ADDRGP4 $224
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 404
;404:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $207
JUMPV
LABELV $221
line 406
;405:		}
;406:		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 1140
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $225
ADDRLP4 8
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
NEI4 $225
line 407
;407:			client->inactivityWarning = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
CNSTI4 1
ASGNI4
line 408
;408:			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ARGI4
ADDRGP4 $228
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 409
;409:		}
LABELV $225
line 410
;410:	}
LABELV $219
LABELV $213
LABELV $209
line 411
;411:	return qtrue;
CNSTI4 1
RETI4
LABELV $207
endproc ClientInactivityTimer 12 8
lit
align 4
LABELV $314
byte 4 2
byte 4 3
byte 4 4
byte 4 5
byte 4 6
byte 4 7
byte 4 8
byte 4 9
byte 4 11
byte 4 12
byte 4 13
code
proc ClientTimerActions 100 32
line 421
;412:}
;413:
;414:/*
;415:==================
;416:ClientTimerActions
;417:
;418:Actions that happen once a second
;419:==================
;420:*/
;421:static void ClientTimerActions( gentity_t *ent, int msec ) {
line 425
;422:	gclient_t	*client;
;423:	int			maxHealth;
;424:
;425:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 426
;426:	client->timeResidual += msec;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $231
JUMPV
LABELV $230
line 428
;427:
;428:	while ( client->timeResidual >= 1000 ) {
line 429
;429:		client->timeResidual -= 1000;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 432
;430:		
;431:		// Infinite Ammo
;432:	if(g_rlinf.integer==1){ client->ps.ammo[WP_ROCKET_LAUNCHER] = 999; }
ADDRGP4 g_rlinf+12
INDIRI4
CNSTI4 1
NEI4 $233
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 999
ASGNI4
LABELV $233
line 433
;433:	if(g_glinf.integer==1){ client->ps.ammo[WP_GRENADE_LAUNCHER] = 999; }
ADDRGP4 g_glinf+12
INDIRI4
CNSTI4 1
NEI4 $236
ADDRLP4 0
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 999
ASGNI4
LABELV $236
line 434
;434:	if(g_pginf.integer==1){ client->ps.ammo[WP_PLASMAGUN] = 999; }
ADDRGP4 g_pginf+12
INDIRI4
CNSTI4 1
NEI4 $239
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
CNSTI4 999
ASGNI4
LABELV $239
line 435
;435:	if(g_mginf.integer==1){ client->ps.ammo[WP_MACHINEGUN] = 999; }
ADDRGP4 g_mginf+12
INDIRI4
CNSTI4 1
NEI4 $242
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 999
ASGNI4
LABELV $242
line 436
;436:	if(g_sginf.integer==1){ client->ps.ammo[WP_SHOTGUN] = 999; }
ADDRGP4 g_sginf+12
INDIRI4
CNSTI4 1
NEI4 $245
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 999
ASGNI4
LABELV $245
line 437
;437:	if(g_bfginf.integer==1){ client->ps.ammo[WP_BFG] = 999; }
ADDRGP4 g_bfginf+12
INDIRI4
CNSTI4 1
NEI4 $248
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 999
ASGNI4
LABELV $248
line 438
;438:	if(g_rginf.integer==1){ client->ps.ammo[WP_RAILGUN] = 999; }
ADDRGP4 g_rginf+12
INDIRI4
CNSTI4 1
NEI4 $251
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTI4 999
ASGNI4
LABELV $251
line 439
;439:	if(g_cginf.integer==1){ client->ps.ammo[WP_CHAINGUN] = 999; }
ADDRGP4 g_cginf+12
INDIRI4
CNSTI4 1
NEI4 $254
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 999
ASGNI4
LABELV $254
line 440
;440:	if(g_lginf.integer==1){ client->ps.ammo[WP_LIGHTNING] = 999; }
ADDRGP4 g_lginf+12
INDIRI4
CNSTI4 1
NEI4 $257
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
CNSTI4 999
ASGNI4
LABELV $257
line 441
;441:	if(g_nginf.integer==1){ client->ps.ammo[WP_NAILGUN] = 999; }
ADDRGP4 g_nginf+12
INDIRI4
CNSTI4 1
NEI4 $260
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 999
ASGNI4
LABELV $260
line 442
;442:	if(g_plinf.integer==1){ client->ps.ammo[WP_PROX_LAUNCHER] = 999; }
ADDRGP4 g_plinf+12
INDIRI4
CNSTI4 1
NEI4 $263
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 999
ASGNI4
LABELV $263
line 445
;443:
;444:		//Stop in elimination!!!
;445:		if (client->ps.pm_flags & PMF_ELIMWARMUP)
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $266
line 446
;446:			continue;
ADDRGP4 $231
JUMPV
LABELV $266
line 449
;447:
;448:		// regenerate
;449:		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $268
line 450
;450:			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 451
;451:		}
ADDRGP4 $269
JUMPV
LABELV $268
line 452
;452:		else if ( client->ps.powerups[PW_REGEN] ) {
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $271
line 453
;453:			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 454
;454:		}
ADDRGP4 $272
JUMPV
LABELV $271
line 455
;455:		else {
line 456
;456:			maxHealth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 457
;457:		}
LABELV $272
LABELV $269
line 458
;458:		if( maxHealth ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $273
line 459
;459:			if ( ent->health < maxHealth ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $275
line 460
;460:				ent->health += g_fasthealthregen.integer;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRGP4 g_fasthealthregen+12
INDIRI4
ADDI4
ASGNI4
line 461
;461:				if ( ent->health > maxHealth * 1.1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
LEF4 $278
line 462
;462:					ent->health = maxHealth * 1.1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTF4 1066192077
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 463
;463:				}
LABELV $278
line 464
;464:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 465
;465:			}
ADDRGP4 $274
JUMPV
LABELV $275
line 466
;466:			else if ( ent->health < maxHealth * 2) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $274
line 467
;467:				ent->health += g_slowhealthregen.integer;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRGP4 g_slowhealthregen+12
INDIRI4
ADDI4
ASGNI4
line 468
;468:				if ( ent->health > maxHealth * 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $283
line 469
;469:					ent->health = maxHealth * 2;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 470
;470:				}
LABELV $283
line 471
;471:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 472
;472:			}
line 473
;473:		} else {
ADDRGP4 $274
JUMPV
LABELV $273
line 475
;474:			// count down health when over max
;475:			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $285
line 476
;476:				ent->health--;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 477
;477:			}
LABELV $285
line 478
;478:			if ( G_IsARoundBasedGametype(g_gametype.integer) && level.humansEliminated ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $287
ADDRGP4 level+9260
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $287
line 479
;479:				ent->damage=5;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 5
ASGNI4
line 480
;480:				G_Damage (ent, NULL, NULL, NULL, NULL, ent->damage, DAMAGE_NO_KNOCKBACK, MOD_UNKNOWN);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
CNSTP4 0
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 481
;481:			}
ADDRGP4 $288
JUMPV
LABELV $287
line 483
;482:			//Start killing players in LMS, if we are in overtime
;483:			else if (g_elimination_roundtime.integer&&g_gametype.integer==GT_LMS && TeamHealthCount( -1, TEAM_FREE ) != ent->health &&
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 g_elimination_roundtime+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $291
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $291
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamHealthCount
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
EQI4 $291
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
NEI4 $291
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9232
INDIRI4
CNSTI4 1000
ADDRGP4 g_elimination_roundtime+12
INDIRI4
MULI4
ADDI4
LTI4 $291
line 484
;484:			         (level.roundNumber==level.roundNumberStarted)&&(level.time>=level.roundStartTime+1000*g_elimination_roundtime.integer)) {
line 485
;485:				ent->damage=5;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 5
ASGNI4
line 486
;486:				G_Damage (ent, NULL, NULL, NULL, NULL, ent->damage, DAMAGE_NO_ARMOR, MOD_UNKNOWN);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
CNSTP4 0
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
CNSTP4 0
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 487
;487:			}
ADDRGP4 $292
JUMPV
LABELV $291
line 488
;488:			else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
GEI4 $300
line 489
;489:				ent->health+=g_regen.integer;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRGP4 g_regen+12
INDIRI4
ADDI4
ASGNI4
line 490
;490:				if (ent->health>client->ps.stats[STAT_MAX_HEALTH]) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $303
line 491
;491:					ent->health= client->ps.stats[STAT_MAX_HEALTH];
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 492
;492:				}
LABELV $303
line 493
;493:			}
LABELV $300
LABELV $292
LABELV $288
line 494
;494:		}
LABELV $274
line 497
;495:
;496:		// count down armor when over max
;497:		if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $305
line 498
;498:			client->ps.stats[STAT_ARMOR]--;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 499
;499:		}
LABELV $305
line 501
;500:		
;501:		if (g_gametype.integer == GT_POSSESSION && ent->health > 0 && client->ps.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
NEI4 $307
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $307
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $307
line 502
;502:			AddScore(ent, ent->client->ps.origin, 1);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 503
;503:			G_LogPrintf("POS: %i %i: %s^7 scored a point\n", ent->s.number, 1, client->pers.netname);
ADDRGP4 $310
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 504
;504:		}
LABELV $307
line 505
;505:	}
LABELV $231
line 428
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $230
line 506
;506:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $311
line 508
;507:		int w, max, inc, t, i;
;508:		int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
ADDRLP4 32
ADDRGP4 $314
INDIRB
ASGNB 44
line 509
;509:		int weapCount = sizeof(weapList) / sizeof(int);
ADDRLP4 76
CNSTI4 11
ASGNI4
line 511
;510:			//
;511:		for (i = 0; i < weapCount; i++) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $318
JUMPV
LABELV $315
line 512
;512:			w = weapList[i];
ADDRLP4 12
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 514
;513:
;514:			switch(w) {
ADDRLP4 84
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $319
ADDRLP4 12
INDIRI4
CNSTI4 13
GTI4 $319
ADDRLP4 12
INDIRI4
ADDRLP4 84
INDIRI4
LSHI4
ADDRGP4 $332-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $332
address $321
address $322
address $323
address $324
address $325
address $326
address $327
address $328
address $319
address $329
address $330
address $331
code
LABELV $321
line 515
;515:				case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
ADDRLP4 20
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $322
line 516
;516:				case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $323
line 517
;517:				case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 2000
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $324
line 518
;518:				case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1750
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $325
line 519
;519:				case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
ADDRLP4 20
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $326
line 520
;520:				case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1750
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $327
line 521
;521:				case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
ADDRLP4 20
CNSTI4 50
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1500
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $328
line 522
;522:				case WP_BFG: max = 10; inc = 1; t = 4000; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 4000
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $329
line 523
;523:				case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
ADDRLP4 20
CNSTI4 10
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 1250
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $330
line 524
;524:				case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
ADDRLP4 20
CNSTI4 5
ASGNI4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 16
CNSTI4 2000
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $331
line 525
;525:				case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
ADDRLP4 20
CNSTI4 100
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
ADDRGP4 $320
JUMPV
LABELV $319
line 526
;526:				default: max = 0; inc = 0; t = 1000; break;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 1000
ASGNI4
LABELV $320
line 528
;527:			}
;528:			client->ammoTimes[w] += msec;
ADDRLP4 88
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 529
;529:		    if (g_ammoregen_infammo.integer == 1) {
ADDRGP4 g_ammoregen_infammo+12
INDIRI4
CNSTI4 1
NEI4 $334
line 530
;530:			  max = 999;
ADDRLP4 20
CNSTI4 999
ASGNI4
line 531
;531:			  inc = 999;
ADDRLP4 28
CNSTI4 999
ASGNI4
line 532
;532:			  t = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 533
;533:			}
LABELV $334
line 535
;534:			
;535:			if ( client->ps.ammo[w] >= max ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $337
line 536
;536:				client->ammoTimes[w] = 0;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 537
;537:			}
LABELV $337
line 538
;538:			if ( client->ammoTimes[w] >= t ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $339
ADDRGP4 $342
JUMPV
LABELV $341
line 540
;539:				while ( client->ammoTimes[w] >= t )
;540:					client->ammoTimes[w] -= t;
ADDRLP4 92
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ASGNI4
LABELV $342
line 539
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 1184
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $341
line 541
;541:				client->ps.ammo[w] += inc;
ADDRLP4 96
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
ADDI4
ASGNI4
line 542
;542:				if ( client->ps.ammo[w] > max ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LEI4 $344
line 543
;543:					client->ps.ammo[w] = max;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 544
;544:				}
LABELV $344
line 545
;545:			}
LABELV $339
line 546
;546:		}
LABELV $316
line 511
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $318
ADDRLP4 24
INDIRI4
ADDRLP4 76
INDIRI4
LTI4 $315
line 547
;547:	}
LABELV $311
line 548
;548:}
LABELV $229
endproc ClientTimerActions 100 32
export ClientIntermissionThink
proc ClientIntermissionThink 24 0
line 555
;549:
;550:/*
;551:====================
;552:ClientIntermissionThink
;553:====================
;554:*/
;555:void ClientIntermissionThink( gclient_t *client ) {
line 556
;556:	client->ps.eFlags &= ~EF_TALK;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 557
;557:	client->ps.eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 561
;558:
;559:	// the level will exit when everyone wants to or after timeouts
;560:
;561:	if( g_entities[client->ps.clientNum].r.svFlags & SVF_BOT )
CNSTI4 816
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $347
line 562
;562:		return; //Bots cannot mark themself as ready
ADDRGP4 $346
JUMPV
LABELV $347
line 565
;563:
;564:	// swap and latch button actions
;565:	client->oldbuttons = client->buttons;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1064
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
line 566
;566:	client->buttons = client->pers.cmd.buttons;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1060
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ASGNI4
line 567
;567:	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 16
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
BXORI4
BANDI4
CNSTI4 0
EQI4 $351
line 569
;568:		// this used to be an ^1 but once a player says ready, it should stick
;569:		client->readyToExit = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
CNSTI4 1
ASGNI4
line 570
;570:	}
LABELV $351
line 571
;571:}
LABELV $346
endproc ClientIntermissionThink 24 0
export ClientEvents
proc ClientEvents 76 32
line 582
;572:
;573:
;574:/*
;575:================
;576:ClientEvents
;577:
;578:Events will be passed on to the clients for presentation,
;579:but any server game effects are handled here
;580:================
;581:*/
;582:void ClientEvents( gentity_t *ent, int oldEventSequence ) {
line 592
;583:	int		i, j;
;584:	int		event;
;585:	gclient_t *client;
;586:	int		damage;
;587:	vec3_t	origin, angles;
;588://	qboolean	fired;
;589:	gitem_t *item;
;590:	gentity_t *drop;
;591:
;592:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 594
;593:
;594:	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $354
line 595
;595:		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 596
;596:	}
LABELV $354
line 597
;597:	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $359
JUMPV
LABELV $356
line 598
;598:		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 600
;599:
;600:		switch ( event ) {
ADDRLP4 56
CNSTI4 11
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $362
ADDRLP4 4
INDIRI4
CNSTI4 12
EQI4 $362
ADDRLP4 4
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $361
LABELV $410
ADDRLP4 4
INDIRI4
CNSTI4 23
LTI4 $361
ADDRLP4 4
INDIRI4
CNSTI4 29
GTI4 $361
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $411-92
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $411
address $371
address $361
address $372
address $401
address $403
address $404
address $407
code
LABELV $362
line 603
;601:		case EV_FALL_MEDIUM:
;602:		case EV_FALL_FAR:
;603:			if ( ent->s.eType != ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $363
line 604
;604:				break;		// not in the player model
ADDRGP4 $361
JUMPV
LABELV $363
line 606
;605:			}
;606:			if ( g_dmflags.integer & DF_NO_FALLING ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $365
line 607
;607:				break;
ADDRGP4 $361
JUMPV
LABELV $365
line 609
;608:			}
;609:			if ( event == EV_FALL_FAR ) {
ADDRLP4 4
INDIRI4
CNSTI4 12
NEI4 $368
line 610
;610:				damage = 10;
ADDRLP4 24
CNSTI4 10
ASGNI4
line 611
;611:			} else {
ADDRGP4 $369
JUMPV
LABELV $368
line 612
;612:				damage = 5;
ADDRLP4 24
CNSTI4 5
ASGNI4
line 613
;613:			}
LABELV $369
line 614
;614:			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 615
;615:			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
CNSTP4 0
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
CNSTP4 0
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 616
;616:			break;
ADDRGP4 $361
JUMPV
LABELV $371
line 619
;617:
;618:		case EV_FIRE_WEAPON:
;619:			FireWeapon( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FireWeapon
CALLV
pop
line 620
;620:			break;
ADDRGP4 $361
JUMPV
LABELV $372
line 624
;621:
;622:		case EV_USE_ITEM1:		// teleporter
;623:			// drop flags in CTF
;624:			item = NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 625
;625:			j = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 627
;626:
;627:			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $373
line 628
;628:				item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 72
INDIRP4
ASGNP4
line 629
;629:				j = PW_REDFLAG;
ADDRLP4 12
CNSTI4 7
ASGNI4
line 630
;630:			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $374
JUMPV
LABELV $373
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $375
line 631
;631:				item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 72
INDIRP4
ASGNP4
line 632
;632:				j = PW_BLUEFLAG;
ADDRLP4 12
CNSTI4 8
ASGNI4
line 633
;633:			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $376
JUMPV
LABELV $375
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $377
line 634
;634:				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 72
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 72
INDIRP4
ASGNP4
line 635
;635:				j = PW_NEUTRALFLAG;
ADDRLP4 12
CNSTI4 9
ASGNI4
line 636
;636:			}
LABELV $377
LABELV $376
LABELV $374
line 638
;637:
;638:			if ( item ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $379
line 639
;639:				drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 72
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 72
INDIRP4
ASGNP4
line 641
;640:				// decide how many seconds it has left
;641:				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 642
;642:				if ( drop->count < 1 ) {
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $382
line 643
;643:					drop->count = 1;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 644
;644:				}
LABELV $382
line 646
;645:
;646:				ent->client->ps.powerups[ j ] = 0;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 647
;647:			}
LABELV $379
line 649
;648:
;649:			if ( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $384
line 650
;650:				if ( ent->client->ps.generic1 > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
LEI4 $387
line 651
;651:					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $389
line 652
;652:						item = BG_FindItem( "Blue Cube" );
ADDRGP4 $391
ARGP4
ADDRLP4 72
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 72
INDIRP4
ASGNP4
line 653
;653:					} else {
ADDRGP4 $390
JUMPV
LABELV $389
line 654
;654:						item = BG_FindItem( "Red Cube" );
ADDRGP4 $392
ARGP4
ADDRLP4 72
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 72
INDIRP4
ASGNP4
line 655
;655:					}
LABELV $390
line 656
;656:					if ( item ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $393
line 657
;657:						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $398
JUMPV
LABELV $395
line 658
;658:							drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 72
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 72
INDIRP4
ASGNP4
line 659
;659:							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $399
line 660
;660:								drop->spawnflags = TEAM_BLUE;
ADDRLP4 20
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 2
ASGNI4
line 661
;661:							} else {
ADDRGP4 $400
JUMPV
LABELV $399
line 662
;662:								drop->spawnflags = TEAM_RED;
ADDRLP4 20
INDIRP4
CNSTI4 528
ADDP4
CNSTI4 1
ASGNI4
line 663
;663:							}
LABELV $400
line 664
;664:						}
LABELV $396
line 657
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $398
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
LTI4 $395
line 665
;665:					}
LABELV $393
line 666
;666:					ent->client->ps.generic1 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 0
ASGNI4
line 667
;667:				}
LABELV $387
line 668
;668:			}
LABELV $384
line 669
;669:			SelectSpawnPoint( ent->client->ps.origin, origin, angles, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 670
;670:			TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 671
;671:			break;
ADDRGP4 $361
JUMPV
LABELV $401
line 674
;672:
;673:		case EV_USE_ITEM2:		// medkit
;674:			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + g_medkitmodifier.integer;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRGP4 g_medkitmodifier+12
INDIRI4
ADDI4
ASGNI4
line 676
;675:
;676:			break;
ADDRGP4 $361
JUMPV
LABELV $403
line 680
;677:
;678:		case EV_USE_ITEM3:		// kamikaze
;679:			// make sure the invulnerability is off
;680:			ent->client->invulnerabilityTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
CNSTI4 0
ASGNI4
line 682
;681:			// start the kamikze
;682:			G_StartKamikaze( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StartKamikaze
CALLV
pop
line 683
;683:			break;
ADDRGP4 $361
JUMPV
LABELV $404
line 686
;684:
;685:		case EV_USE_ITEM4:		// portal
;686:			if( ent->client->portalID ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $405
line 687
;687:				DropPortalSource( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropPortalSource
CALLV
pop
line 688
;688:			}
ADDRGP4 $361
JUMPV
LABELV $405
line 689
;689:			else {
line 690
;690:				DropPortalDestination( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DropPortalDestination
CALLV
pop
line 691
;691:			}
line 692
;692:			break;
ADDRGP4 $361
JUMPV
LABELV $407
line 694
;693:		case EV_USE_ITEM5:		// invulnerability
;694:			ent->client->invulnerabilityTime = level.time + g_invultime.integer*1000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_invultime+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 695
;695:			break;
line 698
;696:
;697:		default:
;698:			break;
LABELV $361
line 700
;699:		}
;700:	}
LABELV $357
line 597
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $359
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $356
line 702
;701:
;702:}
LABELV $353
endproc ClientEvents 76 32
proc StuckInOtherClient 8 0
line 709
;703:
;704:/*
;705:==============
;706:StuckInOtherClient
;707:==============
;708:*/
;709:static int StuckInOtherClient(gentity_t *ent) {
line 713
;710:	int i;
;711:	gentity_t	*ent2;
;712:
;713:	ent2 = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 714
;714:	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $414
line 715
;715:		if ( ent2 == ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $418
line 716
;716:			continue;
ADDRGP4 $415
JUMPV
LABELV $418
line 718
;717:		}
;718:		if ( !ent2->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $420
line 719
;719:			continue;
ADDRGP4 $415
JUMPV
LABELV $420
line 721
;720:		}
;721:		if ( !ent2->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $422
line 722
;722:			continue;
ADDRGP4 $415
JUMPV
LABELV $422
line 724
;723:		}
;724:		if ( ent2->health <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $424
line 725
;725:			continue;
ADDRGP4 $415
JUMPV
LABELV $424
line 728
;726:		}
;727:		//
;728:		if (ent2->r.absmin[0] > ent->r.absmax[0])
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
LEF4 $426
line 729
;729:			continue;
ADDRGP4 $415
JUMPV
LABELV $426
line 730
;730:		if (ent2->r.absmin[1] > ent->r.absmax[1])
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
LEF4 $428
line 731
;731:			continue;
ADDRGP4 $415
JUMPV
LABELV $428
line 732
;732:		if (ent2->r.absmin[2] > ent->r.absmax[2])
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
LEF4 $430
line 733
;733:			continue;
ADDRGP4 $415
JUMPV
LABELV $430
line 734
;734:		if (ent2->r.absmax[0] < ent->r.absmin[0])
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
GEF4 $432
line 735
;735:			continue;
ADDRGP4 $415
JUMPV
LABELV $432
line 736
;736:		if (ent2->r.absmax[1] < ent->r.absmin[1])
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
GEF4 $434
line 737
;737:			continue;
ADDRGP4 $415
JUMPV
LABELV $434
line 738
;738:		if (ent2->r.absmax[2] < ent->r.absmin[2])
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
GEF4 $436
line 739
;739:			continue;
ADDRGP4 $415
JUMPV
LABELV $436
line 740
;740:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $413
JUMPV
LABELV $415
line 714
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $414
line 742
;741:	}
;742:	return qfalse;
CNSTI4 0
RETI4
LABELV $413
endproc StuckInOtherClient 8 0
export SendPendingPredictableEvents
proc SendPendingPredictableEvents 44 12
line 752
;743:}
;744:
;745:void BotTestSolid(vec3_t origin);
;746:
;747:/*
;748:==============
;749:SendPendingPredictableEvents
;750:==============
;751:*/
;752:void SendPendingPredictableEvents( playerState_t *ps ) {
line 758
;753:	gentity_t *t;
;754:	int event, seq;
;755:	int extEvent, number;
;756:
;757:	// if there are still events pending
;758:	if ( ps->entityEventSequence < ps->eventSequence ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $439
line 761
;759:		// create a temporary entity for this event which is sent to everyone
;760:		// except the client who generated the event
;761:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 762
;762:		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 8
LSHI4
BORI4
ASGNI4
line 764
;763:		// set external event to zero before calling BG_PlayerStateToEntityState
;764:		extEvent = ps->externalEvent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 765
;765:		ps->externalEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 767
;766:		// create temporary entity for event
;767:		t = G_TempEntity( ps->origin, event );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 768
;768:		number = t->s.number;
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 769
;769:		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 770
;770:		t->s.number = number;
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 771
;771:		t->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 772
;772:		t->s.eFlags |= EF_PLAYER_EVENT;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 773
;773:		t->s.otherEntityNum = ps->clientNum;
ADDRLP4 36
CNSTI4 140
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 775
;774:		// send to everyone except the client who generated the event
;775:		t->r.svFlags |= SVF_NOTSINGLECLIENT;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 776
;776:		t->r.singleClient = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 778
;777:		// set back external event
;778:		ps->externalEvent = extEvent;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 779
;779:	}
LABELV $439
line 780
;780:}
LABELV $438
endproc SendPendingPredictableEvents 44 12
lit
align 4
LABELV $536
byte 4 3257401344
byte 4 3257401344
byte 4 3257401344
align 4
LABELV $537
byte 4 1109917696
byte 4 1109917696
byte 4 1109917696
export ClientThink_real
code
proc ClientThink_real 356 12
line 793
;781:
;782:/*
;783:==============
;784:ClientThink_real
;785:
;786:This will be called once for each client frame, which will
;787:usually be a couple times for each server frame on fast clients.
;788:
;789:If "g_synchronousClients 1" is set, this will be called exactly
;790:once for each server frame, which makes for smooth demo recording.
;791:==============
;792:*/
;793:void ClientThink_real( gentity_t *ent ) {
line 800
;794:	gclient_t	*client;
;795:	pmove_t		pm;
;796:	int			oldEventSequence;
;797:	int			msec;
;798:	usercmd_t	*ucmd;
;799:
;800:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 803
;801:
;802:	// don't think if the client is not yet connected (and thus not yet spawned in)
;803:	if (client->pers.connected != CON_CONNECTED) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $442
line 804
;804:		return;
ADDRGP4 $441
JUMPV
LABELV $442
line 807
;805:	}
;806:	// mark the time, so the connection sprite can be removed
;807:	ucmd = &ent->client->pers.cmd;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
line 810
;808:
;809:	// sanity check the command time to prevent speedup cheating
;810:	if ( ucmd->serverTime > level.time + 200 ) {
ADDRLP4 244
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $444
line 811
;811:		ucmd->serverTime = level.time + 200;
ADDRLP4 244
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 813
;812://		G_Printf("serverTime <<<<<\n" );
;813:	}
LABELV $444
line 814
;814:	if ( ucmd->serverTime < level.time - 1000 ) {
ADDRLP4 244
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $448
line 815
;815:		ucmd->serverTime = level.time - 1000;
ADDRLP4 244
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 817
;816://		G_Printf("serverTime >>>>>\n" );
;817:	} 
LABELV $448
line 824
;818:
;819://Here comes the unlagged bit!
;820://unlagged - backward reconciliation #4
;821:	// frameOffset should be about the number of milliseconds into a frame 
;822:	// this command packet was received, depending on how fast the server
;823:	// does a G_RunFrame()
;824:	client->frameOffset = trap_Milliseconds() - level.frameStartTime;
ADDRLP4 256
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRLP4 256
INDIRI4
ADDRGP4 level+9444
INDIRI4
SUBI4
ASGNI4
line 846
;825://unlagged - backward reconciliation #4
;826:
;827:
;828://unlagged - lag simulation #3
;829:	// if the client wants to simulate outgoing packet loss
;830:/*	if ( client->pers.plOut ) {
;831:		// see if a random value is below the threshhold
;832:		float thresh = (float)client->pers.plOut / 100.0f;
;833:		if ( random() < thresh ) {
;834:			// do nothing at all if it is - this is a lost command
;835:			return;
;836:		}
;837:	}*/
;838://unlagged - lag simulation #3
;839:
;840:
;841://unlagged - true ping
;842:	// save the estimated ping in a queue for averaging later
;843:
;844:	// we use level.previousTime to account for 50ms lag correction
;845:	// besides, this will turn out numbers more like what players are used to
;846:	client->pers.pingsamples[client->pers.samplehead] = level.previousTime + client->frameOffset - ucmd->serverTime;
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDP4
ADDRGP4 level+36
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1992
ADDP4
INDIRI4
ADDI4
ADDRLP4 244
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 847
;847:	client->pers.samplehead++;
ADDRLP4 264
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 264
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 848
;848:	if ( client->pers.samplehead >= NUM_PING_SAMPLES ) {
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 64
LTI4 $454
line 849
;849:		client->pers.samplehead -= NUM_PING_SAMPLES;
ADDRLP4 268
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 64
SUBI4
ASGNI4
line 850
;850:	}
LABELV $454
line 853
;851:
;852:	// initialize the real ping
;853:	if ( g_truePing.integer ) {
ADDRGP4 g_truePing+12
INDIRI4
CNSTI4 0
EQI4 $456
line 854
;854:		int i, sum = 0;
ADDRLP4 272
CNSTI4 0
ASGNI4
line 857
;855:
;856:		// get an average of the samples we saved up
;857:		for ( i = 0; i < NUM_PING_SAMPLES; i++ ) {
ADDRLP4 268
CNSTI4 0
ASGNI4
LABELV $459
line 858
;858:			sum += client->pers.pingsamples[i];
ADDRLP4 272
ADDRLP4 272
INDIRI4
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 859
;859:		}
LABELV $460
line 857
ADDRLP4 268
ADDRLP4 268
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 64
LTI4 $459
line 861
;860:
;861:		client->pers.realPing = sum / NUM_PING_SAMPLES;
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 272
INDIRI4
CNSTI4 64
DIVI4
ASGNI4
line 862
;862:	}
ADDRGP4 $457
JUMPV
LABELV $456
line 863
;863:	else {
line 865
;864:		// if g_truePing is off, use the normal ping
;865:		client->pers.realPing = client->ps.ping;
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 866
;866:	}
LABELV $457
line 902
;867://unlagged - true ping
;868:
;869:
;870://unlagged - lag simulation #2
;871:	// keep a queue of past commands
;872:/*	client->pers.cmdqueue[client->pers.cmdhead] = client->pers.cmd;
;873:	client->pers.cmdhead++;
;874:	if ( client->pers.cmdhead >= MAX_LATENT_CMDS ) {
;875:		client->pers.cmdhead -= MAX_LATENT_CMDS;
;876:	}
;877:
;878:	// if the client wants latency in commands (client-to-server latency)
;879:	if ( client->pers.latentCmds ) {
;880:		// save the actual command time
;881:		int time = ucmd->serverTime;
;882:
;883:		// find out which index in the queue we want
;884:		int cmdindex = client->pers.cmdhead - client->pers.latentCmds - 1;
;885:		while ( cmdindex < 0 ) {
;886:			cmdindex += MAX_LATENT_CMDS;
;887:		}
;888:
;889:		// read in the old command
;890:		client->pers.cmd = client->pers.cmdqueue[cmdindex];
;891:
;892:		// adjust the real ping to reflect the new latency
;893:		client->pers.realPing += time - ucmd->serverTime;
;894:	}*/
;895://unlagged - lag simulation #2
;896:
;897:
;898://unlagged - backward reconciliation #4
;899:	// save the command time *before* pmove_fixed messes with the serverTime,
;900:	// and *after* lag simulation messes with it :)
;901:	// attackTime will be used for backward reconciliation later (time shift)
;902:	client->attackTime = ucmd->serverTime;
ADDRLP4 0
INDIRP4
CNSTI4 1264
ADDP4
ADDRLP4 244
INDIRP4
INDIRI4
ASGNI4
line 909
;903://unlagged - backward reconciliation #4
;904:
;905:
;906://unlagged - smooth clients #1
;907:	// keep track of this for later - we'll use this to decide whether or not
;908:	// to send extrapolated positions for this client
;909:	client->lastUpdateFrame = level.framenum;
ADDRLP4 0
INDIRP4
CNSTI4 1996
ADDP4
ADDRGP4 level+28
INDIRI4
ASGNI4
line 926
;910://unlagged - smooth clients #1
;911:
;912:
;913://unlagged - lag simulation #1
;914:	// if the client is adding latency to received snapshots (server-to-client latency)
;915:	/*if ( client->pers.latentSnaps ) {
;916:		// adjust the real ping
;917:		client->pers.realPing += client->pers.latentSnaps * (1000 / sv_fps.integer);
;918:		// adjust the attack time so backward reconciliation will work
;919:		client->attackTime -= client->pers.latentSnaps * (1000 / sv_fps.integer);
;920:	}*/
;921://unlagged - lag simulation #1
;922:
;923:
;924://unlagged - true ping
;925:	// make sure the true ping is over 0 - with cl_timenudge it can be less
;926:	if ( client->pers.realPing < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 0
GEI4 $464
line 927
;927:		client->pers.realPing = 0;
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
CNSTI4 0
ASGNI4
line 928
;928:	}
LABELV $464
line 931
;929://unlagged - true ping
;930:
;931:	msec = ucmd->serverTime - client->ps.commandTime;
ADDRLP4 248
ADDRLP4 244
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 934
;932:	// following others may result in bad times, but we still want
;933:	// to check for follow toggles
;934:	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 248
INDIRI4
CNSTI4 1
GEI4 $466
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
EQI4 $466
line 935
;935:		return;
ADDRGP4 $441
JUMPV
LABELV $466
line 937
;936:	}
;937:	if ( msec > 200 ) {
ADDRLP4 248
INDIRI4
CNSTI4 200
LEI4 $468
line 938
;938:		msec = 200;
ADDRLP4 248
CNSTI4 200
ASGNI4
line 939
;939:	}
LABELV $468
line 941
;940:
;941:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $470
line 942
;942:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $473
ARGP4
ADDRGP4 $474
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 943
;943:		trap_Cvar_Update(&pmove_msec);
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 944
;944:	}
ADDRGP4 $471
JUMPV
LABELV $470
line 945
;945:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $475
line 946
;946:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $473
ARGP4
ADDRGP4 $478
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 947
;947:		trap_Cvar_Update(&pmove_msec);
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 948
;948:	}
LABELV $475
LABELV $471
line 950
;949:
;950:	if ( pmove_fixed.integer || client->pers.pmoveFixed ) {
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 pmove_fixed+12
INDIRI4
ADDRLP4 268
INDIRI4
NEI4 $482
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $479
LABELV $482
line 951
;951:		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 954
;952:		//if (ucmd->serverTime - client->ps.commandTime <= 0)
;953:		//	return;
;954:	}
LABELV $479
line 959
;955:
;956:	//
;957:	// check for exiting intermission
;958:	//
;959:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $486
line 960
;960:		ClientIntermissionThink( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 961
;961:		return;
ADDRGP4 $441
JUMPV
LABELV $486
line 965
;962:	}
;963:
;964:	// spectators don't do much
;965:	if ( (client->sess.sessionTeam == TEAM_SPECTATOR) || client->isEliminated ) {
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $491
ADDRLP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
LABELV $491
line 966
;966:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 3
NEI4 $492
line 967
;967:			return;
ADDRGP4 $441
JUMPV
LABELV $492
line 969
;968:		}
;969:		SpectatorThink( ent, ucmd );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 244
INDIRP4
ARGP4
ADDRGP4 SpectatorThink
CALLV
pop
line 970
;970:		return;
ADDRGP4 $441
JUMPV
LABELV $489
line 974
;971:	}
;972:
;973:	// check for inactivity timer, but never drop the local client of a non-dedicated server
;974:	if ( !ClientInactivityTimer( client ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 ClientInactivityTimer
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $494
line 975
;975:		return;
ADDRGP4 $441
JUMPV
LABELV $494
line 979
;976:	}
;977:
;978:	// clear the rewards if time
;979:	if ( level.time > client->rewardTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1148
ADDP4
INDIRI4
LEI4 $496
line 980
;980:		client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 981
;981:	}
LABELV $496
line 983
;982:
;983:	if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
EQI4 $499
line 984
;984:		client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 985
;985:	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 $500
JUMPV
LABELV $499
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $501
line 986
;986:		client->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 987
;987:	} else {
ADDRGP4 $502
JUMPV
LABELV $501
line 988
;988:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 989
;989:	}
LABELV $502
LABELV $500
line 991
;990:
;991:	client->ps.gravity = g_gravity.value*g_gravityModifier.value;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRGP4 g_gravity+8
INDIRF4
ADDRGP4 g_gravityModifier+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 994
;992:
;993:	// set speed
;994:	client->ps.speed = g_speed.value;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CVFI4 4
ASGNI4
line 996
;995:
;996:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $506
line 997
;997:		client->ps.speed *= g_scoutspeedfactor.value;
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 g_scoutspeedfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 998
;998:	}
LABELV $506
line 999
;999:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $510
line 1000
;1000:		client->ps.speed *= g_ammoregenspeedfactor.value;
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 g_ammoregenspeedfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1001
;1001:	}
LABELV $510
line 1002
;1002:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $514
line 1003
;1003:		client->ps.speed *= g_doublerspeedfactor.value;
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 g_doublerspeedfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1004
;1004:	}
LABELV $514
line 1005
;1005:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
CNSTI4 52
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $518
line 1006
;1006:		client->ps.speed *= g_guardspeedfactor.value;
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 g_guardspeedfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1007
;1007:	}
ADDRGP4 $519
JUMPV
LABELV $518
line 1009
;1008:	else
;1009:	if ( client->ps.powerups[PW_HASTE] ) {
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $522
line 1010
;1010:		client->ps.speed *= g_speedfactor.value;
ADDRLP4 280
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 g_speedfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1011
;1011:	}
LABELV $522
LABELV $519
line 1014
;1012:
;1013:	// Let go of the hook if we aren't firing
;1014:	if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $525
ADDRLP4 0
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $525
ADDRLP4 244
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $525
line 1015
;1015:		client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
line 1016
;1016:		Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 1164
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 1017
;1017:	}
LABELV $525
line 1020
;1018:
;1019:	// set up for pmove
;1020:	oldEventSequence = client->ps.eventSequence;
ADDRLP4 252
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1022
;1021:
;1022:	memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 240
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1026
;1023:
;1024:	// check for the hit-scan gauntlet, don't let the action
;1025:	// go through as an attack unless it actually hits something
;1026:	if ( client->ps.weapon == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
ADDRLP4 288
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 288
INDIRI4
NEI4 $527
ADDRLP4 292
ADDRLP4 244
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 296
CNSTI4 0
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 296
INDIRI4
NEI4 $527
ADDRLP4 292
INDIRI4
ADDRLP4 288
INDIRI4
BANDI4
ADDRLP4 296
INDIRI4
EQI4 $527
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
GTI4 $527
line 1027
;1027:		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
line 1028
;1028:		pm.gauntletHit = CheckGauntletAttack( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+40
ADDRLP4 300
INDIRI4
ASGNI4
line 1029
;1029:	}
LABELV $527
line 1031
;1030:
;1031:	if ( ent->flags & FL_FORCE_GESTURE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $530
line 1032
;1032:		ent->flags &= ~FL_FORCE_GESTURE;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 1033
;1033:		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 304
INDIRP4
ADDRLP4 304
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1034
;1034:	}
LABELV $530
line 1037
;1035:
;1036:	// check for invulnerability expansion before doing the Pmove
;1037:	if (client->ps.powerups[PW_INVULNERABILITY] ) {
ADDRLP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $532
line 1038
;1038:		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $534
line 1039
;1039:			vec3_t mins = { -42, -42, -42 };
ADDRLP4 300
ADDRGP4 $536
INDIRB
ASGNB 12
line 1040
;1040:			vec3_t maxs = { 42, 42, 42 };
ADDRLP4 312
ADDRGP4 $537
INDIRB
ASGNB 12
line 1043
;1041:			vec3_t oldmins, oldmaxs;
;1042:
;1043:			VectorCopy (ent->r.mins, oldmins);
ADDRLP4 324
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1044
;1044:			VectorCopy (ent->r.maxs, oldmaxs);
ADDRLP4 336
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1046
;1045:			// expand
;1046:			VectorCopy (mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 300
INDIRB
ASGNB 12
line 1047
;1047:			VectorCopy (maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 312
INDIRB
ASGNB 12
line 1048
;1048:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1050
;1049:			// check if this would get anyone stuck in this player
;1050:			if ( !StuckInOtherClient(ent) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 StuckInOtherClient
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $538
line 1052
;1051:				// set flag so the expanded size will be set in PM_CheckDuck
;1052:				client->ps.pm_flags |= PMF_INVULEXPAND;
ADDRLP4 352
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 352
INDIRP4
ADDRLP4 352
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1053
;1053:			}
LABELV $538
line 1055
;1054:			// set back
;1055:			VectorCopy (oldmins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 324
INDIRB
ASGNB 12
line 1056
;1056:			VectorCopy (oldmaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 336
INDIRB
ASGNB 12
line 1057
;1057:			trap_LinkEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1058
;1058:		}
LABELV $534
line 1059
;1059:	}
LABELV $532
line 1061
;1060:
;1061:	pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 1062
;1062:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 244
INDIRP4
INDIRB
ASGNB 24
line 1063
;1063:	if ( pm.ps->pm_type == PM_DEAD ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $541
line 1064
;1064:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 1065
;1065:	}
ADDRGP4 $542
JUMPV
LABELV $541
line 1066
;1066:	else if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $544
line 1067
;1067:		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
ADDRLP4 4+28
CNSTI4 37814273
ASGNI4
line 1068
;1068:	}
ADDRGP4 $545
JUMPV
LABELV $544
line 1069
;1069:	else {
line 1070
;1070:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 1071
;1071:	}
LABELV $545
LABELV $542
line 1072
;1072:	pm.trace = trap_Trace;
ADDRLP4 4+232
ADDRGP4 trap_Trace
ASGNP4
line 1073
;1073:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+236
ADDRGP4 trap_PointContents
ASGNP4
line 1074
;1074:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 1075
;1075:	pm.noFootsteps = ( g_dmflags.integer & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $555
ADDRLP4 300
CNSTI4 1
ASGNI4
ADDRGP4 $556
JUMPV
LABELV $555
ADDRLP4 300
CNSTI4 0
ASGNI4
LABELV $556
ADDRLP4 4+36
ADDRLP4 300
INDIRI4
ASGNI4
line 1077
;1076:
;1077:	pm.pmove_fixed = pmove_fixed.integer | client->pers.pmoveFixed;
ADDRLP4 4+216
ADDRGP4 pmove_fixed+12
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
BORI4
ASGNI4
line 1078
;1078:	pm.pmove_msec = pmove_msec.integer;
ADDRLP4 4+220
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 1079
;1079:	pm.pmove_float = pmove_float.integer;
ADDRLP4 4+224
ADDRGP4 pmove_float+12
INDIRI4
ASGNI4
line 1080
;1080:	pm.pmove_flags = g_dmflags.integer;
ADDRLP4 4+228
ADDRGP4 g_dmflags+12
INDIRI4
ASGNI4
line 1082
;1081:
;1082:	VectorCopy( client->ps.origin, client->oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 1072
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1098
;1083:
;1084:#ifdef MISSIONPACK
;1085:	if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
;1086:		if ( level.time - level.intermissionQueued >= 1000  ) {
;1087:			pm.cmd.buttons = 0;
;1088:			pm.cmd.forwardmove = 0;
;1089:			pm.cmd.rightmove = 0;
;1090:			pm.cmd.upmove = 0;
;1091:			if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
;1092:				trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
;1093:			}
;1094:			ent->client->ps.pm_type = PM_SPINTERMISSION;
;1095:		}
;1096:	}
;1097:#endif
;1098:	Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 1101
;1099:
;1100:	// save results of pmove
;1101:	if ( ent->client->ps.eventSequence != oldEventSequence ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 252
INDIRI4
EQI4 $565
line 1102
;1102:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1103
;1103:	}
LABELV $565
line 1115
;1104://unlagged - smooth clients #2
;1105:	// clients no longer do extrapolation if cg_smoothClients is 1, because
;1106:	// skip correction is all handled server-side now
;1107:	// since that's the case, it makes no sense to store the extra info
;1108:	// in the client's snapshot entity, so let's save a little bandwidth
;1109:/*
;1110:	if (g_smoothClients.integer) {
;1111:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
;1112:	}
;1113:	else {
;1114:*/
;1115:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 308
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1118
;1116://	}
;1117://unlagged - smooth clients #2
;1118:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1120
;1119:
;1120:	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $568
line 1121
;1121:		client->fireHeld = qfalse;		// for grapple
ADDRLP4 0
INDIRP4
CNSTI4 1160
ADDP4
CNSTI4 0
ASGNI4
line 1122
;1122:	}
LABELV $568
line 1125
;1123:
;1124:	// use the snapped origin for linking so it matches client predicted versions
;1125:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 312
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1127
;1126:
;1127:	VectorCopy (pm.mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+180
INDIRB
ASGNB 12
line 1128
;1128:	VectorCopy (pm.maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+192
INDIRB
ASGNB 12
line 1130
;1129:
;1130:	ent->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ADDRLP4 4+208
INDIRI4
ASGNI4
line 1131
;1131:	ent->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 4+204
INDIRI4
ASGNI4
line 1134
;1132:
;1133:	// execute client events
;1134:	ClientEvents( ent, oldEventSequence );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 252
INDIRI4
ARGI4
ADDRGP4 ClientEvents
CALLV
pop
line 1137
;1135:
;1136:	// link entity now, after any personal teleporters have been used
;1137:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1138
;1138:	if ( !ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
CNSTI4 0
NEI4 $574
line 1139
;1139:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 1140
;1140:	}
LABELV $574
line 1143
;1141:
;1142:	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
;1143:	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 316
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1146
;1144:
;1145:	//test for solid areas in the AAS file
;1146:	BotTestAAS(ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BotTestAAS
CALLV
pop
line 1149
;1147:
;1148:	// touch other objects
;1149:	ClientImpacts( ent, &pm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 1152
;1150:
;1151:	// save results of triggers and client events
;1152:	if (ent->client->ps.eventSequence != oldEventSequence) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 252
INDIRI4
EQI4 $576
line 1153
;1153:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1154
;1154:	}
LABELV $576
line 1157
;1155:
;1156:	// swap and latch button actions
;1157:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 1064
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
line 1158
;1158:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
ADDRLP4 244
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1159
;1159:	client->latched_buttons |= client->buttons & ~client->oldbuttons;
ADDRLP4 328
ADDRLP4 0
INDIRP4
CNSTI4 1068
ADDP4
ASGNP4
ADDRLP4 328
INDIRP4
ADDRLP4 328
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
BCOMI4
BANDI4
BORI4
ASGNI4
line 1162
;1160:
;1161:	// check for respawning
;1162:	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $579
line 1168
;1163:		// wait for the attack button to be pressed
;1164:		// forcerespawn is to prevent users from waiting out powerups
;1165:		// In Last man standing, we force a quick respawn, since
;1166:		// the player must be able to loose health
;1167:		// pressing attack or use is the normal respawn method
;1168:		if ( ( level.time > client->respawnTime ) &&
ADDRLP4 332
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
ASGNI4
ADDRGP4 level+32
INDIRI4
ADDRLP4 332
INDIRI4
LEI4 $441
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 0
LEI4 $590
ADDRGP4 level+32
INDIRI4
ADDRLP4 332
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_forcerespawn+12
INDIRI4
MULI4
GTI4 $591
LABELV $590
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 336
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 340
CNSTI4 0
ASGNI4
ADDRLP4 336
INDIRI4
ADDRLP4 340
INDIRI4
EQI4 $592
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
SUBI4
ADDRLP4 340
INDIRI4
GTI4 $591
LABELV $592
ADDRLP4 244
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
EQI4 $441
LABELV $591
line 1173
;1169:			( ( ( g_forcerespawn.integer > 0 ) && 
;1170:			( level.time - client->respawnTime  > g_forcerespawn.integer * 1000 ) ) ||
;1171:			( G_IsARoundBasedGametype(g_gametype.integer) &&
;1172:			( level.time - client->respawnTime > 0 ) ) ||	
;1173:			( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) ) ) {
line 1175
;1174:
;1175:			ClientRespawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientRespawn
CALLV
pop
line 1176
;1176:		}
line 1177
;1177:		return;
ADDRGP4 $441
JUMPV
LABELV $579
line 1180
;1178:	}
;1179:
;1180:        if ( g_awardpushing.integer < 2 && pm.waterlevel <= 1 && pm.ps->groundEntityNum!=ENTITYNUM_NONE && client->lastSentFlyingTime+500>level.time) {
ADDRGP4 g_awardpushing+12
INDIRI4
CNSTI4 2
GEI4 $593
ADDRLP4 4+208
INDIRI4
CNSTI4 1
GTI4 $593
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $593
ADDRLP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ADDRGP4 level+32
INDIRI4
LEI4 $593
line 1181
;1181:			if ( ! (pm.ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $598
line 1182
;1182:				client->lastSentFlying = -1;
ADDRLP4 0
INDIRP4
CNSTI4 1256
ADDP4
CNSTI4 -1
ASGNI4
line 1183
;1183:			}
LABELV $598
line 1184
;1184:	}
LABELV $593
line 1187
;1185:        
;1186:	// perform once-a-second actions
;1187:	ClientTimerActions( ent, msec );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 248
INDIRI4
ARGI4
ADDRGP4 ClientTimerActions
CALLV
pop
line 1188
;1188:}
LABELV $441
endproc ClientThink_real 356 12
export ClientThink
proc ClientThink 8 8
line 1197
;1189:
;1190:/*
;1191:==================
;1192:ClientThink
;1193:
;1194:A new command has arrived from the client
;1195:==================
;1196:*/
;1197:void ClientThink( int clientNum ) {
line 1200
;1198:	gentity_t *ent;
;1199:
;1200:	ent = g_entities + clientNum;
ADDRLP4 0
CNSTI4 816
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1201
;1201:	trap_GetUsercmd( clientNum, &ent->client->pers.cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1208
;1202:
;1203:	//Unlagged: commented out
;1204:	// mark the time we got info, so we can display the
;1205:	// phone jack if they don't get any for a while
;1206:	//ent->client->lastCmdTime = level.time;
;1207:
;1208:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $601
ADDRGP4 g_synchronousClients+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $601
line 1209
;1209:		ClientThink_real( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1210
;1210:	}
LABELV $601
line 1211
;1211:}
LABELV $600
endproc ClientThink 8 8
export G_RunClient
proc G_RunClient 4 4
line 1214
;1212:
;1213:
;1214:void G_RunClient( gentity_t *ent ) {
line 1215
;1215:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 0
INDIRI4
NEI4 $605
ADDRGP4 g_synchronousClients+12
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $605
line 1216
;1216:		return;
ADDRGP4 $604
JUMPV
LABELV $605
line 1218
;1217:	}
;1218:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1219
;1219:	ClientThink_real( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1220
;1220:}
LABELV $604
endproc G_RunClient 4 4
export SpectatorClientEndFrame
proc SpectatorClientEndFrame 96 4
line 1229
;1221:
;1222:
;1223:/*
;1224:==================
;1225:SpectatorClientEndFrame
;1226:
;1227:==================
;1228:*/
;1229:void SpectatorClientEndFrame( gentity_t *ent ) {
line 1234
;1230:	gclient_t	*cl;
;1231:	int i, preservedScore[MAX_PERSISTANT]; //for keeping in elimination
;1232:
;1233:	// if we are doing a chase cam or a remote view, grab the latest info
;1234:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $610
line 1237
;1235:		int		clientNum, flags;
;1236:
;1237:		clientNum = ent->client->sess.spectatorClient;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
ASGNI4
line 1240
;1238:
;1239:		// team follow1 and team follow2 go to whatever clients are playing
;1240:		if ( clientNum == -1 ) {
ADDRLP4 72
INDIRI4
CNSTI4 -1
NEI4 $612
line 1241
;1241:			clientNum = level.follow1;
ADDRLP4 72
ADDRGP4 level+340
INDIRI4
ASGNI4
line 1242
;1242:		} else if ( clientNum == -2 ) {
ADDRGP4 $613
JUMPV
LABELV $612
ADDRLP4 72
INDIRI4
CNSTI4 -2
NEI4 $615
line 1243
;1243:			clientNum = level.follow2;
ADDRLP4 72
ADDRGP4 level+344
INDIRI4
ASGNI4
line 1244
;1244:		}
LABELV $615
LABELV $613
line 1245
;1245:		if ( clientNum >= 0 ) {
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $618
line 1246
;1246:			cl = &level.clients[ clientNum ];
ADDRLP4 68
CNSTI4 2116
ADDRLP4 72
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1247
;1247:			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 80
ADDRLP4 68
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $620
ADDRLP4 80
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $620
line 1248
;1248:				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
ADDRLP4 84
CNSTI4 104
ASGNI4
ADDRLP4 76
ADDRLP4 68
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
CNSTI4 -540673
BANDI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
CNSTI4 540672
BANDI4
BORI4
ASGNI4
line 1250
;1249:				//this is here LMS/Elimination goes wrong with player follow
;1250:				if(ent->client->sess.sessionTeam!=TEAM_SPECTATOR){
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $622
line 1251
;1251:					for(i = 0; i < MAX_PERSISTANT; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $624
line 1252
;1252:						preservedScore[i] = ent->client->ps.persistant[i];
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 88
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
LABELV $625
line 1251
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $624
line 1253
;1253:					ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 68
INDIRP4
INDIRB
ASGNB 468
line 1254
;1254:					for(i = 0; i < MAX_PERSISTANT; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $628
line 1255
;1255:						ent->client->ps.persistant[i] = preservedScore[i];
ADDRLP4 92
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 92
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
ADDRLP4 92
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
LABELV $629
line 1254
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $628
line 1256
;1256:				}
ADDRGP4 $623
JUMPV
LABELV $622
line 1258
;1257:				else
;1258:					ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 68
INDIRP4
INDIRB
ASGNB 468
LABELV $623
line 1259
;1259:				ent->client->ps.pm_flags |= PMF_FOLLOW;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1260
;1260:				ent->client->ps.eFlags = flags;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 1261
;1261:				return;
ADDRGP4 $609
JUMPV
LABELV $620
line 1263
;1262:			}
;1263:		}
LABELV $618
line 1264
;1264:		if ( ent->client->ps.pm_flags & PMF_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $632
line 1266
;1265:			// drop them to free spectators unless they are dedicated camera followers
;1266:			if ( ent->client->sess.spectatorClient >= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 0
LTI4 $634
line 1267
;1267:				ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
line 1268
;1268:			}
LABELV $634
line 1269
;1269:			ClientBegin( ent->client - level.clients );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 2116
DIVI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 1270
;1270:		}
LABELV $632
line 1271
;1271:	}
LABELV $610
line 1273
;1272:
;1273:	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 3
NEI4 $636
line 1274
;1274:		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1275
;1275:	} else {
ADDRGP4 $637
JUMPV
LABELV $636
line 1276
;1276:		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1277
;1277:	}
LABELV $637
line 1278
;1278:}
LABELV $609
endproc SpectatorClientEndFrame 96 4
export ClientEndFrame
proc ClientEndFrame 40 12
line 1289
;1279:
;1280:/*
;1281:==============
;1282:ClientEndFrame
;1283:
;1284:Called at the end of each server frame for each connected client
;1285:A fast client will have multiple ClientThink for each ClientEdFrame,
;1286:while a slow client may have multiple ClientEndFrame between ClientThink.
;1287:==============
;1288:*/
;1289:void ClientEndFrame( gentity_t *ent ) {
line 1296
;1290:	int			i;
;1291:
;1292://unlagged - smooth clients #1
;1293:	int frames;
;1294://unlagged - smooth clients #1
;1295:
;1296:	if ( (ent->client->sess.sessionTeam == TEAM_SPECTATOR) || ent->client->isEliminated ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
EQI4 $641
ADDRLP4 8
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $639
LABELV $641
line 1297
;1297:		SpectatorClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpectatorClientEndFrame
CALLV
pop
line 1298
;1298:		return;
ADDRGP4 $638
JUMPV
LABELV $639
line 1302
;1299:	}
;1300:
;1301:	// turn off any expired powerups
;1302:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 1303
;1303:		if ( ent->client->ps.powerups[ i ] < level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $646
line 1304
;1304:			ent->client->ps.powerups[ i ] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1305
;1305:		}
LABELV $646
line 1306
;1306:	}
LABELV $643
line 1302
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $642
line 1309
;1307:
;1308:	// set powerup for player animation
;1309:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $649
line 1310
;1310:		ent->client->ps.powerups[PW_GUARD] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 356
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1311
;1311:	}
LABELV $649
line 1312
;1312:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $653
line 1313
;1313:		ent->client->ps.powerups[PW_SCOUT] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 352
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1314
;1314:	}
LABELV $653
line 1315
;1315:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $657
line 1316
;1316:		ent->client->ps.powerups[PW_DOUBLER] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 360
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1317
;1317:	}
LABELV $657
line 1318
;1318:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $661
line 1319
;1319:		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 364
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1320
;1320:	}
LABELV $661
line 1321
;1321:	if ( ent->client->invulnerabilityTime > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $665
line 1322
;1322:		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 368
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1323
;1323:	}
LABELV $665
line 1337
;1324:
;1325:	// save network bandwidth
;1326:#if 0
;1327:	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
;1328:		// FIXME: this must change eventually for non-sync demo recording
;1329:		VectorClear( ent->client->ps.viewangles );
;1330:	}
;1331:#endif
;1332:
;1333:	//
;1334:	// If the end of unit layout is displayed, don't give
;1335:	// the player any normal movement attributes
;1336:	//
;1337:	if ( level.intermissiontime ) {
ADDRGP4 level+9144
INDIRI4
CNSTI4 0
EQI4 $669
line 1338
;1338:		return;
ADDRGP4 $638
JUMPV
LABELV $669
line 1342
;1339:	}
;1340:
;1341:	// burn from lava, etc
;1342:	P_WorldEffects (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_WorldEffects
CALLV
pop
line 1345
;1343:
;1344:	// apply all the damage taken this frame
;1345:	P_DamageFeedback (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_DamageFeedback
CALLV
pop
line 1355
;1346:
;1347:	//Unlagged: Commented out
;1348:	// add the EF_CONNECTION flag if we haven't gotten commands recently
;1349:	/*if ( level.time - ent->client->lastCmdTime > 1000 ) {
;1350:		ent->s.eFlags |= EF_CONNECTION;
;1351:	} else {
;1352:		ent->s.eFlags &= ~EF_CONNECTION;
;1353:	}*/
;1354:
;1355:	ent->client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1357
;1356:
;1357:	G_SetClientSound (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetClientSound
CALLV
pop
line 1365
;1358:
;1359://Unlagged: Always do the else clause
;1360:	// set the latest infor
;1361:/*	if (g_smoothClients.integer) {
;1362:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
;1363:	}
;1364:	else { */
;1365:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1367
;1366://	}
;1367:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1371
;1368:
;1369://unlagged - smooth clients #1
;1370:	// mark as not missing updates initially
;1371:	ent->client->ps.eFlags &= ~EF_CONNECTION;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1374
;1372:
;1373:	// see how many frames the client has missed
;1374:	frames = level.framenum - ent->client->lastUpdateFrame - 1;
ADDRLP4 4
ADDRGP4 level+28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1996
ADDP4
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1377
;1375:
;1376:	// don't extrapolate more than two frames
;1377:	if ( frames > 2 ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LEI4 $673
line 1378
;1378:		frames = 2;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 1381
;1379:
;1380:		// if they missed more than two in a row, show the phone jack
;1381:		ent->client->ps.eFlags |= EF_CONNECTION;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1382
;1382:		ent->s.eFlags |= EF_CONNECTION;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1383
;1383:	}
LABELV $673
line 1386
;1384:
;1385:	// did the client miss any frames?
;1386:	if ( frames > 0 && g_smoothClients.integer ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $675
ADDRGP4 g_smoothClients+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $675
line 1388
;1387:		// yep, missed one or more, so extrapolate the player's movement
;1388:		G_PredictPlayerMove( ent, (float)frames / sv_fps.integer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRGP4 sv_fps+12
INDIRI4
CVIF4 4
DIVF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1390
;1389:		// save network bandwidth
;1390:		SnapVector( ent->s.pos.trBase );
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1391
;1391:	}
LABELV $675
line 1396
;1392://unlagged - smooth clients #1
;1393:
;1394://unlagged - backward reconciliation #1
;1395:	// store the client's position for backward reconciliation later
;1396:	G_StoreHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StoreHistory
CALLV
pop
line 1402
;1397://unlagged - backward reconciliation #1
;1398:
;1399:	// set the bit for the reachability area the client is currently in
;1400://	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
;1401://	ent->client->areabits[i >> 3] |= 1 << (i & 7);
;1402:}
LABELV $638
endproc ClientEndFrame 40 12
import BotTestSolid
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
LABELV $478
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $474
byte 1 56
byte 1 0
align 1
LABELV $473
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $392
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $391
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 67
byte 1 117
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $310
byte 1 80
byte 1 79
byte 1 83
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $224
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $116
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
