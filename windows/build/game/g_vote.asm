export allowedVote
code
proc allowedVote 288 12
file "../../../code/game/g_vote.c"
line 32
;1:/*
;2:===========================================================================
;3:Copyright (C) 2008-2009 Poul Sander
;4:
;5:This file is part of Open Arena source code.
;6:
;7:Open Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Open Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Open Arena source code; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22:
;23:#include "g_local.h"
;24:
;25:/*
;26:==================
;27:allowedVote
;28: *Note: Keep this in sync with allowedVote in ui_votemenu.c (except for cg_voteNames and g_voteNames)
;29:==================
;30: */
;31:#define MAX_VOTENAME_LENGTH 14 //currently the longest string is "/map_restart/\0" (14 chars)
;32:int allowedVote(const char *commandStr) {
line 36
;33:	char tempStr[MAX_VOTENAME_LENGTH];
;34:	int length;
;35:	char voteNames[MAX_CVAR_VALUE_STRING];
;36:	trap_Cvar_VariableStringBuffer( "g_voteNames", voteNames, sizeof( voteNames ) );
ADDRGP4 $61
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 37
;37:	if(Q_strequal(voteNames, "*" ))
ADDRLP4 20
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 276
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $62
line 38
;38:		return qtrue; //if star, everything is allowed
CNSTI4 1
RETI4
ADDRGP4 $60
JUMPV
LABELV $62
line 39
;39:	length = strlen(commandStr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 280
INDIRI4
ASGNI4
line 40
;40:	if(length>MAX_VOTENAME_LENGTH-3)
ADDRLP4 16
INDIRI4
CNSTI4 11
LEI4 $65
line 41
;41:	{
line 43
;42:		//Error: too long
;43:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $60
JUMPV
LABELV $65
line 46
;44:	}
;45:	//Now constructing a string that starts and ends with '/' like: "/clientkick/"
;46:	tempStr[0] = '/';
ADDRLP4 0
CNSTI1 47
ASGNI1
line 47
;47:	strncpy(&tempStr[1],commandStr,length);
ADDRLP4 0+1
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 48
;48:	tempStr[length+1] = '/';
ADDRLP4 16
INDIRI4
ADDRLP4 0+1
ADDP4
CNSTI1 47
ASGNI1
line 49
;49:	tempStr[length+2] = '\0';
ADDRLP4 16
INDIRI4
ADDRLP4 0+2
ADDP4
CNSTI1 0
ASGNI1
line 50
;50:	if(Q_stristr(voteNames,tempStr) != NULL)
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 284
ADDRGP4 Q_stristr
CALLP4
ASGNP4
ADDRLP4 284
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
line 51
;51:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $60
JUMPV
LABELV $70
line 53
;52:	else
;53:		return qfalse;
CNSTI4 0
RETI4
LABELV $60
endproc allowedVote 288 12
export getMappage
proc getMappage 19572 16
line 62
;54:}
;55:
;56:/*
;57:==================
;58:getMappage
;59:==================
;60: */
;61:
;62:t_mappage getMappage(int page) {
line 69
;63:	t_mappage result;
;64:	fileHandle_t	file;
;65:	char *token,*pointer;
;66:	char buffer[MAX_MAPNAME_BUFFER];
;67:	int i, nummaps,maplen;
;68:
;69:	memset(&result,0,sizeof(result));
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 324
ARGI4
ADDRGP4 memset
CALLP4
pop
line 70
;70:	memset(&buffer,0,sizeof(buffer));
ADDRLP4 344
ARGP4
CNSTI4 0
ARGI4
CNSTI4 19200
ARGI4
ADDRGP4 memset
CALLP4
pop
line 73
;71:
;72:	//Check if there is a votemaps.cfg
;73:	trap_FS_FOpenFile(g_votemaps.string,&file,FS_READ);
ADDRGP4 g_votemaps+16
ARGP4
ADDRLP4 19544
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 74
;74:	if(file)
ADDRLP4 19544
INDIRI4
CNSTI4 0
EQI4 $75
line 75
;75:	{
line 77
;76:		//there is a votemaps.cfg file, take allowed maps from there
;77:		trap_FS_Read(&buffer,sizeof(buffer),file);
ADDRLP4 344
ARGP4
CNSTI4 19200
ARGI4
ADDRLP4 19544
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 78
;78:		pointer = buffer;
ADDRLP4 4
ADDRLP4 344
ASGNP4
line 79
;79:		token = COM_Parse(&pointer);
ADDRLP4 4
ARGP4
ADDRLP4 19548
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 19548
INDIRP4
ASGNP4
line 80
;80:		if(token[0]==0 && page == 0) {
ADDRLP4 19552
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 19552
INDIRI4
NEI4 $77
ADDRFP4 4
INDIRI4
ADDRLP4 19552
INDIRI4
NEI4 $77
line 82
;81:			//First page empty
;82:			result.pagenumber = -1;
ADDRLP4 16
CNSTI4 -1
ASGNI4
line 83
;83:			trap_FS_FCloseFile(file);
ADDRLP4 19544
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 84
;84:			return result;
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRB
ASGNB 324
ADDRGP4 $72
JUMPV
LABELV $77
line 87
;85:		}
;86:		//Skip the first pages
;87:		for(i=0;i<MAPS_PER_PAGE*page;i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $82
JUMPV
LABELV $79
line 88
;88:			token = COM_Parse(&pointer);
ADDRLP4 4
ARGP4
ADDRLP4 19556
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 19556
INDIRP4
ASGNP4
line 89
;89:		}
LABELV $80
line 87
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $82
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRFP4 4
INDIRI4
MULI4
LTI4 $79
line 90
;90:		if(!token || token[0]==0) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $85
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $83
LABELV $85
line 92
;91:			//Page empty, return to first page
;92:			trap_FS_FCloseFile(file);
ADDRLP4 19544
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 93
;93:			return getMappage(0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 getMappage
CALLV
pop
ADDRGP4 $72
JUMPV
LABELV $83
line 96
;94:		}
;95:		//There is an actual page:
;96:		result.pagenumber = page;
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
line 97
;97:		for(i=0;i<MAPS_PER_PAGE && token;i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $89
JUMPV
LABELV $86
line 98
;98:			Q_strncpyz(result.mapname[i],token,MAX_MAPNAME);
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRLP4 16+4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 99
;99:			token = COM_Parse(&pointer);
ADDRLP4 4
ARGP4
ADDRLP4 19560
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 19560
INDIRP4
ASGNP4
line 100
;100:		}
LABELV $87
line 97
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $89
ADDRLP4 0
INDIRI4
CNSTI4 10
GEI4 $91
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
LABELV $91
line 101
;101:		trap_FS_FCloseFile(file);
ADDRLP4 19544
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 102
;102:		return result;
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRB
ASGNB 324
ADDRGP4 $72
JUMPV
LABELV $75
line 105
;103:	}
;104:	//There is no votemaps.cfg file, find filelist of maps
;105:	nummaps = trap_FS_GetFileList("maps",".bsp",buffer,sizeof(buffer));
ADDRGP4 $92
ARGP4
ADDRGP4 $93
ARGP4
ADDRLP4 344
ARGP4
CNSTI4 19200
ARGI4
ADDRLP4 19548
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 340
ADDRLP4 19548
INDIRI4
ASGNI4
line 107
;106:
;107:	if(nummaps && nummaps<=MAPS_PER_PAGE*page)
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $94
ADDRLP4 340
INDIRI4
CNSTI4 10
ADDRFP4 4
INDIRI4
MULI4
GTI4 $94
line 108
;108:		return getMappage(0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 getMappage
CALLV
pop
ADDRGP4 $72
JUMPV
LABELV $94
line 110
;109:
;110:	pointer = buffer;
ADDRLP4 4
ADDRLP4 344
ASGNP4
line 111
;111:	result.pagenumber = page;
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
line 113
;112:
;113:	for (i = 0; i < nummaps; i++, pointer += maplen+1) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $96
line 114
;114:		maplen = strlen(pointer);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 19556
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 19556
INDIRI4
ASGNI4
line 115
;115:		if(i>=MAPS_PER_PAGE*page && i<MAPS_PER_PAGE*(page+1)) {
ADDRLP4 19564
CNSTI4 10
ASGNI4
ADDRLP4 19568
ADDRLP4 19564
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 19568
INDIRI4
LTI4 $100
ADDRLP4 0
INDIRI4
ADDRLP4 19568
INDIRI4
ADDRLP4 19564
INDIRI4
ADDI4
GEI4 $100
line 116
;116:			Q_strncpyz(result.mapname[i-MAPS_PER_PAGE*page],pointer,maplen-3);
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRFP4 4
INDIRI4
MULI4
SUBI4
CNSTI4 5
LSHI4
ADDRLP4 16+4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 3
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 117
;117:		}
LABELV $100
line 118
;118:	}
LABELV $97
line 113
ADDRLP4 19556
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 19556
INDIRI4
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 19556
INDIRI4
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
LABELV $99
ADDRLP4 0
INDIRI4
ADDRLP4 340
INDIRI4
LTI4 $96
line 119
;119:return result;
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRB
ASGNB 324
LABELV $72
endproc getMappage 19572 16
export allowedMap
proc allowedMap 8232 12
line 128
;120:}
;121:
;122:/*
;123:==================
;124:allowedMap
;125:==================
;126: */
;127:
;128:int allowedMap(const char *mapname) {
line 135
;129:	int length;
;130:	fileHandle_t	file;           //To check that the map actually exists.
;131:	char                buffer[MAX_MAPS_TEXT];
;132:	char                *token,*pointer;
;133:	qboolean            found;
;134:
;135:	trap_FS_FOpenFile(va("maps/%s.bsp",mapname),&file,FS_READ);
ADDRGP4 $104
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8212
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8212
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 136
;136:	if(!file)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $105
line 137
;137:		return qfalse; //maps/MAPNAME.bsp does not exist
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $105
line 138
;138:	trap_FS_FCloseFile(file);
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 141
;139:
;140:	//Now read the file votemaps.cfg to see what maps are allowed
;141:	trap_FS_FOpenFile(g_votemaps.string,&file,FS_READ);
ADDRGP4 g_votemaps+16
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 143
;142:
;143:	if(!file)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $108
line 144
;144:		return qtrue; //if no file, everything is allowed
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
LABELV $108
line 145
;145:	length = strlen(mapname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8216
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 8216
INDIRI4
ASGNI4
line 146
;146:	if(length>MAX_MAPNAME_LENGTH-3)
ADDRLP4 16
INDIRI4
CNSTI4 31
LEI4 $110
line 147
;147:	{
line 149
;148:		//Error: too long
;149:		trap_FS_FCloseFile(file);
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 150
;150:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $110
line 154
;151:	}
;152:
;153:	//Add file checking here
;154:	trap_FS_Read(&buffer,MAX_MAPS_TEXT,file);
ADDRLP4 20
ARGP4
CNSTI4 8192
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 155
;155:	found = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 156
;156:	pointer = buffer;
ADDRLP4 8
ADDRLP4 20
ASGNP4
line 157
;157:	token = COM_Parse(&pointer);
ADDRLP4 8
ARGP4
ADDRLP4 8220
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8220
INDIRP4
ASGNP4
ADDRGP4 $113
JUMPV
LABELV $112
line 158
;158:	while(token[0]!=0 && !found) {
line 159
;159:		if(Q_strequal(token,mapname))
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8224
INDIRI4
CNSTI4 0
NEI4 $115
line 160
;160:			found = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $115
line 161
;161:		token = COM_Parse(&pointer);
ADDRLP4 8
ARGP4
ADDRLP4 8228
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8228
INDIRP4
ASGNP4
line 162
;162:	}
LABELV $113
line 158
ADDRLP4 8224
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 8224
INDIRI4
EQI4 $117
ADDRLP4 4
INDIRI4
ADDRLP4 8224
INDIRI4
EQI4 $112
LABELV $117
line 164
;163:
;164:	trap_FS_FCloseFile(file);
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 166
;165:	//The map was not found
;166:	return found;
ADDRLP4 4
INDIRI4
RETI4
LABELV $103
endproc allowedMap 8232 12
export allowedGametype
proc allowedGametype 280 12
line 175
;167:}
;168:
;169:/*
;170:==================
;171:allowedGametype
;172:==================
;173: */
;174:#define MAX_GAMETYPENAME_LENGTH 5 //currently the longest string is "/12/\0" (5 chars)
;175:int allowedGametype(const char *gametypeStr) {
line 179
;176:	char tempStr[MAX_GAMETYPENAME_LENGTH];
;177:	int length;
;178:	char voteGametypes[MAX_CVAR_VALUE_STRING];
;179:	trap_Cvar_VariableStringBuffer( "g_voteGametypes", voteGametypes, sizeof( voteGametypes ) );
ADDRGP4 $119
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 180
;180:	if(Q_strequal(voteGametypes, "*" ))
ADDRLP4 12
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 268
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $120
line 181
;181:		return qtrue; //if star, everything is allowed
CNSTI4 1
RETI4
ADDRGP4 $118
JUMPV
LABELV $120
line 182
;182:	length = strlen(gametypeStr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 272
INDIRI4
ASGNI4
line 183
;183:	if(length>MAX_GAMETYPENAME_LENGTH-3)
ADDRLP4 8
INDIRI4
CNSTI4 2
LEI4 $122
line 184
;184:	{
line 186
;185:		//Error: too long
;186:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $122
line 188
;187:	}
;188:	tempStr[0] = '/';
ADDRLP4 0
CNSTI1 47
ASGNI1
line 189
;189:	strncpy(&tempStr[1],gametypeStr,length);
ADDRLP4 0+1
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 190
;190:	tempStr[length+1] = '/';
ADDRLP4 8
INDIRI4
ADDRLP4 0+1
ADDP4
CNSTI1 47
ASGNI1
line 191
;191:	tempStr[length+2] = '\0';
ADDRLP4 8
INDIRI4
ADDRLP4 0+2
ADDP4
CNSTI1 0
ASGNI1
line 192
;192:	if(Q_stristr(voteGametypes,tempStr) != NULL)
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 Q_stristr
CALLP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $127
line 193
;193:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $118
JUMPV
LABELV $127
line 194
;194:	else {
line 195
;195:		return qfalse;
CNSTI4 0
RETI4
LABELV $118
endproc allowedGametype 280 12
export allowedTimelimit
proc allowedTimelimit 20 0
line 204
;196:	}
;197:}
;198:
;199:/*
;200:==================
;201:allowedTimelimit
;202:==================
;203: */
;204:int allowedTimelimit(int limit) {
line 206
;205:	int min, max;
;206:	min = g_voteMinTimelimit.integer;
ADDRLP4 4
ADDRGP4 g_voteMinTimelimit+12
INDIRI4
ASGNI4
line 207
;207:	max = g_voteMaxTimelimit.integer;
ADDRLP4 0
ADDRGP4 g_voteMaxTimelimit+12
INDIRI4
ASGNI4
line 208
;208:	if(limit<min && limit != 0)
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $132
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $132
line 209
;209:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $132
line 210
;210:	if(max!=0 && limit>max)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $134
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $134
line 211
;211:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $134
line 212
;212:	if(limit==0 && max > 0)
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $136
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $136
line 213
;213:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $129
JUMPV
LABELV $136
line 214
;214:	return qtrue;
CNSTI4 1
RETI4
LABELV $129
endproc allowedTimelimit 20 0
export allowedFraglimit
proc allowedFraglimit 20 0
line 222
;215:}
;216:
;217:/*
;218:==================
;219:allowedFraglimit
;220:==================
;221: */
;222:int allowedFraglimit(int limit) {
line 224
;223:	int min, max;
;224:	min = g_voteMinFraglimit.integer;
ADDRLP4 4
ADDRGP4 g_voteMinFraglimit+12
INDIRI4
ASGNI4
line 225
;225:	max = g_voteMaxFraglimit.integer;
ADDRLP4 0
ADDRGP4 g_voteMaxFraglimit+12
INDIRI4
ASGNI4
line 226
;226:	if(limit<min && limit != 0)
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $141
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $141
line 227
;227:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $141
line 228
;228:	if(max != 0 && limit>max)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $143
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $143
line 229
;229:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $143
line 230
;230:	if(limit==0 && max > 0)
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $145
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $145
line 231
;231:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $138
JUMPV
LABELV $145
line 232
;232:	return qtrue;
CNSTI4 1
RETI4
LABELV $138
endproc allowedFraglimit 20 0
export VoteParseCustomVotes
proc VoteParseCustomVotes 4128 12
line 246
;233:}
;234:
;235:#define MAX_CUSTOM_VOTES    12
;236:
;237:char            custom_vote_info[1024];
;238:
;239:/*
;240:==================
;241:VoteParseCustomVotes
;242: *Reads the file votecustom.cfg. Finds all the commands that can be used with
;243: *"/callvote custom COMMAND" and adds the commands to custom_vote_info
;244:==================
;245: */
;246:int VoteParseCustomVotes( void ) {
line 252
;247:	fileHandle_t	file;
;248:	char            buffer[4*1024];
;249:	int             commands;
;250:	char	*token,*pointer;
;251:
;252:	trap_FS_FOpenFile(g_votecustom.string,&file,FS_READ);
ADDRGP4 g_votecustom+16
ARGP4
ADDRLP4 4108
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 254
;253:
;254:	if(!file)
ADDRLP4 4108
INDIRI4
CNSTI4 0
NEI4 $149
line 255
;255:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $147
JUMPV
LABELV $149
line 257
;256:
;257:	memset(&buffer,0,sizeof(buffer));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4096
ARGI4
ADDRGP4 memset
CALLP4
pop
line 258
;258:	memset(&custom_vote_info,0,sizeof(custom_vote_info));
ADDRGP4 custom_vote_info
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 260
;259:
;260:	commands = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 262
;261:
;262:	trap_FS_Read(&buffer,sizeof(buffer),file);
ADDRLP4 12
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4108
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 264
;263:
;264:	pointer = buffer;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $152
JUMPV
LABELV $151
line 266
;265:
;266:	while ( commands < MAX_CUSTOM_VOTES ) {
line 267
;267:	token = COM_Parse( &pointer );
ADDRLP4 8
ARGP4
ADDRLP4 4112
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4112
INDIRP4
ASGNP4
line 268
;268:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $154
line 269
;269:			break;
ADDRGP4 $153
JUMPV
LABELV $154
line 272
;270:	}
;271:
;272:		if ( strequals( token, "votecommand" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 4116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $156
line 273
;273:			token = COM_Parse( &pointer );
ADDRLP4 8
ARGP4
ADDRLP4 4120
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4120
INDIRP4
ASGNP4
line 274
;274:			Q_strcat(custom_vote_info,sizeof(custom_vote_info),va("%s ",token));
ADDRGP4 $159
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 custom_vote_info
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4124
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 275
;275:			commands++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 276
;276:	}
LABELV $156
line 277
;277:	}
LABELV $152
line 266
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $151
LABELV $153
line 279
;278:
;279:	trap_FS_FCloseFile(file);
ADDRLP4 4108
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 281
;280:
;281:	return commands;
ADDRLP4 4
INDIRI4
RETI4
LABELV $147
endproc VoteParseCustomVotes 4128 12
export getCustomVote
proc getCustomVote 5348 12
line 289
;282:}
;283:/*
;284:==================
;285:getCustomVote
;286: *Returns a custom vote. This will go beyond MAX_CUSTOM_VOTES.
;287:==================
;288: */
;289:t_customvote getCustomVote(char* votecommand) {
line 296
;290:	t_customvote result;
;291:	fileHandle_t	file;
;292:	char            buffer[4*1024];
;293:	char	*token,*pointer;
;294:	char	key[MAX_TOKEN_CHARS];
;295:
;296:	trap_FS_FOpenFile(g_votecustom.string,&file,FS_READ);
ADDRGP4 g_votecustom+16
ARGP4
ADDRLP4 5312
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 298
;297:
;298:	if(!file) {
ADDRLP4 5312
INDIRI4
CNSTI4 0
NEI4 $163
line 299
;299:		memset(&result,0,sizeof(result));
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 184
ARGI4
ADDRGP4 memset
CALLP4
pop
line 300
;300:		return result;
ADDRFP4 0
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 184
ADDRGP4 $160
JUMPV
LABELV $163
line 303
;301:	}
;302:
;303:	memset(&buffer,0,sizeof(buffer));
ADDRLP4 1216
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4096
ARGI4
ADDRGP4 memset
CALLP4
pop
line 305
;304:
;305:	trap_FS_Read(&buffer,sizeof(buffer),file);
ADDRLP4 1216
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 5312
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 307
;306:
;307:	trap_FS_FCloseFile(file);
ADDRLP4 5312
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 309
;308:
;309:	pointer = buffer;
ADDRLP4 1212
ADDRLP4 1216
ASGNP4
ADDRGP4 $166
JUMPV
LABELV $165
line 311
;310:
;311:	while ( qtrue ) {
line 312
;312:		token = COM_Parse( &pointer );
ADDRLP4 1212
ARGP4
ADDRLP4 5316
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 5316
INDIRP4
ASGNP4
line 313
;313:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $168
line 314
;314:				break;
ADDRGP4 $167
JUMPV
LABELV $168
line 317
;315:		}
;316:
;317:		if ( !strequals( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $172
ARGP4
ADDRLP4 5320
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 5320
INDIRI4
CNSTI4 0
EQI4 $170
line 318
;318:			Com_Printf( "Missing { in votecustom.cfg\n" );
ADDRGP4 $173
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 319
;319:			break;
ADDRGP4 $167
JUMPV
LABELV $170
line 322
;320:		}
;321:
;322:		memset(&result,0,sizeof(result));
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 184
ARGI4
ADDRGP4 memset
CALLP4
pop
ADDRGP4 $175
JUMPV
LABELV $174
line 324
;323:
;324:		while ( 1 ) {
line 325
;325:			token = COM_ParseExt( &pointer, qtrue );
ADDRLP4 1212
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 5324
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 5324
INDIRP4
ASGNP4
line 326
;326:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $177
line 327
;327:					Com_Printf( "Unexpected end of customvote.cfg\n" );
ADDRGP4 $179
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 328
;328:					break;
ADDRGP4 $176
JUMPV
LABELV $177
line 330
;329:			}
;330:			if ( strequals( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $182
ARGP4
ADDRLP4 5328
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 5328
INDIRI4
CNSTI4 0
NEI4 $180
line 331
;331:				break;
ADDRGP4 $176
JUMPV
LABELV $180
line 333
;332:			}
;333:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 335
;334:
;335:			token = COM_ParseExt( &pointer, qfalse );
ADDRLP4 1212
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 5332
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 5332
INDIRP4
ASGNP4
line 336
;336:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $183
line 337
;337:				Com_Printf("Invalid/missing argument to %s in customvote.cfg\n",key);
ADDRGP4 $185
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 338
;338:			}
LABELV $183
line 339
;339:			if(Q_strequal(key,"votecommand")) {
ADDRLP4 4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 5336
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5336
INDIRI4
CNSTI4 0
NEI4 $186
line 340
;340:				Q_strncpyz(result.votename,token,sizeof(result.votename));
ADDRLP4 1028
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 341
;341:			} else if(Q_strequal(key,"displayname")) {
ADDRGP4 $187
JUMPV
LABELV $186
ADDRLP4 4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 5340
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5340
INDIRI4
CNSTI4 0
NEI4 $188
line 342
;342:				Q_strncpyz(result.displayname,token,sizeof(result.displayname));
ADDRLP4 1028+32
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 343
;343:			} else if(Q_strequal(key,"command")) {
ADDRGP4 $189
JUMPV
LABELV $188
ADDRLP4 4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 5344
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5344
INDIRI4
CNSTI4 0
NEI4 $193
line 344
;344:				Q_strncpyz(result.command,token,sizeof(result.command));
ADDRLP4 1028+82
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 345
;345:			} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 346
;346:				Com_Printf("Unknown key in customvote.cfg: %s\n",key);
ADDRGP4 $198
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 347
;347:			}
LABELV $194
LABELV $189
LABELV $187
line 348
;348:		}
LABELV $175
line 324
ADDRGP4 $174
JUMPV
LABELV $176
line 350
;349:
;350:		if(Q_strequal(result.votename,votecommand)) {
ADDRLP4 1028
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5324
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5324
INDIRI4
CNSTI4 0
NEI4 $199
line 351
;351:			return result;
ADDRFP4 0
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 184
ADDRGP4 $160
JUMPV
LABELV $199
line 353
;352:		}
;353:	}
LABELV $166
line 311
ADDRGP4 $165
JUMPV
LABELV $167
line 356
;354:
;355:	//Nothing was found
;356:	memset(&result,0,sizeof(result));
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 184
ARGI4
ADDRGP4 memset
CALLP4
pop
line 357
;357:	return result;
ADDRFP4 0
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 184
LABELV $160
endproc getCustomVote 5348 12
bss
align 1
LABELV $202
skip 1024
export whiteListedStr
code
proc whiteListedStr 36 12
line 360
;358:}
;359:
;360:const char* whiteListedStr(const char* str) {
line 362
;361:	static char buffer[1024];
;362:	int sourceIndex = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 363
;363:	int destIndex = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 364
;364:	int sourceLength = strlen(str);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 365
;365:	memset(&buffer, 0, sizeof(buffer));
ADDRGP4 $202
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 366
;366:	for (; sourceIndex < sourceLength && destIndex < sizeof(buffer); ++sourceIndex) {
ADDRGP4 $206
JUMPV
LABELV $203
line 367
;367:		char a = str[sourceIndex];
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 368
;368:		if ( (a >= 'a' && a <= 'z') || (a >= 'A' && a <= 'Z') || (a >= '0' && a <= '9') || a == ' ' || a == '?' ) {
ADDRLP4 20
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 97
LTI4 $210
ADDRLP4 20
INDIRI4
CNSTI4 122
LEI4 $215
LABELV $210
ADDRLP4 24
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 65
LTI4 $212
ADDRLP4 24
INDIRI4
CNSTI4 90
LEI4 $215
LABELV $212
ADDRLP4 28
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 48
LTI4 $214
ADDRLP4 28
INDIRI4
CNSTI4 57
LEI4 $215
LABELV $214
ADDRLP4 32
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 32
EQI4 $215
ADDRLP4 32
INDIRI4
CNSTI4 63
NEI4 $207
LABELV $215
line 369
;369:			buffer[destIndex] = a;
ADDRLP4 4
INDIRI4
ADDRGP4 $202
ADDP4
ADDRLP4 16
INDIRI1
ASGNI1
line 370
;370:			++destIndex;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 371
;371:		}
LABELV $207
line 372
;372:	}
LABELV $204
line 366
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $206
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $216
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 1024
LTU4 $203
LABELV $216
line 373
;373:	buffer[sizeof(buffer)-1] = 0;
ADDRGP4 $202+1023
CNSTI1 0
ASGNI1
line 374
;374:	return buffer;
ADDRGP4 $202
RETP4
LABELV $201
endproc whiteListedStr 36 12
export CheckVote
proc CheckVote 8 8
line 382
;375:}
;376:
;377:/*
;378:==================
;379:CheckVote
;380:==================
;381:*/
;382:void CheckVote( void ) {
line 383
;383:	if ( level.voteExecuteTime && level.voteExecuteTime < level.time ) {
ADDRGP4 level+2408
INDIRI4
CNSTI4 0
EQI4 $219
ADDRGP4 level+2408
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $219
line 384
;384:		level.voteExecuteTime = 0;
ADDRGP4 level+2408
CNSTI4 0
ASGNI4
line 385
;385:		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
ADDRGP4 $225
ARGP4
ADDRGP4 level+356
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
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 386
;386:	}
LABELV $219
line 387
;387:	if ( !level.voteTime ) {
ADDRGP4 level+2404
INDIRI4
CNSTI4 0
NEI4 $227
line 388
;388:		return;
ADDRGP4 $218
JUMPV
LABELV $227
line 390
;389:	}
;390:	if ( level.time - level.voteTime >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+2404
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $230
line 391
;391:		if(g_dmflags.integer & DF_LIGHT_VOTING) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $234
line 393
;392:			//Let pass if there was at least twice as many for as against
;393:			if ( level.voteYes > level.voteNo*2 ) {
ADDRGP4 level+2412
INDIRI4
ADDRGP4 level+2416
INDIRI4
CNSTI4 1
LSHI4
LEI4 $237
line 394
;394:				trap_SendServerCommand( -1, va("print \"Vote passed. At least 2 of 3 voted yes (%s)\n\"", whiteListedStr(level.voteDisplayString)) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $241
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 395
;395:				level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+2408
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 396
;396:			} else {
ADDRGP4 $231
JUMPV
LABELV $237
line 398
;397:				//Let pass if there is more yes than no and at least 2 yes votes and at least 30% yes of all on the server
;398:				if ( level.voteYes > level.voteNo && level.voteYes >= 2 && (level.voteYes*10)>(level.numVotingClients*3) ) {
ADDRGP4 level+2412
INDIRI4
ADDRGP4 level+2416
INDIRI4
LEI4 $245
ADDRGP4 level+2412
INDIRI4
CNSTI4 2
LTI4 $245
CNSTI4 10
ADDRGP4 level+2412
INDIRI4
MULI4
CNSTI4 3
ADDRGP4 level+2420
INDIRI4
MULI4
LEI4 $245
line 399
;399:					trap_SendServerCommand( -1, va("print \"Vote passed. More yes than no. (%s)\n\"", whiteListedStr(level.voteDisplayString)) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $252
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 400
;400:					level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+2408
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 401
;401:				} else {
ADDRGP4 $231
JUMPV
LABELV $245
line 402
;402:					trap_SendServerCommand( -1, va("print \"Vote failed. (%s)\n\"", whiteListedStr(level.voteDisplayString)) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $256
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 403
;403:				}
line 404
;404:			}
line 405
;405:		} else {
ADDRGP4 $231
JUMPV
LABELV $234
line 406
;406:			trap_SendServerCommand( -1, va("print \"Vote failed. (%s)\n\"", whiteListedStr(level.voteDisplayString)) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $256
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 407
;407:		}
line 408
;408:	} else {
ADDRGP4 $231
JUMPV
LABELV $230
line 410
;409:		// ATVI Q3 1.32 Patch #9, WNF
;410:		if ( level.voteYes > (level.numVotingClients)/2 ) {
ADDRGP4 level+2412
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LEI4 $259
line 412
;411:			// execute the command, then remove the vote
;412:			trap_SendServerCommand( -1, va ("print \"Vote passed. (%s)\n\"", whiteListedStr(level.voteDisplayString)) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $263
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 413
;413:			level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+2408
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 414
;414:		} else if ( level.voteNo >= (level.numVotingClients)/2 ) {
ADDRGP4 $260
JUMPV
LABELV $259
ADDRGP4 level+2416
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LTI4 $218
line 416
;415:			// same behavior as a timeout
;416:			trap_SendServerCommand( -1, va("print \"Vote failed. (%s)\n\"", whiteListedStr(level.voteDisplayString) ) );
ADDRGP4 level+1380
ARGP4
ADDRLP4 0
ADDRGP4 whiteListedStr
CALLP4
ASGNP4
ADDRGP4 $256
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 417
;417:		} else {
line 419
;418:			// still waiting for a majority
;419:			return;
LABELV $268
LABELV $260
line 421
;420:		}
;421:	}
LABELV $231
line 422
;422:	level.voteTime = 0;
ADDRGP4 level+2404
CNSTI4 0
ASGNI4
line 423
;423:	trap_SetConfigstring( CS_VOTE_TIME, "" );
CNSTI4 8
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 425
;424:
;425:}
LABELV $218
endproc CheckVote 8 8
export ForceFail
proc ForceFail 0 8
line 427
;426:
;427:void ForceFail( void ) {
line 428
;428:	level.voteTime = 0;
ADDRGP4 level+2404
CNSTI4 0
ASGNI4
line 429
;429:	level.voteExecuteTime = 0;
ADDRGP4 level+2408
CNSTI4 0
ASGNI4
line 430
;430:	level.voteString[0] = 0;
ADDRGP4 level+356
CNSTI1 0
ASGNI1
line 431
;431:	level.voteDisplayString[0] = 0;
ADDRGP4 level+1380
CNSTI1 0
ASGNI1
line 432
;432:	level.voteKickClient = -1;
ADDRGP4 level+2424
CNSTI4 -1
ASGNI4
line 433
;433:	level.voteKickType = 0;
ADDRGP4 level+2428
CNSTI4 0
ASGNI4
line 434
;434:	trap_SetConfigstring( CS_VOTE_TIME, "" );
CNSTI4 8
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 435
;435:	trap_SetConfigstring( CS_VOTE_STRING, "" );	
CNSTI4 9
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 436
;436:	trap_SetConfigstring( CS_VOTE_YES, "" );
CNSTI4 10
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 437
;437:	trap_SetConfigstring( CS_VOTE_NO, "" );
CNSTI4 11
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 438
;438:}
LABELV $274
endproc ForceFail 0 8
export CountVotes
proc CountVotes 16 8
line 448
;439:
;440:
;441:/*
;442:==================
;443:CountVotes
;444:
;445: Iterates through all the clients and counts the votes
;446:==================
;447:*/
;448:void CountVotes( void ) {
line 450
;449:	int i;
;450:	int yes=0,no=0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 452
;451:
;452:	level.numVotingClients=0;
ADDRGP4 level+2420
CNSTI4 0
ASGNI4
line 454
;453:
;454:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $286
JUMPV
LABELV $283
line 455
;455:		if ( level.clients[ i ].pers.connected != CON_CONNECTED ) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $288
line 456
;456:			continue; //Client was not connected
ADDRGP4 $284
JUMPV
LABELV $288
line 459
;457:		}
;458:
;459:		if (level.clients[i].sess.sessionTeam == TEAM_SPECTATOR) {
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1024
ADDP4
INDIRI4
CNSTI4 3
NEI4 $290
line 460
;460:			continue; //Don't count spectators
ADDRGP4 $284
JUMPV
LABELV $290
line 463
;461:		}
;462:
;463:		if ( g_entities[i].r.svFlags & SVF_BOT )
CNSTI4 816
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $292
line 464
;464:			continue; //Is a bot
ADDRGP4 $284
JUMPV
LABELV $292
line 467
;465:
;466:		//The client can vote
;467:		level.numVotingClients++;
ADDRLP4 12
ADDRGP4 level+2420
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 470
;468:
;469:		//Did the client vote yes?
;470:		if(level.clients[i].vote>0)
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1252
ADDP4
INDIRI4
CNSTI4 0
LEI4 $297
line 471
;471:			yes++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
line 474
;472:
;473:		//Did the client vote no?
;474:		if(level.clients[i].vote<0)
CNSTI4 2116
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1252
ADDP4
INDIRI4
CNSTI4 0
GEI4 $299
line 475
;475:			no++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $299
line 476
;476:	}
LABELV $284
line 454
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $286
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $283
line 479
;477:
;478:	//See if anything has changed
;479:	if(level.voteYes != yes) {
ADDRGP4 level+2412
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $301
line 480
;480:		level.voteYes = yes;
ADDRGP4 level+2412
ADDRLP4 4
INDIRI4
ASGNI4
line 481
;481:		trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
ADDRGP4 $305
ARGP4
ADDRGP4 level+2412
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 482
;482:	}
LABELV $301
line 484
;483:
;484:	if(level.voteNo != no) {
ADDRGP4 level+2416
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $307
line 485
;485:		level.voteNo = no;
ADDRGP4 level+2416
ADDRLP4 8
INDIRI4
ASGNI4
line 486
;486:		trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );
ADDRGP4 $305
ARGP4
ADDRGP4 level+2416
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 487
;487:	}
LABELV $307
line 488
;488:}
LABELV $281
endproc CountVotes 16 8
export ClientLeaving
proc ClientLeaving 0 0
line 490
;489:
;490:void ClientLeaving(int clientNumber) {
line 491
;491:	if(clientNumber == level.voteKickClient) {
ADDRFP4 0
INDIRI4
ADDRGP4 level+2424
INDIRI4
NEI4 $313
line 492
;492:		ForceFail();
ADDRGP4 ForceFail
CALLV
pop
line 493
;493:	}
LABELV $313
line 494
;494:}
LABELV $312
endproc ClientLeaving 0 0
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
bss
export custom_vote_info
align 1
LABELV custom_vote_info
skip 1024
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
LABELV $305
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $273
byte 1 0
align 1
LABELV $263
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $256
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $252
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 77
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 110
byte 1 111
byte 1 46
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $241
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 65
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 50
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 51
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $225
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $198
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $190
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $185
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 114
byte 1 103
byte 1 117
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $182
byte 1 125
byte 1 0
align 1
LABELV $179
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 123
byte 1 0
align 1
LABELV $159
byte 1 37
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $158
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $119
byte 1 103
byte 1 95
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $104
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $93
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $92
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $64
byte 1 42
byte 1 0
align 1
LABELV $61
byte 1 103
byte 1 95
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
