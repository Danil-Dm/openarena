export Pickup_Powerup
code
proc Pickup_Powerup 136 28
file "../../../code/game/g_items.c"
line 50
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
;25:/*
;26:
;27:  Items are any object that a player can touch to gain some effect.
;28:
;29:  Pickup will return the number of seconds until they should respawn.
;30:
;31:  all items should pop when dropped in lava or slime
;32:
;33:  Respawnable items don't actually go away when picked up, they are
;34:  just made invisible and untouchable.  This allows them to ride
;35:  movers and respawn apropriately.
;36:*/
;37:
;38:
;39:#define	RESPAWN_ARMOR		g_armorrespawn.value
;40:#define	RESPAWN_HEALTH		g_healthrespawn.value
;41:#define	RESPAWN_AMMO		g_ammorespawn.value
;42:#define	RESPAWN_HOLDABLE	g_holdablerespawn.value
;43:#define	RESPAWN_MEGAHEALTH	g_megahealthrespawn.value//120
;44:#define	RESPAWN_POWERUP		g_poweruprespawn.value
;45:
;46:
;47://======================================================================
;48:
;49:int Pickup_Powerup( gentity_t *ent, gentity_t *other )
;50:{
line 55
;51:	int			quantity;
;52:	int			i;
;53:	gclient_t	*client;
;54:
;55:	if ( !other->client->ps.powerups[ent->item->giTag] ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $61
line 58
;56:		// round timing to seconds to make multiple powerup timers
;57:		// count in sync
;58:		other->client->ps.powerups[ent->item->giTag] =
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 60
;59:		    level.time - ( level.time % 1000 );
;60:	}
LABELV $61
line 62
;61:
;62:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $65
line 63
;63:		quantity = ent->count;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 64
;64:	}
ADDRGP4 $66
JUMPV
LABELV $65
line 65
;65:	else {
line 66
;66:		quantity = ent->item->quantity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 67
;67:	}
LABELV $66
line 68
;68:	other->client->ps.powerups[ent->item->giTag] += mod_poweruptime * 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDRGP4 mod_poweruptime
INDIRI4
MULI4
ADDI4
ASGNI4
line 71
;69:
;70:	// give any nearby players a "denied" anti-reward
;71:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $70
JUMPV
LABELV $67
line 77
;72:		vec3_t		delta;
;73:		float		len;
;74:		vec3_t		forward;
;75:		trace_t		tr;
;76:
;77:		client = &level.clients[i];
ADDRLP4 0
CNSTI4 2116
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 78
;78:		if ( client == other->client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $72
line 79
;79:			continue;
ADDRGP4 $68
JUMPV
LABELV $72
line 81
;80:		}
;81:		if ( client->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $74
line 82
;82:			continue;
ADDRGP4 $68
JUMPV
LABELV $74
line 84
;83:		}
;84:		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $76
line 85
;85:			continue;
ADDRGP4 $68
JUMPV
LABELV $76
line 90
;86:		}
;87:
;88:		// if same team in team game, no sound
;89:		// cannot use OnSameTeam as it expects to g_entities, not clients
;90:		if (G_IsATeamGametype(g_gametype.integer) && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 G_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $78
ADDRLP4 104
CNSTI4 1024
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
NEI4 $78
line 91
;91:			continue;
ADDRGP4 $68
JUMPV
LABELV $78
line 95
;92:		}
;93:
;94:		// if too far away, no sound
;95:		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
CNSTI4 24
ASGNI4
ADDRLP4 16
ADDRLP4 108
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 108
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 96
;96:		len = VectorNormalize( delta );
ADDRLP4 16
ARGP4
ADDRLP4 120
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 120
INDIRF4
ASGNF4
line 97
;97:		if ( len > 192 ) {
ADDRLP4 40
INDIRF4
CNSTF4 1128267776
LEF4 $83
line 98
;98:			continue;
ADDRGP4 $68
JUMPV
LABELV $83
line 102
;99:		}
;100:
;101:		// if not facing, no sound
;102:		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 124
CNSTP4 0
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 103
;103:		if ( DotProduct( delta, forward ) < 0.4 ) {
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
CNSTF4 1053609165
GEF4 $85
line 104
;104:			continue;
ADDRGP4 $68
JUMPV
LABELV $85
line 108
;105:		}
;106:
;107:		// if not line of sight, no sound
;108:		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
ADDRLP4 44
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 128
CNSTP4 0
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 109
;109:		if ( tr.fraction != 1.0 ) {
ADDRLP4 44+8
INDIRF4
CNSTF4 1065353216
EQF4 $91
line 110
;110:			continue;
ADDRGP4 $68
JUMPV
LABELV $91
line 114
;111:		}
;112:
;113:		// anti-reward
;114:		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
ADDRLP4 132
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 115
;115:	}
LABELV $68
line 71
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $70
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $67
line 116
;116:	return RESPAWN_POWERUP;
ADDRGP4 g_poweruprespawn+8
INDIRF4
CVFI4 4
RETI4
LABELV $60
endproc Pickup_Powerup 136 28
export Pickup_PersistantPowerup
proc Pickup_PersistantPowerup 1104 12
line 122
;117:}
;118:
;119://======================================================================
;120:
;121:int Pickup_PersistantPowerup( gentity_t *ent, gentity_t *other )
;122:{
line 128
;123:	int		clientNum;
;124:	char	userinfo[MAX_INFO_STRING];
;125:	float	handicap;
;126:	int		max;
;127:
;128:	other->client->ps.stats[STAT_PERSISTANT_POWERUP] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 129
;129:	other->client->persistantPowerup = ent;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 131
;130:
;131:	switch( ent->item->giTag ) {
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 10
LTI4 $96
ADDRLP4 1036
INDIRI4
CNSTI4 13
GTI4 $96
ADDRLP4 1036
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $120-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $120
address $105
address $99
address $109
address $113
code
LABELV $99
line 133
;132:	case PW_GUARD:
;133:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 134
;134:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 135
;135:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1048
INDIRF4
ASGNF4
line 136
;136:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1052
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1052
INDIRF4
CNSTF4 0
LEF4 $103
ADDRLP4 1052
INDIRF4
CNSTF4 1120403456
LEF4 $101
LABELV $103
line 137
;137:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 138
;138:		}
LABELV $101
line 139
;139:		max = (int)(g_guardhealthmodifier.value *  handicap);
ADDRLP4 1032
ADDRGP4 g_guardhealthmodifier+8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 141
;140:
;141:		other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 142
;142:		other->client->ps.stats[STAT_HEALTH] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 143
;143:		other->client->ps.stats[STAT_MAX_HEALTH] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 144
;144:		other->client->ps.stats[STAT_ARMOR] = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 145
;145:		other->client->pers.maxHealth = max;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 147
;146:
;147:		break;
ADDRGP4 $97
JUMPV
LABELV $105
line 150
;148:
;149:	case PW_SCOUT:
;150:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 151
;151:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 152
;152:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 1056
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1060
INDIRF4
ASGNF4
line 153
;153:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1064
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1064
INDIRF4
CNSTF4 0
LEF4 $108
ADDRLP4 1064
INDIRF4
CNSTF4 1120403456
LEF4 $106
LABELV $108
line 154
;154:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 155
;155:		}
LABELV $106
line 156
;156:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 157
;157:		other->client->ps.stats[STAT_ARMOR] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 158
;158:		break;
ADDRGP4 $97
JUMPV
LABELV $109
line 161
;159:
;160:	case PW_DOUBLER:
;161:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 162
;162:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 163
;163:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 1068
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1072
INDIRF4
ASGNF4
line 164
;164:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1076
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1076
INDIRF4
CNSTF4 0
LEF4 $112
ADDRLP4 1076
INDIRF4
CNSTF4 1120403456
LEF4 $110
LABELV $112
line 165
;165:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 166
;166:		}
LABELV $110
line 167
;167:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 168
;168:		break;
ADDRGP4 $97
JUMPV
LABELV $113
line 170
;169:	case PW_AMMOREGEN:
;170:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 171
;171:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 172
;172:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 1080
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1084
INDIRF4
ASGNF4
line 173
;173:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1088
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1088
INDIRF4
CNSTF4 0
LEF4 $116
ADDRLP4 1088
INDIRF4
CNSTF4 1120403456
LEF4 $114
LABELV $116
line 174
;174:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 175
;175:		}
LABELV $114
line 176
;176:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 177
;177:		memset(other->client->ammoTimes, 0, sizeof(other->client->ammoTimes));
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1184
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 178
;178:		break;
ADDRGP4 $97
JUMPV
LABELV $96
line 180
;179:	default:
;180:		clientNum = other->client->ps.clientNum;
ADDRLP4 1028
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 181
;181:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 182
;182:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 1096
INDIRF4
ASGNF4
line 183
;183:		if( handicap<=0.0f || handicap>100.0f) {
ADDRLP4 1100
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 1100
INDIRF4
CNSTF4 0
LEF4 $119
ADDRLP4 1100
INDIRF4
CNSTF4 1120403456
LEF4 $117
LABELV $119
line 184
;184:			handicap = 100.0f;
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
line 185
;185:		}
LABELV $117
line 186
;186:		other->client->pers.maxHealth = handicap;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 548
ADDP4
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 187
;187:		break;
LABELV $97
line 190
;188:	}
;189:
;190:	return -1;
CNSTI4 -1
RETI4
LABELV $95
endproc Pickup_PersistantPowerup 1104 12
export Pickup_Holdable
proc Pickup_Holdable 4 0
line 196
;191:}
;192:
;193://======================================================================
;194:
;195:int Pickup_Holdable( gentity_t *ent, gentity_t *other )
;196:{
line 198
;197:
;198:	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 200
;199:
;200:	if( ent->item->giTag == HI_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $123
line 201
;201:		other->client->ps.eFlags |= EF_KAMIKAZE;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 202
;202:	}
LABELV $123
line 204
;203:
;204:	return RESPAWN_HOLDABLE;
ADDRGP4 g_holdablerespawn+8
INDIRF4
CVFI4 4
RETI4
LABELV $122
endproc Pickup_Holdable 4 0
export Add_Ammo
proc Add_Ammo 4 0
line 211
;205:}
;206:
;207:
;208://======================================================================
;209:
;210:void Add_Ammo (gentity_t *ent, int weapon, int count)
;211:{
line 212
;212:	ent->client->ps.ammo[weapon] += count;
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 213
;213:	if ( ent->client->ps.ammo[weapon] > mod_ammolimit ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRGP4 mod_ammolimit
INDIRI4
LEI4 $127
line 214
;214:		ent->client->ps.ammo[weapon] = mod_ammolimit;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRGP4 mod_ammolimit
INDIRI4
ASGNI4
line 215
;215:	}
LABELV $127
line 216
;216:}
LABELV $126
endproc Add_Ammo 4 0
export Pickup_Ammo
proc Pickup_Ammo 4 12
line 219
;217:
;218:int Pickup_Ammo (gentity_t *ent, gentity_t *other)
;219:{
line 222
;220:	int		quantity;
;221:
;222:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $130
line 223
;223:		quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 224
;224:	}
ADDRGP4 $131
JUMPV
LABELV $130
line 225
;225:	else {
line 226
;226:		quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 227
;227:	}
LABELV $131
line 229
;228:
;229:	Add_Ammo (other, ent->item->giTag, quantity);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 231
;230:
;231:	return RESPAWN_AMMO;
ADDRGP4 g_ammorespawn+8
INDIRF4
CVFI4 4
RETI4
LABELV $129
endproc Pickup_Ammo 4 12
export Pickup_Weapon
proc Pickup_Weapon 8 12
line 238
;232:}
;233:
;234://======================================================================
;235:
;236:
;237:int Pickup_Weapon (gentity_t *ent, gentity_t *other)
;238:{
line 241
;239:	int		quantity;
;240:
;241:	if ( ent->count < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $134
line 242
;242:		quantity = 0; // None for you, sir!
ADDRLP4 0
CNSTI4 0
ASGNI4
line 243
;243:	}
ADDRGP4 $135
JUMPV
LABELV $134
line 244
;244:	else {
line 245
;245:		if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $136
line 246
;246:			quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 247
;247:		}
ADDRGP4 $137
JUMPV
LABELV $136
line 248
;248:		else {
line 249
;249:			quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 250
;250:		}
LABELV $137
line 253
;251:
;252:		// dropped items and teamplay weapons always have full ammo
;253:		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $138
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $138
line 256
;254:			// respawning rules
;255:			// drop the quantity if the already have over the minimum
;256:			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $141
line 257
;257:				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 258
;258:			}
ADDRGP4 $142
JUMPV
LABELV $141
line 259
;259:			else {
line 260
;260:				quantity = 1;		// only add a single shot
ADDRLP4 0
CNSTI4 1
ASGNI4
line 261
;261:			}
LABELV $142
line 262
;262:		}
LABELV $138
line 263
;263:	}
LABELV $135
line 266
;264:
;265:	// add the weapon
;266:	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 268
;267:
;268:	Add_Ammo( other, ent->item->giTag, quantity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 270
;269:
;270:	if (ent->item->giTag == WP_GRAPPLING_HOOK)
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $143
line 271
;271:		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
LABELV $143
line 274
;272:
;273:	// team deathmatch has slow weapon respawns
;274:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $145
line 275
;275:		return g_weaponTeamRespawn.integer;
ADDRGP4 g_weaponTeamRespawn+12
INDIRI4
RETI4
ADDRGP4 $133
JUMPV
LABELV $145
line 278
;276:	}
;277:
;278:	return g_weaponRespawn.integer;
ADDRGP4 g_weaponRespawn+12
INDIRI4
RETI4
LABELV $133
endproc Pickup_Weapon 8 12
export Pickup_Health
proc Pickup_Health 24 0
line 285
;279:}
;280:
;281:
;282://======================================================================
;283:
;284:int Pickup_Health (gentity_t *ent, gentity_t *other)
;285:{
line 289
;286:	int			max;
;287:	int			quantity;
;288:
;289:	if( !other->client)
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $151
line 290
;290:		return RESPAWN_HEALTH;
ADDRGP4 g_healthrespawn+8
INDIRF4
CVFI4 4
RETI4
ADDRGP4 $150
JUMPV
LABELV $151
line 293
;291:
;292:	// small and mega healths will go over the max
;293:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $154
CNSTI4 52
ADDRLP4 8
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $154
line 294
;294:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 295
;295:	}
ADDRGP4 $155
JUMPV
LABELV $154
line 296
;296:	else if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 5
EQI4 $157
ADDRLP4 12
INDIRI4
CNSTI4 100
EQI4 $157
line 297
;297:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 298
;298:	}
ADDRGP4 $158
JUMPV
LABELV $157
line 299
;299:	else {
line 300
;300:		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 301
;301:	}
LABELV $158
LABELV $155
line 303
;302:
;303:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $159
line 304
;304:		quantity = ent->count;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 305
;305:	}
ADDRGP4 $160
JUMPV
LABELV $159
line 306
;306:	else {
line 307
;307:		quantity = ent->item->quantity;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 308
;308:	}
LABELV $160
line 310
;309:
;310:	other->health += quantity;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 312
;311:
;312:	if (other->health > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $161
line 313
;313:		other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 314
;314:	}
LABELV $161
line 315
;315:	other->client->ps.stats[STAT_HEALTH] = other->health;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 317
;316:
;317:	if ( ent->item->quantity == 100 ) {		// mega health respawns slow
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $163
line 318
;318:		return RESPAWN_MEGAHEALTH;
ADDRGP4 g_megahealthrespawn+8
INDIRF4
CVFI4 4
RETI4
ADDRGP4 $150
JUMPV
LABELV $163
line 321
;319:	}
;320:
;321:	return RESPAWN_HEALTH;
ADDRGP4 g_healthrespawn+8
INDIRF4
CVFI4 4
RETI4
LABELV $150
endproc Pickup_Health 24 0
export Pickup_Armor
proc Pickup_Armor 12 0
line 327
;322:}
;323:
;324://======================================================================
;325:
;326:int Pickup_Armor( gentity_t *ent, gentity_t *other )
;327:{
line 330
;328:	int		upperBound;
;329:
;330:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 332
;331:
;332:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $168
CNSTI4 52
ADDRLP4 8
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 11
NEI4 $168
line 333
;333:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 334
;334:	}
ADDRGP4 $169
JUMPV
LABELV $168
line 335
;335:	else {
line 336
;336:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 337
;337:	}
LABELV $169
line 339
;338:
;339:	if ( other->client->ps.stats[STAT_ARMOR] > upperBound ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $171
line 340
;340:		other->client->ps.stats[STAT_ARMOR] = upperBound;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 341
;341:	}
LABELV $171
line 343
;342:
;343:	return RESPAWN_ARMOR;
ADDRGP4 g_armorrespawn+8
INDIRF4
CVFI4 4
RETI4
LABELV $167
endproc Pickup_Armor 12 0
export RespawnItem
proc RespawnItem 28 12
line 354
;344:}
;345:
;346://======================================================================
;347:
;348:/*
;349:===============
;350:RespawnItem
;351:===============
;352:*/
;353:void RespawnItem( gentity_t *ent )
;354:{
line 356
;355:	//Don't spawn quad if quadfactor are 1.0 or less
;356:	if(ent->item->giType == IT_POWERUP && ent->item->giTag == PW_QUAD && g_quadfactor.value <= 1.0)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $175
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
NEI4 $175
ADDRGP4 g_quadfactor+8
INDIRF4
CNSTF4 1065353216
GTF4 $175
line 357
;357:		return;
ADDRGP4 $174
JUMPV
LABELV $175
line 360
;358:
;359:	// randomly select from teamed entities
;360:	if (ent->team) {
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
line 365
;361:		gentity_t	*master;
;362:		int	count;
;363:		int choice;
;364:
;365:		if ( !ent->teammaster ) {
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $180
line 366
;366:			G_Error( "RespawnItem: bad teammaster");
ADDRGP4 $182
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 367
;367:		}
LABELV $180
line 368
;368:		master = ent->teammaster;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
line 370
;369:
;370:		for (count = 0, ent = master; ent; ent = ent->teamchain, count++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $186
JUMPV
LABELV $183
line 371
;371:			;
LABELV $184
line 370
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $186
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $183
line 373
;372:
;373:		choice = (count > 0)? rand()%count : 0;
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $188
ADDRLP4 20
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
ADDRGP4 $189
JUMPV
LABELV $188
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $189
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 375
;374:
;375:		for (count = 0, ent = master; count < choice; ent = ent->teamchain, count++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $193
JUMPV
LABELV $190
line 376
;376:			;
LABELV $191
line 375
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $193
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $190
line 377
;377:	}
LABELV $178
line 379
;378:
;379:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 380
;380:	ent->s.eFlags &= ~EF_NODRAW;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 381
;381:	ent->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 382
;382:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 384
;383:
;384:	if ( ent->item->giType == IT_POWERUP ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $194
line 389
;385:		// play powerup spawn sound to all clients
;386:		gentity_t	*te;
;387:
;388:		// if the powerup respawn sound should Not be global
;389:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $196
line 390
;390:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 391
;391:		}
ADDRGP4 $197
JUMPV
LABELV $196
line 392
;392:		else {
line 393
;393:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 394
;394:		}
LABELV $197
line 395
;395:		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $198
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 396
;396:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 397
;397:	}
LABELV $194
line 399
;398:
;399:	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $199
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $199
line 404
;400:		// play powerup spawn sound to all clients
;401:		gentity_t	*te;
;402:
;403:		// if the powerup respawn sound should Not be global
;404:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $201
line 405
;405:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 406
;406:		}
ADDRGP4 $202
JUMPV
LABELV $201
line 407
;407:		else {
line 408
;408:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 409
;409:		}
LABELV $202
line 410
;410:		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
ADDRGP4 $203
ARGP4
ADDRLP4 20
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 411
;411:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 412
;412:	}
LABELV $199
line 415
;413:
;414:	// play the normal respawn sound only to nearby clients
;415:	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 40
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 417
;416:
;417:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 418
;418:}
LABELV $174
endproc RespawnItem 28 12
export Touch_Item
proc Touch_Item 60 12
line 427
;419:
;420:
;421:/*
;422:===============
;423:Touch_Item
;424:===============
;425:*/
;426:void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace)
;427:{
line 432
;428:	int			respawn;
;429:	qboolean	predict;
;430:
;431:	//instant gib
;432:	if (g_elimination_items.integer == 0){
ADDRGP4 g_elimination_items+12
INDIRI4
CNSTI4 0
NEI4 $205
line 433
;433:	if ((g_instantgib.integer || g_rockets.integer || g_gametype.integer == GT_CTF_ELIMINATION || g_elimination_allgametypes.integer)
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $216
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $216
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
EQI4 $216
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $208
LABELV $216
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $208
line 435
;434:	        && ent->item->giType != IT_TEAM)
;435:		return;
ADDRGP4 $204
JUMPV
LABELV $208
line 436
;436:	}
LABELV $205
line 439
;437:
;438:	//Cannot touch flag before round starts
;439:	if(g_gametype.integer == GT_CTF_ELIMINATION && level.roundNumber != level.roundNumberStarted)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $217
ADDRGP4 level+9236
INDIRI4
ADDRGP4 level+9240
INDIRI4
EQI4 $217
line 440
;440:		return;
ADDRGP4 $204
JUMPV
LABELV $217
line 443
;441:
;442:	//Cannot take ctf elimination oneway
;443:	if(g_gametype.integer == GT_CTF_ELIMINATION && g_elimination_ctf_oneway.integer!=0 && (
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $222
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 g_elimination_ctf_oneway+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $222
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $231
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
ADDRLP4 12
INDIRI4
MODI4
ADDRLP4 8
INDIRI4
EQI4 $230
LABELV $231
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 1
NEI4 $222
ADDRGP4 level+9256
INDIRI4
ADDRGP4 level+9236
INDIRI4
ADDI4
CNSTI4 2
MODI4
CNSTI4 0
EQI4 $222
LABELV $230
line 446
;444:	            (other->client->sess.sessionTeam==TEAM_BLUE && (level.eliminationSides+level.roundNumber)%2 == 0 ) ||
;445:	            (other->client->sess.sessionTeam==TEAM_RED && (level.eliminationSides+level.roundNumber)%2 != 0 ) ))
;446:		return;
ADDRGP4 $204
JUMPV
LABELV $222
line 447
;447:	if (g_elimination_items.integer == 0)
ADDRGP4 g_elimination_items+12
INDIRI4
CNSTI4 0
NEI4 $232
line 448
;448:	if (g_gametype.integer == GT_ELIMINATION || g_gametype.integer == GT_LMS)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $239
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
NEI4 $235
LABELV $239
line 449
;449:		return;		//nothing to pick up in elimination
ADDRGP4 $204
JUMPV
LABELV $235
LABELV $232
line 451
;450:
;451:	if (!other->client)
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $240
line 452
;452:		return;
ADDRGP4 $204
JUMPV
LABELV $240
line 453
;453:	if (other->health < 1)
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $242
line 454
;454:		return;		// dead people can't pickup
ADDRGP4 $204
JUMPV
LABELV $242
line 457
;455:
;456:	// the same pickup rules are used for client side and server side
;457:	if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps ) ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $244
line 458
;458:		return;
ADDRGP4 $204
JUMPV
LABELV $244
line 462
;459:	}
;460:
;461:	//In double DD we cannot "pick up" a flag we already got
;462:	if(g_gametype.integer == GT_DOUBLE_D) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $247
line 463
;463:		if( strequals(ent->classname, "team_CTF_redflag") ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $250
line 464
;464:			if(other->client->sess.sessionTeam == level.pointStatusA) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9264
INDIRI4
NEI4 $253
line 465
;465:				return;
ADDRGP4 $204
JUMPV
LABELV $253
line 467
;466:			}
;467:		}
LABELV $250
line 468
;468:		if( strequals(ent->classname, "team_CTF_blueflag") ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $256
line 469
;469:			if(other->client->sess.sessionTeam == level.pointStatusB) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDRGP4 level+9268
INDIRI4
NEI4 $259
line 470
;470:				return;
ADDRGP4 $204
JUMPV
LABELV $259
line 472
;471:			}
;472:		}
LABELV $256
line 473
;473:	}
LABELV $247
line 475
;474:
;475:	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );
ADDRGP4 $262
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 477
;476:
;477:	predict = other->client->pers.predictItemPickup;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 480
;478:
;479:	// call the item-specific pickup function
;480:	switch( ent->item->giType ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LTI4 $204
ADDRLP4 20
INDIRI4
CNSTI4 8
GTI4 $204
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $276-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $276
address $266
address $267
address $268
address $269
address $270
address $275
address $271
address $272
code
LABELV $266
line 482
;481:	case IT_WEAPON:
;482:		respawn = Pickup_Weapon(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Pickup_Weapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
ASGNI4
line 484
;483://		predict = qfalse;
;484:		break;
ADDRGP4 $264
JUMPV
LABELV $267
line 486
;485:	case IT_AMMO:
;486:		respawn = Pickup_Ammo(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Pickup_Ammo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
ASGNI4
line 488
;487://		predict = qfalse;
;488:		break;
ADDRGP4 $264
JUMPV
LABELV $268
line 490
;489:	case IT_ARMOR:
;490:		respawn = Pickup_Armor(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Pickup_Armor
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 36
INDIRI4
ASGNI4
line 491
;491:		break;
ADDRGP4 $264
JUMPV
LABELV $269
line 493
;492:	case IT_HEALTH:
;493:		respawn = Pickup_Health(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Pickup_Health
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 40
INDIRI4
ASGNI4
line 494
;494:		break;
ADDRGP4 $264
JUMPV
LABELV $270
line 496
;495:	case IT_POWERUP:
;496:		respawn = Pickup_Powerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Pickup_Powerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 44
INDIRI4
ASGNI4
line 497
;497:		predict = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 498
;498:		break;
ADDRGP4 $264
JUMPV
LABELV $271
line 500
;499:	case IT_PERSISTANT_POWERUP:
;500:		respawn = Pickup_PersistantPowerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Pickup_PersistantPowerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 48
INDIRI4
ASGNI4
line 501
;501:		break;
ADDRGP4 $264
JUMPV
LABELV $272
line 503
;502:	case IT_TEAM:
;503:		respawn = Pickup_Team(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Pickup_Team
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 52
INDIRI4
ASGNI4
line 505
;504:		//If touching a team item remove spawnprotection
;505:		if (other->client->spawnprotected) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $264
line 506
;506:			other->client->spawnprotected = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 2000
ADDP4
CNSTI4 0
ASGNI4
line 507
;507:		}
line 508
;508:		break;
ADDRGP4 $264
JUMPV
LABELV $275
line 510
;509:	case IT_HOLDABLE:
;510:		respawn = Pickup_Holdable(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Pickup_Holdable
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 56
INDIRI4
ASGNI4
line 511
;511:		break;
line 513
;512:	default:
;513:		return;
LABELV $264
line 516
;514:	}
;515:
;516:	if ( !respawn ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $278
line 517
;517:		return;
ADDRGP4 $204
JUMPV
LABELV $278
line 521
;518:	}
;519:
;520:	// play the normal pickup sound
;521:	if (predict) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $280
line 522
;522:		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddPredictableEvent
CALLV
pop
line 523
;523:	}
ADDRGP4 $281
JUMPV
LABELV $280
line 524
;524:	else {
line 525
;525:		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 526
;526:	}
LABELV $281
line 529
;527:
;528:	// powerup pickups are global broadcasts
;529:	if ( ent->item->giType == IT_POWERUP || ent->item->giType == IT_TEAM) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 5
EQI4 $284
ADDRLP4 28
INDIRI4
CNSTI4 8
NEI4 $282
LABELV $284
line 531
;530:		// if we want the global sound to play
;531:		if (!ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $285
line 534
;532:			gentity_t	*te;
;533:
;534:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 36
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 36
INDIRP4
ASGNP4
line 535
;535:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 536
;536:			te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 40
ADDRLP4 32
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 537
;537:		}
ADDRGP4 $286
JUMPV
LABELV $285
line 538
;538:		else {
line 541
;539:			gentity_t	*te;
;540:
;541:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 36
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 36
INDIRP4
ASGNP4
line 542
;542:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 544
;543:			// only send this temp entity to a single client
;544:			te->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 40
ADDRLP4 32
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 545
;545:			te->r.singleClient = other->s.number;
ADDRLP4 32
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 546
;546:		}
LABELV $286
line 547
;547:	}
LABELV $282
line 550
;548:
;549:	// fire item targets
;550:	G_UseTargets (ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 553
;551:
;552:	// wait of -1 will not respawn
;553:	if ( ent->wait == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 3212836864
NEF4 $287
line 554
;554:		ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 555
;555:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 556
;556:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 557
;557:		ent->unlinkAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 558
;558:		return;
ADDRGP4 $204
JUMPV
LABELV $287
line 562
;559:	}
;560:
;561:	// non zero wait overrides respawn time
;562:	if ( ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CNSTF4 0
EQF4 $289
line 563
;563:		respawn = ent->wait;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 564
;564:	}
LABELV $289
line 567
;565:
;566:	// random can be used to vary the respawn time
;567:	if ( ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
CNSTF4 0
EQF4 $291
line 568
;568:		respawn += crandom() * ent->random;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 569
;569:		if ( respawn < 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
GEI4 $293
line 570
;570:			respawn = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 571
;571:		}
LABELV $293
line 572
;572:	}
LABELV $291
line 575
;573:
;574:	// dropped items will not respawn
;575:	if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $295
line 576
;576:		ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 577
;577:	}
LABELV $295
line 582
;578:
;579:	// picked up items still stay around, they just don't
;580:	// draw anything.  This allows respawnable items
;581:	// to be placed on movers.
;582:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 583
;583:	ent->s.eFlags |= EF_NODRAW;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 584
;584:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 590
;585:
;586:	// ZOID
;587:	// A negative respawn times means to never respawn this item (but don't
;588:	// delete it).  This is used by items that are respawned by third party
;589:	// events such as ctf flags
;590:	if ( respawn <= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $297
line 591
;591:		ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 592
;592:		ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTP4 0
ASGNP4
line 593
;593:	}
ADDRGP4 $298
JUMPV
LABELV $297
line 594
;594:	else {
line 595
;595:		ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRLP4 0
INDIRI4
MULI4
ADDI4
ASGNI4
line 596
;596:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 597
;597:	}
LABELV $298
line 598
;598:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 599
;599:}
LABELV $204
endproc Touch_Item 60 12
export LaunchItem
proc LaunchItem 20 8
line 612
;600:
;601:
;602://======================================================================
;603:
;604:/*
;605:================
;606:LaunchItem
;607:
;608:Spawns an item and tosses it forward
;609:================
;610:*/
;611:gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity )
;612:{
line 615
;613:	gentity_t	*dropped;
;614:
;615:	dropped = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 617
;616:
;617:	dropped->s.eType = ET_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 618
;618:	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 619
;619:	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 1
ASGNI4
line 621
;620:
;621:	dropped->classname = item->classname;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 622
;622:	dropped->item = item;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 623
;623:	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 624
;624:	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 625
;625:	dropped->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 627
;626:
;627:	dropped->touch = Touch_Item;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 629
;628:
;629:	G_SetOrigin( dropped, origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 630
;630:	dropped->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 631
;631:	dropped->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 632
;632:	VectorCopy( velocity, dropped->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 633
;633:	dropped->s.eFlags |= EF_BOUNCE_HALF;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 634
;634:	if ((G_UsesTeamFlags(g_gametype.integer) || G_UsesTheWhiteFlag(g_gametype.integer) || g_gametype.integer == GT_DOUBLE_D)
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $308
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $308
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $302
LABELV $308
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $302
line 635
;635:	        && item->giType == IT_TEAM) { // Special case for CTF flags
line 636
;636:		dropped->think = Team_DroppedFlagThink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Team_DroppedFlagThink
ASGNP4
line 637
;637:		dropped->nextthink = level.time + g_autoflagreturn.integer*1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_autoflagreturn+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 638
;638:		Team_CheckDroppedItem( dropped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Team_CheckDroppedItem
CALLV
pop
line 639
;639:	}
ADDRGP4 $303
JUMPV
LABELV $302
line 640
;640:	else {   // auto-remove after 30 seconds
line 641
;641:		dropped->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 642
;642:		dropped->nextthink = level.time + g_droppeditemtime.integer*1000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDRGP4 g_droppeditemtime+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 643
;643:	}
LABELV $303
line 645
;644:
;645:	dropped->flags = FL_DROPPED_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 4096
ASGNI4
line 647
;646:
;647:	trap_LinkEntity (dropped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 649
;648:
;649:	return dropped;
ADDRLP4 0
INDIRP4
RETP4
LABELV $300
endproc LaunchItem 20 8
export Drop_Item
proc Drop_Item 40 16
line 660
;650:}
;651:
;652:/*
;653:================
;654:Drop_Item
;655:
;656:Spawns an item and tosses it forward
;657:================
;658:*/
;659:gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle )
;660:{
line 664
;661:	vec3_t	velocity;
;662:	vec3_t	angles;
;663:
;664:	VectorCopy( ent->s.apos.trBase, angles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 665
;665:	angles[YAW] += angle;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 666
;666:	angles[PITCH] = 0;	// always forward
ADDRLP4 12
CNSTF4 0
ASGNF4
line 668
;667:
;668:	AngleVectors( angles, velocity, NULL, NULL );
ADDRLP4 12
ARGP4
ADDRLP4 0
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
ADDRGP4 AngleVectors
CALLV
pop
line 669
;669:	VectorScale( velocity, 150, velocity );
ADDRLP4 28
CNSTF4 1125515264
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1125515264
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 670
;670:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 32
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
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 672
;671:
;672:	return LaunchItem( item, ent->s.pos.trBase, velocity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
RETP4
LABELV $313
endproc Drop_Item 40 16
export Use_Item
proc Use_Item 0 4
line 684
;673:}
;674:
;675:
;676:/*
;677:================
;678:Use_Item
;679:
;680:Respawn the item
;681:================
;682:*/
;683:void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator )
;684:{
line 685
;685:	RespawnItem( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 686
;686:}
LABELV $320
endproc Use_Item 0 4
export FinishSpawningItem
proc FinishSpawningItem 96 28
line 699
;687:
;688://======================================================================
;689:
;690:/*
;691:================
;692:FinishSpawningItem
;693:
;694:Traces down to find where an item should rest, instead of letting them
;695:free fall from their spawn points
;696:================
;697:*/
;698:void FinishSpawningItem( gentity_t *ent )
;699:{
line 703
;700:	trace_t		tr;
;701:	vec3_t		dest;
;702:
;703:	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 704
;704:	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 706
;705:
;706:	ent->s.eType = ET_ITEM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 707
;707:	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 708
;708:	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 710
;709:
;710:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 711
;711:	ent->touch = Touch_Item;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 713
;712:	// using an item causes it to respawn
;713:	ent->use = Use_Item;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Item
ASGNP4
line 715
;714:
;715:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $322
line 717
;716:		// suspended
;717:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 718
;718:	}
ADDRGP4 $323
JUMPV
LABELV $322
line 719
;719:	else {
line 721
;720:		// drop to floor
;721:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 72
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 722
;722:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 723
;723:		if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $326
line 724
;724:			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $329
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 725
;725:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 726
;726:			return;
ADDRGP4 $321
JUMPV
LABELV $326
line 730
;727:		}
;728:
;729:		// allow to ride movers
;730:		ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 732
;731:
;732:		G_SetOrigin( ent, tr.endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 733
;733:	}
LABELV $323
line 736
;734:
;735:	// team slaves and targeted items aren't present at start
;736:	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $334
ADDRLP4 72
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $332
LABELV $334
line 737
;737:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 738
;738:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 739
;739:		return;
ADDRGP4 $321
JUMPV
LABELV $332
line 744
;740:	}
;741:
;742:
;743:	// powerups don't spawn in for a while (but not in elimination)
;744:	if(!G_IsARoundBasedGametype(g_gametype.integer) && !g_instantgib.integer && !g_elimination_allgametypes.integer && !g_rockets.integer )
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $335
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $335
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $335
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $335
line 745
;745:		if ( ent->item->giType == IT_POWERUP ) {
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $341
line 748
;746:			float	respawn;
;747:
;748:			respawn = 45 + crandom() * 15;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
CNSTF4 1097859072
CNSTF4 1073741824
ADDRLP4 88
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
CNSTF4 1110704128
ADDF4
ASGNF4
line 749
;749:			ent->s.eFlags |= EF_NODRAW;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 750
;750:			ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 751
;751:			ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 84
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 752
;752:			ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 753
;753:			return;
ADDRGP4 $321
JUMPV
LABELV $341
LABELV $335
line 757
;754:		}
;755:
;756:
;757:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 758
;758:}
LABELV $321
endproc FinishSpawningItem 96 28
export G_CheckTeamItems
proc G_CheckTeamItems 36 12
line 769
;759:
;760:
;761:qboolean	itemRegistered[MAX_ITEMS];
;762:
;763:/*
;764:==================
;765:G_CheckTeamItems
;766:==================
;767:*/
;768:void G_CheckTeamItems( void )
;769:{
line 772
;770:
;771:	// Set up team stuff
;772:	Team_InitGame();
ADDRGP4 Team_InitGame
CALLV
pop
line 774
;773:
;774:	if( (G_UsesTeamFlags(g_gametype.integer) && !G_UsesTheWhiteFlag(g_gametype.integer)) || g_gametype.integer == GT_DOUBLE_D) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 G_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $351
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $350
LABELV $351
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $345
LABELV $350
line 778
;775:		gitem_t	*item;
;776:
;777:		// check for the two flags
;778:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $352
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 779
;779:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $355
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $353
LABELV $355
line 780
;780:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map\n" );
ADDRGP4 $356
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 781
;781:		}
LABELV $353
line 782
;782:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $357
ARGP4
ADDRLP4 20
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 783
;783:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 24
ADDRLP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
CNSTU4 0
EQU4 $360
ADDRLP4 24
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $358
LABELV $360
line 784
;784:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map\n" );
ADDRGP4 $361
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 785
;785:		}
LABELV $358
line 786
;786:	}
LABELV $345
line 787
;787:	if( g_gametype.integer == GT_1FCTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $362
line 791
;788:		gitem_t	*item;
;789:
;790:		// check for all three flags
;791:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $352
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 792
;792:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $367
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
LABELV $367
line 793
;793:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map\n" );
ADDRGP4 $356
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 794
;794:		}
LABELV $365
line 795
;795:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $357
ARGP4
ADDRLP4 20
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 796
;796:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 24
ADDRLP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
CNSTU4 0
EQU4 $370
ADDRLP4 24
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $368
LABELV $370
line 797
;797:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map\n" );
ADDRGP4 $361
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 798
;798:		}
LABELV $368
line 799
;799:		item = BG_FindItem( "Neutral Flag" );
ADDRGP4 $371
ARGP4
ADDRLP4 28
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 800
;800:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 32
ADDRLP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 32
INDIRU4
CNSTU4 0
EQU4 $374
ADDRLP4 32
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $372
LABELV $374
line 801
;801:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_neutralflag in map\n" );
ADDRGP4 $375
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 802
;802:		}
LABELV $372
line 803
;803:	}
LABELV $362
line 805
;804:
;805:	if( g_gametype.integer == GT_OBELISK ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $376
line 809
;806:		gentity_t	*ent;
;807:
;808:		// check for the two obelisks
;809:		ent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 810
;810:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 811
;811:		if( !ent ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $380
line 812
;812:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map\n" );
ADDRGP4 $382
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 813
;813:		}
LABELV $380
line 815
;814:
;815:		ent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 816
;816:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $383
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 817
;817:		if( !ent ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $384
line 818
;818:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map\n" );
ADDRGP4 $386
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 819
;819:		}
LABELV $384
line 820
;820:	}
LABELV $376
line 822
;821:
;822:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $387
line 826
;823:		gentity_t	*ent;
;824:
;825:		// check for all three obelisks
;826:		ent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 827
;827:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 828
;828:		if( !ent ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $390
line 829
;829:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map\n" );
ADDRGP4 $382
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 830
;830:		}
LABELV $390
line 832
;831:
;832:		ent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 833
;833:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $383
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 834
;834:		if( !ent ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $392
line 835
;835:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map\n" );
ADDRGP4 $386
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 836
;836:		}
LABELV $392
line 838
;837:
;838:		ent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 839
;839:		ent = G_Find( ent, FOFS(classname), "team_neutralobelisk" );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $394
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 840
;840:		if( !ent ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $395
line 841
;841:			G_Printf( S_COLOR_YELLOW "WARNING: No team_neutralobelisk in map\n" );
ADDRGP4 $397
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 842
;842:		}
LABELV $395
line 843
;843:	}
LABELV $387
line 844
;844:}
LABELV $344
endproc G_CheckTeamItems 36 12
export ClearRegisteredItems
proc ClearRegisteredItems 56 12
line 852
;845:
;846:/*
;847:==============
;848:ClearRegisteredItems
;849:==============
;850:*/
;851:void ClearRegisteredItems( void )
;852:{
line 853
;853:	memset( itemRegistered, 0, sizeof( itemRegistered ) );
ADDRGP4 itemRegistered
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 855
;854:
;855:	if(g_instantgib.integer) {
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 0
EQI4 $399
line 856
;856:		if(g_instantgib.integer & 2) {
ADDRGP4 g_instantgib+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $402
line 857
;857:			RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 858
;858:		}
LABELV $402
line 859
;859:		RegisterItem( BG_FindItemForWeapon( WP_RAILGUN ) );
CNSTI4 7
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 860
;860:	}
ADDRGP4 $400
JUMPV
LABELV $399
line 861
;861:	else if(g_rockets.integer) {
ADDRGP4 g_rockets+12
INDIRI4
CNSTI4 0
EQI4 $405
line 862
;862:		RegisterItem( BG_FindItemForWeapon( WP_ROCKET_LAUNCHER ) );
CNSTI4 5
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 863
;863:	}
ADDRGP4 $406
JUMPV
LABELV $405
line 864
;864:	else {
line 866
;865:		// players always start with the base weapon
;866:		RegisterItem( BG_FindItemForWeapon( WP_MACHINEGUN ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 867
;867:		RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 868
;868:		if(G_IsARoundBasedGametype(g_gametype.integer) || g_elimination_allgametypes.integer) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 G_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $412
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $408
LABELV $412
line 869
;869:			RegisterItem( BG_FindItemForWeapon( WP_SHOTGUN ) );
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 870
;870:			RegisterItem( BG_FindItemForWeapon( WP_GRENADE_LAUNCHER ) );
CNSTI4 4
ARGI4
ADDRLP4 20
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 871
;871:			RegisterItem( BG_FindItemForWeapon( WP_ROCKET_LAUNCHER ) );
CNSTI4 5
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 872
;872:			RegisterItem( BG_FindItemForWeapon( WP_LIGHTNING ) );
CNSTI4 6
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 873
;873:			RegisterItem( BG_FindItemForWeapon( WP_RAILGUN ) );
CNSTI4 7
ARGI4
ADDRLP4 32
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 874
;874:			RegisterItem( BG_FindItemForWeapon( WP_PLASMAGUN ) );
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 875
;875:			RegisterItem( BG_FindItemForWeapon( WP_BFG ) );
CNSTI4 9
ARGI4
ADDRLP4 40
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 876
;876:			RegisterItem( BG_FindItemForWeapon( WP_NAILGUN ) );
CNSTI4 11
ARGI4
ADDRLP4 44
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 877
;877:			RegisterItem( BG_FindItemForWeapon( WP_PROX_LAUNCHER ) );
CNSTI4 12
ARGI4
ADDRLP4 48
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 878
;878:			RegisterItem( BG_FindItemForWeapon( WP_CHAINGUN ) );
CNSTI4 13
ARGI4
ADDRLP4 52
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 879
;879:		}
LABELV $408
line 880
;880:	}
LABELV $406
LABELV $400
line 881
;881:	if (g_grapple.integer) {
ADDRGP4 g_grapple+12
INDIRI4
CNSTI4 0
EQI4 $413
line 882
;882:		RegisterItem( BG_FindItemForWeapon( WP_GRAPPLING_HOOK ) );
CNSTI4 10
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 883
;883:	}
LABELV $413
line 884
;884:	if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
NEI4 $416
line 885
;885:		RegisterItem( BG_FindItem( "Red Cube" ) );
ADDRGP4 $419
ARGP4
ADDRLP4 0
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 886
;886:		RegisterItem( BG_FindItem( "Blue Cube" ) );
ADDRGP4 $420
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 887
;887:	}
LABELV $416
line 889
;888:
;889:	if(g_gametype.integer == GT_DOUBLE_D ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $421
line 890
;890:		RegisterItem( BG_FindItem( "Point A (Blue)" ) );
ADDRGP4 $424
ARGP4
ADDRLP4 0
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 891
;891:		RegisterItem( BG_FindItem( "Point A (Red)" ) );
ADDRGP4 $425
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 892
;892:		RegisterItem( BG_FindItem( "Point A (White)" ) );
ADDRGP4 $426
ARGP4
ADDRLP4 8
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 893
;893:		RegisterItem( BG_FindItem( "Point B (Blue)" ) );
ADDRGP4 $427
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 894
;894:		RegisterItem( BG_FindItem( "Point B (Red)" ) );
ADDRGP4 $428
ARGP4
ADDRLP4 16
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 895
;895:		RegisterItem( BG_FindItem( "Point B (White)" ) );
ADDRGP4 $429
ARGP4
ADDRLP4 20
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 896
;896:	}
LABELV $421
line 898
;897:
;898:	if(g_gametype.integer == GT_DOMINATION ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 12
NEI4 $430
line 899
;899:		RegisterItem( BG_FindItem( "Neutral domination point" ) );
ADDRGP4 $433
ARGP4
ADDRLP4 0
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 900
;900:		RegisterItem( BG_FindItem( "Red domination point" ) );
ADDRGP4 $434
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 901
;901:		RegisterItem( BG_FindItem( "Blue domination point" ) );
ADDRGP4 $435
ARGP4
ADDRLP4 8
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 902
;902:	}
LABELV $430
line 904
;903:
;904:	if (g_gametype.integer == GT_POSSESSION) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
NEI4 $436
line 905
;905:		RegisterItem(BG_FindItem("Neutral Flag") );
ADDRGP4 $371
ARGP4
ADDRLP4 0
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 906
;906:	}
LABELV $436
line 908
;907:
;908:}
LABELV $398
endproc ClearRegisteredItems 56 12
export RegisterItem
proc RegisterItem 0 4
line 918
;909:
;910:/*
;911:===============
;912:RegisterItem
;913:
;914:The item will be added to the precache list
;915:===============
;916:*/
;917:void RegisterItem( gitem_t *item )
;918:{
line 919
;919:	if ( !item ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $440
line 920
;920:		G_Error( "RegisterItem: NULL" );
ADDRGP4 $442
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 921
;921:	}
LABELV $440
line 922
;922:	itemRegistered[ item - bg_itemlist ] = qtrue;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
CNSTI4 1
ASGNI4
line 923
;923:}
LABELV $439
endproc RegisterItem 0 4
export SaveRegisteredItems
proc SaveRegisteredItems 268 8
line 935
;924:
;925:
;926:/*
;927:===============
;928:SaveRegisteredItems
;929:
;930:Write the needed items to a config string
;931:so the client will know which ones to precache
;932:===============
;933:*/
;934:void SaveRegisteredItems( void )
;935:{
line 940
;936:	char	string[MAX_ITEMS+1];
;937:	int		i;
;938:	int		count;
;939:
;940:	count = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 941
;941:	for ( i = 0 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $447
JUMPV
LABELV $444
line 942
;942:		if ( itemRegistered[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
line 943
;943:			count++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 944
;944:			string[i] = '1';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 49
ASGNI1
line 945
;945:		}
ADDRGP4 $449
JUMPV
LABELV $448
line 946
;946:		else {
line 947
;947:			string[i] = '0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 48
ASGNI1
line 948
;948:		}
LABELV $449
line 949
;949:	}
LABELV $445
line 941
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $447
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $444
line 950
;950:	string[ bg_numItems ] = 0;
ADDRGP4 bg_numItems
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 951
;951:	G_Printf( "%i items registered\n", count );
ADDRGP4 $450
ARGP4
ADDRLP4 264
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 952
;952:	trap_SetConfigstring(CS_ITEMS, string);
CNSTI4 27
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 953
;953:}
LABELV $443
endproc SaveRegisteredItems 268 8
export G_ItemDisabled
proc G_ItemDisabled 132 16
line 961
;954:
;955:/*
;956:============
;957:G_ItemDisabled
;958:============
;959:*/
;960:int G_ItemDisabled( gitem_t *item )
;961:{
line 963
;962:	char name[128];
;963:	if (!g_runes.integer && item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 g_runes+12
INDIRI4
CNSTI4 0
NEI4 $452
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $452
line 964
;964:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $451
JUMPV
LABELV $452
line 967
;965:	}
;966:
;967:	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $455
ARGP4
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 968
;968:	return trap_Cvar_VariableIntegerValue( name );
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
RETI4
LABELV $451
endproc G_ItemDisabled 132 16
export G_SpawnItem
proc G_SpawnItem 40 12
line 982
;969:}
;970:
;971:/*
;972:============
;973:G_SpawnItem
;974:
;975:Sets the clipping size and plants the object on the floor.
;976:
;977:Items can't be immediately dropped to floor, because they might
;978:be on an entity that hasn't spawned yet.
;979:============
;980:*/
;981:void G_SpawnItem (gentity_t *ent, gitem_t *item)
;982:{
line 983
;983:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $457
ARGP4
ADDRGP4 $458
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 984
;984:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $459
ARGP4
ADDRGP4 $458
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 986
;985:
;986:	RegisterItem( item );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 987
;987:	if ( G_ItemDisabled(item) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_ItemDisabled
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $460
line 988
;988:		return;
ADDRGP4 $456
JUMPV
LABELV $460
line 990
;989:
;990:	ent->item = item;
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 993
;991:	// some movers spawn on the second frame, so delay item
;992:	// spawns until the third frame so they can ride trains
;993:	ent->nextthink = level.time + FRAMETIME * 2;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 994
;994:	ent->think = FinishSpawningItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 FinishSpawningItem
ASGNP4
line 996
;995:
;996:	ent->physicsBounce = 0.50;		// items are bouncy
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 1056964608
ASGNF4
line 997
;997:	if (g_elimination_items.integer == 0) {
ADDRGP4 g_elimination_items+12
INDIRI4
CNSTI4 0
NEI4 $463
line 998
;998:	if (g_gametype.integer == GT_ELIMINATION || g_gametype.integer == GT_LMS ||
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRGP4 g_gametype+12
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $478
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 10
EQI4 $478
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $466
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 g_instantgib+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $478
ADDRGP4 g_rockets+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $478
ADDRGP4 g_elimination_allgametypes+12
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $478
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 9
NEI4 $466
LABELV $478
line 999
;999:	        ( item->giType != IT_TEAM && (g_instantgib.integer || g_rockets.integer || g_elimination_allgametypes.integer || g_gametype.integer==GT_CTF_ELIMINATION) ) ) {
line 1000
;1000:		ent->s.eFlags |= EF_NODRAW; //Invisible in elimination
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1001
;1001:		ent->r.svFlags |= SVF_NOCLIENT;  //Don't broadcast
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1002
;1002:	}
LABELV $466
line 1003
;1003:	}
LABELV $463
line 1005
;1004:
;1005:	if(g_gametype.integer == GT_DOUBLE_D && (strequals(ent->classname, "team_CTF_redflag") || strequals(ent->classname, "team_CTF_blueflag")
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 11
NEI4 $479
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $485
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $485
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $485
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $479
LABELV $485
line 1006
;1006:	        || strequals(ent->classname, "team_CTF_neutralflag") || item->giType == IT_PERSISTANT_POWERUP  )) {
line 1007
;1007:		ent->s.eFlags |= EF_NODRAW; //Don't draw the flag models/persistant powerups
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1008
;1008:	}
LABELV $479
line 1010
;1009:
;1010:	if( !G_UsesTheWhiteFlag(g_gametype.integer) && strequals(ent->classname, "team_CTF_neutralflag")) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 G_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $486
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $486
line 1011
;1011:		ent->s.eFlags |= EF_NODRAW; // Don't draw the flag in CTF_elimination
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1012
;1012:	}
LABELV $486
line 1014
;1013:
;1014:	if( g_gametype.integer == GT_POSSESSION && (strequals(ent->classname, "team_CTF_redflag") || strequals(ent->classname, "team_CTF_blueflag") ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
NEI4 $489
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $492
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $489
LABELV $492
line 1015
;1015:		ent->s.eFlags |= EF_NODRAW; // Don't draw the flag colored flags in possession
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1016
;1016:	}
LABELV $489
line 1018
;1017:
;1018:	if (strequals(ent->classname, "domination_point")) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $495
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $493
line 1019
;1019:		ent->s.eFlags |= EF_NODRAW; // Don't draw domination_point. It is just a pointer to where the Domination points should be placed
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1020
;1020:	}
LABELV $493
line 1021
;1021:	if ( item->giType == IT_POWERUP ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $496
line 1022
;1022:		G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $198
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 1023
;1023:		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
ADDRGP4 $498
ARGP4
ADDRGP4 $458
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1024
;1024:	}
LABELV $496
line 1026
;1025:
;1026:	if ( item->giType == IT_PERSISTANT_POWERUP ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $499
line 1027
;1027:		ent->s.generic1 = ent->spawnflags;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ASGNI4
line 1028
;1028:	}
LABELV $499
line 1029
;1029:}
LABELV $456
endproc G_SpawnItem 40 12
export G_BounceItem
proc G_BounceItem 64 12
line 1039
;1030:
;1031:
;1032:/*
;1033:================
;1034:G_BounceItem
;1035:
;1036:================
;1037:*/
;1038:void G_BounceItem( gentity_t *ent, trace_t *trace )
;1039:{
line 1045
;1040:	vec3_t	velocity;
;1041:	float	dot;
;1042:	int		hitTime;
;1043:
;1044:	// reflect the velocity on the trace plane
;1045:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+36
INDIRI4
CVIF4 4
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1046
;1046:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1047
;1047:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1048
;1048:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1051
;1049:
;1050:	// cut the velocity to keep from bouncing forever
;1051:	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
line 1054
;1052:
;1053:	// check for stop
;1054:	if ( trace->plane.normal[2] > 0 && ent->s.pos.trDelta[2] < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $509
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1109393408
GEF4 $509
line 1055
;1055:		trace->endpos[2] += 1.0;	// make sure it is off ground
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1056
;1056:		SnapVector( trace->endpos );
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1057
;1057:		G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1058
;1058:		ent->s.groundEntityNum = trace->entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 1059
;1059:		return;
ADDRGP4 $501
JUMPV
LABELV $509
line 1062
;1060:	}
;1061:
;1062:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1063
;1063:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1064
;1064:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1065
;1065:}
LABELV $501
endproc G_BounceItem 64 12
export G_RunItem
proc G_RunItem 124 28
line 1074
;1066:
;1067:/*
;1068:================
;1069:G_RunItem
;1070:
;1071:================
;1072:*/
;1073:void G_RunItem( gentity_t *ent )
;1074:{
line 1083
;1075:	vec3_t		origin;
;1076:	vec3_t		angles;
;1077:	vec3_t		velocity;
;1078:	trace_t		tr;
;1079:	int			contents;
;1080:	int			mask;
;1081:
;1082:	// if groundentity has been set to -1, it may have been pushed off an edge
;1083:	if ( ent->s.groundEntityNum == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $513
line 1084
;1084:		if ( ent->s.pos.trType != TR_GRAVITY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 5
EQI4 $515
line 1085
;1085:			ent->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1086
;1086:			ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1087
;1087:		}
LABELV $515
line 1088
;1088:	}
LABELV $513
line 1090
;1089:
;1090:	if ( ent->s.pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $518
line 1092
;1091:		// check think function
;1092:		G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1093
;1093:		return;
ADDRGP4 $512
JUMPV
LABELV $518
line 1097
;1094:	}
;1095:
;1096:	// get current position
;1097:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1100
;1098:
;1099:	// trace a line from the previous position to the current position
;1100:	if ( ent->clipmask ) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 0
EQI4 $521
line 1101
;1101:		mask = ent->clipmask;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 1102
;1102:	}
ADDRGP4 $522
JUMPV
LABELV $521
line 1103
;1103:	else {
line 1104
;1104:		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
ADDRLP4 72
CNSTI4 65537
ASGNI4
line 1105
;1105:	}
LABELV $522
line 1106
;1106:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin,
ADDRLP4 0
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1109
;1107:	            ent->r.ownerNum, mask );
;1108:
;1109:	VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 1111
;1110:
;1111:	if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $524
line 1112
;1112:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1113
;1113:	}
LABELV $524
line 1115
;1114:
;1115:	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1118
;1116:
;1117:	// check think function
;1118:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1120
;1119:
;1120:	if ( tr.fraction == 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $528
line 1121
;1121:		return;
ADDRGP4 $512
JUMPV
LABELV $528
line 1125
;1122:	}
;1123:
;1124:	// if it is in a nodrop volume, remove it
;1125:	contents = trap_PointContents( ent->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 104
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 104
INDIRI4
ASGNI4
line 1126
;1126:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 68
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $531
line 1127
;1127:		if (ent->item && ent->item->giType == IT_TEAM && (Q_strequal(ent->item->pickup_name,"Red Cube") || Q_strequal(ent->item->pickup_name,"Blue Cube"))) {
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $533
ADDRLP4 108
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $533
ADDRLP4 108
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRGP4 $419
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $535
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRGP4 $420
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $533
LABELV $535
line 1128
;1128:			TossClientCubesValues(angles, origin, velocity);
ADDRLP4 88
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 TossClientCubesValues
CALLV
pop
line 1129
;1129:			G_SetOrigin( ent, origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1130
;1130:			ent->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1131
;1131:			ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1132
;1132:			VectorCopy( velocity, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 76
INDIRB
ASGNB 12
line 1133
;1133:			return;
ADDRGP4 $512
JUMPV
LABELV $533
line 1135
;1134:		}
;1135:		if (ent->item && ent->item->giType == IT_TEAM) {
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $537
ADDRLP4 120
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $537
line 1136
;1136:			Team_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Team_FreeEntity
CALLV
pop
line 1137
;1137:		}
ADDRGP4 $512
JUMPV
LABELV $537
line 1138
;1138:		else {
line 1139
;1139:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1140
;1140:		}
line 1141
;1141:		return;
ADDRGP4 $512
JUMPV
LABELV $531
line 1144
;1142:	}
;1143:
;1144:	G_BounceItem( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceItem
CALLV
pop
line 1145
;1145:}
LABELV $512
endproc G_RunItem 124 28
bss
export itemRegistered
align 4
LABELV itemRegistered
skip 1024
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
import ArmorIndex
import Think_Weapon
import SetRespawn
import PrecacheItem
import UseHoldableItem
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
LABELV $498
byte 1 110
byte 1 111
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $495
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 95
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $482
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $459
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $458
byte 1 48
byte 1 0
align 1
LABELV $457
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $455
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $450
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $442
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $435
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $434
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $433
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $429
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 87
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $428
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 82
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $427
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 66
byte 1 32
byte 1 40
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $426
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 87
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $425
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 82
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $424
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 32
byte 1 40
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 41
byte 1 0
align 1
LABELV $420
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
LABELV $419
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
LABELV $397
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $394
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $386
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $383
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $382
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $379
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $375
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $371
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $361
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $357
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $356
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $352
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $329
byte 1 70
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $258
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $252
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $203
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $198
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $182
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $100
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
