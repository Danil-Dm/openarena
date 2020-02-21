data
export remapCount
align 4
LABELV remapCount
byte 4 0
export AddRemap
code
proc AddRemap 8 8
file "../../../code/game/g_utils.c"
line 39
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
;23:// g_utils.c -- misc utility functions for game module
;24:
;25:#include "g_local.h"
;26:
;27:typedef struct {
;28:	char oldShader[MAX_QPATH];
;29:	char newShader[MAX_QPATH];
;30:	float timeOffset;
;31:} shaderRemap_t;
;32:
;33:#define MAX_SHADER_REMAPS 128
;34:
;35:int remapCount = 0;
;36:shaderRemap_t remappedShaders[MAX_SHADER_REMAPS];
;37:
;38:void AddRemap(const char *oldShader, const char *newShader, float timeOffset)
;39:{
line 42
;40:	int i;
;41:
;42:	for (i = 0; i < remapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $65
JUMPV
LABELV $62
line 43
;43:		if ( Q_strequal(oldShader, remappedShaders[i].oldShader) ) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $66
line 45
;44:			// found it, just update this one
;45:			strcpy(remappedShaders[i].newShader,newShader);
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 46
;46:			remappedShaders[i].timeOffset = timeOffset;
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 remappedShaders+128
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 47
;47:			return;
ADDRGP4 $61
JUMPV
LABELV $66
line 49
;48:		}
;49:	}
LABELV $63
line 42
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $65
ADDRLP4 0
INDIRI4
ADDRGP4 remapCount
INDIRI4
LTI4 $62
line 50
;50:	if (remapCount < MAX_SHADER_REMAPS) {
ADDRGP4 remapCount
INDIRI4
CNSTI4 128
GEI4 $70
line 51
;51:		strcpy(remappedShaders[remapCount].newShader,newShader);
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 52
;52:		strcpy(remappedShaders[remapCount].oldShader,oldShader);
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 53
;53:		remappedShaders[remapCount].timeOffset = timeOffset;
CNSTI4 132
ADDRGP4 remapCount
INDIRI4
MULI4
ADDRGP4 remappedShaders+128
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 54
;54:		remapCount++;
ADDRLP4 4
ADDRGP4 remapCount
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 55
;55:	}
LABELV $70
line 56
;56:}
LABELV $61
endproc AddRemap 8 8
bss
align 1
LABELV $75
skip 4096
export BuildShaderStateConfig
code
proc BuildShaderStateConfig 144 24
line 59
;57:
;58:const char *BuildShaderStateConfig(void)
;59:{
line 64
;60:	static char	buff[MAX_STRING_CHARS*4];
;61:	char out[(MAX_QPATH * 2) + 5];
;62:	int i;
;63:
;64:	memset(buff, 0, MAX_STRING_CHARS);
ADDRGP4 $75
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 65
;65:	for (i = 0; i < remapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $79
JUMPV
LABELV $76
line 66
;66:		Com_sprintf(out, (MAX_QPATH * 2) + 5, "%s=%s:%5.2f@", remappedShaders[i].oldShader, remappedShaders[i].newShader, remappedShaders[i].timeOffset);
ADDRLP4 4
ARGP4
CNSTI4 133
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 140
CNSTI4 132
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders
ADDP4
ARGP4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders+64
ADDP4
ARGP4
ADDRLP4 140
INDIRI4
ADDRGP4 remappedShaders+128
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 67
;67:		Q_strcat( buff, sizeof( buff ), out);
ADDRGP4 $75
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 68
;68:	}
LABELV $77
line 65
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $79
ADDRLP4 0
INDIRI4
ADDRGP4 remapCount
INDIRI4
LTI4 $76
line 69
;69:	return buff;
ADDRGP4 $75
RETP4
LABELV $74
endproc BuildShaderStateConfig 144 24
export G_FindConfigstringIndex
proc G_FindConfigstringIndex 1036 12
line 87
;70:}
;71:
;72:/*
;73:=========================================================================
;74:
;75:model / sound configstring indexes
;76:
;77:=========================================================================
;78:*/
;79:
;80:/*
;81:================
;82:G_FindConfigstringIndex
;83:
;84:================
;85:*/
;86:int G_FindConfigstringIndex( char *name, int start, int max, qboolean create )
;87:{
line 91
;88:	int		i;
;89:	char	s[MAX_STRING_CHARS];
;90:
;91:	if ( !name || !name[0] ) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $86
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $84
LABELV $86
line 92
;92:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $83
JUMPV
LABELV $84
line 95
;93:	}
;94:
;95:	for ( i=1 ; i<max ; i++ ) {
ADDRLP4 1024
CNSTI4 1
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $87
line 96
;96:		trap_GetConfigstring( start + i, s, sizeof( s ) );
ADDRFP4 4
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 97
;97:		if ( !s[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $91
line 98
;98:			break;
ADDRGP4 $89
JUMPV
LABELV $91
line 100
;99:		}
;100:		if ( strequals( s, name ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $93
line 101
;101:			return i;
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $83
JUMPV
LABELV $93
line 103
;102:		}
;103:	}
LABELV $88
line 95
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $90
ADDRLP4 1024
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $87
LABELV $89
line 105
;104:
;105:	if ( !create ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $95
line 106
;106:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $83
JUMPV
LABELV $95
line 109
;107:	}
;108:
;109:	if ( i == max ) {
ADDRLP4 1024
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $97
line 110
;110:		G_Error( "G_FindConfigstringIndex: overflow" );
ADDRGP4 $99
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 111
;111:	}
LABELV $97
line 113
;112:
;113:	trap_SetConfigstring( start + i, name );
ADDRFP4 4
INDIRI4
ADDRLP4 1024
INDIRI4
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 115
;114:
;115:	return i;
ADDRLP4 1024
INDIRI4
RETI4
LABELV $83
endproc G_FindConfigstringIndex 1036 12
export G_ModelIndex
proc G_ModelIndex 4 16
line 120
;116:}
;117:
;118:
;119:int G_ModelIndex( char *name )
;120:{
line 121
;121:	return G_FindConfigstringIndex (name, CS_MODELS, MAX_MODELS, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
CNSTI4 256
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 G_FindConfigstringIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $100
endproc G_ModelIndex 4 16
export G_SoundIndex
proc G_SoundIndex 4 16
line 125
;122:}
;123:
;124:int G_SoundIndex( char *name )
;125:{
line 126
;126:	return G_FindConfigstringIndex (name, CS_SOUNDS, MAX_SOUNDS, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 288
ARGI4
CNSTI4 256
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 G_FindConfigstringIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $101
endproc G_SoundIndex 4 16
export G_TeamCommand
proc G_TeamCommand 8 8
line 140
;127:}
;128:
;129://=====================================================================
;130:
;131:
;132:/*
;133:================
;134:G_TeamCommand
;135:
;136:Broadcasts a command to only a specific team
;137:================
;138:*/
;139:void G_TeamCommand( team_t team, char *cmd )
;140:{
line 143
;141:	int		i;
;142:
;143:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $103
line 144
;144:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
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
NEI4 $108
line 145
;145:			if ( level.clients[i].sess.sessionTeam == team ) {
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
ADDRFP4 0
INDIRI4
NEI4 $110
line 146
;146:				trap_SendServerCommand( i, va("%s", cmd ));
ADDRGP4 $112
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 147
;147:			}
LABELV $110
line 148
;148:		}
LABELV $108
line 149
;149:	}
LABELV $104
line 143
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $106
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $103
line 150
;150:}
LABELV $102
endproc G_TeamCommand 8 8
export G_Find
proc G_Find 8 8
line 166
;151:
;152:
;153:/*
;154:=============
;155:G_Find
;156:
;157:Searches all active entities for the next one that holds
;158:the matching string at fieldofs (use the FOFS() macro) in the structure.
;159:
;160:Searches beginning at the entity after from, or the beginning if NULL
;161:NULL will be returned if the end of the list is reached.
;162:
;163:=============
;164:*/
;165:gentity_t *G_Find (gentity_t *from, int fieldofs, const char *match)
;166:{
line 169
;167:	char	*s;
;168:
;169:	if (!from)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $114
line 170
;170:		from = g_entities;
ADDRFP4 0
ADDRGP4 g_entities
ASGNP4
ADDRGP4 $119
JUMPV
LABELV $114
line 172
;171:	else
;172:		from++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
line 174
;173:
;174:	for ( ; from < &g_entities[level.num_entities] ; from++) {
ADDRGP4 $119
JUMPV
LABELV $116
line 175
;175:		if (!from->inuse)
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $121
line 176
;176:			continue;
ADDRGP4 $117
JUMPV
LABELV $121
line 177
;177:		s = *(char **) ((byte *)from + fieldofs);
ADDRLP4 0
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 178
;178:		if (!s)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $123
line 179
;179:			continue;
ADDRGP4 $117
JUMPV
LABELV $123
line 180
;180:		if (Q_strequal (s, match))
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $125
line 181
;181:			return from;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $113
JUMPV
LABELV $125
line 182
;182:	}
LABELV $117
line 174
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $119
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTI4 816
ADDRGP4 level+12
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
LTU4 $116
line 184
;183:
;184:	return NULL;
CNSTP4 0
RETP4
LABELV $113
endproc G_Find 8 8
export G_PickTarget
proc G_PickTarget 144 12
line 198
;185:}
;186:
;187:
;188:/*
;189:=============
;190:G_PickTarget
;191:
;192:Selects a random entity from among the targets
;193:=============
;194:*/
;195:#define MAXCHOICES	32
;196:
;197:gentity_t *G_PickTarget (char *targetname)
;198:{
line 199
;199:	gentity_t	*ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 200
;200:	int		num_choices = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 203
;201:	gentity_t	*choice[MAXCHOICES];
;202:
;203:	if (!targetname) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
line 204
;204:		G_Printf("G_PickTarget called with NULL targetname\n");
ADDRGP4 $130
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 205
;205:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $127
JUMPV
LABELV $131
line 208
;206:	}
;207:
;208:	while(1) {
line 209
;209:		ent = G_Find (ent, FOFS(targetname), targetname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
line 210
;210:		if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $134
line 211
;211:			break;
ADDRGP4 $133
JUMPV
LABELV $134
line 212
;212:		choice[num_choices++] = ent;
ADDRLP4 140
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 213
;213:		if (num_choices == MAXCHOICES)
ADDRLP4 4
INDIRI4
CNSTI4 32
NEI4 $136
line 214
;214:			break;
ADDRGP4 $133
JUMPV
LABELV $136
line 215
;215:	}
LABELV $132
line 208
ADDRGP4 $131
JUMPV
LABELV $133
line 217
;216:
;217:	if (!num_choices) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $138
line 218
;218:		G_Printf("G_PickTarget: target %s not found\n", targetname);
ADDRGP4 $140
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 219
;219:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $127
JUMPV
LABELV $138
line 222
;220:	}
;221:
;222:	return choice[rand() % num_choices];
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
RETP4
LABELV $127
endproc G_PickTarget 144 12
export G_UseTargets
proc G_UseTargets 24 12
line 238
;223:}
;224:
;225:
;226:/*
;227:==============================
;228:G_UseTargets
;229:
;230:"activator" should be set to the entity that initiated the firing.
;231:
;232:Search for (string)targetname in all entities that
;233:match (string)self.target and call their .use function
;234:
;235:==============================
;236:*/
;237:void G_UseTargets( gentity_t *ent, gentity_t *activator )
;238:{
line 241
;239:	gentity_t		*t;
;240:
;241:	if ( !ent ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
line 242
;242:		return;
ADDRGP4 $141
JUMPV
LABELV $142
line 245
;243:	}
;244:
;245:	if (ent->targetShaderName && ent->targetShaderNewName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CNSTI4 660
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $144
ADDRLP4 4
INDIRP4
CNSTI4 664
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $144
line 246
;246:		float f = level.time * 0.001;
ADDRLP4 12
CNSTF4 981668463
ADDRGP4 level+32
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 247
;247:		AddRemap(ent->targetShaderName, ent->targetShaderNewName, f);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 660
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 AddRemap
CALLV
pop
line 248
;248:		trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
ADDRLP4 20
ADDRGP4 BuildShaderStateConfig
CALLP4
ASGNP4
CNSTI4 24
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 249
;249:	}
LABELV $144
line 251
;250:
;251:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $147
line 252
;252:		return;
ADDRGP4 $141
JUMPV
LABELV $147
line 255
;253:	}
;254:
;255:	t = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $150
JUMPV
LABELV $149
line 256
;256:	while ( (t = G_Find (t, FOFS(targetname), ent->target)) != NULL ) {
line 257
;257:		if ( t == ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $152
line 258
;258:			G_Printf ("WARNING: Entity used itself.\n");
ADDRGP4 $154
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 259
;259:		}
ADDRGP4 $153
JUMPV
LABELV $152
line 260
;260:		else {
line 261
;261:			if ( t->use ) {
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $155
line 262
;262:				t->use (t, ent, activator);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 263
;263:			}
LABELV $155
line 264
;264:		}
LABELV $153
line 265
;265:		if ( !ent->inuse ) {
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $157
line 266
;266:			G_Printf("entity was removed while using targets\n");
ADDRGP4 $159
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 267
;267:			return;
ADDRGP4 $141
JUMPV
LABELV $157
line 269
;268:		}
;269:	}
LABELV $150
line 256
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
ADDRLP4 12
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $149
line 270
;270:}
LABELV $141
endproc G_UseTargets 24 12
bss
align 4
LABELV $161
skip 4
align 4
LABELV $162
skip 96
export tv
code
proc tv 8 0
line 282
;271:
;272:
;273:/*
;274:=============
;275:TempVector
;276:
;277:This is just a convenience function
;278:for making temporary vectors for function calls
;279:=============
;280:*/
;281:float	*tv( float x, float y, float z )
;282:{
line 289
;283:	static	int		index;
;284:	static	vec3_t	vecs[8];
;285:	float	*v;
;286:
;287:	// use an array so that multiple tempvectors won't collide
;288:	// for a while
;289:	v = vecs[index];
ADDRLP4 0
CNSTI4 12
ADDRGP4 $161
INDIRI4
MULI4
ADDRGP4 $162
ADDP4
ASGNP4
line 290
;290:	index = (index + 1)&7;
ADDRLP4 4
ADDRGP4 $161
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 7
BANDI4
ASGNI4
line 292
;291:
;292:	v[0] = x;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRF4
ASGNF4
line 293
;293:	v[1] = y;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 294
;294:	v[2] = z;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 296
;295:
;296:	return v;
ADDRLP4 0
INDIRP4
RETP4
LABELV $160
endproc tv 8 0
bss
align 4
LABELV $164
skip 4
align 1
LABELV $165
skip 256
export vtos
code
proc vtos 12 24
line 309
;297:}
;298:
;299:
;300:/*
;301:=============
;302:VectorToString
;303:
;304:This is just a convenience function
;305:for printing vectors
;306:=============
;307:*/
;308:char	*vtos( const vec3_t v )
;309:{
line 315
;310:	static	int		index;
;311:	static	char	str[8][32];
;312:	char	*s;
;313:
;314:	// use an array so that multiple vtos won't collide
;315:	s = str[index];
ADDRLP4 0
ADDRGP4 $164
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 $165
ADDP4
ASGNP4
line 316
;316:	index = (index + 1)&7;
ADDRLP4 4
ADDRGP4 $164
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 7
BANDI4
ASGNI4
line 318
;317:
;318:	Com_sprintf (s, 32, "(%i %i %i)", (int)v[0], (int)v[1], (int)v[2]);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $166
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 320
;319:
;320:	return s;
ADDRLP4 0
INDIRP4
RETP4
LABELV $163
endproc vtos 12 24
data
align 4
LABELV $168
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV $169
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV $170
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV $171
byte 4 0
byte 4 0
byte 4 3212836864
export G_SetMovedir
code
proc G_SetMovedir 16 16
line 335
;321:}
;322:
;323:
;324:/*
;325:===============
;326:G_SetMovedir
;327:
;328:The editor only specifies a single value for angles (yaw),
;329:but we have special constants to generate an up or down direction.
;330:Angles will be cleared, because it is being used to represent a direction
;331:instead of an orientation.
;332:===============
;333:*/
;334:void G_SetMovedir( vec3_t angles, vec3_t movedir )
;335:{
line 341
;336:	static vec3_t VEC_UP		= {0, -1, 0};
;337:	static vec3_t MOVEDIR_UP	= {0, 0, 1};
;338:	static vec3_t VEC_DOWN		= {0, -2, 0};
;339:	static vec3_t MOVEDIR_DOWN	= {0, 0, -1};
;340:
;341:	if ( VectorCompare (angles, VEC_UP) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $168
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $172
line 342
;342:		VectorCopy (MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 $169
INDIRB
ASGNB 12
line 343
;343:	}
ADDRGP4 $173
JUMPV
LABELV $172
line 344
;344:	else if ( VectorCompare (angles, VEC_DOWN) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $174
line 345
;345:		VectorCopy (MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 $171
INDIRB
ASGNB 12
line 346
;346:	}
ADDRGP4 $175
JUMPV
LABELV $174
line 347
;347:	else {
line 348
;348:		AngleVectors (angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 349
;349:	}
LABELV $175
LABELV $173
line 350
;350:	VectorClear( angles );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 351
;351:}
LABELV $167
endproc G_SetMovedir 16 16
export vectoyaw
proc vectoyaw 20 8
line 355
;352:
;353:
;354:float vectoyaw( const vec3_t vec )
;355:{
line 358
;356:	float	yaw;
;357:
;358:	if (vec[YAW] == 0 && vec[PITCH] == 0) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $177
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $177
line 359
;359:		yaw = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 360
;360:	}
ADDRGP4 $178
JUMPV
LABELV $177
line 361
;361:	else {
line 362
;362:		if (vec[PITCH]) {
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 0
EQF4 $179
line 363
;363:			yaw = ( atan2( vec[YAW], vec[PITCH]) * 180 / M_PI );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1127481344
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 364
;364:		}
ADDRGP4 $180
JUMPV
LABELV $179
line 365
;365:		else if (vec[YAW] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 0
LEF4 $181
line 366
;366:			yaw = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 367
;367:		}
ADDRGP4 $182
JUMPV
LABELV $181
line 368
;368:		else {
line 369
;369:			yaw = 270;
ADDRLP4 0
CNSTF4 1132920832
ASGNF4
line 370
;370:		}
LABELV $182
LABELV $180
line 371
;371:		if (yaw < 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $183
line 372
;372:			yaw += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 373
;373:		}
LABELV $183
line 374
;374:	}
LABELV $178
line 376
;375:
;376:	return yaw;
ADDRLP4 0
INDIRF4
RETF4
LABELV $176
endproc vectoyaw 20 8
export G_InitGentity
proc G_InitGentity 4 0
line 381
;377:}
;378:
;379:
;380:void G_InitGentity( gentity_t *e )
;381:{
line 382
;382:	e->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 383
;383:	e->classname = "noclass";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $186
ASGNP4
line 384
;384:	e->s.number = e - g_entities;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 385
;385:	e->r.ownerNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1023
ASGNI4
line 386
;386:}
LABELV $185
endproc G_InitGentity 4 0
export G_Spawn
proc G_Spawn 16 20
line 404
;387:
;388:/*
;389:=================
;390:G_Spawn
;391:
;392:Either finds a free entity, or allocates a new one.
;393:
;394:  The slots from 0 to MAX_CLIENTS-1 are always reserved for clients, and will
;395:never be used by anything else.
;396:
;397:Try to avoid reusing an entity that was recently freed, because it
;398:can cause the client to think the entity morphed into something else
;399:instead of being removed and recreated, which can cause interpolated
;400:angles and bad trails.
;401:=================
;402:*/
;403:gentity_t *G_Spawn( void )
;404:{
line 408
;405:	int			i, force;
;406:	gentity_t	*e;
;407:
;408:	e = NULL;	// shut up warning
ADDRLP4 0
CNSTP4 0
ASGNP4
line 409
;409:	for ( force = 0 ; force < 2 ; force++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $188
line 412
;410:		// if we go through all entities and can't find one to free,
;411:		// override the normal minimum times before use
;412:		e = &g_entities[MAX_CLIENTS];
ADDRLP4 0
ADDRGP4 g_entities+52224
ASGNP4
line 413
;413:		for ( i = MAX_CLIENTS ; i<level.num_entities ; i++, e++) {
ADDRLP4 4
CNSTI4 64
ASGNI4
ADDRGP4 $196
JUMPV
LABELV $193
line 414
;414:			if ( e->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $198
line 415
;415:				continue;
ADDRGP4 $194
JUMPV
LABELV $198
line 420
;416:			}
;417:
;418:			// the first couple seconds of server time can involve a lot of
;419:			// freeing and allocating, so relax the replacement policy
;420:			if ( !force && e->freetime > level.startTime + 2000 && level.time - e->freetime < 1000 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $200
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
LEI4 $200
ADDRGP4 level+32
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 1000
GEI4 $200
line 421
;421:				continue;
ADDRGP4 $194
JUMPV
LABELV $200
line 425
;422:			}
;423:
;424:			// reuse this slot
;425:			G_InitGentity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 426
;426:			return e;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $187
JUMPV
LABELV $194
line 413
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
LABELV $196
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $193
line 428
;427:		}
;428:		if ( level.num_entities < ENTITYNUM_MAX_NORMAL ) {
ADDRGP4 level+12
INDIRI4
CNSTI4 1022
GEI4 $204
line 429
;429:			break;
ADDRGP4 $190
JUMPV
LABELV $204
line 431
;430:		}
;431:	}
LABELV $189
line 409
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $188
LABELV $190
line 432
;432:	if ( level.num_entities == ENTITYNUM_MAX_NORMAL ) {
ADDRGP4 level+12
INDIRI4
CNSTI4 1022
NEI4 $207
line 433
;433:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $210
line 434
;434:			G_Printf("%4i: %s\n", i, g_entities[i].classname);
ADDRGP4 $214
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 816
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 435
;435:		}
LABELV $211
line 433
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $210
line 436
;436:		G_Error( "G_Spawn: no free entities" );
ADDRGP4 $216
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 437
;437:	}
LABELV $207
line 440
;438:
;439:	// open up a new slot
;440:	level.num_entities++;
ADDRLP4 12
ADDRGP4 level+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 443
;441:
;442:	// let the server system know that there are more entities
;443:	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ),
ADDRGP4 level+4
INDIRP4
ARGP4
ADDRGP4 level+12
INDIRI4
ARGI4
CNSTI4 816
ARGI4
ADDRGP4 level
INDIRP4
ARGP4
CNSTI4 2116
ARGI4
ADDRGP4 trap_LocateGameData
CALLV
pop
line 446
;444:	                     &level.clients[0].ps, sizeof( level.clients[0] ) );
;445:
;446:	G_InitGentity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 447
;447:	return e;
ADDRLP4 0
INDIRP4
RETP4
LABELV $187
endproc G_Spawn 16 20
export G_EntitiesFree
proc G_EntitiesFree 8 0
line 456
;448:}
;449:
;450:/*
;451:=================
;452:G_EntitiesFree
;453:=================
;454:*/
;455:qboolean G_EntitiesFree( void )
;456:{
line 460
;457:	int			i;
;458:	gentity_t	*e;
;459:
;460:	if ( level.num_entities < ENTITYNUM_MAX_NORMAL ) {
ADDRGP4 level+12
INDIRI4
CNSTI4 1022
GEI4 $221
line 462
;461:		// can open a new slot if needed
;462:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $220
JUMPV
LABELV $221
line 465
;463:	}
;464:
;465:	e = &g_entities[MAX_CLIENTS];
ADDRLP4 4
ADDRGP4 g_entities+52224
ASGNP4
line 466
;466:	for ( i = MAX_CLIENTS; i < level.num_entities; i++, e++) {
ADDRLP4 0
CNSTI4 64
ASGNI4
ADDRGP4 $228
JUMPV
LABELV $225
line 467
;467:		if ( e->inuse ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $230
line 468
;468:			continue;
ADDRGP4 $226
JUMPV
LABELV $230
line 471
;469:		}
;470:		// slot available
;471:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $220
JUMPV
LABELV $226
line 466
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $228
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $225
line 473
;472:	}
;473:	return qfalse;
CNSTI4 0
RETI4
LABELV $220
endproc G_EntitiesFree 8 0
export G_FreeEntity
proc G_FreeEntity 0 12
line 485
;474:}
;475:
;476:
;477:/*
;478:=================
;479:G_FreeEntity
;480:
;481:Marks the entity as free
;482:=================
;483:*/
;484:void G_FreeEntity( gentity_t *ed )
;485:{
line 486
;486:	trap_UnlinkEntity (ed);		// unlink from world
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 488
;487:
;488:	if ( ed->neverFree ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $233
line 489
;489:		return;
ADDRGP4 $232
JUMPV
LABELV $233
line 492
;490:	}
;491:
;492:	memset (ed, 0, sizeof(*ed));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 816
ARGI4
ADDRGP4 memset
CALLP4
pop
line 493
;493:	ed->classname = "freed";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $235
ASGNP4
line 494
;494:	ed->freetime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 495
;495:	ed->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 496
;496:}
LABELV $232
endproc G_FreeEntity 0 12
export G_TempEntity
proc G_TempEntity 20 8
line 508
;497:
;498:/*
;499:=================
;500:G_TempEntity
;501:
;502:Spawns an event entity that will be auto-removed
;503:The origin will be snapped to save net bandwidth, so care
;504:must be taken if the origin is right on a surface (snap towards start vector first)
;505:=================
;506:*/
;507:gentity_t *G_TempEntity( const vec3_t origin, int event )
;508:{
line 512
;509:	gentity_t		*e;
;510:	vec3_t		snapped;
;511:
;512:	e = G_Spawn();
ADDRLP4 16
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 513
;513:	e->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 515
;514:
;515:	e->classname = "tempEntity";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $238
ASGNP4
line 516
;516:	e->eventTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 517
;517:	e->freeAfterEvent = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 519
;518:
;519:	VectorCopy( origin, snapped );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 520
;520:	SnapVector( snapped );		// save network bandwidth
ADDRLP4 4
ADDRLP4 4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 521
;521:	G_SetOrigin( e, snapped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 524
;522:
;523:	// find cluster for PVS
;524:	trap_LinkEntity( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 526
;525:
;526:	return e;
ADDRLP4 0
INDIRP4
RETP4
LABELV $237
endproc G_TempEntity 20 8
export G_KillBox
proc G_KillBox 4168 32
line 548
;527:}
;528:
;529:
;530:
;531:/*
;532:==============================================================================
;533:
;534:Kill box
;535:
;536:==============================================================================
;537:*/
;538:
;539:/*
;540:=================
;541:G_KillBox
;542:
;543:Kills all entities that would touch the proposed new positioning
;544:of ent.  Ent should be unlinked before calling this!
;545:=================
;546:*/
;547:void G_KillBox (gentity_t *ent)
;548:{
line 554
;549:	int			i, num;
;550:	int			touch[MAX_GENTITIES];
;551:	gentity_t	*hit;
;552:	vec3_t		mins, maxs;
;553:
;554:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4136
ADDRLP4 4132
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4136
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4132
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4136
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4132
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108+8
ADDRLP4 4140
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4140
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 555
;555:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4148
ADDRLP4 4144
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4148
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4144
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4148
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4144
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120+8
ADDRLP4 4152
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4152
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 556
;556:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4156
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4156
INDIRI4
ASGNI4
line 558
;557:
;558:	for (i=0 ; i<num ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $252
JUMPV
LABELV $249
line 559
;559:		hit = &g_entities[touch[i]];
ADDRLP4 4
CNSTI4 816
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 560
;560:		if ( !hit->client ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $253
line 561
;561:			continue;
ADDRGP4 $250
JUMPV
LABELV $253
line 565
;562:		}
;563:
;564:		// nail it
;565:		G_Damage ( hit, ent, ent, NULL, NULL,
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4164
CNSTP4 0
ASGNP4
ADDRLP4 4164
INDIRP4
ARGP4
ADDRLP4 4164
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
line 567
;566:		           100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG);
;567:	}
LABELV $250
line 558
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $252
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $249
line 569
;568:
;569:}
LABELV $244
endproc G_KillBox 4168 32
export G_AddPredictableEvent
proc G_AddPredictableEvent 0 12
line 583
;570:
;571://==============================================================================
;572:
;573:/*
;574:===============
;575:G_AddPredictableEvent
;576:
;577:Use for non-pmove events that would also be predicted on the
;578:client side: jumppads and item pickups
;579:Adds an event+parm and twiddles the event counter
;580:===============
;581:*/
;582:void G_AddPredictableEvent( gentity_t *ent, int event, int eventParm )
;583:{
line 584
;584:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $256
line 585
;585:		return;
ADDRGP4 $255
JUMPV
LABELV $256
line 587
;586:	}
;587:	BG_AddPredictableEventToPlayerstate( event, eventParm, &ent->client->ps );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 588
;588:}
LABELV $255
endproc G_AddPredictableEvent 0 12
export G_AddEvent
proc G_AddEvent 4 8
line 599
;589:
;590:
;591:/*
;592:===============
;593:G_AddEvent
;594:
;595:Adds an event+parm and twiddles the event counter
;596:===============
;597:*/
;598:void G_AddEvent( gentity_t *ent, int event, int eventParm )
;599:{
line 602
;600:	int		bits;
;601:
;602:	if ( !event ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $259
line 603
;603:		G_Printf( "G_AddEvent: zero event added for entity %i\n", ent->s.number );
ADDRGP4 $261
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 604
;604:		return;
ADDRGP4 $258
JUMPV
LABELV $259
line 608
;605:	}
;606:
;607:	// clients need to add the event in playerState_t instead of entityState_t
;608:	if ( ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $262
line 609
;609:		bits = ent->client->ps.externalEvent & EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 768
BANDI4
ASGNI4
line 610
;610:		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
CNSTI4 768
BANDI4
ASGNI4
line 611
;611:		ent->client->ps.externalEvent = event | bits;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 612
;612:		ent->client->ps.externalEventParm = eventParm;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 613
;613:		ent->client->ps.externalEventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 136
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 614
;614:	}
ADDRGP4 $263
JUMPV
LABELV $262
line 615
;615:	else {
line 616
;616:		bits = ent->s.event & EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 768
BANDI4
ASGNI4
line 617
;617:		bits = ( bits + EV_EVENT_BIT1 ) & EV_EVENT_BITS;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
CNSTI4 768
BANDI4
ASGNI4
line 618
;618:		ent->s.event = event | bits;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 619
;619:		ent->s.eventParm = eventParm;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 620
;620:	}
LABELV $263
line 621
;621:	ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 622
;622:}
LABELV $258
endproc G_AddEvent 4 8
export G_Sound
proc G_Sound 8 8
line 631
;623:
;624:
;625:/*
;626:=============
;627:G_Sound
;628:=============
;629:*/
;630:void G_Sound( gentity_t *ent, int channel, int soundIndex )
;631:{
line 634
;632:	gentity_t	*te;
;633:
;634:	te = G_TempEntity( ent->r.currentOrigin, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 635
;635:	te->s.eventParm = soundIndex;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 636
;636:}
LABELV $266
endproc G_Sound 8 8
export G_GlobalSound
proc G_GlobalSound 16 8
line 645
;637:
;638:/*
;639:=============
;640:G_GlobalSound
;641:KK-OAX G_SoundIndex must first be called.
;642:=============
;643:*/
;644:void G_GlobalSound( int soundIndex )
;645:{
line 649
;646:	gentity_t  *te;
;647:	//Let's avoid the S_FindName error if soundIndex is 0.
;648:	//Sago: And let's check that the sound index is within the allowed range.
;649:	if( ( soundIndex <= 0 ) ||  soundIndex >= MAX_SOUNDS ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $270
ADDRLP4 4
INDIRI4
CNSTI4 256
LTI4 $268
LABELV $270
line 650
;650:		if (g_developer.integer){
ADDRGP4 g_developer+12
INDIRI4
CNSTI4 0
EQI4 $267
line 652
;651:			//Display this message when debugging
;652:			G_Printf( "GlobalSound: Error, no soundIndex specified. Check your code!\n" );
ADDRGP4 $274
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 653
;653:		}
line 654
;654:		return;
ADDRGP4 $267
JUMPV
LABELV $268
line 657
;655:	}
;656:	//Spawn a Temporary Entity at the origin point for Intermission with the event EV_GLOBAL_SOUND
;657:	te = G_TempEntity( level.intermission_origin, EV_GLOBAL_SOUND );
ADDRGP4 level+9160
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 659
;658:	//Add the soundIndex to the parameters for the EV_GLOBAL_SOUND event we are calling
;659:	te->s.eventParm = soundIndex;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 661
;660:	//Broadcast the sound event.
;661:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 662
;662:}
LABELV $267
endproc G_GlobalSound 16 8
export G_SetOrigin
proc G_SetOrigin 8 0
line 675
;663:
;664://==============================================================================
;665:
;666:
;667:/*
;668:================
;669:G_SetOrigin
;670:
;671:Sets the pos trajectory for a fixed position
;672:================
;673:*/
;674:void G_SetOrigin( gentity_t *ent, vec3_t origin )
;675:{
line 676
;676:	VectorCopy( origin, ent->s.pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 677
;677:	ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 678
;678:	ent->s.pos.trTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 679
;679:	ent->s.pos.trDuration = 0;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 680
;680:	VectorClear( ent->s.pos.trDelta );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 682
;681:
;682:	VectorCopy( origin, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 683
;683:}
LABELV $276
endproc G_SetOrigin 8 0
lit
align 4
LABELV $278
byte 4 0
byte 4 0
byte 4 1065353216
export DebugLine
code
proc DebugLine 116 12
line 694
;684:
;685:/*
;686:================
;687:DebugLine
;688:
;689:  debug polygons only work when running a local game
;690:  with r_debugSurface set to 2
;691:================
;692:*/
;693:int DebugLine(vec3_t start, vec3_t end, int color)
;694:{
line 695
;695:	vec3_t points[4], dir, cross, up = {0, 0, 1};
ADDRLP4 72
ADDRGP4 $278
INDIRB
ASGNB 12
line 698
;696:	float dot;
;697:
;698:	VectorCopy(start, points[0]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 699
;699:	VectorCopy(start, points[1]);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 701
;700:	//points[1][2] -= 2;
;701:	VectorCopy(end, points[2]);
ADDRLP4 0+24
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 703
;702:	//points[2][2] -= 2;
;703:	VectorCopy(end, points[3]);
ADDRLP4 0+36
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 706
;704:
;705:
;706:	VectorSubtract(end, start, dir);
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 88
INDIRP4
INDIRF4
ADDRLP4 92
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96
CNSTI4 4
ASGNI4
ADDRLP4 60+4
ADDRLP4 88
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 100
CNSTI4 8
ASGNI4
ADDRLP4 60+8
ADDRFP4 4
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 707
;707:	VectorNormalize(dir);
ADDRLP4 60
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 708
;708:	dot = DotProduct(dir, up);
ADDRLP4 84
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
MULF4
ADDF4
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 709
;709:	if (dot > 0.99 || dot < -0.99) VectorSet(cross, 1, 0, 0);
ADDRLP4 84
INDIRF4
CNSTF4 1065185444
GTF4 $290
ADDRLP4 84
INDIRF4
CNSTF4 3212669092
GEF4 $288
LABELV $290
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
ADDRLP4 48+4
CNSTF4 0
ASGNF4
ADDRLP4 48+8
CNSTF4 0
ASGNF4
ADDRGP4 $289
JUMPV
LABELV $288
line 710
;710:	else CrossProduct(dir, up, cross);
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
LABELV $289
line 712
;711:
;712:	VectorNormalize(cross);
ADDRLP4 48
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 714
;713:
;714:	VectorMA(points[0], 2, cross, points[0]);
ADDRLP4 108
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 715
;715:	VectorMA(points[1], -2, cross, points[1]);
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
CNSTF4 3221225472
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+4
ADDRLP4 0+12+4
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+12+8
ADDRLP4 0+12+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 716
;716:	VectorMA(points[2], -2, cross, points[2]);
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 3221225472
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 717
;717:	VectorMA(points[3], 2, cross, points[3]);
ADDRLP4 0+36
ADDRLP4 0+36
INDIRF4
CNSTF4 1073741824
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+36+4
ADDRLP4 0+36+4
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+36+8
ADDRLP4 0+36+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 719
;718:
;719:	return trap_DebugPolygonCreate(color, 4, points);
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 112
ADDRGP4 trap_DebugPolygonCreate
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
RETI4
LABELV $277
endproc DebugLine 116 12
bss
export remappedShaders
align 4
LABELV remappedShaders
skip 16896
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
import G_TouchSolids
import G_TouchTriggers
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
LABELV $274
byte 1 71
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $261
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 69
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $238
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $235
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $216
byte 1 71
byte 1 95
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $214
byte 1 37
byte 1 52
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $166
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 0
align 1
LABELV $159
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $154
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $140
byte 1 71
byte 1 95
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $130
byte 1 71
byte 1 95
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $99
byte 1 71
byte 1 95
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $80
byte 1 37
byte 1 115
byte 1 61
byte 1 37
byte 1 115
byte 1 58
byte 1 37
byte 1 53
byte 1 46
byte 1 50
byte 1 102
byte 1 64
byte 1 0
