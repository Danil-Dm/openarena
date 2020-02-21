export G_ResetHistory
code
proc G_ResetHistory 20 0
file "../../../code/game/g_unlagged.c"
line 34
;1:/*
;2:===========================================================================
;3:Copyright (C) 2006 Neil Toronto.
;4:
;5:This file is part of the Unlagged source code.
;6:
;7:Unlagged source code is free software; you can redistribute it and/or
;8:modify it under the terms of the GNU General Public License as published by
;9:the Free Software Foundation; either version 2 of the License, or (at your
;10:option) any later version.
;11:
;12:Unlagged source code is distributed in the hope that it will be useful, but
;13:WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;14:or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;15:for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Unlagged source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22:
;23://Sago: For some reason the Niels version must use a different char set.
;24:#include "g_local.h"
;25:
;26:/*
;27:============
;28:G_ResetHistory
;29:
;30:Clear out the given client's history (should be called when the teleport bit is flipped)
;31:============
;32:*/
;33:void G_ResetHistory( gentity_t *ent )
;34:{
line 38
;35:	int		i, time;
;36:
;37:	// fill up the history with data (assume the current position)
;38:	ent->client->historyHead = NUM_CLIENT_HISTORY - 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
CNSTI4 16
ASGNI4
line 39
;39:	for ( i = ent->client->historyHead, time = level.time; i >= 0; i--, time -= 50 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRGP4 level+32
INDIRI4
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $61
line 40
;40:		VectorCopy( ent->r.mins, ent->client->history[i].mins );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 41
;41:		VectorCopy( ent->r.maxs, ent->client->history[i].maxs );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 42
;42:		VectorCopy( ent->r.currentOrigin, ent->client->history[i].currentOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 24
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 43
;43:		ent->client->history[i].leveltime = time;
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 36
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 44
;44:	}
LABELV $62
line 39
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
LABELV $64
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $61
line 45
;45:}
LABELV $60
endproc G_ResetHistory 20 0
export G_StoreHistory
proc G_StoreHistory 36 0
line 56
;46:
;47:
;48:/*
;49:============
;50:G_StoreHistory
;51:
;52:Keep track of where the client's been
;53:============
;54:*/
;55:void G_StoreHistory( gentity_t *ent )
;56:{
line 59
;57:	int		head;
;58:
;59:	ent->client->historyHead++;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 60
;60:	if ( ent->client->historyHead >= NUM_CLIENT_HISTORY ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
CNSTI4 17
LTI4 $67
line 61
;61:		ent->client->historyHead = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
CNSTI4 0
ASGNI4
line 62
;62:	}
LABELV $67
line 64
;63:
;64:	head = ent->client->historyHead;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ASGNI4
line 67
;65:
;66:	// store all the collision-detection info and the time
;67:	VectorCopy( ent->r.mins, ent->client->history[head].mins );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 68
;68:	VectorCopy( ent->r.maxs, ent->client->history[head].maxs );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 69
;69:	VectorCopy( ent->s.pos.trBase, ent->client->history[head].currentOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 24
ASGNI4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 70
;70:	SnapVector( ent->client->history[head].currentOrigin );
ADDRLP4 24
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 28
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 28
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
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 32
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
line 71
;71:	ent->client->history[head].leveltime = level.time;
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 36
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 72
;72:}
LABELV $66
endproc G_StoreHistory 36 0
proc TimeShiftLerp 20 0
line 84
;73:
;74:
;75:/*
;76:=============
;77:TimeShiftLerp
;78:
;79:Used below to interpolate between two previous vectors
;80:Returns a vector "frac" times the distance between "start" and "end"
;81:=============
;82:*/
;83:static void TimeShiftLerp( float frac, vec3_t start, vec3_t end, vec3_t result )
;84:{
line 93
;85:// From CG_InterpolateEntityPosition in cg_ents.c:
;86:	/*
;87:		cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
;88:		cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
;89:		cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
;90:	*/
;91:// Making these exactly the same should avoid floating-point error
;92:
;93:	result[0] = start[0] + frac * ( end[0] - start[0] );
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 94
;94:	result[1] = start[1] + frac * ( end[1] - start[1] );
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRFP4 12
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 95
;95:	result[2] = start[2] + frac * ( end[2] - start[2] );
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRFP4 12
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRLP4 16
INDIRF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 96
;96:}
LABELV $70
endproc TimeShiftLerp 20 0
export G_TimeShiftClient
proc G_TimeShiftClient 76 16
line 107
;97:
;98:
;99:/*
;100:=================
;101:G_TimeShiftClient
;102:
;103:Move a client back to where he was at the specified "time"
;104:=================
;105:*/
;106:void G_TimeShiftClient( gentity_t *ent, int time, qboolean debug, gentity_t *debugger )
;107:{
line 112
;108:	int		j, k;
;109:	
;110:	// find two entries in the history whose times sandwich "time"
;111:	// assumes no two adjacent records have the same timestamp
;112:	j = k = ent->client->historyHead;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $72
line 113
;113:	do {
line 114
;114:		if ( ent->client->history[j].leveltime <= time )
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 36
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $75
line 115
;115:			break;
ADDRGP4 $74
JUMPV
LABELV $75
line 116
;116:		k = j;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 117
;117:		j--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 118
;118:		if ( j < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $77
line 119
;119:			j = NUM_CLIENT_HISTORY - 1;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 120
;120:		}
LABELV $77
line 121
;121:	}
LABELV $73
line 122
;122:	while ( j != ent->client->historyHead );
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
NEI4 $72
LABELV $74
line 125
;123:
;124:	// if we got past the first iteration above, we've sandwiched (or wrapped)
;125:	if ( j != k ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $79
line 127
;126:		// make sure it doesn't get re-saved
;127:		if ( ent->client->saved.leveltime != level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1988
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
EQI4 $81
line 129
;128:			// save the current origin and bounding box
;129:			VectorCopy( ent->r.mins, ent->client->saved.mins );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1952
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 130
;130:			VectorCopy( ent->r.maxs, ent->client->saved.maxs );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1964
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 131
;131:			VectorCopy( ent->r.currentOrigin, ent->client->saved.currentOrigin );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1976
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 132
;132:			ent->client->saved.leveltime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1988
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 133
;133:		}
LABELV $81
line 137
;134:
;135:		// if we haven't wrapped back to the head, we've sandwiched, so
;136:		// we shift the client's position back to where he was at "time"
;137:		if ( j != ent->client->historyHead ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
EQI4 $85
line 138
;138:			float	frac = (float)(time - ent->client->history[j].leveltime) /
ADDRLP4 16
CNSTI4 40
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ASGNP4
ADDRLP4 24
CNSTI4 36
ASGNI4
ADDRLP4 28
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
ADDRFP4 4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 16
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 142
;139:			               (float)(ent->client->history[k].leveltime - ent->client->history[j].leveltime);
;140:
;141:			// interpolate between the two origins to give position at time index "time"
;142:			TimeShiftLerp( frac,
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 32
CNSTI4 40
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ASGNP4
ADDRLP4 44
CNSTI4 24
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 40
INDIRP4
ADDP4
ADDRLP4 44
INDIRI4
ADDP4
ARGP4
ADDRLP4 32
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 40
INDIRP4
ADDP4
ADDRLP4 44
INDIRI4
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 TimeShiftLerp
CALLV
pop
line 147
;143:			               ent->client->history[j].currentOrigin, ent->client->history[k].currentOrigin,
;144:			               ent->r.currentOrigin );
;145:
;146:			// lerp these too, just for fun (and ducking)
;147:			TimeShiftLerp( frac,
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
CNSTI4 40
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ASGNP4
ADDRLP4 48
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 56
INDIRP4
ADDP4
ARGP4
ADDRLP4 48
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 56
INDIRP4
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRGP4 TimeShiftLerp
CALLV
pop
line 151
;148:			               ent->client->history[j].mins, ent->client->history[k].mins,
;149:			               ent->r.mins );
;150:
;151:			TimeShiftLerp( frac,
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 60
CNSTI4 40
ASGNI4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ASGNP4
ADDRLP4 72
CNSTI4 12
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 68
INDIRP4
ADDP4
ADDRLP4 72
INDIRI4
ADDP4
ARGP4
ADDRLP4 60
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 68
INDIRP4
ADDP4
ADDRLP4 72
INDIRI4
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRGP4 TimeShiftLerp
CALLV
pop
line 156
;152:			               ent->client->history[j].maxs, ent->client->history[k].maxs,
;153:			               ent->r.maxs );
;154:
;155:			// this will recalculate absmin and absmax
;156:			trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 157
;157:		}
ADDRGP4 $86
JUMPV
LABELV $85
line 158
;158:		else {
line 160
;159:			// we wrapped, so grab the earliest
;160:			VectorCopy( ent->client->history[k].currentOrigin, ent->r.currentOrigin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 161
;161:			VectorCopy( ent->client->history[k].mins, ent->r.mins );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 436
ADDP4
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
INDIRB
ASGNB 12
line 162
;162:			VectorCopy( ent->client->history[k].maxs, ent->r.maxs );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1272
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 165
;163:
;164:			// this will recalculate absmin and absmax
;165:			trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 166
;166:		}
LABELV $86
line 167
;167:	}
LABELV $79
line 168
;168:}
LABELV $71
endproc G_TimeShiftClient 76 16
export G_TimeShiftAllClients
proc G_TimeShiftAllClients 32 16
line 180
;169:
;170:
;171:/*
;172:=====================
;173:G_TimeShiftAllClients
;174:
;175:Move ALL clients back to where they were at the specified "time",
;176:except for "skip"
;177:=====================
;178:*/
;179:void G_TimeShiftAllClients( int time, gentity_t *skip )
;180:{
line 183
;181:	int			i;
;182:	gentity_t	*ent;
;183:	qboolean debug = ( skip != NULL && skip->client && skip->s.weapon == WP_RAILGUN );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $89
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $89
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $89
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $90
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 186
;184:
;185:	// for every client
;186:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 187
;187:	for ( i = 0; i < MAX_CLIENTS; i++, ent++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $91
line 188
;188:		if ( ent->client && ent->inuse && ent->client->sess.sessionTeam < TEAM_SPECTATOR && ent != skip ) {
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $95
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $95
ADDRLP4 28
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
GEI4 $95
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $95
line 189
;189:			G_TimeShiftClient( ent, time, debug, skip );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_TimeShiftClient
CALLV
pop
line 190
;190:		}
LABELV $95
line 191
;191:	}
LABELV $92
line 187
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
LTI4 $91
line 192
;192:}
LABELV $87
endproc G_TimeShiftAllClients 32 16
lit
align 4
LABELV $98
byte 4 0
byte 4 0
byte 4 2
byte 4 4
byte 4 0
byte 4 0
byte 4 8
byte 4 16
byte 4 0
byte 4 0
byte 4 0
byte 4 32
byte 4 0
byte 4 64
export G_DoTimeShiftFor
code
proc G_DoTimeShiftFor 84 8
line 203
;193:
;194:
;195:/*
;196:================
;197:G_DoTimeShiftFor
;198:
;199:Decide what time to shift everyone back to, and do it
;200:================
;201:*/
;202:void G_DoTimeShiftFor( gentity_t *ent )
;203:{
line 204
;204:	int wpflags[WP_NUM_WEAPONS] = { 0, 0, 2, 4, 0, 0, 8, 16, 0, 0, 0, 32, 0, 64 };
ADDRLP4 4
ADDRGP4 $98
INDIRB
ASGNB 56
line 206
;205:
;206:	int wpflag = wpflags[ent->client->ps.weapon];
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 210
;207:	int time;
;208:
;209:	// don't time shift for mistakes or bots
;210:	if ( !ent->inuse || !ent->client || (ent->r.svFlags & SVF_BOT) ) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $102
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $102
ADDRLP4 64
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 68
INDIRI4
EQI4 $99
LABELV $102
line 211
;211:		return;
ADDRGP4 $97
JUMPV
LABELV $99
line 215
;212:	}
;213:
;214:	// if it's enabled server-side and the client wants it or wants it for this weapon
;215:	if ( g_delagHitscan.integer && ( ent->client->pers.delag & 1 || ent->client->pers.delag & wpflag ) ) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 g_delagHitscan+12
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $103
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 72
INDIRI4
NEI4 $106
ADDRLP4 76
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
ADDRLP4 72
INDIRI4
EQI4 $103
LABELV $106
line 217
;216:		// do the full lag compensation, except what the client nudges
;217:		time = ent->client->attackTime + ent->client->pers.cmdTimeNudge;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
ADDRLP4 80
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDI4
ASGNI4
line 219
;218:		//Give the lightning gun some handicap (lag was part of weapon balance in VQ3)
;219:		if(ent->client->ps.weapon == WP_LIGHTNING && g_lagLightning.integer)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 6
NEI4 $104
ADDRGP4 g_lagLightning+12
INDIRI4
CNSTI4 0
EQI4 $104
line 220
;220:			time+=50;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 50
ADDI4
ASGNI4
line 221
;221:	}
ADDRGP4 $104
JUMPV
LABELV $103
line 222
;222:	else {
line 224
;223:		// do just 50ms
;224:		time = level.previousTime + ent->client->frameOffset;
ADDRLP4 0
ADDRGP4 level+36
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1992
ADDP4
INDIRI4
ADDI4
ASGNI4
line 225
;225:	}
LABELV $104
line 227
;226:
;227:	G_TimeShiftAllClients( time, ent );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TimeShiftAllClients
CALLV
pop
line 228
;228:}
LABELV $97
endproc G_DoTimeShiftFor 84 8
export G_UnTimeShiftClient
proc G_UnTimeShiftClient 12 4
line 239
;229:
;230:
;231:/*
;232:===================
;233:G_UnTimeShiftClient
;234:
;235:Move a client back to where he was before the time shift
;236:===================
;237:*/
;238:void G_UnTimeShiftClient( gentity_t *ent )
;239:{
line 241
;240:	// if it was saved
;241:	if ( ent->client->saved.leveltime == level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1988
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
NEI4 $112
line 243
;242:		// move it back
;243:		VectorCopy( ent->client->saved.mins, ent->r.mins );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1952
ADDP4
INDIRB
ASGNB 12
line 244
;244:		VectorCopy( ent->client->saved.maxs, ent->r.maxs );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1964
ADDP4
INDIRB
ASGNB 12
line 245
;245:		VectorCopy( ent->client->saved.currentOrigin, ent->r.currentOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1976
ADDP4
INDIRB
ASGNB 12
line 246
;246:		ent->client->saved.leveltime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1988
ADDP4
CNSTI4 0
ASGNI4
line 249
;247:
;248:		// this will recalculate absmin and absmax
;249:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 250
;250:	}
LABELV $112
line 251
;251:}
LABELV $111
endproc G_UnTimeShiftClient 12 4
export G_UnTimeShiftAllClients
proc G_UnTimeShiftAllClients 16 4
line 263
;252:
;253:
;254:/*
;255:=======================
;256:G_UnTimeShiftAllClients
;257:
;258:Move ALL the clients back to where they were before the time shift,
;259:except for "skip"
;260:=======================
;261:*/
;262:void G_UnTimeShiftAllClients( gentity_t *skip )
;263:{
line 267
;264:	int			i;
;265:	gentity_t	*ent;
;266:
;267:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 268
;268:	for ( i = 0; i < MAX_CLIENTS; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $116
line 269
;269:		if ( ent->client && ent->inuse && ent->client->sess.sessionTeam < TEAM_SPECTATOR && ent != skip ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $120
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $120
ADDRLP4 12
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
GEI4 $120
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $120
line 270
;270:			G_UnTimeShiftClient( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 271
;271:		}
LABELV $120
line 272
;272:	}
LABELV $117
line 268
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
LTI4 $116
line 273
;273:}
LABELV $115
endproc G_UnTimeShiftAllClients 16 4
export G_UndoTimeShiftFor
proc G_UndoTimeShiftFor 8 4
line 284
;274:
;275:
;276:/*
;277:==================
;278:G_UndoTimeShiftFor
;279:
;280:Put everyone except for this client back where they were
;281:==================
;282:*/
;283:void G_UndoTimeShiftFor( gentity_t *ent )
;284:{
line 287
;285:
;286:	// don't un-time shift for mistakes or bots
;287:	if ( !ent->inuse || !ent->client || (ent->r.svFlags & SVF_BOT) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $126
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $123
LABELV $126
line 288
;288:		return;
ADDRGP4 $122
JUMPV
LABELV $123
line 291
;289:	}
;290:
;291:	G_UnTimeShiftAllClients( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftAllClients
CALLV
pop
line 292
;292:}
LABELV $122
endproc G_UndoTimeShiftFor 8 4
export G_PredictPlayerClipVelocity
proc G_PredictPlayerClipVelocity 28 0
line 306
;293:
;294:
;295:/*
;296:===========================
;297:G_PredictPlayerClipVelocity
;298:
;299:Slide on the impacting surface
;300:===========================
;301:*/
;302:
;303:#define	OVERCLIP		1.001f
;304:
;305:void G_PredictPlayerClipVelocity( vec3_t in, vec3_t normal, vec3_t out )
;306:{
line 310
;307:	float	backoff;
;308:
;309:	// find the magnitude of the vector "in" along "normal"
;310:	backoff = DotProduct (in, normal);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 313
;311:
;312:	// tilt the plane a bit to avoid floating-point error issues
;313:	if ( backoff < 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $128
line 314
;314:		backoff *= OVERCLIP;
ADDRLP4 0
CNSTF4 1065361605
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 315
;315:	}
ADDRGP4 $129
JUMPV
LABELV $128
line 316
;316:	else {
line 317
;317:		backoff /= OVERCLIP;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065361605
DIVF4
ASGNF4
line 318
;318:	}
LABELV $129
line 321
;319:
;320:	// slide along
;321:	VectorMA( in, -backoff, normal, out );
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 322
;322:}
LABELV $127
endproc G_PredictPlayerClipVelocity 28 0
export G_PredictPlayerSlideMove
proc G_PredictPlayerSlideMove 300 28
line 335
;323:
;324:
;325:/*
;326:========================
;327:G_PredictPlayerSlideMove
;328:
;329:Advance the given entity frametime seconds, sliding as appropriate
;330:========================
;331:*/
;332:#define	MAX_CLIP_PLANES	5
;333:
;334:qboolean G_PredictPlayerSlideMove( gentity_t *ent, float frametime )
;335:{
line 351
;336:	int			bumpcount, numbumps;
;337:	vec3_t		dir;
;338:	float		d;
;339:	int			numplanes;
;340:	vec3_t		planes[MAX_CLIP_PLANES];
;341:	vec3_t		primal_velocity, velocity, origin;
;342:	vec3_t		clipVelocity;
;343:	int			i, j, k;
;344:	trace_t	trace;
;345:	vec3_t		end;
;346:	float		time_left;
;347:	float		into;
;348:	vec3_t		endVelocity;
;349:	vec3_t		endClipVelocity;
;350:
;351:	numbumps = 4;
ADDRLP4 232
CNSTI4 4
ASGNI4
line 353
;352:
;353:	VectorCopy( ent->s.pos.trDelta, primal_velocity );
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 354
;354:	VectorCopy( primal_velocity, velocity );
ADDRLP4 76
ADDRLP4 236
INDIRB
ASGNB 12
line 355
;355:	VectorCopy( ent->s.pos.trBase, origin );
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 357
;356:
;357:	VectorCopy( velocity, endVelocity );
ADDRLP4 140
ADDRLP4 76
INDIRB
ASGNB 12
line 359
;358:
;359:	time_left = frametime;
ADDRLP4 212
ADDRFP4 4
INDIRF4
ASGNF4
line 361
;360:
;361:	numplanes = 0;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 363
;362:
;363:	for ( bumpcount = 0; bumpcount < numbumps; bumpcount++ ) {
ADDRLP4 228
CNSTI4 0
ASGNI4
ADDRGP4 $134
JUMPV
LABELV $131
line 366
;364:
;365:		// calculate position we are trying to move to
;366:		VectorMA( origin, time_left, velocity, end );
ADDRLP4 216
ADDRLP4 112
INDIRF4
ADDRLP4 76
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 216+4
ADDRLP4 112+4
INDIRF4
ADDRLP4 76+4
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 216+8
ADDRLP4 112+8
INDIRF4
ADDRLP4 76+8
INDIRF4
ADDRLP4 212
INDIRF4
MULF4
ADDF4
ASGNF4
line 369
;367:
;368:		// see if we can make it there
;369:		trap_Trace( &trace, origin, ent->r.mins, ent->r.maxs, end, ent->s.number, ent->clipmask );
ADDRLP4 152
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 252
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 216
ARGP4
ADDRLP4 252
INDIRP4
INDIRI4
ARGI4
ADDRLP4 252
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 371
;370:
;371:		if (trace.allsolid) {
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $141
line 373
;372:			// entity is completely trapped in another solid
;373:			VectorClear( velocity );
ADDRLP4 256
CNSTF4 0
ASGNF4
ADDRLP4 76+8
ADDRLP4 256
INDIRF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 256
INDIRF4
ASGNF4
ADDRLP4 76
ADDRLP4 256
INDIRF4
ASGNF4
line 374
;374:			VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 112
INDIRB
ASGNB 12
line 375
;375:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $130
JUMPV
LABELV $141
line 378
;376:		}
;377:
;378:		if (trace.fraction > 0) {
ADDRLP4 152+8
INDIRF4
CNSTF4 0
LEF4 $145
line 380
;379:			// actually covered some distance
;380:			VectorCopy( trace.endpos, origin );
ADDRLP4 112
ADDRLP4 152+12
INDIRB
ASGNB 12
line 381
;381:		}
LABELV $145
line 383
;382:
;383:		if (trace.fraction == 1) {
ADDRLP4 152+8
INDIRF4
CNSTF4 1065353216
NEF4 $149
line 384
;384:			break;		// moved the entire distance
ADDRGP4 $133
JUMPV
LABELV $149
line 387
;385:		}
;386:
;387:		time_left -= time_left * trace.fraction;
ADDRLP4 212
ADDRLP4 212
INDIRF4
ADDRLP4 212
INDIRF4
ADDRLP4 152+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 389
;388:
;389:		if ( numplanes >= MAX_CLIP_PLANES ) {
ADDRLP4 108
INDIRI4
CNSTI4 5
LTI4 $153
line 391
;390:			// this shouldn't really happen
;391:			VectorClear( velocity );
ADDRLP4 260
CNSTF4 0
ASGNF4
ADDRLP4 76+8
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 76
ADDRLP4 260
INDIRF4
ASGNF4
line 392
;392:			VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 112
INDIRB
ASGNB 12
line 393
;393:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $130
JUMPV
LABELV $153
line 401
;394:		}
;395:
;396:		//
;397:		// if this is the same plane we hit before, nudge velocity
;398:		// out along it, which fixes some epsilon issues with
;399:		// non-axial planes
;400:		//
;401:		for ( i = 0; i < numplanes; i++ ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 $160
JUMPV
LABELV $157
line 402
;402:			if ( DotProduct( trace.plane.normal, planes[i] ) > 0.99 ) {
ADDRLP4 260
CNSTI4 12
ADDRLP4 92
INDIRI4
MULI4
ASGNI4
ADDRLP4 152+24
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 152+24+4
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 152+24+8
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1065185444
LEF4 $161
line 403
;403:				VectorAdd( trace.plane.normal, velocity, velocity );
ADDRLP4 76
ADDRLP4 152+24
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 152+24+4
INDIRF4
ADDRLP4 76+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRLP4 152+24+8
INDIRF4
ADDRLP4 76+8
INDIRF4
ADDF4
ASGNF4
line 404
;404:				break;
ADDRGP4 $159
JUMPV
LABELV $161
line 406
;405:			}
;406:		}
LABELV $158
line 401
ADDRLP4 92
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $160
ADDRLP4 92
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $157
LABELV $159
line 408
;407:
;408:		if ( i < numplanes ) {
ADDRLP4 92
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $179
line 409
;409:			continue;
ADDRGP4 $132
JUMPV
LABELV $179
line 412
;410:		}
;411:
;412:		VectorCopy( trace.plane.normal, planes[numplanes] );
CNSTI4 12
ADDRLP4 108
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ADDRLP4 152+24
INDIRB
ASGNB 12
line 413
;413:		numplanes++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 420
;414:
;415:		//
;416:		// modify velocity so it parallels all of the clip planes
;417:		//
;418:
;419:		// find a plane that it enters
;420:		for ( i = 0; i < numplanes; i++ ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 $185
JUMPV
LABELV $182
line 421
;421:			into = DotProduct( velocity, planes[i] );
ADDRLP4 260
CNSTI4 12
ADDRLP4 92
INDIRI4
MULI4
ASGNI4
ADDRLP4 208
ADDRLP4 76
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 76+4
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 76+8
INDIRF4
ADDRLP4 260
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 422
;422:			if ( into >= 0.1 ) {
ADDRLP4 208
INDIRF4
CNSTF4 1036831949
LTF4 $190
line 423
;423:				continue;		// move doesn't interact with the plane
ADDRGP4 $183
JUMPV
LABELV $190
line 427
;424:			}
;425:
;426:			// slide along the plane
;427:			G_PredictPlayerClipVelocity( velocity, planes[i], clipVelocity );
ADDRLP4 76
ARGP4
CNSTI4 12
ADDRLP4 92
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 G_PredictPlayerClipVelocity
CALLV
pop
line 430
;428:
;429:			// slide along the plane
;430:			G_PredictPlayerClipVelocity( endVelocity, planes[i], endClipVelocity );
ADDRLP4 140
ARGP4
CNSTI4 12
ADDRLP4 92
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 G_PredictPlayerClipVelocity
CALLV
pop
line 433
;431:
;432:			// see if there is a second plane that the new move enters
;433:			for ( j = 0; j < numplanes; j++ ) {
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRGP4 $195
JUMPV
LABELV $192
line 434
;434:				if ( j == i ) {
ADDRLP4 88
INDIRI4
ADDRLP4 92
INDIRI4
NEI4 $196
line 435
;435:					continue;
ADDRGP4 $193
JUMPV
LABELV $196
line 438
;436:				}
;437:
;438:				if ( DotProduct( clipVelocity, planes[j] ) >= 0.1 ) {
ADDRLP4 264
CNSTI4 12
ADDRLP4 88
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 264
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $198
line 439
;439:					continue;		// move doesn't interact with the plane
ADDRGP4 $193
JUMPV
LABELV $198
line 443
;440:				}
;441:
;442:				// try clipping the move to the plane
;443:				G_PredictPlayerClipVelocity( clipVelocity, planes[j], clipVelocity );
ADDRLP4 64
ARGP4
CNSTI4 12
ADDRLP4 88
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 G_PredictPlayerClipVelocity
CALLV
pop
line 444
;444:				G_PredictPlayerClipVelocity( endClipVelocity, planes[j], endClipVelocity );
ADDRLP4 128
ARGP4
CNSTI4 12
ADDRLP4 88
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 G_PredictPlayerClipVelocity
CALLV
pop
line 447
;445:
;446:				// see if it goes back into the first clip plane
;447:				if ( DotProduct( clipVelocity, planes[i] ) >= 0 ) {
ADDRLP4 268
CNSTI4 12
ADDRLP4 92
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 0
LTF4 $204
line 448
;448:					continue;
ADDRGP4 $193
JUMPV
LABELV $204
line 452
;449:				}
;450:
;451:				// slide the original velocity along the crease
;452:				CrossProduct( planes[i], planes[j], dir );
ADDRLP4 272
CNSTI4 12
ASGNI4
ADDRLP4 272
INDIRI4
ADDRLP4 92
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 272
INDIRI4
ADDRLP4 88
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 453
;453:				VectorNormalize( dir );
ADDRLP4 96
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 454
;454:				d = DotProduct( dir, velocity );
ADDRLP4 124
ADDRLP4 96
INDIRF4
ADDRLP4 76
INDIRF4
MULF4
ADDRLP4 96+4
INDIRF4
ADDRLP4 76+4
INDIRF4
MULF4
ADDF4
ADDRLP4 96+8
INDIRF4
ADDRLP4 76+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 455
;455:				VectorScale( dir, d, clipVelocity );
ADDRLP4 64
ADDRLP4 96
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 96+4
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 96+8
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
line 457
;456:
;457:				CrossProduct( planes[i], planes[j], dir );
ADDRLP4 280
CNSTI4 12
ASGNI4
ADDRLP4 280
INDIRI4
ADDRLP4 92
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 280
INDIRI4
ADDRLP4 88
INDIRI4
MULI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 458
;458:				VectorNormalize( dir );
ADDRLP4 96
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 459
;459:				d = DotProduct( dir, endVelocity );
ADDRLP4 124
ADDRLP4 96
INDIRF4
ADDRLP4 140
INDIRF4
MULF4
ADDRLP4 96+4
INDIRF4
ADDRLP4 140+4
INDIRF4
MULF4
ADDF4
ADDRLP4 96+8
INDIRF4
ADDRLP4 140+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 460
;460:				VectorScale( dir, d, endClipVelocity );
ADDRLP4 128
ADDRLP4 96
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
ADDRLP4 128+4
ADDRLP4 96+4
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
ADDRLP4 128+8
ADDRLP4 96+8
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ASGNF4
line 463
;461:
;462:				// see if there is a third plane the the new move enters
;463:				for ( k = 0; k < numplanes; k++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $229
JUMPV
LABELV $226
line 464
;464:					if ( k == i || k == j ) {
ADDRLP4 0
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $232
ADDRLP4 0
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $230
LABELV $232
line 465
;465:						continue;
ADDRGP4 $227
JUMPV
LABELV $230
line 468
;466:					}
;467:
;468:					if ( DotProduct( clipVelocity, planes[k] ) >= 0.1 ) {
ADDRLP4 292
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 64
INDIRF4
ADDRLP4 292
INDIRI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 64+4
INDIRF4
ADDRLP4 292
INDIRI4
ADDRLP4 4+4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 64+8
INDIRF4
ADDRLP4 292
INDIRI4
ADDRLP4 4+8
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 1036831949
LTF4 $233
line 469
;469:						continue;		// move doesn't interact with the plane
ADDRGP4 $227
JUMPV
LABELV $233
line 473
;470:					}
;471:
;472:					// stop dead at a tripple plane interaction
;473:					VectorClear( velocity );
ADDRLP4 296
CNSTF4 0
ASGNF4
ADDRLP4 76+8
ADDRLP4 296
INDIRF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 296
INDIRF4
ASGNF4
ADDRLP4 76
ADDRLP4 296
INDIRF4
ASGNF4
line 474
;474:					VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 112
INDIRB
ASGNB 12
line 475
;475:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $130
JUMPV
LABELV $227
line 463
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $229
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $226
line 477
;476:				}
;477:			}
LABELV $193
line 433
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $195
ADDRLP4 88
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $192
line 480
;478:
;479:			// if we have fixed all interactions, try another move
;480:			VectorCopy( clipVelocity, velocity );
ADDRLP4 76
ADDRLP4 64
INDIRB
ASGNB 12
line 481
;481:			VectorCopy( endClipVelocity, endVelocity );
ADDRLP4 140
ADDRLP4 128
INDIRB
ASGNB 12
line 482
;482:			break;
ADDRGP4 $184
JUMPV
LABELV $183
line 420
ADDRLP4 92
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $185
ADDRLP4 92
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $182
LABELV $184
line 484
;483:		}
;484:	}
LABELV $132
line 363
ADDRLP4 228
ADDRLP4 228
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $134
ADDRLP4 228
INDIRI4
ADDRLP4 232
INDIRI4
LTI4 $131
LABELV $133
line 486
;485:
;486:	VectorCopy( endVelocity, velocity );
ADDRLP4 76
ADDRLP4 140
INDIRB
ASGNB 12
line 487
;487:	VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 112
INDIRB
ASGNB 12
line 489
;488:
;489:	return (bumpcount != 0);
ADDRLP4 228
INDIRI4
CNSTI4 0
EQI4 $242
ADDRLP4 248
CNSTI4 1
ASGNI4
ADDRGP4 $243
JUMPV
LABELV $242
ADDRLP4 248
CNSTI4 0
ASGNI4
LABELV $243
ADDRLP4 248
INDIRI4
RETI4
LABELV $130
endproc G_PredictPlayerSlideMove 300 28
export G_PredictPlayerStepSlideMove
proc G_PredictPlayerStepSlideMove 124 28
line 503
;490:}
;491:
;492:
;493:/*
;494:============================
;495:G_PredictPlayerStepSlideMove
;496:
;497:Advance the given entity frametime seconds, stepping and sliding as appropriate
;498:============================
;499:*/
;500:#define	STEPSIZE 18
;501:
;502:void G_PredictPlayerStepSlideMove( gentity_t *ent, float frametime )
;503:{
line 509
;504:	vec3_t start_o, start_v;
;505:	vec3_t down, up;
;506:	trace_t trace;
;507:	float stepSize;
;508:
;509:	VectorCopy (ent->s.pos.trBase, start_o);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 510
;510:	VectorCopy (ent->s.pos.trDelta, start_v);
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 512
;511:
;512:	if ( !G_PredictPlayerSlideMove( ent, frametime ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 108
ADDRGP4 G_PredictPlayerSlideMove
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $245
line 514
;513:		// not clipped, so forget stepping
;514:		return;
ADDRGP4 $244
JUMPV
LABELV $245
line 517
;515:	}
;516:
;517:	VectorCopy (start_o, up);
ADDRLP4 80
ADDRLP4 56
INDIRB
ASGNB 12
line 518
;518:	up[2] += STEPSIZE;
ADDRLP4 80+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 521
;519:
;520:	// test the player position if they were a stepheight higher
;521:	trap_Trace( &trace, start_o, ent->r.mins, ent->r.maxs, up, ent->s.number, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 112
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 112
INDIRP4
INDIRI4
ARGI4
ADDRLP4 112
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 522
;522:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $248
line 523
;523:		return;		// can't step up
ADDRGP4 $244
JUMPV
LABELV $248
line 526
;524:	}
;525:
;526:	stepSize = trace.endpos[2] - start_o[2];
ADDRLP4 104
ADDRLP4 0+12+8
INDIRF4
ADDRLP4 56+8
INDIRF4
SUBF4
ASGNF4
line 529
;527:
;528:	// try slidemove from this position
;529:	VectorCopy( trace.endpos, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 530
;530:	VectorCopy( start_v, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 92
INDIRB
ASGNB 12
line 532
;531:
;532:	G_PredictPlayerSlideMove( ent, frametime );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 G_PredictPlayerSlideMove
CALLI4
pop
line 535
;533:
;534:	// push down the final amount
;535:	VectorCopy( ent->s.pos.trBase, down );
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 536
;536:	down[2] -= stepSize;
ADDRLP4 68+8
ADDRLP4 68+8
INDIRF4
ADDRLP4 104
INDIRF4
SUBF4
ASGNF4
line 537
;537:	trap_Trace( &trace, ent->s.pos.trBase, ent->r.mins, ent->r.maxs, down, ent->s.number, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 116
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 116
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 68
ARGP4
ADDRLP4 116
INDIRP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 538
;538:	if ( !trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $255
line 539
;539:		VectorCopy( trace.endpos, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 540
;540:	}
LABELV $255
line 541
;541:	if ( trace.fraction < 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $258
line 542
;542:		G_PredictPlayerClipVelocity( ent->s.pos.trDelta, trace.plane.normal, ent->s.pos.trDelta );
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 G_PredictPlayerClipVelocity
CALLV
pop
line 543
;543:	}
LABELV $258
line 544
;544:}
LABELV $244
endproc G_PredictPlayerStepSlideMove 124 28
export G_PredictPlayerMove
proc G_PredictPlayerMove 0 8
line 557
;545:
;546:
;547:/*
;548:===================
;549:G_PredictPlayerMove
;550:
;551:Advance the given entity frametime seconds, stepping and sliding as appropriate
;552:
;553:This is the entry point to the server-side-only prediction code
;554:===================
;555:*/
;556:void G_PredictPlayerMove( gentity_t *ent, float frametime )
;557:{
line 558
;558:	G_PredictPlayerStepSlideMove( ent, frametime );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 G_PredictPlayerStepSlideMove
CALLV
pop
line 559
;559:}
LABELV $262
endproc G_PredictPlayerMove 0 8
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
