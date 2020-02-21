data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
code
proc CG_DrawField 64 20
file "../../../code/cgame/cg_draw.c"
line 205
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
;21: */
;22://
;23:// cg_draw.c -- draw all of the graphical elements during
;24:// active (after loading) gameplay
;25:
;26:#include "cg_local.h"
;27:
;28:#ifdef MISSIONPACK
;29:#include "../ui/ui_shared.h"
;30:
;31:// used for scoreboard
;32:extern displayContextDef_t cgDC;
;33:menuDef_t *menuScoreboard = NULL;
;34:#else
;35:int drawTeamOverlayModificationCount = -1;
;36:#endif
;37:
;38:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;39:int numSortedTeamPlayers;
;40:
;41:char systemChat[256];
;42:char teamChat1[256];
;43:char teamChat2[256];
;44:
;45:#ifdef MISSIONPACK
;46:
;47:int CG_Text_Width(const char *text, float scale, int limit) {
;48:	int count, len;
;49:	float out;
;50:	glyphInfo_t *glyph;
;51:	float useScale;
;52:	const char *s = text;
;53:	fontInfo_t *font = &cgDC.Assets.textFont;
;54:	if (scale <= cg_smallFont.value) {
;55:		font = &cgDC.Assets.smallFont;
;56:	} else if (scale > cg_bigFont.value) {
;57:		font = &cgDC.Assets.bigFont;
;58:	}
;59:	useScale = scale * font->glyphScale;
;60:	out = 0;
;61:	if (text) {
;62:		len = strlen(text);
;63:		if (limit > 0 && len > limit) {
;64:			len = limit;
;65:		}
;66:		count = 0;
;67:		while (s && *s && count < len) {
;68:			if (Q_IsColorString(s)) {
;69:				s += 2;
;70:				continue;
;71:			} else {
;72:				glyph = &font->glyphs[*s & 255];
;73:				out += glyph->xSkip;
;74:				s++;
;75:				count++;
;76:			}
;77:		}
;78:	}
;79:	return out * useScale;
;80:}
;81:
;82:int CG_Text_Height(const char *text, float scale, int limit) {
;83:	int len, count;
;84:	float max;
;85:	glyphInfo_t *glyph;
;86:	float useScale;
;87:	const char *s = text;
;88:	fontInfo_t *font = &cgDC.Assets.textFont;
;89:	if (scale <= cg_smallFont.value) {
;90:		font = &cgDC.Assets.smallFont;
;91:	} else if (scale > cg_bigFont.value) {
;92:		font = &cgDC.Assets.bigFont;
;93:	}
;94:	useScale = scale * font->glyphScale;
;95:	max = 0;
;96:	if (text) {
;97:		len = strlen(text);
;98:		if (limit > 0 && len > limit) {
;99:			len = limit;
;100:		}
;101:		count = 0;
;102:		while (s && *s && count < len) {
;103:			if (Q_IsColorString(s)) {
;104:				s += 2;
;105:				continue;
;106:			} else {
;107:				glyph = &font->glyphs[*s & 255];
;108:				if (max < glyph->height) {
;109:					max = glyph->height;
;110:				}
;111:				s++;
;112:				count++;
;113:			}
;114:		}
;115:	}
;116:	return max * useScale;
;117:}
;118:
;119:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;120:	float w, h;
;121:	w = width * scale;
;122:	h = height * scale;
;123:	CG_AdjustFrom640(&x, &y, &w, &h);
;124:	trap_R_DrawStretchPic(x, y, w, h, s, t, s2, t2, hShader);
;125:}
;126:
;127:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;128:	int len, count;
;129:	vec4_t newColor;
;130:	glyphInfo_t *glyph;
;131:	float useScale;
;132:	fontInfo_t *font = &cgDC.Assets.textFont;
;133:	if (scale <= cg_smallFont.value) {
;134:		font = &cgDC.Assets.smallFont;
;135:	} else if (scale > cg_bigFont.value) {
;136:		font = &cgDC.Assets.bigFont;
;137:	}
;138:	useScale = scale * font->glyphScale;
;139:	if (text) {
;140:		const char *s = text;
;141:		trap_R_SetColor(color);
;142:		memcpy(&newColor[0], &color[0], sizeof (vec4_t));
;143:		len = strlen(text);
;144:		if (limit > 0 && len > limit) {
;145:			len = limit;
;146:		}
;147:		count = 0;
;148:		while (s && *s && count < len) {
;149:			glyph = &font->glyphs[*s & 255];
;150:			if (Q_IsColorString(s)) {
;151:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof ( newColor));
;152:				newColor[3] = color[3];
;153:				trap_R_SetColor(newColor);
;154:				s += 2;
;155:				continue;
;156:			} else {
;157:				float yadj = useScale * glyph->top;
;158:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;159:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;160:					colorBlack[3] = newColor[3];
;161:					trap_R_SetColor(colorBlack);
;162:					CG_Text_PaintChar(x + ofs, y - yadj + ofs,
;163:							glyph->imageWidth,
;164:							glyph->imageHeight,
;165:							useScale,
;166:							glyph->s,
;167:							glyph->t,
;168:							glyph->s2,
;169:							glyph->t2,
;170:							glyph->glyph);
;171:					colorBlack[3] = 1.0;
;172:					trap_R_SetColor(newColor);
;173:				}
;174:				CG_Text_PaintChar(x, y - yadj,
;175:						glyph->imageWidth,
;176:						glyph->imageHeight,
;177:						useScale,
;178:						glyph->s,
;179:						glyph->t,
;180:						glyph->s2,
;181:						glyph->t2,
;182:						glyph->glyph);
;183:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;184:				x += (glyph->xSkip * useScale) + adjust;
;185:				s++;
;186:				count++;
;187:			}
;188:		}
;189:		trap_R_SetColor(NULL);
;190:	}
;191:}
;192:
;193:
;194:#endif
;195:
;196:/*
;197:==============
;198:CG_DrawField
;199:
;200:Draws large numbers for status bar and powerups
;201:==============
;202: */
;203:#ifndef MISSIONPACK
;204:
;205:static void CG_DrawField(int x, int y, int width, int value) {
line 210
;206:	char num[16], *ptr;
;207:	int l;
;208:	int frame;
;209:
;210:	if (width < 1) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $75
line 211
;211:		return;
ADDRGP4 $74
JUMPV
LABELV $75
line 215
;212:	}
;213:
;214:	// draw number string
;215:	if (width > 5) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $77
line 216
;216:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 217
;217:	}
LABELV $77
line 219
;218:
;219:	switch (width) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $79
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $79
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $109-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $109
address $81
address $88
address $95
address $102
code
LABELV $81
line 221
;220:		case 1:
;221:			value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $83
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $84
JUMPV
LABELV $83
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $84
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 222
;222:			value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $86
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $87
JUMPV
LABELV $86
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $87
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 223
;223:			break;
ADDRGP4 $80
JUMPV
LABELV $88
line 225
;224:		case 2:
;225:			value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $90
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $91
JUMPV
LABELV $90
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $91
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 226
;226:			value = value < -9 ? -9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -9
GEI4 $93
ADDRLP4 44
CNSTI4 -9
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $93
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $94
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 227
;227:			break;
ADDRGP4 $80
JUMPV
LABELV $95
line 229
;228:		case 3:
;229:			value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $97
ADDRLP4 48
CNSTI4 999
ASGNI4
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $98
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 230
;230:			value = value < -99 ? -99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -99
GEI4 $100
ADDRLP4 52
CNSTI4 -99
ASGNI4
ADDRGP4 $101
JUMPV
LABELV $100
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $101
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 231
;231:			break;
ADDRGP4 $80
JUMPV
LABELV $102
line 233
;232:		case 4:
;233:			value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $104
ADDRLP4 56
CNSTI4 9999
ASGNI4
ADDRGP4 $105
JUMPV
LABELV $104
ADDRLP4 56
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $105
ADDRFP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 234
;234:			value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $107
ADDRLP4 60
CNSTI4 -999
ASGNI4
ADDRGP4 $108
JUMPV
LABELV $107
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $108
ADDRFP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 235
;235:			break;
LABELV $79
LABELV $80
line 238
;236:	}
;237:
;238:	Com_sprintf(num, sizeof (num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $111
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 239
;239:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 240
;240:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $112
line 241
;241:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $112
line 242
;242:	x += 2 + CHAR_WIDTH * (width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 5
LSHI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 244
;243:
;244:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $115
JUMPV
LABELV $114
line 245
;245:	while (*ptr && l) {
line 246
;246:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $117
line 247
;247:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $118
JUMPV
LABELV $117
line 249
;248:		else
;249:			frame = *ptr - '0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $118
line 251
;250:
;251:		CG_DrawPic(x, y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame]);
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+452
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 252
;252:		x += CHAR_WIDTH;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 253
;253:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 254
;254:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 255
;255:	}
LABELV $115
line 245
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $121
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $114
LABELV $121
line 256
;256:}
LABELV $74
endproc CG_DrawField 64 20
export CG_Draw3DModel
proc CG_Draw3DModel 548 16
line 265
;257:#endif // MISSIONPACK
;258:
;259:/*
;260:================
;261:CG_Draw3DModel
;262:
;263:================
;264: */
;265:void CG_Draw3DModel(float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles) {
line 269
;266:	refdef_t refdef;
;267:	refEntity_t ent;
;268:
;269:	if (!cg_draw3dIcons.integer || !cg_drawIcons.integer) {
ADDRLP4 544
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 544
INDIRI4
EQI4 $127
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 544
INDIRI4
NEI4 $123
LABELV $127
line 270
;270:		return;
ADDRGP4 $122
JUMPV
LABELV $123
line 273
;271:	}
;272:
;273:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 275
;274:
;275:	memset(&refdef, 0, sizeof ( refdef));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 277
;276:
;277:	memset(&ent, 0, sizeof ( ent));
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 278
;278:	AnglesToAxis(angles, ent.axis);
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 279
;279:	VectorCopy(origin, ent.origin);
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 280
;280:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 281
;281:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 282
;282:	ent.renderfx = RF_NOSHADOW; // no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 284
;283:
;284:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 286
;285:
;286:	AxisClear(refdef.viewaxis);
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 288
;287:
;288:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 289
;289:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 291
;290:
;291:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 292
;292:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 293
;293:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 294
;294:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 296
;295:
;296:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 298
;297:
;298:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 299
;299:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 300
;300:	trap_R_RenderScene(&refdef);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 301
;301:}
LABELV $122
endproc CG_Draw3DModel 548 16
export CG_Draw3DModelEyes
proc CG_Draw3DModelEyes 616 16
line 303
;302:
;303:void CG_Draw3DModelEyes(float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, vec3_t eyep) {
line 307
;304:	refdef_t refdef;
;305:	refEntity_t ent;
;306:
;307:	if (!cg_draw3dIcons.integer || !cg_drawIcons.integer) {
ADDRLP4 544
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 544
INDIRI4
EQI4 $147
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 544
INDIRI4
NEI4 $143
LABELV $147
line 308
;308:		return;
ADDRGP4 $142
JUMPV
LABELV $143
line 311
;309:	}
;310:
;311:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 313
;312:
;313:	memset(&refdef, 0, sizeof ( refdef));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 315
;314:
;315:	memset(&ent, 0, sizeof ( ent));
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 316
;316:	AnglesToAxis(angles, ent.axis);
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 317
;317:	VectorCopy(origin, ent.origin);
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 320
;318:
;319:	// leilei - deal with the eyes here
;320:	VectorCopy(eyep, ent.eyepos[0]);
ADDRLP4 368+140
ADDRFP4 32
INDIRP4
INDIRB
ASGNB 12
line 323
;321:
;322:	//	speed *= 0.05f;
;323:	{
line 325
;324:		vec3_t angers, right, fawed, awp, ah;
;325:		VectorCopy(angles, angers);
ADDRLP4 548
ADDRFP4 28
INDIRP4
INDIRB
ASGNB 12
line 326
;326:		angers[0] *= 2;
ADDRLP4 548
CNSTF4 1073741824
ADDRLP4 548
INDIRF4
MULF4
ASGNF4
line 327
;327:		angers[1] *= -2.0;
ADDRLP4 548+4
CNSTF4 3221225472
ADDRLP4 548+4
INDIRF4
MULF4
ASGNF4
line 328
;328:		AngleVectors(angers, fawed, right, awp);
ADDRLP4 548
ARGP4
ADDRLP4 560
ARGP4
ADDRLP4 584
ARGP4
ADDRLP4 596
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 329
;329:		VectorMA(origin, 1024, fawed, ah);
ADDRLP4 608
ADDRFP4 24
INDIRP4
ASGNP4
ADDRLP4 612
CNSTF4 1149239296
ASGNF4
ADDRLP4 572
ADDRLP4 608
INDIRP4
INDIRF4
ADDRLP4 612
INDIRF4
ADDRLP4 560
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 572+4
ADDRLP4 608
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 612
INDIRF4
ADDRLP4 560+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 572+8
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1149239296
ADDRLP4 560+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 330
;330:		VectorCopy(ah, ent.eyelook);
ADDRLP4 368+164
ADDRLP4 572
INDIRB
ASGNB 12
line 331
;331:	}
line 333
;332:
;333:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 334
;334:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 335
;335:	ent.renderfx = RF_NOSHADOW; // no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 337
;336:
;337:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 339
;338:
;339:	AxisClear(refdef.viewaxis);
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 341
;340:
;341:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 342
;342:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 344
;343:
;344:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 345
;345:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 346
;346:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 347
;347:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 349
;348:
;349:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 351
;350:
;351:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 352
;352:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 353
;353:	trap_R_RenderScene(&refdef);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 354
;354:}
LABELV $142
endproc CG_Draw3DModelEyes 616 16
export CG_DrawHead
proc CG_DrawHead 56 36
line 363
;355:
;356:/*
;357:================
;358:CG_DrawHead
;359:
;360:Used for both the status bar and the scoreboard
;361:================
;362: */
;363:void CG_DrawHead(float x, float y, float w, float h, int clientNum, vec3_t headAngles) {
line 370
;364:	clipHandle_t cm;
;365:	clientInfo_t *ci;
;366:	float len;
;367:	vec3_t origin;
;368:	vec3_t mins, maxs;
;369:
;370:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 2120
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 372
;371:
;372:	if (cg_draw3dIcons.integer) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $171
line 373
;373:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 374
;374:		if (!cm) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $174
line 375
;375:			return;
ADDRGP4 $169
JUMPV
LABELV $174
line 379
;376:		}
;377:
;378:		// offset the origin y and z to center the head
;379:		trap_R_ModelBounds(cm, mins, maxs);
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 381
;380:
;381:		origin[2] = -0.5 * (mins[2] + maxs[2]);
ADDRLP4 4+8
CNSTF4 3204448256
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 382
;382:		origin[1] = 0.5 * (mins[1] + maxs[1]);
ADDRLP4 4+4
CNSTF4 1056964608
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 386
;383:
;384:		// calculate distance so the head nearly fills the box
;385:		// assume heads are taller than wide
;386:		len = 0.7 * (maxs[2] - mins[2]);
ADDRLP4 44
CNSTF4 1060320051
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 387
;387:		origin[0] = len / 0.268; // len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 390
;388:
;389:		// allow per-model tweaking
;390:		VectorAdd(origin, ci->headOffset, origin);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDF4
ASGNF4
line 393
;391:
;392:		//CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
;393:		CG_Draw3DModelEyes(x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, ci->eyepos);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 2104
ADDP4
ARGP4
ADDRGP4 CG_Draw3DModelEyes
CALLV
pop
line 396
;394:
;395:		//	CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
;396:	} else if (cg_drawIcons.integer) {
ADDRGP4 $172
JUMPV
LABELV $171
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $188
line 397
;397:		CG_DrawPic(x, y, w, h, ci->modelIcon);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 398
;398:	}
LABELV $188
LABELV $172
line 401
;399:
;400:	// if they are deferred, draw a cross out
;401:	if (ci->deferred) {
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $191
line 402
;402:		CG_DrawPic(x, y, w, h, cgs.media.deferShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+180268+196
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 403
;403:	}
LABELV $191
line 404
;404:}
LABELV $169
endproc CG_DrawHead 56 36
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 413
;405:
;406:/*
;407:================
;408:CG_DrawFlagModel
;409:
;410:Used for both the status bar and the scoreboard
;411:================
;412: */
;413:void CG_DrawFlagModel(float x, float y, float w, float h, int team, qboolean force2D) {
line 420
;414:	qhandle_t cm;
;415:	float len;
;416:	vec3_t origin, angles;
;417:	vec3_t mins, maxs;
;418:	qhandle_t handle;
;419:
;420:	if (!force2D && cg_draw3dIcons.integer) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $196
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $196
line 422
;421:
;422:		VectorClear(angles);
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 424
;423:
;424:		cm = cgs.media.redFlagModel;
ADDRLP4 52
ADDRGP4 cgs+180268+36
INDIRI4
ASGNI4
line 427
;425:
;426:		// offset the origin y and z to center the flag
;427:		trap_R_ModelBounds(cm, mins, maxs);
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 429
;428:
;429:		origin[2] = -0.5 * (mins[2] + maxs[2]);
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 430
;430:		origin[1] = 0.5 * (mins[1] + maxs[1]);
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 434
;431:
;432:		// calculate distance so the flag nearly fills the box
;433:		// assume heads are taller than wide
;434:		len = 0.5 * (maxs[2] - mins[2]);
ADDRLP4 56
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 435
;435:		origin[0] = len / 0.268; // len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 56
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 437
;436:
;437:		angles[YAW] = 60 * sin(cg.time / 2000.0);
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 438
;438:		;
line 440
;439:
;440:		if (team == TEAM_RED) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $213
line 441
;441:			handle = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+36
INDIRI4
ASGNI4
line 442
;442:			if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $214
line 443
;443:				if (cgs.redflag == TEAM_BLUE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 2
NEI4 $220
line 444
;444:					handle = cgs.media.blueFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+40
INDIRI4
ASGNI4
LABELV $220
line 445
;445:				if (cgs.redflag == TEAM_FREE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 0
NEI4 $225
line 446
;446:					handle = cgs.media.neutralFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+44
INDIRI4
ASGNI4
LABELV $225
line 447
;447:				if (cgs.redflag == TEAM_NONE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 3
NEI4 $214
line 448
;448:					handle = cgs.media.neutralFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+44
INDIRI4
ASGNI4
line 449
;449:			}
line 450
;450:		} else if (team == TEAM_BLUE) {
ADDRGP4 $214
JUMPV
LABELV $213
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $235
line 451
;451:			handle = cgs.media.blueFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+40
INDIRI4
ASGNI4
line 452
;452:			if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $236
line 453
;453:				if (cgs.redflag == TEAM_BLUE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 2
NEI4 $242
line 454
;454:					handle = cgs.media.blueFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+40
INDIRI4
ASGNI4
LABELV $242
line 455
;455:				if (cgs.redflag == TEAM_FREE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 0
NEI4 $247
line 456
;456:					handle = cgs.media.neutralFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+44
INDIRI4
ASGNI4
LABELV $247
line 457
;457:				if (cgs.redflag == TEAM_NONE)
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 3
NEI4 $236
line 458
;458:					handle = cgs.media.neutralFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+44
INDIRI4
ASGNI4
line 459
;459:			}
line 460
;460:		} else if (team == TEAM_FREE) {
ADDRGP4 $236
JUMPV
LABELV $235
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $195
line 461
;461:			handle = cgs.media.neutralFlagModel;
ADDRLP4 48
ADDRGP4 cgs+180268+44
INDIRI4
ASGNI4
line 462
;462:		} else {
line 463
;463:			return;
LABELV $258
LABELV $236
LABELV $214
line 465
;464:		}
;465:		CG_Draw3DModel(x, y, w, h, handle, 0, origin, angles);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 466
;466:	} else if (cg_drawIcons.integer) {
ADDRGP4 $197
JUMPV
LABELV $196
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $261
line 469
;467:		gitem_t *item;
;468:
;469:		if (team == TEAM_RED) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $264
line 470
;470:			item = BG_FindItemForPowerup(PW_REDFLAG);
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 471
;471:		} else if (team == TEAM_BLUE) {
ADDRGP4 $265
JUMPV
LABELV $264
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $266
line 472
;472:			item = BG_FindItemForPowerup(PW_BLUEFLAG);
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 473
;473:		} else if (team == TEAM_FREE) {
ADDRGP4 $267
JUMPV
LABELV $266
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $195
line 474
;474:			item = BG_FindItemForPowerup(PW_NEUTRALFLAG);
CNSTI4 9
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 475
;475:		} else {
line 476
;476:			return;
LABELV $269
LABELV $267
LABELV $265
line 478
;477:		}
;478:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $270
line 479
;479:			CG_DrawPic(x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 480
;480:		}
LABELV $270
line 481
;481:	}
LABELV $261
LABELV $197
line 482
;482:}
LABELV $195
endproc CG_DrawFlagModel 72 32
proc CG_DrawStatusBarHead 56 24
line 492
;483:
;484:/*
;485:================
;486:CG_DrawStatusBarHead
;487:
;488:================
;489: */
;490:#ifndef MISSIONPACK
;491:
;492:static void CG_DrawStatusBarHead(float x) {
line 497
;493:	vec3_t angles;
;494:	float size, stretch;
;495:	float frac;
;496:
;497:	VectorClear(angles);
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 499
;498:
;499:	if (cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME) {
ADDRGP4 cg+125280
INDIRF4
CNSTF4 0
EQF4 $276
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+125280
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $276
line 500
;500:		frac = (float) (cg.time - cg.damageTime) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+125280
INDIRF4
SUBF4
CNSTF4 1140457472
DIVF4
ASGNF4
line 501
;501:		size = ICON_SIZE * 1.25 * (1.5 - frac * 0.5);
ADDRLP4 16
CNSTF4 1114636288
CNSTF4 1069547520
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 503
;502:
;503:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 505
;504:		// kick in the direction of damage
;505:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
CNSTF4 1056964608
ASGNF4
ADDRLP4 32
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRGP4 cg+125284
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
MULF4
ADDF4
SUBF4
ASGNF4
line 507
;506:
;507:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+125316
CNSTF4 1110704128
ADDRGP4 cg+125284
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 509
;508:
;509:		cg.headEndYaw = 180 + 20 * cos(crandom() * M_PI);
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 36
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
ARGF4
ADDRLP4 40
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125304
CNSTF4 1101004800
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 510
;510:		cg.headEndPitch = 5 * cos(crandom() * M_PI);
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 44
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
ARGF4
ADDRLP4 48
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125300
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 512
;511:
;512:		cg.headStartTime = cg.time;
ADDRGP4 cg+125320
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 513
;513:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+125308
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 514
;514:	} else {
ADDRGP4 $277
JUMPV
LABELV $276
line 515
;515:		if (cg.time >= cg.headEndTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125308
INDIRI4
LTI4 $292
line 517
;516:			// select a new head angle
;517:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+125316
ADDRGP4 cg+125304
INDIRF4
ASGNF4
line 518
;518:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+125312
ADDRGP4 cg+125300
INDIRF4
ASGNF4
line 519
;519:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+125320
ADDRGP4 cg+125308
INDIRI4
ASGNI4
line 520
;520:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+125308
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 522
;521:
;522:			cg.headEndYaw = 180 + 20 * cos(crandom() * M_PI);
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
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
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125304
CNSTF4 1101004800
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 523
;523:			cg.headEndPitch = 5 * cos(crandom() * M_PI);
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 40
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
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+125300
CNSTF4 1084227584
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 524
;524:		}
LABELV $292
line 526
;525:
;526:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 527
;527:	}
LABELV $277
line 530
;528:
;529:	// if the server was frozen for a while we may have a bad head start time
;530:	if (cg.headStartTime > cg.time) {
ADDRGP4 cg+125320
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $306
line 531
;531:		cg.headStartTime = cg.time;
ADDRGP4 cg+125320
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 532
;532:	}
LABELV $306
line 534
;533:
;534:	frac = (cg.time - cg.headStartTime) / (float) (cg.headEndTime - cg.headStartTime);
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125320
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+125308
INDIRI4
ADDRGP4 cg+125320
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 535
;535:	frac = frac * frac * (3 - 2 * frac);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 536
;536:	angles[YAW] = cg.headStartYaw + (cg.headEndYaw - cg.headStartYaw) * frac;
ADDRLP4 4+4
ADDRGP4 cg+125316
INDIRF4
ADDRGP4 cg+125304
INDIRF4
ADDRGP4 cg+125316
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 537
;537:	angles[PITCH] = cg.headStartPitch + (cg.headEndPitch - cg.headStartPitch) * frac;
ADDRLP4 4
ADDRGP4 cg+125312
INDIRF4
ADDRGP4 cg+125300
INDIRF4
ADDRGP4 cg+125312
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 539
;538:
;539:	CG_DrawHead(x, 480 - size, size, size,
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 541
;540:			cg.snap->ps.clientNum, angles);
;541:}
LABELV $273
endproc CG_DrawStatusBarHead 56 24
proc CG_DrawStatusBarFlag 4 24
line 552
;542:#endif // MISSIONPACK
;543:
;544:/*
;545:================
;546:CG_DrawStatusBarFlag
;547:
;548:================
;549: */
;550:#ifndef MISSIONPACK
;551:
;552:static void CG_DrawStatusBarFlag(float x, int team) {
line 553
;553:	CG_DrawFlagModel(x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse);
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 0
CNSTF4 1111490560
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 554
;554:}
LABELV $324
endproc CG_DrawStatusBarFlag 4 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 563
;555:#endif // MISSIONPACK
;556:
;557:/*
;558:================
;559:CG_DrawTeamBackground
;560:
;561:================
;562: */
;563:void CG_DrawTeamBackground(int x, int y, int w, int h, float alpha, int team) {
line 566
;564:	vec4_t hcolor;
;565:
;566:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 567
;567:	if (team == TEAM_RED) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $327
line 568
;568:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 569
;569:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 570
;570:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 571
;571:	} else if (team == TEAM_BLUE) {
ADDRGP4 $328
JUMPV
LABELV $327
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $325
line 572
;572:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 573
;573:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 574
;574:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 575
;575:	} else {
line 576
;576:		return;
LABELV $332
LABELV $328
line 578
;577:	}
;578:	trap_R_SetColor(hcolor);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 579
;579:	CG_DrawPic(x, y, w, h, cgs.media.teamStatusBar);
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+180268+192
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 580
;580:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 581
;581:}
LABELV $325
endproc CG_DrawTeamBackground 16 20
data
align 4
LABELV $338
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 84 32
line 591
;582:
;583:/*
;584:================
;585:CG_DrawStatusBar
;586:
;587:================
;588: */
;589:#ifndef MISSIONPACK
;590:
;591:static void CG_DrawStatusBar(void) {
line 609
;592:	int color;
;593:	centity_t *cent;
;594:	playerState_t *ps;
;595:	int value;
;596:	vec4_t hcolor;
;597:	vec3_t angles;
;598:	vec3_t origin;
;599:	qhandle_t handle;
;600:
;601:	static float colors[4][4] = {
;602:		//		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;603:		{ 1.0f, 0.69f, 0.0f, 1.0f}, // normal
;604:		{ 1.0f, 0.2f, 0.2f, 1.0f}, // low health
;605:		{ 0.5f, 0.5f, 0.5f, 1.0f}, // weapon firing
;606:		{ 1.0f, 1.0f, 1.0f, 1.0f}
;607:	}; // health > 100
;608:
;609:	if (cg_drawStatus.integer == 0) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $339
line 610
;610:		return;
ADDRGP4 $337
JUMPV
LABELV $339
line 614
;611:	}
;612:
;613:	// draw the team background
;614:	if (!(cg.snap->ps.pm_flags & PMF_FOLLOW)) //If not following anybody:
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $342
line 615
;615:		CG_DrawTeamBackground(0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM]);
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
ADDRGP4 $343
JUMPV
LABELV $342
line 617
;616:	else //Sago: If we follow find the teamcolor of the guy we follow. It might not be our own team!
;617:		CG_DrawTeamBackground(0, 420, 640, 60, 0.33f, cgs.clientinfo[ cg.snap->ps.clientNum ].team);
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 2120
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
LABELV $343
line 619
;618:
;619:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 28
CNSTI4 936
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 620
;620:	ps = &cg.snap->ps;
ADDRLP4 32
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 622
;621:
;622:	VectorClear(angles);
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 60
INDIRF4
ASGNF4
line 625
;623:
;624:	// draw any 3D icons first, so the changes back to 2D are minimized
;625:	if (cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel) {
ADDRLP4 64
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $353
CNSTI4 172
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $353
line 626
;626:		origin[0] = 70;
ADDRLP4 16
CNSTF4 1116471296
ASGNF4
line 627
;627:		origin[1] = 0;
ADDRLP4 16+4
CNSTF4 0
ASGNF4
line 628
;628:		origin[2] = 0;
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 629
;629:		angles[YAW] = 90 + 20 * sin(cg.time / 1000.0);
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 72
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4+4
CNSTF4 1101004800
ADDRLP4 72
INDIRF4
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 630
;630:		CG_Draw3DModel(CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
CNSTI4 172
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 632
;631:				cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles);
;632:	}
LABELV $353
line 634
;633:
;634:	CG_DrawStatusBarHead(185 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE);
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 636
;635:
;636:	if (cg.predictedPlayerState.powerups[PW_REDFLAG]) {
ADDRGP4 cg+107636+312+28
INDIRI4
CNSTI4 0
EQI4 $361
line 637
;637:		CG_DrawStatusBarFlag(185 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED);
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 638
;638:	} else if (cg.predictedPlayerState.powerups[PW_BLUEFLAG]) {
ADDRGP4 $362
JUMPV
LABELV $361
ADDRGP4 cg+107636+312+32
INDIRI4
CNSTI4 0
EQI4 $366
line 639
;639:		CG_DrawStatusBarFlag(185 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE);
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 640
;640:	} else if (cg.predictedPlayerState.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 $367
JUMPV
LABELV $366
ADDRGP4 cg+107636+312+36
INDIRI4
CNSTI4 0
EQI4 $371
line 641
;641:		CG_DrawStatusBarFlag(185 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE);
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 642
;642:	}
LABELV $371
LABELV $367
LABELV $362
line 644
;643:
;644:	if (ps->stats[ STAT_ARMOR ]) {
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $376
line 645
;645:		origin[0] = 90;
ADDRLP4 16
CNSTF4 1119092736
ASGNF4
line 646
;646:		origin[1] = 0;
ADDRLP4 16+4
CNSTF4 0
ASGNF4
line 647
;647:		origin[2] = -10;
ADDRLP4 16+8
CNSTF4 3240099840
ASGNF4
line 648
;648:		angles[YAW] = (cg.time & 2047) * 360 / 2048.0;
ADDRLP4 4+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 649
;649:		CG_Draw3DModel(370 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 cgs+180268+184
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 651
;650:				cgs.media.armorModel, 0, origin, angles);
;651:	}
LABELV $376
line 653
;652:
;653:	if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
NEI4 $384
line 654
;654:		origin[0] = 90;
ADDRLP4 16
CNSTF4 1119092736
ASGNF4
line 655
;655:		origin[1] = 0;
ADDRLP4 16+4
CNSTF4 0
ASGNF4
line 656
;656:		origin[2] = -10;
ADDRLP4 16+8
CNSTF4 3240099840
ASGNF4
line 657
;657:		angles[YAW] = (cg.time & 2047) * 360 / 2048.0;
ADDRLP4 4+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 658
;658:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $391
line 659
;659:			handle = cgs.media.redCubeModel;
ADDRLP4 52
ADDRGP4 cgs+180268+20
INDIRI4
ASGNI4
line 660
;660:		} else {
ADDRGP4 $392
JUMPV
LABELV $391
line 661
;661:			handle = cgs.media.blueCubeModel;
ADDRLP4 52
ADDRGP4 cgs+180268+24
INDIRI4
ASGNI4
line 662
;662:		}
LABELV $392
line 663
;663:		CG_Draw3DModel(470 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles);
CNSTF4 1141800960
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 664
;664:	}
LABELV $384
line 670
;665:
;666:
;667:	//
;668:	// ammo
;669:	//
;670:	if (cent->currentState.weapon) {
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $398
line 671
;671:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 672
;672:		if (value > -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $400
line 673
;673:			if (cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+107636+148
INDIRI4
CNSTI4 3
NEI4 $402
ADDRGP4 cg+107636+44
INDIRI4
CNSTI4 100
LEI4 $402
line 674
;674:					&& cg.predictedPlayerState.weaponTime > 100) {
line 676
;675:				// draw as dark grey when reloading
;676:				color = 2; // dark grey
ADDRLP4 56
CNSTI4 2
ASGNI4
line 677
;677:			} else {
ADDRGP4 $403
JUMPV
LABELV $402
line 678
;678:				if (value >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $408
line 679
;679:					color = 0; // green
ADDRLP4 56
CNSTI4 0
ASGNI4
line 680
;680:				} else {
ADDRGP4 $409
JUMPV
LABELV $408
line 681
;681:					color = 1; // red
ADDRLP4 56
CNSTI4 1
ASGNI4
line 682
;682:				}
LABELV $409
line 683
;683:			}
LABELV $403
line 684
;684:			trap_R_SetColor(colors[color]);
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $338
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 686
;685:
;686:			CG_DrawField(0, 432, 3, value);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 687
;687:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 690
;688:
;689:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;690:			if (!cg_draw3dIcons.integer && cg_drawIcons.integer) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $410
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $410
line 693
;691:				qhandle_t icon;
;692:
;693:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 76
CNSTI4 172
ADDRGP4 cg+107636+144
INDIRI4
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 694
;694:				if (icon) {
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $417
line 695
;695:					CG_DrawPic(CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon);
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 80
CNSTF4 1111490560
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 696
;696:				}
LABELV $417
line 697
;697:			}
LABELV $410
line 698
;698:		}
LABELV $400
line 699
;699:	}
LABELV $398
line 704
;700:
;701:	//
;702:	// health
;703:	//
;704:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 705
;705:	if (value > 100) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $419
line 706
;706:		trap_R_SetColor(colors[3]); // white
ADDRGP4 $338+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 707
;707:	} else if (value > 25) {
ADDRGP4 $420
JUMPV
LABELV $419
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $422
line 708
;708:		trap_R_SetColor(colors[0]); // green
ADDRGP4 $338
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 709
;709:	} else if (value > 0) {
ADDRGP4 $423
JUMPV
LABELV $422
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $424
line 710
;710:		color = (cg.time >> 8) & 1; // flash
ADDRLP4 56
ADDRGP4 cg+107604
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 711
;711:		trap_R_SetColor(colors[color]);
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $338
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 712
;712:	} else {
ADDRGP4 $425
JUMPV
LABELV $424
line 713
;713:		trap_R_SetColor(colors[1]); // red
ADDRGP4 $338+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 714
;714:	}
LABELV $425
LABELV $423
LABELV $420
line 717
;715:
;716:	// stretch the health up when taking damage
;717:	CG_DrawField(185, 432, 3, value);
CNSTI4 185
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 718
;718:	CG_ColorForHealth(hcolor);
ADDRLP4 36
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 719
;719:	trap_R_SetColor(hcolor);
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 725
;720:
;721:
;722:	//
;723:	// armor
;724:	//
;725:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 726
;726:	if (value > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $428
line 727
;727:		trap_R_SetColor(colors[0]);
ADDRGP4 $338
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 728
;728:		CG_DrawField(370, 432, 3, value);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 729
;729:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 731
;730:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;731:		if (!cg_draw3dIcons.integer && cg_drawIcons.integer) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $430
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $430
line 732
;732:			CG_DrawPic(370 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon);
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 cgs+180268+188
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 733
;733:		}
LABELV $430
line 735
;734:
;735:	}
LABELV $428
line 738
;736:
;737:	//Skulls!
;738:	if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
NEI4 $436
line 739
;739:		value = ps->generic1;
ADDRLP4 0
ADDRLP4 32
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 740
;740:		if (value > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $439
line 741
;741:			trap_R_SetColor(colors[0]);
ADDRGP4 $338
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 742
;742:			CG_DrawField(470, 432, 3, value);
CNSTI4 470
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 743
;743:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 745
;744:			// if we didn't draw a 3D icon, draw a 2D icon for skull
;745:			if (!cg_draw3dIcons.integer && cg_drawIcons.integer) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $441
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $441
line 746
;746:				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $445
line 747
;747:					handle = cgs.media.redCubeIcon;
ADDRLP4 52
ADDRGP4 cgs+180268+28
INDIRI4
ASGNI4
line 748
;748:				} else {
ADDRGP4 $446
JUMPV
LABELV $445
line 749
;749:					handle = cgs.media.blueCubeIcon;
ADDRLP4 52
ADDRGP4 cgs+180268+32
INDIRI4
ASGNI4
line 750
;750:				}
LABELV $446
line 751
;751:				CG_DrawPic(470 + CHAR_WIDTH * 3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, handle);
CNSTF4 1141800960
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 752
;752:			}
LABELV $441
line 754
;753:
;754:		}
LABELV $439
line 755
;755:	}
LABELV $436
line 756
;756:}
LABELV $337
endproc CG_DrawStatusBar 84 32
proc CG_DrawAttacker 52 24
line 773
;757:#endif
;758:
;759:/*
;760:===========================================================================================
;761:
;762: UPPER RIGHT CORNER
;763:
;764:===========================================================================================
;765: */
;766:
;767:/*
;768:================
;769:CG_DrawAttacker
;770:
;771:================
;772: */
;773:static float CG_DrawAttacker(float y) {
line 781
;774:	int t;
;775:	float size;
;776:	vec3_t angles;
;777:	const char *info;
;778:	const char *name;
;779:	int clientNum;
;780:
;781:	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $453
line 782
;782:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $452
JUMPV
LABELV $453
line 785
;783:	}
;784:
;785:	if (!cg.attackerTime) {
ADDRGP4 cg+125008
INDIRI4
CNSTI4 0
NEI4 $457
line 786
;786:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $452
JUMPV
LABELV $457
line 789
;787:	}
;788:
;789:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107636+248+24
INDIRI4
ASGNI4
line 790
;790:	if (clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $467
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $467
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $463
LABELV $467
line 791
;791:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $452
JUMPV
LABELV $463
line 794
;792:	}
;793:
;794:	if ( !cgs.clientinfo[clientNum].infoValid ) {
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
INDIRI4
CNSTI4 0
NEI4 $468
line 795
;795:		cg.attackerTime = 0;
ADDRGP4 cg+125008
CNSTI4 0
ASGNI4
line 796
;796:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $452
JUMPV
LABELV $468
line 799
;797:	}
;798:
;799:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125008
INDIRI4
SUBI4
ASGNI4
line 800
;800:	if (t > ATTACKER_HEAD_TIME) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $474
line 801
;801:		cg.attackerTime = 0;
ADDRGP4 cg+125008
CNSTI4 0
ASGNI4
line 802
;802:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $452
JUMPV
LABELV $474
line 805
;803:	}
;804:
;805:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 807
;806:
;807:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 808
;808:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 809
;809:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 810
;810:	CG_DrawHead(640 - size, y, size, size, clientNum, angles);
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 812
;811:
;812:	info = CG_ConfigString(CS_PLAYERS + clientNum);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 40
INDIRP4
ASGNP4
line 813
;813:	name = Info_ValueForKey(info, "n");
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $479
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
line 814
;814:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 815
;815:	CG_DrawBigString(640 - (Q_PrintStrlen(name) * BIGCHAR_WIDTH), y, name, 0.5);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
CNSTI4 640
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 817
;816:
;817:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $452
endproc CG_DrawAttacker 52 24
proc CG_DrawSpeedMeter 40 16
line 826
;818:}
;819:
;820:/*
;821:================
;822:CG_DrawSpeedMeter
;823:
;824:================
;825: */
;826:static float CG_DrawSpeedMeter(float y) {
line 833
;827:	char *s;
;828:	int w;
;829:	vec_t *vel;
;830:	int speed;
;831:
;832:	/* speed meter can get in the way of the scoreboard */
;833:	if (cg.scoreBoardShowing) {
ADDRGP4 cg+114788
INDIRI4
CNSTI4 0
EQI4 $481
line 834
;834:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $480
JUMPV
LABELV $481
line 837
;835:	}
;836:
;837:	vel = cg.snap->ps.velocity;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
line 839
;838:	/* ignore vertical component of velocity */
;839:	speed = sqrt(vel[0] * vel[0] + vel[1] * vel[1]);
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 841
;840:
;841:	s = va("%iu/s", speed);
ADDRGP4 $485
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 843
;842:
;843:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 845
;844:
;845:	if (cg_drawSpeed.integer == 1) {
ADDRGP4 cg_drawSpeed+12
INDIRI4
CNSTI4 1
NEI4 $486
line 847
;846:		/* top left-hand corner of screen */
;847:		CG_DrawBigString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 848
;848:		return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
ADDRGP4 $480
JUMPV
LABELV $486
line 849
;849:	} else {
line 851
;850:		/* center of screen */
;851:		CG_DrawBigString(320 - w / 2, 300, s, 1.0F);
CNSTI4 320
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 300
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 852
;852:		return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $480
endproc CG_DrawSpeedMeter 40 16
proc CG_DrawSnapshot 16 16
line 861
;853:	}
;854:}
;855:
;856:/*
;857:==================
;858:CG_DrawSnapshot
;859:==================
;860: */
;861:static float CG_DrawSnapshot(float y) {
line 865
;862:	char *s;
;863:	int w;
;864:
;865:	s = va("time:%i snap:%i cmd:%i", cg.snap->serverTime,
ADDRGP4 $490
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 867
;866:			cg.latestSnapshotNum, cgs.serverCommandSequence);
;867:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 869
;868:
;869:	CG_DrawBigString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 871
;870:
;871:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $489
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $495
skip 16
align 4
LABELV $496
skip 4
align 4
LABELV $497
skip 4
code
proc CG_DrawFPS 44 16
line 881
;872:}
;873:
;874:/*
;875:==================
;876:CG_DrawFPS
;877:==================
;878: */
;879:#define FPS_FRAMES 4
;880:
;881:static float CG_DrawFPS(float y) {
line 893
;882:	char *s;
;883:	int w;
;884:	static int previousTimes[FPS_FRAMES];
;885:	static int index;
;886:	int i, total;
;887:	int fps;
;888:	static int previous;
;889:	int t, frameTime;
;890:
;891:	// don't use serverTime, because that will be drifting to
;892:	// correct for internet lag changes, timescales, timedemos, etc
;893:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 894
;894:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $497
INDIRI4
SUBI4
ASGNI4
line 895
;895:	previous = t;
ADDRGP4 $497
ADDRLP4 8
INDIRI4
ASGNI4
line 897
;896:
;897:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $496
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $495
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 898
;898:	index++;
ADDRLP4 32
ADDRGP4 $496
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 899
;899:	if (index > FPS_FRAMES) {
ADDRGP4 $496
INDIRI4
CNSTI4 4
LEI4 $498
line 901
;900:		// average multiple frames together to smooth changes out a bit
;901:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 902
;902:		for (i = 0; i < FPS_FRAMES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $500
line 903
;903:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $495
ADDP4
INDIRI4
ADDI4
ASGNI4
line 904
;904:		}
LABELV $501
line 902
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $500
line 905
;905:		if (!total) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $504
line 906
;906:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 907
;907:		}
LABELV $504
line 908
;908:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 910
;909:
;910:		s = va("%ifps", fps);
ADDRGP4 $506
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 911
;911:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 913
;912:
;913:		CG_DrawBigString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 914
;914:	}
LABELV $498
line 916
;915:
;916:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $494
endproc CG_DrawFPS 44 16
proc CG_DrawPossessionString 44 16
line 919
;917:}
;918:
;919:static float CG_DrawPossessionString(float y) {
line 927
;920:	vec4_t *color;
;921:	char *line;
;922:	int timeUntilWon;
;923:	int i;
;924:	int w;
;925:	float distance;
;926:
;927:	if (cgs.gametype != GT_POSSESSION) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 13
EQI4 $508
line 928
;928:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $507
JUMPV
LABELV $508
line 931
;929:	}
;930:
;931:	line = "Find the flag";
ADDRLP4 4
ADDRGP4 $511
ASGNP4
line 932
;932:	timeUntilWon = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 933
;933:	if (cgs.fraglimit > 0 && cgs.fraglimit < 1000) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $512
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 1000
GEI4 $512
line 934
;934:		timeUntilWon = cgs.fraglimit - cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 12
ADDRGP4 cgs+31476
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
SUBI4
ASGNI4
line 935
;935:	}
LABELV $512
line 936
;936:	color = &colorYellow;
ADDRLP4 8
ADDRGP4 colorYellow
ASGNP4
line 938
;937:
;938:	if (cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $518
line 939
;939:		if (timeUntilWon > 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $521
line 940
;940:			line = va("Survive for %i:%02i", timeUntilWon / 60, timeUntilWon % 60);
ADDRGP4 $523
ARGP4
ADDRLP4 24
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 60
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
DIVI4
ARGI4
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
MODI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 941
;941:		} else if (timeUntilWon == 0) {
ADDRGP4 $519
JUMPV
LABELV $521
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $524
line 942
;942:			line = va("You survived");
ADDRGP4 $526
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 943
;943:			color = &colorGreen;
ADDRLP4 8
ADDRGP4 colorGreen
ASGNP4
line 944
;944:		} else {
ADDRGP4 $519
JUMPV
LABELV $524
line 945
;945:			line = va("Survive!");
ADDRGP4 $527
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 946
;946:		}
line 947
;947:	} else {
ADDRGP4 $519
JUMPV
LABELV $518
line 948
;948:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $528
line 949
;949:			if (cg_entities[i].currentState.eType == ET_PLAYER && cg_entities[i].currentState.powerups & (1 << PW_NEUTRALFLAG)) {
ADDRLP4 24
CNSTI4 936
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $532
ADDRLP4 24
INDIRI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $532
line 950
;950:				if (cg_entities[i].lerpOrigin[0] || cg_entities[i].lerpOrigin[1] || cg_entities[i].lerpOrigin[2]) {
ADDRLP4 28
CNSTI4 936
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
CNSTF4 0
ASGNF4
ADDRLP4 28
INDIRI4
ADDRGP4 cg_entities+776
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
NEF4 $544
ADDRLP4 28
INDIRI4
ADDRGP4 cg_entities+776+4
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
NEF4 $544
ADDRLP4 28
INDIRI4
ADDRGP4 cg_entities+776+8
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
EQF4 $536
LABELV $544
line 951
;951:					distance = Distance(cg_entities[i].lerpOrigin, cg.snap->ps.origin);
CNSTI4 936
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities+776
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 36
INDIRF4
ASGNF4
line 952
;952:					line = va("%d0 units to flag carrier", ((int) distance) / 10);
ADDRGP4 $547
ARGP4
ADDRLP4 16
INDIRF4
CVFI4 4
CNSTI4 10
DIVI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 953
;953:					color = &colorYellow;
ADDRLP4 8
ADDRGP4 colorYellow
ASGNP4
line 954
;954:				}
LABELV $536
line 955
;955:			}
LABELV $532
line 956
;956:		}
LABELV $529
line 948
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $528
line 957
;957:	}
LABELV $519
line 959
;958:
;959:	w = CG_DrawStrlen(line) * SMALLCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 960
;960:	CG_DrawSmallStringColor(635 - w, y + 2, line, *color);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 962
;961:
;962:	return y + SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $507
endproc CG_DrawPossessionString 44 16
proc CG_DrawTimer 32 16
line 970
;963:}
;964:
;965:/*
;966:=================
;967:CG_DrawTimer
;968:=================
;969: */
;970:static float CG_DrawTimer(float y) {
line 976
;971:	char *s;
;972:	int w;
;973:	int mins, seconds, tens;
;974:	int msec;
;975:
;976:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34804
INDIRI4
SUBI4
ASGNI4
line 978
;977:
;978:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 979
;979:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 980
;980:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 981
;981:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 982
;982:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 984
;983:
;984:	s = va("%i:%i%i", mins, tens, seconds);
ADDRGP4 $551
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 985
;985:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 987
;986:
;987:	CG_DrawBigString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 989
;988:
;989:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $548
endproc CG_DrawTimer 32 16
proc CG_DrawLMSmode 12 16
line 1059
;990:}
;991:
;992:/*
;993:CG_DrawDoubleDominationThings
;994:Might be relevant for debugging missionpack.
;995: */
;996:/*
;997:static float CG_DrawDoubleDominationThings( float y ) {
;998:	char		*s;
;999:	int			w;
;1000:	int 		statusA, statusB;
;1001:	statusA = cgs.redflag;
;1002:	statusB = cgs.blueflag;
;1003:
;1004:	// This is only useful in Developer mode.
;1005:	if(!cg_developer.integer) {
;1006:		return;
;1007:	}
;1008:	
;1009:	if(statusA == TEAM_NONE) {
;1010:		s = va("Point A not spawned");
;1011:	} else
;1012:	if(statusA == TEAM_FREE) {
;1013:		s = va("Point A is not controlled");
;1014:	} else
;1015:	if(statusA == TEAM_RED) {
;1016:		s = va("Point A is controlled by RED");
;1017:	} else
;1018:	if(statusA == TEAM_BLUE) {
;1019:		s = va("Point A is controlled by BLUE");
;1020:	} else
;1021:		s = va("Point A has an error");
;1022:	w = CG_DrawStrlen( s ) * SMALLCHAR_WIDTH;
;1023:	CG_DrawSmallString( 635 - w, y + 2, s, 1.0F);
;1024:	y+=SMALLCHAR_HEIGHT+4;
;1025:
;1026:	if(statusB == TEAM_NONE) {
;1027:		s = va("Point B not spawned");
;1028:	} else
;1029:	if(statusB == TEAM_FREE) {
;1030:		s = va("Point B is not controlled");
;1031:	} else
;1032:	if(statusB == TEAM_RED) {
;1033:		s = va("Point B is controlled by RED");
;1034:	} else
;1035:	if(statusB == TEAM_BLUE) {
;1036:		s = va("Point B is controlled by BLUE");
;1037:	} else
;1038:		s = va("Point B has an error");
;1039:	w = CG_DrawStrlen( s ) * SMALLCHAR_WIDTH;
;1040:	CG_DrawSmallString( 635 - w, y + 2, s, 1.0F);
;1041:
;1042:	if( ( ( statusB == statusA ) && ( statusA == TEAM_RED ) ) ||
;1043:		( ( statusB == statusA ) && ( statusA == TEAM_BLUE ) ) ) {
;1044:		s = va("Capture in: %i",(cgs.timetaken+10*1000-cg.time)/1000+1);
;1045:		w = CG_DrawStrlen( s ) * SMALLCHAR_WIDTH;
;1046:		y+=SMALLCHAR_HEIGHT+4;
;1047:		CG_DrawSmallString( 635 - w, y + 2, s, 1.0F);
;1048:	}
;1049:
;1050:	return y + SMALLCHAR_HEIGHT+4;
;1051:}
;1052:*/
;1053:/*
;1054:=================
;1055:CG_DrawLMSmode
;1056:=================
;1057: */
;1058:
;1059:static float CG_DrawLMSmode(float y) {
line 1063
;1060:	char *s;
;1061:	int w;
;1062:
;1063:	if (cgs.lms_mode == 0) {
ADDRGP4 cgs+34820
INDIRI4
CNSTI4 0
NEI4 $553
line 1064
;1064:		s = va("LMS: Point/round + OT");
ADDRGP4 $556
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1065
;1065:	}
ADDRGP4 $554
JUMPV
LABELV $553
line 1066
;1066:	else if (cgs.lms_mode == 1) {
ADDRGP4 cgs+34820
INDIRI4
CNSTI4 1
NEI4 $557
line 1067
;1067:		s = va("LMS: Point/round - OT");
ADDRGP4 $560
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1068
;1068:	}
ADDRGP4 $558
JUMPV
LABELV $557
line 1069
;1069:	else if (cgs.lms_mode == 2) {
ADDRGP4 cgs+34820
INDIRI4
CNSTI4 2
NEI4 $561
line 1070
;1070:		s = va("LMS: Point/kill + OT");
ADDRGP4 $564
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1071
;1071:	}
ADDRGP4 $562
JUMPV
LABELV $561
line 1072
;1072:	else if (cgs.lms_mode == 3) {
ADDRGP4 cgs+34820
INDIRI4
CNSTI4 3
NEI4 $565
line 1073
;1073:		s = va("LMS: Point/kill - OT");
ADDRGP4 $568
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1074
;1074:	}
ADDRGP4 $566
JUMPV
LABELV $565
line 1075
;1075:	else {
line 1076
;1076:		s = va("LMS: Unknown mode");
ADDRGP4 $569
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1077
;1077:	}
LABELV $566
LABELV $562
LABELV $558
LABELV $554
line 1079
;1078:
;1079:	w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1080
;1080:	CG_DrawSmallString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 1082
;1081:
;1082:	return y + SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $552
endproc CG_DrawLMSmode 12 16
proc CG_DrawCTFoneway 28 16
line 1091
;1083:}
;1084:
;1085:/*
;1086:=================
;1087:CG_DrawCTFoneway
;1088:=================
;1089: */
;1090:
;1091:static float CG_DrawCTFoneway(float y) {
line 1096
;1092:	char *s;
;1093:	int w;
;1094:	vec4_t color;
;1095:
;1096:	if (cgs.gametype != GT_CTF_ELIMINATION)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
EQI4 $571
line 1097
;1097:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $570
JUMPV
LABELV $571
line 1099
;1098:
;1099:	memcpy(color, g_color_table[ColorIndex(COLOR_WHITE)], sizeof (color));
ADDRLP4 0
ARGP4
ADDRGP4 g_color_table+112
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1101
;1100:
;1101:	if ((cgs.elimflags & EF_ONEWAY) == 0) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $575
line 1102
;1102:		return y; //nothing to draw
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $570
JUMPV
LABELV $575
line 1104
;1103:	}
;1104:	else if (cgs.attackingTeam == TEAM_BLUE) {
ADDRGP4 cgs+34816
INDIRI4
CNSTI4 2
NEI4 $578
line 1105
;1105:		memcpy(color, g_color_table[ColorIndex(COLOR_BLUE)], sizeof (color));
ADDRLP4 0
ARGP4
ADDRGP4 g_color_table+64
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1106
;1106:		s = va("Blue team on offence");
ADDRGP4 $582
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
ASGNP4
line 1107
;1107:	}
ADDRGP4 $579
JUMPV
LABELV $578
line 1108
;1108:	else if (cgs.attackingTeam == TEAM_RED) {
ADDRGP4 cgs+34816
INDIRI4
CNSTI4 1
NEI4 $583
line 1109
;1109:		memcpy(color, g_color_table[ColorIndex(COLOR_RED)], sizeof (color));
ADDRLP4 0
ARGP4
ADDRGP4 g_color_table+16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1110
;1110:		s = va("Red team on offence");
ADDRGP4 $587
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
ASGNP4
line 1111
;1111:	}
ADDRGP4 $584
JUMPV
LABELV $583
line 1112
;1112:	else {
line 1113
;1113:		s = va("Unknown team on offence");
ADDRGP4 $588
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
ASGNP4
line 1114
;1114:	}
LABELV $584
LABELV $579
line 1117
;1115:
;1116:
;1117:	w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1118
;1118:	CG_DrawSmallStringColor(635 - w, y + 2, s, color);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 1120
;1119:
;1120:	return y + SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $570
endproc CG_DrawCTFoneway 28 16
proc CG_DrawDomStatus 44 16
line 1129
;1121:}
;1122:
;1123:/*
;1124:=================
;1125:CG_DrawDomStatus
;1126:=================
;1127: */
;1128:
;1129:static float CG_DrawDomStatus(float y) {
line 1134
;1130:	int i, w;
;1131:	char *s;
;1132:	vec4_t color;
;1133:
;1134:	for (i = 0; i < cgs.domination_points_count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $593
JUMPV
LABELV $590
line 1135
;1135:		switch (cgs.domination_points_status[i]) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34956
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $599
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $601
ADDRGP4 $595
JUMPV
LABELV $599
line 1137
;1136:			case TEAM_RED:
;1137:				memcpy(color, g_color_table[ColorIndex(COLOR_RED)], sizeof (color));
ADDRLP4 12
ARGP4
ADDRGP4 g_color_table+16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1138
;1138:				break;
ADDRGP4 $596
JUMPV
LABELV $601
line 1140
;1139:			case TEAM_BLUE:
;1140:				memcpy(color, g_color_table[ColorIndex(COLOR_BLUE)], sizeof (color));
ADDRLP4 12
ARGP4
ADDRGP4 g_color_table+64
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1141
;1141:				break;
ADDRGP4 $596
JUMPV
LABELV $595
line 1143
;1142:			default:
;1143:				memcpy(color, g_color_table[ColorIndex(COLOR_WHITE)], sizeof (color));
ADDRLP4 12
ARGP4
ADDRGP4 g_color_table+112
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1144
;1144:				break;
LABELV $596
line 1147
;1145:		}
;1146:
;1147:		s = va("%s", cgs.domination_points_names[i]);
ADDRGP4 $604
ARGP4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+34836
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
line 1148
;1148:		w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1149
;1149:		CG_DrawSmallStringColor(635 - w, y + 2, s, color);
CNSTI4 635
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 1150
;1150:		y += SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 1152
;1151:
;1152:	}
LABELV $591
line 1134
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $593
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+34832
INDIRI4
LTI4 $590
line 1154
;1153:
;1154:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $589
endproc CG_DrawDomStatus 44 16
proc CG_DrawEliminationTimer 80 36
line 1162
;1155:}
;1156:
;1157:/*
;1158:=================
;1159:CG_DrawEliminationTimer
;1160:=================
;1161: */
;1162:static float CG_DrawEliminationTimer(float y) {
line 1175
;1163:	char *s;
;1164:	int w;
;1165:	int mins, seconds, tens, sec;
;1166:	int msec;
;1167:	vec4_t color;
;1168:	const char *st __attribute__ ((unused));
;1169:	float scale __attribute__ ((unused));
;1170:	int cw __attribute__ ((unused));
;1171:	int rst;
;1172:
;1173:
;1174:
;1175:	rst = cgs.roundStartTime;
ADDRLP4 24
ADDRGP4 cgs+34808
INDIRI4
ASGNI4
line 1177
;1176:
;1177:	if (cg.time > rst && !cgs.roundtime) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $608
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 0
NEI4 $608
line 1178
;1178:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $606
JUMPV
LABELV $608
line 1182
;1179:	}
;1180:
;1181:	//default color is white
;1182:	memcpy(color, g_color_table[ColorIndex(COLOR_WHITE)], sizeof (color));
ADDRLP4 8
ARGP4
ADDRGP4 g_color_table+112
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1185
;1183:
;1184:	//msec = cg.time - cgs.levelStartTime;
;1185:	if (cg.time > rst) //We are started
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $613
line 1186
;1186:	{
line 1187
;1187:		msec = cgs.roundtime * 1000 - (cg.time - rst);
ADDRLP4 4
CNSTI4 1000
ADDRGP4 cgs+34812
INDIRI4
MULI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
SUBI4
ASGNI4
line 1188
;1188:		if (msec <= 30 * 1000 - 1) //<= 30 seconds
ADDRLP4 4
INDIRI4
CNSTI4 29999
GTI4 $618
line 1189
;1189:			memcpy(color, g_color_table[ColorIndex(COLOR_YELLOW)], sizeof (color));
ADDRLP4 8
ARGP4
ADDRGP4 g_color_table+48
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $618
line 1190
;1190:		if (msec <= 10 * 1000 - 1) //<= 10 seconds
ADDRLP4 4
INDIRI4
CNSTI4 9999
GTI4 $621
line 1191
;1191:			memcpy(color, g_color_table[ColorIndex(COLOR_RED)], sizeof (color));
ADDRLP4 8
ARGP4
ADDRGP4 g_color_table+16
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $621
line 1192
;1192:		msec += 1000; //120-1 instead of 119-0
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1193
;1193:	} else {
ADDRGP4 $614
JUMPV
LABELV $613
line 1195
;1194:		//Warmup
;1195:		msec = -cg.time + rst;
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
NEGI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 1196
;1196:		memcpy(color, g_color_table[ColorIndex(COLOR_GREEN)], sizeof (color));
ADDRLP4 8
ARGP4
ADDRGP4 g_color_table+32
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1197
;1197:		sec = msec / 1000;
ADDRLP4 44
ADDRLP4 4
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1198
;1198:		msec += 1000; //5-1 instead of 4-0
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1202
;1199:		/***
;1200:		Lots of stuff
;1201:		 ****/
;1202:		if (cg.warmup == 0) {
ADDRGP4 cg+125248
INDIRI4
CNSTI4 0
NEI4 $626
line 1203
;1203:			st = va("Round in: %i", sec + 1);
ADDRGP4 $629
ARGP4
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 60
INDIRP4
ASGNP4
line 1204
;1204:			if (sec != cg.warmupCount) {
ADDRLP4 44
INDIRI4
ADDRGP4 cg+125252
INDIRI4
EQI4 $630
line 1205
;1205:				cg.warmupCount = sec;
ADDRGP4 cg+125252
ADDRLP4 44
INDIRI4
ASGNI4
line 1206
;1206:				switch (sec) {
ADDRLP4 64
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $636
ADDRLP4 64
INDIRI4
CNSTI4 1
EQI4 $639
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $642
ADDRGP4 $635
JUMPV
LABELV $636
line 1208
;1207:					case 0:
;1208:						trap_S_StartLocalSound(cgs.media.count1Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1364
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1209
;1209:						break;
ADDRGP4 $635
JUMPV
LABELV $639
line 1211
;1210:					case 1:
;1211:						trap_S_StartLocalSound(cgs.media.count2Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1360
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1212
;1212:						break;
ADDRGP4 $635
JUMPV
LABELV $642
line 1214
;1213:					case 2:
;1214:						trap_S_StartLocalSound(cgs.media.count3Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1356
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1215
;1215:						break;
line 1217
;1216:					default:
;1217:						break;
LABELV $635
line 1219
;1218:				}
;1219:			}
LABELV $630
line 1220
;1220:			scale = 0.45f;
ADDRLP4 56
CNSTF4 1055286886
ASGNF4
line 1221
;1221:			switch (cg.warmupCount) {
ADDRLP4 64
ADDRGP4 cg+125252
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $648
ADDRLP4 64
INDIRI4
CNSTI4 1
EQI4 $649
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $650
ADDRGP4 $645
JUMPV
LABELV $648
line 1223
;1222:				case 0:
;1223:					cw = 28;
ADDRLP4 48
CNSTI4 28
ASGNI4
line 1224
;1224:					scale = 0.54f;
ADDRLP4 56
CNSTF4 1057635697
ASGNF4
line 1225
;1225:					break;
ADDRGP4 $646
JUMPV
LABELV $649
line 1227
;1226:				case 1:
;1227:					cw = 24;
ADDRLP4 48
CNSTI4 24
ASGNI4
line 1228
;1228:					scale = 0.51f;
ADDRLP4 56
CNSTF4 1057132380
ASGNF4
line 1229
;1229:					break;
ADDRGP4 $646
JUMPV
LABELV $650
line 1231
;1230:				case 2:
;1231:					cw = 20;
ADDRLP4 48
CNSTI4 20
ASGNI4
line 1232
;1232:					scale = 0.48f;
ADDRLP4 56
CNSTF4 1056293519
ASGNF4
line 1233
;1233:					break;
ADDRGP4 $646
JUMPV
LABELV $645
line 1235
;1234:				default:
;1235:					cw = 16;
ADDRLP4 48
CNSTI4 16
ASGNI4
line 1236
;1236:					scale = 0.45f;
ADDRLP4 56
CNSTF4 1055286886
ASGNF4
line 1237
;1237:					break;
LABELV $646
line 1245
;1238:			}
;1239:
;1240:#ifdef MISSIONPACK
;1241:			//w = CG_Text_Width(s, scale, 0);
;1242:			//CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, st, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;1243:#else
;1244:
;1245:			w = CG_DrawStrlen(st);
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
ASGNI4
line 1246
;1246:			CG_DrawStringExt(320 - w * cw / 2, 70, st, colorWhite,
ADDRLP4 72
ADDRLP4 48
INDIRI4
ASGNI4
CNSTI4 320
ADDRLP4 32
INDIRI4
ADDRLP4 72
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 72
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1249
;1247:					qfalse, qtrue, cw, (int) (cw * 1.5), 0);
;1248:#endif
;1249:		}
LABELV $626
line 1253
;1250:		/*
;1251:		Lots of stuff
;1252:		 */
;1253:	}
LABELV $614
line 1255
;1254:
;1255:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1256
;1256:	mins = seconds / 60;
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1257
;1257:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 36
INDIRI4
MULI4
SUBI4
ASGNI4
line 1258
;1258:	tens = seconds / 10;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1259
;1259:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 40
INDIRI4
MULI4
SUBI4
ASGNI4
line 1261
;1260:
;1261:	if (msec >= 0)
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $651
line 1262
;1262:		s = va(" %i:%i%i", mins, tens, seconds);
ADDRGP4 $653
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
ASGNP4
ADDRGP4 $652
JUMPV
LABELV $651
line 1264
;1263:	else
;1264:		s = va(" Overtime");
ADDRGP4 $654
ARGP4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 64
INDIRP4
ASGNP4
LABELV $652
line 1265
;1265:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 68
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1267
;1266:
;1267:	CG_DrawBigStringColor(635 - w, y + 2, s, color);
CNSTI4 635
ADDRLP4 32
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 1269
;1268:
;1269:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $606
endproc CG_DrawEliminationTimer 80 36
proc CG_DrawTeamOverlay 148 36
line 1278
;1270:}
;1271:
;1272:/*
;1273:=================
;1274:CG_DrawTeamOverlay
;1275:=================
;1276: */
;1277:
;1278:static float CG_DrawTeamOverlay(float y, qboolean right, qboolean upper) {
line 1290
;1279:	int x, w, h, xx;
;1280:	int i, j, len;
;1281:	const char *p;
;1282:	vec4_t hcolor;
;1283:	int pwidth, lwidth;
;1284:	int plyrs;
;1285:	char st[16];
;1286:	clientInfo_t *ci;
;1287:	gitem_t *item;
;1288:	int ret_y, count;
;1289:
;1290:	if (!cg_drawTeamOverlay.integer) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $656
line 1291
;1291:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $655
JUMPV
LABELV $656
line 1294
;1292:	}
;1293:
;1294:	if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE) {
ADDRLP4 92
CNSTI4 304
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $659
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $659
line 1295
;1295:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $655
JUMPV
LABELV $659
line 1298
;1296:	}
;1297:
;1298:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 1301
;1299:
;1300:	// max player name width
;1301:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 1302
;1302:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $664
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $665
JUMPV
LABELV $664
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $665
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 1303
;1303:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $669
JUMPV
LABELV $666
line 1304
;1304:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 2120
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1305
;1305:		if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $671
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $671
line 1306
;1306:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1307
;1307:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 1308
;1308:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $674
line 1309
;1309:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $674
line 1310
;1310:		}
LABELV $671
line 1311
;1311:	}
LABELV $667
line 1303
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $669
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $666
line 1313
;1312:
;1313:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $676
line 1314
;1314:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $655
JUMPV
LABELV $676
line 1316
;1315:
;1316:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $678
line 1317
;1317:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $678
line 1320
;1318:
;1319:	// max location name width
;1320:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1321
;1321:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $680
line 1322
;1322:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 1323
;1323:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $684
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $684
line 1324
;1324:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 1325
;1325:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $686
line 1326
;1326:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $686
line 1327
;1327:		}
LABELV $684
line 1328
;1328:	}
LABELV $681
line 1321
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $680
line 1330
;1329:
;1330:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $688
line 1331
;1331:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $688
line 1333
;1332:
;1333:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 1335
;1334:
;1335:	if (right)
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $690
line 1336
;1336:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $691
JUMPV
LABELV $690
line 1338
;1337:	else
;1338:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $691
line 1340
;1339:
;1340:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1342
;1341:
;1342:	if (upper) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $692
line 1343
;1343:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 1344
;1344:	} else {
ADDRGP4 $693
JUMPV
LABELV $692
line 1345
;1345:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1346
;1346:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 1347
;1347:	}
LABELV $693
line 1349
;1348:
;1349:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $694
line 1350
;1350:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 1351
;1351:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1352
;1352:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1353
;1353:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1354
;1354:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $695
JUMPV
LABELV $694
line 1355
;1355:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1356
;1356:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1357
;1357:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 1358
;1358:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1359
;1359:	}
LABELV $695
line 1360
;1360:	trap_R_SetColor(hcolor);
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1361
;1361:	CG_DrawPic(x, y, w, h, cgs.media.teamStatusBar);
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+180268+192
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1362
;1362:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1364
;1363:
;1364:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $708
JUMPV
LABELV $705
line 1365
;1365:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 2120
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 1366
;1366:		if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $710
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $710
line 1368
;1367:
;1368:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 1370
;1369:
;1370:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1372
;1371:
;1372:			CG_DrawStringExt(xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1376
;1373:					ci->name, hcolor, qfalse, qfalse,
;1374:					TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;1375:
;1376:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $716
line 1377
;1377:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 1378
;1378:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $720
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $718
LABELV $720
line 1379
;1379:					p = "unknown";
ADDRLP4 20
ADDRGP4 $721
ASGNP4
LABELV $718
line 1380
;1380:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 1381
;1381:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $722
line 1382
;1382:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $722
line 1386
;1383:
;1384:				//				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;1385:				//					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;1386:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1387
;1387:				CG_DrawStringExt(xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1390
;1388:						p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;1389:						TEAM_OVERLAY_MAXLOCATION_WIDTH);
;1390:			}
LABELV $716
line 1392
;1391:
;1392:			CG_GetColorForHealth(ci->health, ci->armor, hcolor);
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 1394
;1393:
;1394:			Com_sprintf(st, sizeof (st), "%3i %3i", ci->health, ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $724
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1396
;1395:
;1396:			xx = x + TINYCHAR_WIDTH * 3 +
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 1399
;1397:					TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1398:
;1399:			CG_DrawStringExt(xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1404
;1400:					st, hcolor, qfalse, qfalse,
;1401:					TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;1402:
;1403:			// draw weapon icon
;1404:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 1406
;1405:
;1406:			if (cg_weapons[ci->curWeapon].weaponIcon) {
CNSTI4 172
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $725
line 1407
;1407:				CG_DrawPic(xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
CNSTI4 172
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1409
;1408:						cg_weapons[ci->curWeapon].weaponIcon);
;1409:			} else {
ADDRGP4 $726
JUMPV
LABELV $725
line 1410
;1410:				CG_DrawPic(xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 cgs+180268+196
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1412
;1411:						cgs.media.deferShader);
;1412:			}
LABELV $726
line 1415
;1413:
;1414:			// Draw powerup icons
;1415:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $731
line 1416
;1416:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 1417
;1417:			} else {
ADDRGP4 $732
JUMPV
LABELV $731
line 1418
;1418:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 1419
;1419:			}
LABELV $732
line 1420
;1420:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $733
line 1421
;1421:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $737
line 1423
;1422:
;1423:					item = BG_FindItemForPowerup(j);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 136
INDIRP4
ASGNP4
line 1425
;1424:
;1425:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $739
line 1426
;1426:						CG_DrawPic(xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1428
;1427:								trap_R_RegisterShader(item->icon));
;1428:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $741
line 1429
;1429:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1430
;1430:						} else {
ADDRGP4 $742
JUMPV
LABELV $741
line 1431
;1431:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1432
;1432:						}
LABELV $742
line 1433
;1433:					}
LABELV $739
line 1434
;1434:				}
LABELV $737
line 1435
;1435:			}
LABELV $734
line 1420
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $733
line 1437
;1436:
;1437:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1438
;1438:		}
LABELV $710
line 1439
;1439:	}
LABELV $706
line 1364
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $708
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $705
line 1441
;1440:
;1441:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $655
endproc CG_DrawTeamOverlay 148 36
proc CG_DrawFollowMessage 28 16
line 1445
;1442:	//#endif
;1443:}
;1444:
;1445:static float CG_DrawFollowMessage(float y) {
line 1449
;1446:	char *s;
;1447:	int w;
;1448:
;1449:	if (!(cg.snap->ps.pm_flags & PMF_FOLLOW) || ((cgs.elimflags & EF_NO_FREESPEC) && CG_IsARoundBasedGametype(cgs.gametype) && CG_IsATeamGametype(cgs.gametype))) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $750
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $744
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $744
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $744
LABELV $750
line 1450
;1450:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $743
JUMPV
LABELV $744
line 1453
;1451:	}
;1452:
;1453:	s = va("USE_ITEM to stop following");
ADDRGP4 $751
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1454
;1454:	w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1455
;1455:	CG_DrawSmallString(635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 1457
;1456:
;1457:	return y + SMALLCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $743
endproc CG_DrawFollowMessage 28 16
proc CG_DrawFragMsgIcons 52 36
line 1460
;1458:}
;1459:
;1460:static void CG_DrawFragMsgIcons(fragInfo_t fi, int i) {
line 1501
;1461:	int x_offset;
;1462:	int spacing;
;1463:#ifdef MISSIONPACK
;1464:	float *color;
;1465:	int imageWidth = 10;
;1466:	int imageHeight = 10;
;1467:#else
;1468:	vec4_t hcolor;
;1469:#endif
;1470:
;1471:#ifdef MISSIONPACK
;1472:	color = CG_FadeColor(fi.fragTime, FRAGMSG_FADETIME);
;1473:	if (!color) {
;1474:		trap_R_SetColor(NULL);
;1475:		return;
;1476:	}
;1477:	trap_R_SetColor(color);
;1478:
;1479:	spacing = 3;
;1480:
;1481:	if (fi.attackerName[0] != '\0') {
;1482:		CG_Text_Paint(FRAGMSG_X, FRAGMSG_Y + (i * 16), 0.20, color,
;1483:				fi.attackerName, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;1484:		x_offset = CG_Text_Width(fi.attackerName, 0.20, 0) + spacing;
;1485:	} else x_offset = 0;
;1486:
;1487:	CG_DrawPic(FRAGMSG_X + x_offset, FRAGMSG_Y + (i * 16) - imageHeight,
;1488:			imageWidth, imageHeight, fi.causeShader);
;1489:
;1490:	x_offset += imageWidth + spacing;
;1491:
;1492:	CG_Text_Paint(FRAGMSG_X + x_offset, FRAGMSG_Y + (i * 16), 0.20, color,
;1493:			fi.targetName, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;1494:
;1495:	if (fi.teamFrag) {
;1496:		x_offset += CG_Text_Width(fi.targetName, 0.20, 0) + spacing;
;1497:		CG_Text_Paint(FRAGMSG_X + x_offset, FRAGMSG_Y + (i * 16), 0.20, color,
;1498:				"(^1TEAMMATE^7)", 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;1499:	}
;1500:#else
;1501:	hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1502
;1502:	trap_R_SetColor(hcolor);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1503
;1503:	spacing = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 1505
;1504:
;1505:	if (fi.attackerName[0] != '\0') {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $756
line 1506
;1506:		CG_DrawStringExt(FRAGMSG_X, FRAGMSG_Y + (i * TINYCHAR_HEIGHT),
CNSTI4 20
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 300
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1509
;1507:				fi.attackerName, hcolor, qfalse, qfalse,
;1508:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;1509:		x_offset = CG_DrawStrlen(fi.attackerName) * TINYCHAR_WIDTH + spacing;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 1510
;1510:	} else x_offset = 0;
ADDRGP4 $757
JUMPV
LABELV $756
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $757
line 1512
;1511:
;1512:	CG_DrawPic(FRAGMSG_X + x_offset, FRAGMSG_Y + (i * TINYCHAR_HEIGHT),
ADDRLP4 16
INDIRI4
CNSTI4 20
ADDI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 300
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
CNSTF4 1090519040
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1515
;1513:			TINYCHAR_WIDTH, TINYCHAR_HEIGHT, fi.causeShader);
;1514:
;1515:	x_offset += TINYCHAR_WIDTH + spacing;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 8
ADDI4
ADDI4
ASGNI4
line 1517
;1516:
;1517:	CG_DrawStringExt(FRAGMSG_X + x_offset, FRAGMSG_Y + (i * TINYCHAR_HEIGHT),
ADDRLP4 16
INDIRI4
CNSTI4 20
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 300
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1521
;1518:			fi.targetName, hcolor, qfalse, qfalse,
;1519:			TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;1520:
;1521:	if (fi.teamFrag) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $758
line 1522
;1522:		x_offset += CG_DrawStrlen(fi.targetName) * TINYCHAR_WIDTH + spacing;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 3
LSHI4
ADDRLP4 20
INDIRI4
ADDI4
ADDI4
ASGNI4
line 1523
;1523:		CG_DrawStringExt(FRAGMSG_X + x_offset,
ADDRLP4 16
INDIRI4
CNSTI4 20
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 300
ADDI4
ARGI4
ADDRGP4 $760
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1526
;1524:				FRAGMSG_Y + (i * TINYCHAR_HEIGHT), "(^1TEAMMATE^7)", hcolor,
;1525:				qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;1526:	}
LABELV $758
line 1529
;1527:
;1528:#endif
;1529:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1530
;1530:}
LABELV $752
endproc CG_DrawFragMsgIcons 52 36
proc CG_DrawFragMsgText 28 36
line 1532
;1531:
;1532:static void CG_DrawFragMsgText(char *msg, int i) {
line 1549
;1533:#ifdef MISSIONPACK
;1534:	float *color;
;1535:#else
;1536:	vec4_t hcolor;
;1537:#endif
;1538:
;1539:#ifdef MISSIONPACK
;1540:	color = CG_FadeColor(cgs.fragMsg[i].fragTime, FRAGMSG_FADETIME);
;1541:	if (!color) {
;1542:		trap_R_SetColor(NULL);
;1543:		return;
;1544:	}
;1545:	trap_R_SetColor(color);
;1546:	CG_Text_Paint(FRAGMSG_X, FRAGMSG_Y + (i * 13), 0.20, color, msg, 0, 0,
;1547:			ITEM_TEXTSTYLE_SHADOWED);
;1548:#else
;1549:	hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1550
;1550:	trap_R_SetColor(hcolor);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1552
;1551:
;1552:	CG_DrawStringExt(FRAGMSG_X, FRAGMSG_Y + (i * TINYCHAR_HEIGHT),
CNSTI4 20
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 300
ADDI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1555
;1553:			msg, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;1554:#endif
;1555:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1556
;1556:}
LABELV $761
endproc CG_DrawFragMsgText 28 36
proc CG_DrawFragMessage 284 12
line 1558
;1557:
;1558:static void CG_DrawFragMessage(void) {
line 1560
;1559:	int i;
;1560:	for (i = FRAGMSG_MAX - 1; i >= 0; i--) {
ADDRLP4 0
CNSTI4 4
ASGNI4
LABELV $766
line 1561
;1561:		if (cgs.fragMsg[i].targetName[0] != '\0') {
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $770
line 1563
;1562:			// remove frag message after elapsed time
;1563:			if (cg.time > cgs.fragMsg[i].fragTime + FRAGMSG_FADETIME) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828+68
ADDP4
INDIRI4
CNSTI4 7000
ADDI4
LEI4 $773
line 1564
;1564:				memset(&cgs.fragMsg[i], 0, sizeof (fragInfo_t));
ADDRLP4 4
CNSTI4 276
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1565
;1565:			}
LABELV $773
line 1566
;1566:		}
LABELV $770
line 1567
;1567:		if (cgs.fragMsg[i].targetName[0] != '\0') {
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $779
line 1568
;1568:			if (cg_obituaryOutput.integer == 2) {
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 2
NEI4 $782
line 1569
;1569:				CG_DrawFragMsgText(cgs.fragMsg[i].message, i);
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828+76
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawFragMsgText
CALLV
pop
line 1570
;1570:			} else if (cg_obituaryOutput.integer >= 3) {
ADDRGP4 $783
JUMPV
LABELV $782
ADDRGP4 cg_obituaryOutput+12
INDIRI4
CNSTI4 3
LTI4 $787
line 1571
;1571:				CG_DrawFragMsgIcons(cgs.fragMsg[i], i);
ADDRLP4 4
CNSTI4 276
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+178828
ADDP4
INDIRB
ASGNB 276
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawFragMsgIcons
CALLV
pop
line 1572
;1572:			}
LABELV $787
LABELV $783
line 1573
;1573:		}
LABELV $779
line 1574
;1574:	}
LABELV $767
line 1560
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $766
line 1575
;1575:}
LABELV $765
endproc CG_DrawFragMessage 284 12
proc CG_DrawUpperRight 28 12
line 1583
;1576:
;1577:/*
;1578:=====================
;1579:CG_DrawUpperRight
;1580:
;1581:=====================
;1582: */
;1583:static void CG_DrawUpperRight(stereoFrame_t stereoFrame) {
line 1586
;1584:	float y;
;1585:
;1586:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1588
;1587:
;1588:	if (CG_IsATeamGametype(cgs.gametype) && cg_drawTeamOverlay.integer == 1) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $792
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $792
line 1589
;1589:		y = CG_DrawTeamOverlay(y, qtrue, qtrue);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1590
;1590:	}
LABELV $792
line 1595
;1591:	/*if ( cgs.gametype == GT_DOUBLE_D ) {
;1592:		y = CG_DrawDoubleDominationThings(y);
;1593:	} 
;1594:	else*/
;1595:	if (cgs.gametype == GT_LMS && cg.showScores) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 10
NEI4 $796
ADDRGP4 cg+114784
INDIRI4
CNSTI4 0
EQI4 $796
line 1596
;1596:		y = CG_DrawLMSmode(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawLMSmode
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1597
;1597:	} else
ADDRGP4 $797
JUMPV
LABELV $796
line 1598
;1598:		if (cgs.gametype == GT_CTF_ELIMINATION) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $800
line 1599
;1599:		y = CG_DrawCTFoneway(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawCTFoneway
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1600
;1600:	} else
ADDRGP4 $801
JUMPV
LABELV $800
line 1601
;1601:		if (cgs.gametype == GT_DOMINATION) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 12
NEI4 $803
line 1602
;1602:		y = CG_DrawDomStatus(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawDomStatus
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1603
;1603:	} else if (cgs.gametype == GT_POSSESSION) {
ADDRGP4 $804
JUMPV
LABELV $803
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 13
NEI4 $806
line 1604
;1604:		y = CG_DrawPossessionString(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPossessionString
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1605
;1605:	}
LABELV $806
LABELV $804
LABELV $801
LABELV $797
line 1607
;1606:
;1607:	if (cg_drawSnapshot.integer) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $809
line 1608
;1608:		y = CG_DrawSnapshot(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1609
;1609:	}
LABELV $809
line 1610
;1610:	if (cg_drawFPS.integer && (stereoFrame == STEREO_CENTER || stereoFrame == STEREO_RIGHT)) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 cg_drawFPS+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $812
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $815
ADDRLP4 12
INDIRI4
CNSTI4 2
NEI4 $812
LABELV $815
line 1611
;1611:		y = CG_DrawFPS(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1612
;1612:	}
LABELV $812
line 1613
;1613:	if (CG_IsARoundBasedGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $816
line 1614
;1614:		y = CG_DrawEliminationTimer(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 CG_DrawEliminationTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1617
;1615:		/*if (cgs.clientinfo[ cg.clientNum ].isDead)
;1616:			y = CG_DrawEliminationDeathMessage( y);*/
;1617:	}
LABELV $816
line 1619
;1618:
;1619:	y = CG_DrawFollowMessage(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 CG_DrawFollowMessage
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1621
;1620:
;1621:	if (cg_drawTimer.integer) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $819
line 1622
;1622:		y = CG_DrawTimer(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1623
;1623:	}
LABELV $819
line 1624
;1624:	if (cg_drawAttacker.integer) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $822
line 1625
;1625:		y = CG_DrawAttacker(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1626
;1626:	}
LABELV $822
line 1627
;1627:	if (cg_drawSpeed.integer) {
ADDRGP4 cg_drawSpeed+12
INDIRI4
CNSTI4 0
EQI4 $825
line 1628
;1628:		y = CG_DrawSpeedMeter(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 CG_DrawSpeedMeter
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1629
;1629:	}
LABELV $825
line 1631
;1630:
;1631:}
LABELV $791
endproc CG_DrawUpperRight 28 12
proc CG_DrawScores 116 20
line 1650
;1632:
;1633:/*
;1634:===========================================================================================
;1635:
;1636: LOWER RIGHT CORNER
;1637:
;1638:===========================================================================================
;1639: */
;1640:
;1641:/*
;1642:=================
;1643:CG_DrawScores
;1644:
;1645:Draw the small two score display
;1646:=================
;1647: */
;1648:#ifndef MISSIONPACK
;1649:
;1650:static float CG_DrawScores(float y) {
line 1660
;1651:	const char *s;
;1652:	int s1, s2, score;
;1653:	int x, w;
;1654:	int v;
;1655:	vec4_t color;
;1656:	float y1;
;1657:	gitem_t *item;
;1658:	int statusA, statusB;
;1659:
;1660:	statusA = cgs.redflag;
ADDRLP4 44
ADDRGP4 cgs+34988
INDIRI4
ASGNI4
line 1661
;1661:	statusB = cgs.blueflag;
ADDRLP4 48
ADDRGP4 cgs+34992
INDIRI4
ASGNI4
line 1663
;1662:
;1663:	s1 = cgs.scores1;
ADDRLP4 28
ADDRGP4 cgs+34980
INDIRI4
ASGNI4
line 1664
;1664:	s2 = cgs.scores2;
ADDRLP4 36
ADDRGP4 cgs+34984
INDIRI4
ASGNI4
line 1666
;1665:
;1666:	y -= BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1668
;1667:
;1668:	y1 = y;
ADDRLP4 32
ADDRFP4 0
INDIRF4
ASGNF4
line 1671
;1669:
;1670:	// draw from the right side to left
;1671:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $833
line 1672
;1672:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1673
;1673:		color[0] = 0.0f;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1674
;1674:		color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1675
;1675:		color[2] = 1.0f;
ADDRLP4 4+8
CNSTF4 1065353216
ASGNF4
line 1676
;1676:		color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1677
;1677:		s = va("%2i", s2);
ADDRGP4 $839
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 64
INDIRP4
ASGNP4
line 1678
;1678:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 68
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1679
;1679:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1680
;1680:		CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1681
;1681:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $840
line 1682
;1682:			CG_DrawPic(x, y - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.selectShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+180268+276
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1683
;1683:		}
LABELV $840
line 1684
;1684:		CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1686
;1685:
;1686:		if (CG_UsesTeamFlags(cgs.gametype) && !CG_UsesTheWhiteFlag(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $845
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $845
line 1688
;1687:			// Display flag status
;1688:			item = BG_FindItemForPowerup(PW_BLUEFLAG);
CNSTI4 8
ARGI4
ADDRLP4 80
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 80
INDIRP4
ASGNP4
line 1690
;1689:
;1690:			if (item) {
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $849
line 1691
;1691:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 32
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1692
;1692:				if (cgs.blueflag >= 0 && cgs.blueflag <= 2) {
ADDRGP4 cgs+34992
INDIRI4
CNSTI4 0
LTI4 $851
ADDRGP4 cgs+34992
INDIRI4
CNSTI4 2
GTI4 $851
line 1693
;1693:					CG_DrawPic(x, y1 - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.blueFlagShader[cgs.blueflag]);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34992
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+60
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1694
;1694:				}
LABELV $851
line 1695
;1695:			}
LABELV $849
line 1696
;1696:		}
LABELV $845
line 1698
;1697:
;1698:		if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $858
line 1701
;1699:			// Display Domination point status
;1700:
;1701:			y1 = y - 32; //BIGCHAR_HEIGHT - 8;
ADDRLP4 32
ADDRFP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 1702
;1702:			if (cgs.redflag >= 0 && cgs.redflag <= 3) {
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 0
LTI4 $861
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 3
GTI4 $861
line 1703
;1703:				CG_DrawPic(x, y1 - 4, w, 32, cgs.media.ddPointSkinB[cgs.blueflag]);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+34992
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+104
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1704
;1704:			}
LABELV $861
line 1705
;1705:		}
LABELV $858
line 1707
;1706:
;1707:		color[0] = 1.0f;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1708
;1708:		color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1709
;1709:		color[2] = 0.0f;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1710
;1710:		color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1711
;1711:		s = va("%2i", s1);
ADDRGP4 $839
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 80
INDIRP4
ASGNP4
line 1712
;1712:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 84
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1713
;1713:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1714
;1714:		CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1715
;1715:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $871
line 1716
;1716:			CG_DrawPic(x, y - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.selectShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+180268+276
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1717
;1717:		}
LABELV $871
line 1718
;1718:		CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1720
;1719:
;1720:		if (CG_UsesTeamFlags(cgs.gametype) && !CG_UsesTheWhiteFlag(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $876
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $876
line 1722
;1721:			// Display flag status
;1722:			item = BG_FindItemForPowerup(PW_REDFLAG);
CNSTI4 7
ARGI4
ADDRLP4 96
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 96
INDIRP4
ASGNP4
line 1724
;1723:
;1724:			if (item) {
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $880
line 1725
;1725:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 32
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1726
;1726:				if (cgs.redflag >= 0 && cgs.redflag <= 2) {
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 0
LTI4 $882
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 2
GTI4 $882
line 1727
;1727:					CG_DrawPic(x, y1 - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.redFlagShader[cgs.redflag]);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1728
;1728:				}
LABELV $882
line 1729
;1729:			}
LABELV $880
line 1730
;1730:		}
LABELV $876
line 1732
;1731:
;1732:		if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $889
line 1735
;1733:			// Display Domination point status
;1734:
;1735:			y1 = y - 32; //BIGCHAR_HEIGHT - 8;
ADDRLP4 32
ADDRFP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 1736
;1736:			if (cgs.redflag >= 0 && cgs.redflag <= 3) {
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 0
LTI4 $892
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 3
GTI4 $892
line 1737
;1737:				CG_DrawPic(x, y1 - 4, w, 32, cgs.media.ddPointSkinA[cgs.redflag]);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 cgs+34988
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1738
;1738:			}
LABELV $892
line 1743
;1739:
;1740:
;1741:
;1742:			//Time till capture:
;1743:			if (((statusB == statusA) && (statusA == TEAM_RED)) ||
ADDRLP4 96
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $902
ADDRLP4 96
INDIRI4
CNSTI4 1
EQI4 $901
LABELV $902
ADDRLP4 100
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 100
INDIRI4
NEI4 $899
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $899
LABELV $901
line 1744
;1744:					((statusB == statusA) && (statusA == TEAM_BLUE))) {
line 1745
;1745:				s = va("%i", (cgs.takeAt - cg.time) / 1000 + 1);
ADDRGP4 $111
ARGP4
ADDRGP4 cgs+34828
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 104
INDIRP4
ASGNP4
line 1746
;1746:				w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 108
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1747
;1747:				CG_DrawBigString(x + 32 + 8 - w / 2, y - 28, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
CNSTI4 8
ADDI4
ADDRLP4 24
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1105199104
SUBF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1748
;1748:			}
LABELV $899
line 1749
;1749:		}
LABELV $889
line 1751
;1750:
;1751:		if (cgs.gametype == GT_OBELISK) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 6
NEI4 $905
line 1752
;1752:			s = va("^1%3i%% ^4%3i%%", cg.redObeliskHealth, cg.blueObeliskHealth);
ADDRGP4 $908
ARGP4
ADDRGP4 cg+156536
INDIRI4
ARGI4
ADDRGP4 cg+156540
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 96
INDIRP4
ASGNP4
line 1753
;1753:			CG_DrawSmallString(x, y - 28, s, 1.0F);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1105199104
SUBF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 1754
;1754:		}
LABELV $905
line 1756
;1755:
;1756:		if (CG_UsesTeamFlags(cgs.gametype) || CG_UsesTheWhiteFlag(cgs.gametype) ||
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_UsesTeamFlags
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $919
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_UsesTheWhiteFlag
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $919
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $919
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $911
LABELV $919
line 1757
;1757:				CG_IsARoundBasedGametype(cgs.gametype) || cgs.gametype == GT_DOUBLE_D) {
line 1758
;1758:			v = cgs.capturelimit;
ADDRLP4 52
ADDRGP4 cgs+31480
INDIRI4
ASGNI4
line 1759
;1759:		} else {
ADDRGP4 $912
JUMPV
LABELV $911
line 1760
;1760:			v = cgs.fraglimit;
ADDRLP4 52
ADDRGP4 cgs+31476
INDIRI4
ASGNI4
line 1761
;1761:		}
LABELV $912
line 1762
;1762:		if (v) {
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $834
line 1763
;1763:			s = va("%2i", v);
ADDRGP4 $839
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 108
INDIRP4
ASGNP4
line 1764
;1764:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 112
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1765
;1765:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1766
;1766:			CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1767
;1767:		}
line 1769
;1768:
;1769:	} else {
ADDRGP4 $834
JUMPV
LABELV $833
line 1772
;1770:		qboolean spectator;
;1771:
;1772:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1773
;1773:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1774
;1774:		spectator = (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR);
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $927
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRGP4 $928
JUMPV
LABELV $927
ADDRLP4 68
CNSTI4 0
ASGNI4
LABELV $928
ADDRLP4 64
ADDRLP4 68
INDIRI4
ASGNI4
line 1777
;1775:
;1776:		// always show your score in the second box if not in first place
;1777:		if (s1 != score) {
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $929
line 1778
;1778:			s2 = score;
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1779
;1779:		}
LABELV $929
line 1780
;1780:		if (s2 != SCORE_NOT_PRESENT) {
ADDRLP4 36
INDIRI4
CNSTI4 -9999
EQI4 $931
line 1781
;1781:			s = va("%2i", s2);
ADDRGP4 $839
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 72
INDIRP4
ASGNP4
line 1782
;1782:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 76
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1783
;1783:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1784
;1784:			if (!spectator && score == s2 && score != s1) {
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $933
ADDRLP4 80
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $933
ADDRLP4 80
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $933
line 1785
;1785:				color[0] = 1.0f;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1786
;1786:				color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1787
;1787:				color[2] = 0.0f;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1788
;1788:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1789
;1789:				CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1790
;1790:				CG_DrawPic(x, y - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.selectShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+180268+276
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1791
;1791:			} else {
ADDRGP4 $934
JUMPV
LABELV $933
line 1792
;1792:				color[0] = 0.5f;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1793
;1793:				color[1] = 0.5f;
ADDRLP4 4+4
CNSTF4 1056964608
ASGNF4
line 1794
;1794:				color[2] = 0.5f;
ADDRLP4 4+8
CNSTF4 1056964608
ASGNF4
line 1795
;1795:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1796
;1796:				CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1797
;1797:			}
LABELV $934
line 1798
;1798:			CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1799
;1799:		}
LABELV $931
line 1802
;1800:
;1801:		// first place
;1802:		if (s1 != SCORE_NOT_PRESENT) {
ADDRLP4 28
INDIRI4
CNSTI4 -9999
EQI4 $943
line 1803
;1803:			s = va("%2i", s1);
ADDRGP4 $839
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 72
INDIRP4
ASGNP4
line 1804
;1804:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 76
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1805
;1805:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1806
;1806:			if (!spectator && score == s1) {
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $945
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $945
line 1807
;1807:				color[0] = 0.0f;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1808
;1808:				color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1809
;1809:				color[2] = 1.0f;
ADDRLP4 4+8
CNSTF4 1065353216
ASGNF4
line 1810
;1810:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1811
;1811:				CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1812
;1812:				CG_DrawPic(x, y - 4, w, BIGCHAR_HEIGHT + 8, cgs.media.selectShader);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+180268+276
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1813
;1813:			} else {
ADDRGP4 $946
JUMPV
LABELV $945
line 1814
;1814:				color[0] = 0.5f;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1815
;1815:				color[1] = 0.5f;
ADDRLP4 4+4
CNSTF4 1056964608
ASGNF4
line 1816
;1816:				color[2] = 0.5f;
ADDRLP4 4+8
CNSTF4 1056964608
ASGNF4
line 1817
;1817:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1818
;1818:				CG_FillRect(x, y - 4, w, BIGCHAR_HEIGHT + 8, color);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1819
;1819:			}
LABELV $946
line 1820
;1820:			CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1821
;1821:		}
LABELV $943
line 1823
;1822:
;1823:		if (cgs.fraglimit) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
EQI4 $955
line 1824
;1824:			s = va("%2i", cgs.fraglimit);
ADDRGP4 $839
ARGP4
ADDRGP4 cgs+31476
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 72
INDIRP4
ASGNP4
line 1825
;1825:			w = CG_DrawStrlen(s) * BIGCHAR_WIDTH + 8;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 76
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1826
;1826:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 1827
;1827:			CG_DrawBigString(x + 4, y, s, 1.0F);
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1828
;1828:		}
LABELV $955
line 1830
;1829:
;1830:	}
LABELV $834
line 1832
;1831:
;1832:	return y1 - 8;
ADDRLP4 32
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $828
endproc CG_DrawScores 116 20
data
align 4
LABELV $960
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 208 20
line 1843
;1833:}
;1834:#endif // MISSIONPACK
;1835:
;1836:/*
;1837:================
;1838:CG_DrawPowerups
;1839:================
;1840: */
;1841:#ifndef MISSIONPACK
;1842:
;1843:static float CG_DrawPowerups(float y) {
line 1860
;1844:	int sorted[MAX_POWERUPS];
;1845:	int sortedTime[MAX_POWERUPS];
;1846:	int i, j, k;
;1847:	int active;
;1848:	playerState_t *ps;
;1849:	int t;
;1850:	gitem_t *item;
;1851:	int x;
;1852:	int color;
;1853:	float size;
;1854:	float f;
;1855:	static float colors[2][4] = {
;1856:		{ 0.2f, 1.0f, 0.2f, 1.0f},
;1857:		{ 1.0f, 0.2f, 0.2f, 1.0f}
;1858:	};
;1859:
;1860:	ps = &cg.snap->ps;
ADDRLP4 152
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1862
;1861:
;1862:	if (ps->stats[STAT_HEALTH] <= 0) {
ADDRLP4 152
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $962
line 1863
;1863:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $959
JUMPV
LABELV $962
line 1867
;1864:	}
;1865:
;1866:	// sort the list by time remaining
;1867:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1868
;1868:	for (i = 0; i < MAX_POWERUPS; i++) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $964
line 1869
;1869:		if (!ps->powerups[ i ]) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 152
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $968
line 1870
;1870:			continue;
ADDRGP4 $965
JUMPV
LABELV $968
line 1875
;1871:		}
;1872:
;1873:		// ZOID--don't draw if the power up has unlimited time
;1874:		// This is true of the CTF flags
;1875:		if ( ps->powerups[ i ] == INT_MAX ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 152
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 2147483647
NEI4 $970
line 1876
;1876:			continue;
ADDRGP4 $965
JUMPV
LABELV $970
line 1879
;1877:		}
;1878:
;1879:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 152
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 1880
;1880:		if ( t <= 0 ) {
ADDRLP4 140
INDIRI4
CNSTI4 0
GTI4 $973
line 1881
;1881:			continue;
ADDRGP4 $965
JUMPV
LABELV $973
line 1884
;1882:		}
;1883:
;1884:		item = BG_FindItemForPowerup(i);
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 172
INDIRP4
ASGNP4
line 1885
;1885:		if (item && item->giType == IT_PERSISTANT_POWERUP)
ADDRLP4 148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $975
ADDRLP4 148
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $975
line 1886
;1886:			continue; //Don't draw persistant powerups here!
ADDRGP4 $965
JUMPV
LABELV $975
line 1889
;1887:
;1888:		// insert into the list
;1889:		for (j = 0; j < active; j++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $980
JUMPV
LABELV $977
line 1890
;1890:			if (sortedTime[j] >= t) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $981
line 1891
;1891:				for (k = active - 1; k >= j; k--) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $986
JUMPV
LABELV $983
line 1892
;1892:					sorted[k + 1] = sorted[k];
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 68+4
ADDP4
ADDRLP4 180
INDIRI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1893
;1893:					sortedTime[k + 1] = sortedTime[k];
ADDRLP4 184
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 184
INDIRI4
ADDRLP4 4+4
ADDP4
ADDRLP4 184
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1894
;1894:				}
LABELV $984
line 1891
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $986
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $983
line 1895
;1895:				break;
ADDRGP4 $979
JUMPV
LABELV $981
line 1897
;1896:			}
;1897:		}
LABELV $978
line 1889
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $980
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $977
LABELV $979
line 1898
;1898:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1899
;1899:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1900
;1900:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1901
;1901:	}
LABELV $965
line 1868
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $964
line 1904
;1902:
;1903:	// draw the icons and timers
;1904:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1905
;1905:	for (i = 0; i < active; i++) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $992
JUMPV
LABELV $989
line 1906
;1906:		item = BG_FindItemForPowerup(sorted[i]);
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 172
INDIRP4
ASGNP4
line 1908
;1907:
;1908:		if (item) {
ADDRLP4 148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $993
line 1910
;1909:
;1910:			color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1912
;1911:
;1912:			y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1914
;1913:
;1914:			trap_R_SetColor(colors[color]);
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $960
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1915
;1915:			CG_DrawField(x, y, 2, sortedTime[ i ] / 1000);
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
CNSTI4 2
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1917
;1916:
;1917:			t = ps->powerups[ sorted[i] ];
ADDRLP4 180
CNSTI4 2
ASGNI4
ADDRLP4 140
ADDRLP4 144
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 152
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1918
;1918:			if (t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $995
line 1919
;1919:				trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1920
;1920:			} else {
ADDRGP4 $996
JUMPV
LABELV $995
line 1923
;1921:				vec4_t modulate;
;1922:
;1923:				f = (float) (t - cg.time) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1924
;1924:				f -= (int) f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1925
;1925:				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 184+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 160
INDIRF4
ASGNF4
line 1926
;1926:				trap_R_SetColor(modulate);
ADDRLP4 184
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1927
;1927:			}
LABELV $996
line 1929
;1928:
;1929:			if (cg.powerupActive == sorted[i] &&
ADDRGP4 cg+125000
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $1002
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125004
INDIRI4
SUBI4
CNSTI4 200
GEI4 $1002
line 1930
;1930:					cg.time - cg.powerupTime < PULSE_TIME) {
line 1931
;1931:				f = 1.0 - (((float) cg.time - cg.powerupTime) / PULSE_TIME);
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+125004
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1932
;1932:				size = ICON_SIZE * (1.0 + (PULSE_SCALE - 1.0) * f);
ADDRLP4 156
CNSTF4 1111490560
CNSTF4 1056964608
ADDRLP4 160
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1933
;1933:			} else {
ADDRGP4 $1003
JUMPV
LABELV $1002
line 1934
;1934:				size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1935
;1935:			}
LABELV $1003
line 1937
;1936:
;1937:			CG_DrawPic(640 - size, y + ICON_SIZE / 2 - size / 2,
ADDRLP4 148
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1939
;1938:					size, size, trap_R_RegisterShader(item->icon));
;1939:		}
LABELV $993
line 1940
;1940:	}
LABELV $990
line 1905
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $992
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $989
line 1941
;1941:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1943
;1942:
;1943:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $959
endproc CG_DrawPowerups 208 20
proc CG_DrawLowerRight 16 12
line 1955
;1944:}
;1945:#endif // MISSIONPACK
;1946:
;1947:/*
;1948:=====================
;1949:CG_DrawLowerRight
;1950:
;1951:=====================
;1952: */
;1953:#ifndef MISSIONPACK
;1954:
;1955:static void CG_DrawLowerRight(void) {
line 1958
;1956:	float y;
;1957:
;1958:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1960
;1959:
;1960:	if (CG_IsATeamGametype(cgs.gametype) && cg_drawTeamOverlay.integer == 2) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1010
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $1010
line 1961
;1961:		y = CG_DrawTeamOverlay(y, qtrue, qfalse);
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1962
;1962:	}
LABELV $1010
line 1964
;1963:
;1964:	y = CG_DrawScores(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1965
;1965:	y = CG_DrawPowerups(y);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1966
;1966:}
LABELV $1009
endproc CG_DrawLowerRight 16 12
proc CG_DrawPickupItem 16 20
line 1976
;1967:#endif // MISSIONPACK
;1968:
;1969:/*
;1970:===================
;1971:CG_DrawPickupItem
;1972:===================
;1973: */
;1974:#ifndef MISSIONPACK
;1975:
;1976:static int CG_DrawPickupItem(int y) {
line 1980
;1977:	int value;
;1978:	float *fadeColor;
;1979:
;1980:	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1015
line 1981
;1981:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1014
JUMPV
LABELV $1015
line 1984
;1982:	}
;1983:
;1984:	y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
ASGNI4
line 1986
;1985:
;1986:	value = cg.itemPickup;
ADDRLP4 0
ADDRGP4 cg+125256
INDIRI4
ASGNI4
line 1987
;1987:	if (value) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1019
line 1988
;1988:		fadeColor = CG_FadeColor(cg.itemPickupTime, 3000);
ADDRGP4 cg+125260
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 8
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1989
;1989:		if (fadeColor) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1022
line 1990
;1990:			CG_RegisterItemVisuals(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1991
;1991:			trap_R_SetColor(fadeColor);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1992
;1992:			CG_DrawPic(8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon);
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1993
;1993:			CG_DrawBigString(ICON_SIZE + 16, y + (ICON_SIZE / 2 - BIGCHAR_HEIGHT / 2), bg_itemlist[ value ].pickup_name, fadeColor[0]);
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+28
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1994
;1994:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1995
;1995:		}
LABELV $1022
line 1996
;1996:	}
LABELV $1019
line 1998
;1997:
;1998:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $1014
endproc CG_DrawPickupItem 16 20
proc CG_DrawLowerLeft 16 12
line 2010
;1999:}
;2000:#endif // MISSIONPACK
;2001:
;2002:/*
;2003:=====================
;2004:CG_DrawLowerLeft
;2005:
;2006:=====================
;2007: */
;2008:#ifndef MISSIONPACK
;2009:
;2010:static void CG_DrawLowerLeft(void) {
line 2013
;2011:	float y;
;2012:
;2013:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 2015
;2014:
;2015:	if (CG_IsATeamGametype(cgs.gametype) && cg_drawTeamOverlay.integer == 3) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1027
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 3
NEI4 $1027
line 2016
;2016:		y = CG_DrawTeamOverlay(y, qfalse, qfalse);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 2017
;2017:	}
LABELV $1027
line 2020
;2018:
;2019:
;2020:	y = CG_DrawPickupItem(y);
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawPickupItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2021
;2021:}
LABELV $1026
endproc CG_DrawLowerLeft 16 12
proc CG_DrawTeamInfo 56 36
line 2034
;2022:#endif // MISSIONPACK
;2023:
;2024:
;2025://===========================================================================================
;2026:
;2027:/*
;2028:=================
;2029:CG_DrawTeamInfo
;2030:=================
;2031: */
;2032:#ifndef MISSIONPACK
;2033:
;2034:static void CG_DrawTeamInfo(void) {
line 2043
;2035:	int w, h;
;2036:	int i, len;
;2037:	vec4_t hcolor;
;2038:	int chatHeight;
;2039:
;2040:#define CHATLOC_Y 420 // bottom end
;2041:#define CHATLOC_X 0
;2042:
;2043:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $1032
line 2044
;2044:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $1033
JUMPV
LABELV $1032
line 2046
;2045:	else
;2046:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $1033
line 2047
;2047:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1036
line 2048
;2048:		return; // disabled
ADDRGP4 $1031
JUMPV
LABELV $1036
line 2050
;2049:
;2050:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+178796
INDIRI4
ADDRGP4 cgs+178792
INDIRI4
EQI4 $1038
line 2051
;2051:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+178796
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+178760
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $1042
line 2052
;2052:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+178796
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2053
;2053:		}
LABELV $1042
line 2055
;2054:
;2055:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+178792
INDIRI4
ADDRGP4 cgs+178796
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 2057
;2056:
;2057:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2059
;2058:
;2059:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+178796
INDIRI4
ASGNI4
ADDRGP4 $1054
JUMPV
LABELV $1051
line 2060
;2060:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+176832
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 2061
;2061:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $1058
line 2062
;2062:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $1058
line 2063
;2063:		}
LABELV $1052
line 2059
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1054
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+178792
INDIRI4
LTI4 $1051
line 2064
;2064:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 2065
;2065:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 2067
;2066:
;2067:		if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED ) {
CNSTI4 2120
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1060
line 2068
;2068:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 2069
;2069:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 2070
;2070:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2071
;2071:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2072
;2072:		} else if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE ) {
ADDRGP4 $1061
JUMPV
LABELV $1060
CNSTI4 2120
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1068
line 2073
;2073:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 2074
;2074:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 2075
;2075:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 2076
;2076:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2077
;2077:		} else {
ADDRGP4 $1069
JUMPV
LABELV $1068
line 2078
;2078:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 2079
;2079:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 2080
;2080:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2081
;2081:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 2082
;2082:		}
LABELV $1069
LABELV $1061
line 2084
;2083:
;2084:		trap_R_SetColor(hcolor);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2085
;2085:		CG_DrawPic(CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar);
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+180268+192
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2086
;2086:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2088
;2087:
;2088:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 2089
;2089:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 2091
;2090:
;2091:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+178792
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1087
JUMPV
LABELV $1084
line 2092
;2092:			CG_DrawStringExt(CHATLOC_X + TINYCHAR_WIDTH,
ADDRLP4 44
CNSTI4 8
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 420
ADDRGP4 cgs+178792
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+176832
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2096
;2093:					CHATLOC_Y - (cgs.teamChatPos - i) * TINYCHAR_HEIGHT,
;2094:					cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;2095:					TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0);
;2096:		}
LABELV $1085
line 2091
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1087
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+178796
INDIRI4
GEI4 $1084
line 2097
;2097:	}
LABELV $1038
line 2098
;2098:}
LABELV $1031
endproc CG_DrawTeamInfo 56 36
proc CG_DrawHoldableItem 8 20
line 2108
;2099:#endif // MISSIONPACK
;2100:
;2101:/*
;2102:===================
;2103:CG_DrawHoldableItem
;2104:===================
;2105: */
;2106:#ifndef MISSIONPACK
;2107:
;2108:static void CG_DrawHoldableItem(void) {
line 2111
;2109:	int value;
;2110:
;2111:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 2112
;2112:	if (value) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1094
line 2113
;2113:		CG_RegisterItemVisuals(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 2114
;2114:		CG_DrawPic(640 - ICON_SIZE, (SCREEN_HEIGHT - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon);
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2115
;2115:	}
LABELV $1094
line 2117
;2116:
;2117:}
LABELV $1092
endproc CG_DrawHoldableItem 8 20
proc CG_DrawPersistantPowerup 8 20
line 2128
;2118:#endif // MISSIONPACK
;2119:
;2120:#ifndef MISSIONPACK
;2121:/*
;2122:===================
;2123:CG_DrawPersistantPowerup
;2124:===================
;2125: */
;2126:#if 1 // sos001208 - DEAD // sago - ALIVE
;2127:
;2128:static void CG_DrawPersistantPowerup(void) {
line 2131
;2129:	int value;
;2130:
;2131:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ASGNI4
line 2132
;2132:	if (value) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1099
line 2133
;2133:		CG_RegisterItemVisuals(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 2134
;2134:		CG_DrawPic(640 - ICON_SIZE, (SCREEN_HEIGHT - ICON_SIZE) / 2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon);
CNSTF4 1142161408
ARGF4
CNSTF4 1126694912
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2135
;2135:	}
LABELV $1099
line 2136
;2136:}
LABELV $1097
endproc CG_DrawPersistantPowerup 8 20
proc CG_DrawReward 68 36
line 2145
;2137:#endif
;2138:#endif // MISSIONPACK
;2139:
;2140:/*
;2141:===================
;2142:CG_DrawReward
;2143:===================
;2144: */
;2145:static void CG_DrawReward(void) {
line 2151
;2146:	float *color;
;2147:	int i, count;
;2148:	float x, y;
;2149:	char buf[32];
;2150:
;2151:	if (!cg_drawRewards.integer) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $1103
line 2152
;2152:		return;
ADDRGP4 $1102
JUMPV
LABELV $1103
line 2155
;2153:	}
;2154:
;2155:	color = CG_FadeColor(cg.rewardTime, REWARD_TIME);
ADDRGP4 cg+125020
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 2156
;2156:	if (!color) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1107
line 2157
;2157:		if (cg.rewardStack > 0) {
ADDRGP4 cg+125016
INDIRI4
CNSTI4 0
LEI4 $1102
line 2158
;2158:			for (i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1115
JUMPV
LABELV $1112
line 2159
;2159:				cg.rewardSound[i] = cg.rewardSound[i + 1];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+125104
ADDP4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+125104+4
ADDP4
INDIRI4
ASGNI4
line 2161
;2160:
;2161:				cg.rewardShader[i] = cg.rewardShader[i + 1];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+125064
ADDP4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+125064+4
ADDP4
INDIRI4
ASGNI4
line 2162
;2162:				cg.rewardCount[i] = cg.rewardCount[i + 1];
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+125024
ADDP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+125024+4
ADDP4
INDIRI4
ASGNI4
line 2163
;2163:			}
LABELV $1113
line 2158
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1115
ADDRLP4 0
INDIRI4
ADDRGP4 cg+125016
INDIRI4
LTI4 $1112
line 2164
;2164:			cg.rewardTime = cg.time;
ADDRGP4 cg+125020
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2165
;2165:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+125016
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2166
;2166:			color = CG_FadeColor(cg.rewardTime, REWARD_TIME);
ADDRGP4 cg+125020
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 2168
;2167:
;2168:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+125104
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2170
;2169:
;2170:		} else {
line 2171
;2171:			return;
LABELV $1110
line 2173
;2172:		}
;2173:	}
LABELV $1107
line 2175
;2174:
;2175:	trap_R_SetColor(color);
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2192
;2176:
;2177:	/*
;2178:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;2179:
;2180:	if (count) {
;2181:		y = 4;
;2182:		x = 320 - count * ICON_SIZE;
;2183:		for ( i = 0 ; i < count ; i++ ) {
;2184:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;2185:			x += (ICON_SIZE*2);
;2186:		}
;2187:	}
;2188:
;2189:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;2190:	 */
;2191:
;2192:	if (cg.rewardCount[0] >= 10) {
ADDRGP4 cg+125024
INDIRI4
CNSTI4 10
LTI4 $1131
line 2193
;2193:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2194
;2194:		x = 320 - ICON_SIZE / 2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 2195
;2195:		CG_DrawPic(x, y, ICON_SIZE - 4, ICON_SIZE - 4, cg.rewardShader[0]);
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+125064
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2196
;2196:		Com_sprintf(buf, sizeof (buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1135
ARGP4
ADDRGP4 cg+125024
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2197
;2197:		x = (SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen(buf)) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 2198
;2198:		CG_DrawStringExt(x, y + ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2200
;2199:				SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0);
;2200:	} else {
ADDRGP4 $1132
JUMPV
LABELV $1131
line 2202
;2201:
;2202:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+125024
INDIRI4
ASGNI4
line 2204
;2203:
;2204:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2205
;2205:		x = 320 - count * ICON_SIZE / 2;
ADDRLP4 4
CNSTI4 320
CNSTI4 48
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 2206
;2206:		for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1141
JUMPV
LABELV $1138
line 2207
;2207:			CG_DrawPic(x, y, ICON_SIZE - 4, ICON_SIZE - 4, cg.rewardShader[0]);
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+125064
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2208
;2208:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2209
;2209:		}
LABELV $1139
line 2206
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1141
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1138
line 2210
;2210:	}
LABELV $1132
line 2211
;2211:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2212
;2212:}
LABELV $1102
endproc CG_DrawReward 68 36
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 2242
;2213:
;2214:
;2215:/*
;2216:===============================================================================
;2217:
;2218:LAGOMETER
;2219:
;2220:===============================================================================
;2221: */
;2222:
;2223:#define LAG_SAMPLES  128
;2224:
;2225:typedef struct {
;2226:	int frameSamples[LAG_SAMPLES];
;2227:	int frameCount;
;2228:	int snapshotFlags[LAG_SAMPLES];
;2229:	int snapshotSamples[LAG_SAMPLES];
;2230:	int snapshotCount;
;2231:} lagometer_t;
;2232:
;2233:lagometer_t lagometer;
;2234:
;2235:/*
;2236:==============
;2237:CG_AddLagometerFrameInfo
;2238:
;2239:Adds the current interpolate / extrapolate bar for this frame
;2240:==============
;2241: */
;2242:void CG_AddLagometerFrameInfo(void) {
line 2245
;2243:	int offset;
;2244:
;2245:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 2246
;2246:	lagometer.frameSamples[ lagometer.frameCount & (LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2247
;2247:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2248
;2248:}
LABELV $1144
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 2260
;2249:
;2250:/*
;2251:==============
;2252:CG_AddLagometerSnapshotInfo
;2253:
;2254:Each time a snapshot is received, log its ping time and
;2255:the number of snapshots that were dropped before it.
;2256:
;2257:Pass NULL for a dropped packet.
;2258:==============
;2259: */
;2260:void CG_AddLagometerSnapshotInfo(snapshot_t *snap) {
line 2262
;2261:	// dropped packet
;2262:	if (!snap) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1150
line 2263
;2263:		lagometer.snapshotSamples[ lagometer.snapshotCount & (LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 2264
;2264:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2265
;2265:		return;
ADDRGP4 $1149
JUMPV
LABELV $1150
line 2269
;2266:	}
;2267:
;2268:	// add this snapshot's info
;2269:	lagometer.snapshotSamples[ lagometer.snapshotCount & (LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2270
;2270:	lagometer.snapshotFlags[ lagometer.snapshotCount & (LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 2271
;2271:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2272
;2272:}
LABELV $1149
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 64 20
line 2281
;2273:
;2274:/*
;2275:==============
;2276:CG_DrawDisconnect
;2277:
;2278:Should we draw something differnet for long lag vs no packets?
;2279:==============
;2280: */
;2281:static void CG_DrawDisconnect(void) {
line 2289
;2282:	float x, y;
;2283:	int cmdNum;
;2284:	usercmd_t cmd;
;2285:	const char *s;
;2286:	int w; // bk010215 - FIXME char message[1024];
;2287:
;2288:	// draw the phone jack if we are completely past our buffers
;2289:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2290
;2290:	trap_GetUserCmd(cmdNum, &cmd);
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 2291
;2291:	if (cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $1165
ADDRLP4 48
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $1161
LABELV $1165
line 2292
;2292:			|| cmd.serverTime > cg.time) { // special check for map_restart // bk 0102165 - FIXME
line 2293
;2293:		return;
ADDRGP4 $1160
JUMPV
LABELV $1161
line 2297
;2294:	}
;2295:
;2296:	// also add text in center of screen
;2297:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $1166
ASGNP4
line 2298
;2298:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2299
;2299:	CG_DrawBigString(320 - w / 2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2302
;2300:
;2301:	// blink the icon
;2302:	if ((cg.time >> 9) & 1) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1167
line 2303
;2303:		return;
ADDRGP4 $1160
JUMPV
LABELV $1167
line 2306
;2304:	}
;2305:
;2306:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 2307
;2307:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 2309
;2308:
;2309:	CG_DrawPic(x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga"));
ADDRGP4 $1170
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1111490560
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2310
;2310:}
LABELV $1160
endproc CG_DrawDisconnect 64 20
proc CG_DrawLagometer 68 36
line 2321
;2311:
;2312:
;2313:#define MAX_LAGOMETER_PING 900
;2314:#define MAX_LAGOMETER_RANGE 300
;2315:
;2316:/*
;2317:==============
;2318:CG_DrawLagometer
;2319:==============
;2320: */
;2321:static void CG_DrawLagometer(void) {
line 2328
;2322:	int a, x, y, i;
;2323:	float v;
;2324:	float ax, ay, aw, ah, mid, range;
;2325:	int color;
;2326:	float vscale;
;2327:
;2328:	if (!cg_lagometer.integer || cgs.localServer) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg_lagometer+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1176
ADDRGP4 cgs+31452
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1172
LABELV $1176
line 2329
;2329:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2330
;2330:		return;
ADDRGP4 $1171
JUMPV
LABELV $1172
line 2340
;2331:	}
;2332:
;2333:	//
;2334:	// draw the graph
;2335:	//
;2336:#ifdef MISSIONPACK
;2337:	x = 640 - 48;
;2338:	y = 480 - 144;
;2339:#else
;2340:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 2341
;2341:	y = 480 - 48;
ADDRLP4 48
CNSTI4 432
ASGNI4
line 2344
;2342:#endif
;2343:
;2344:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2345
;2345:	CG_DrawPic(x, y, 48, 48, cgs.media.lagometerShader);
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1111490560
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+180268+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2347
;2346:
;2347:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 2348
;2348:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 2349
;2349:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 2350
;2350:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 2351
;2351:	CG_AdjustFrom640(&ax, &ay, &aw, &ah);
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2353
;2352:
;2353:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 2354
;2354:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 2355
;2355:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 2357
;2356:
;2357:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 2360
;2358:
;2359:	// draw the frame interpoalte / extrapolate graph
;2360:	for (a = 0; a < aw; a++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1182
JUMPV
LABELV $1179
line 2361
;2361:		i = (lagometer.frameCount - 1 - a) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2362
;2362:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2363
;2363:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2364
;2364:		if (v > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1184
line 2365
;2365:			if (color != 1) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $1186
line 2366
;2366:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 2367
;2367:				trap_R_SetColor(g_color_table[ColorIndex(COLOR_YELLOW)]);
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2368
;2368:			}
LABELV $1186
line 2369
;2369:			if (v > range) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1189
line 2370
;2370:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2371
;2371:			}
LABELV $1189
line 2372
;2372:			trap_R_DrawStretchPic(ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+180268+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2373
;2373:		} else if (v < 0) {
ADDRGP4 $1185
JUMPV
LABELV $1184
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1193
line 2374
;2374:			if (color != 2) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $1195
line 2375
;2375:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 2376
;2376:				trap_R_SetColor(g_color_table[ColorIndex(COLOR_BLUE)]);
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2377
;2377:			}
LABELV $1195
line 2378
;2378:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 2379
;2379:			if (v > range) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1198
line 2380
;2380:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2381
;2381:			}
LABELV $1198
line 2382
;2382:			trap_R_DrawStretchPic(ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+180268+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2383
;2383:		}
LABELV $1193
LABELV $1185
line 2384
;2384:	}
LABELV $1180
line 2360
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1182
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1179
line 2387
;2385:
;2386:	// draw the snapshot latency / drop graph
;2387:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2388
;2388:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 2390
;2389:
;2390:	for (a = 0; a < aw; a++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1205
JUMPV
LABELV $1202
line 2391
;2391:		i = (lagometer.snapshotCount - 1 - a) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2392
;2392:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2393
;2393:		if (v > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1208
line 2394
;2394:			if (lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1210
line 2395
;2395:				if (color != 5) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $1211
line 2396
;2396:					color = 5; // YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 2397
;2397:					trap_R_SetColor(g_color_table[ColorIndex(COLOR_YELLOW)]);
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2398
;2398:				}
line 2399
;2399:			} else {
ADDRGP4 $1211
JUMPV
LABELV $1210
line 2400
;2400:				if (color != 3) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $1216
line 2401
;2401:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 2402
;2402:					trap_R_SetColor(g_color_table[ColorIndex(COLOR_GREEN)]);
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2403
;2403:				}
LABELV $1216
line 2404
;2404:			}
LABELV $1211
line 2405
;2405:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2406
;2406:			if (v > range) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1219
line 2407
;2407:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2408
;2408:			}
LABELV $1219
line 2409
;2409:			trap_R_DrawStretchPic(ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+180268+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2410
;2410:		} else if (v < 0) {
ADDRGP4 $1209
JUMPV
LABELV $1208
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1223
line 2411
;2411:			if (color != 4) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $1225
line 2412
;2412:				color = 4; // RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 2413
;2413:				trap_R_SetColor(g_color_table[ColorIndex(COLOR_RED)]);
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2414
;2414:			}
LABELV $1225
line 2415
;2415:			trap_R_DrawStretchPic(ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+180268+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2416
;2416:		}
LABELV $1223
LABELV $1209
line 2417
;2417:	}
LABELV $1203
line 2390
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1205
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1202
line 2419
;2418:
;2419:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2421
;2420:
;2421:	if (cg_nopredict.integer || cg_synchronousClients.integer) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $1234
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1230
LABELV $1234
line 2422
;2422:		CG_DrawBigString(ax, ay, "snc", 1.0);
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $1235
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2423
;2423:	}
LABELV $1230
line 2425
;2424:
;2425:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2426
;2426:}
LABELV $1171
endproc CG_DrawLagometer 68 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 2446
;2427:
;2428:
;2429:
;2430:/*
;2431:===============================================================================
;2432:
;2433:CENTER PRINTING
;2434:
;2435:===============================================================================
;2436: */
;2437:
;2438:/*
;2439:==============
;2440:CG_CenterPrint
;2441:
;2442:Called for important messages that should stay in the center of the screen
;2443:for a few moments
;2444:==============
;2445: */
;2446:void CG_CenterPrint(const char *str, int y, int charWidth) {
line 2449
;2447:	char *s;
;2448:
;2449:	Q_strncpyz(cg.centerPrint, str, sizeof (cg.centerPrint));
ADDRGP4 cg+123956
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2451
;2450:
;2451:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+123944
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2452
;2452:	cg.centerPrintY = y;
ADDRGP4 cg+123952
ADDRFP4 4
INDIRI4
ASGNI4
line 2453
;2453:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+123948
ADDRFP4 8
INDIRI4
ASGNI4
line 2456
;2454:
;2455:	// count the number of lines for centering
;2456:	cg.centerPrintLines = 1;
ADDRGP4 cg+124980
CNSTI4 1
ASGNI4
line 2457
;2457:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123956
ASGNP4
ADDRGP4 $1246
JUMPV
LABELV $1245
line 2458
;2458:	while (*s) {
line 2459
;2459:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $1248
line 2460
;2460:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+124980
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1248
line 2461
;2461:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2462
;2462:	}
LABELV $1246
line 2458
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1245
line 2463
;2463:}
LABELV $1236
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1064 36
line 2470
;2464:
;2465:/*
;2466:===================
;2467:CG_DrawCenterString
;2468:===================
;2469: */
;2470:static void CG_DrawCenterString(void) {
line 2479
;2471:	char *start;
;2472:	int l;
;2473:	int x, y, w;
;2474:#ifdef MISSIONPACK // bk010221 - unused else
;2475:	int h;
;2476:#endif
;2477:	float *color;
;2478:
;2479:	if (!cg.centerPrintTime) {
ADDRGP4 cg+123944
INDIRI4
CNSTI4 0
NEI4 $1252
line 2480
;2480:		return;
ADDRGP4 $1251
JUMPV
LABELV $1252
line 2483
;2481:	}
;2482:
;2483:	color = CG_FadeColor(cg.centerPrintTime, 1000 * cg_centertime.value);
ADDRGP4 cg+123944
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 2484
;2484:	if (!color) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1257
line 2485
;2485:		return;
ADDRGP4 $1251
JUMPV
LABELV $1257
line 2488
;2486:	}
;2487:
;2488:	trap_R_SetColor(color);
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2490
;2489:
;2490:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123956
ASGNP4
line 2492
;2491:
;2492:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+123952
INDIRI4
ADDRGP4 cg+124980
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $1263
JUMPV
LABELV $1262
line 2494
;2493:
;2494:	while (1) {
line 2497
;2495:		char linebuffer[1024];
;2496:
;2497:		for (l = 0; l < 50; l++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1265
line 2498
;2498:			if (!start[l] || start[l] == '\n') {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $1271
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $1269
LABELV $1271
line 2499
;2499:				break;
ADDRGP4 $1267
JUMPV
LABELV $1269
line 2501
;2500:			}
;2501:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2502
;2502:		}
LABELV $1266
line 2497
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $1265
LABELV $1267
line 2503
;2503:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 2512
;2504:
;2505:#ifdef MISSIONPACK
;2506:		w = CG_Text_Width(linebuffer, 0.5, 0);
;2507:		h = CG_Text_Height(linebuffer, 0.5, 0);
;2508:		x = (SCREEN_WIDTH - w) / 2;
;2509:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2510:		y += h + 6;
;2511:#else
;2512:		w = cg.centerPrintCharWidth * CG_DrawStrlen(linebuffer);
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+123948
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 2514
;2513:
;2514:		x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2516
;2515:
;2516:		CG_DrawStringExt(x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+123948
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+123948
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2519
;2517:				cg.centerPrintCharWidth, (int) (cg.centerPrintCharWidth * 1.5), 0);
;2518:
;2519:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1069547520
ADDRGP4 cg+123948
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $1277
JUMPV
LABELV $1276
line 2521
;2520:#endif
;2521:		while (*start && (*start != '\n')) {
line 2522
;2522:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2523
;2523:		}
LABELV $1277
line 2521
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $1279
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $1276
LABELV $1279
line 2524
;2524:		if (!*start) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1280
line 2525
;2525:			break;
ADDRGP4 $1264
JUMPV
LABELV $1280
line 2527
;2526:		}
;2527:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2528
;2528:	}
LABELV $1263
line 2494
ADDRGP4 $1262
JUMPV
LABELV $1264
line 2530
;2529:
;2530:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2531
;2531:}
LABELV $1251
endproc CG_DrawCenterString 1064 36
proc drawCenterString 24 36
line 2535
;2532:
;2533:#ifndef MISSIONPACK
;2534:
;2535:static void drawCenterString(const char* line, float* color) {
line 2537
;2536:	int x, y, w;
;2537:	y = 100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 2539
;2538:
;2539:	if (!line || !color) {
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $1285
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
NEU4 $1283
LABELV $1285
line 2540
;2540:		return;
ADDRGP4 $1282
JUMPV
LABELV $1283
line 2544
;2541:	}
;2542:
;2543:
;2544:	w = cg.centerPrintCharWidth * CG_DrawStrlen(line);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 cg+123948
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
ASGNI4
line 2546
;2545:
;2546:	x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 0
CNSTI4 640
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2548
;2547:
;2548:	CG_DrawStringExt(x, y, line, color, qfalse, qtrue,
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+123948
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+123948
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2550
;2549:			cg.centerPrintCharWidth, (int) (cg.centerPrintCharWidth * 1.5), 0);
;2550:}
LABELV $1282
endproc drawCenterString 24 36
proc CG_DrawCenter1FctfString 28 8
line 2558
;2551:#endif
;2552:
;2553:/*
;2554:=====================
;2555:CG_DrawCenter1FctfString
;2556:=====================
;2557: */
;2558:static void CG_DrawCenter1FctfString(void) {
line 2564
;2559:#ifndef MISSIONPACK
;2560:	float *color;
;2561:	char *line;
;2562:	int status;
;2563:
;2564:	if (cgs.gametype != GT_1FCTF)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
EQI4 $1290
line 2565
;2565:		return;
ADDRGP4 $1289
JUMPV
LABELV $1290
line 2567
;2566:
;2567:	status = cgs.flagStatus;
ADDRLP4 0
ADDRGP4 cgs+34996
INDIRI4
ASGNI4
line 2570
;2568:
;2569:	//Sago: TODO: Find the proper defines instead of hardcoded values.
;2570:	switch (status) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $1296
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $1298
ADDRLP4 12
INDIRI4
CNSTI4 4
EQI4 $1300
ADDRGP4 $1289
JUMPV
LABELV $1296
line 2572
;2571:		case 2:
;2572:			line = va("Red has the flag!");
ADDRGP4 $1297
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2573
;2573:			color = colorRed;
ADDRLP4 4
ADDRGP4 colorRed
ASGNP4
line 2574
;2574:			break;
ADDRGP4 $1295
JUMPV
LABELV $1298
line 2576
;2575:		case 3:
;2576:			line = va("Blue has the flag!");
ADDRGP4 $1299
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 2577
;2577:			color = colorBlue;
ADDRLP4 4
ADDRGP4 colorBlue
ASGNP4
line 2578
;2578:			break;
ADDRGP4 $1295
JUMPV
LABELV $1300
line 2580
;2579:		case 4:
;2580:			line = va("Flag dropped!");
ADDRGP4 $1301
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 2581
;2581:			color = colorWhite;
ADDRLP4 4
ADDRGP4 colorWhite
ASGNP4
line 2582
;2582:			break;
line 2584
;2583:		default:
;2584:			return;
LABELV $1295
line 2586
;2585:
;2586:	};
line 2588
;2587:
;2588:	drawCenterString(line, color);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 drawCenterString
CALLV
pop
line 2591
;2589:
;2590:#endif
;2591:}
LABELV $1289
endproc CG_DrawCenter1FctfString 28 8
data
align 4
LABELV $1303
byte 4 -100
code
proc CG_DrawCenterDDString 48 36
line 2598
;2592:
;2593:/*
;2594:=====================
;2595:CG_DrawCenterDDString
;2596:=====================
;2597: */
;2598:static void CG_DrawCenterDDString(void) {
line 2608
;2599:#ifndef MISSIONPACK
;2600:	int x, y, w;
;2601:	float *color;
;2602:	char *line;
;2603:	int statusA, statusB;
;2604:	int sec;
;2605:	static int lastDDSec = -100;
;2606:
;2607:
;2608:	if (cgs.gametype != GT_DOUBLE_D)
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
EQI4 $1304
line 2609
;2609:		return;
ADDRGP4 $1302
JUMPV
LABELV $1304
line 2612
;2610:
;2611:
;2612:	statusA = cgs.redflag;
ADDRLP4 0
ADDRGP4 cgs+34988
INDIRI4
ASGNI4
line 2613
;2613:	statusB = cgs.blueflag;
ADDRLP4 8
ADDRGP4 cgs+34992
INDIRI4
ASGNI4
line 2615
;2614:
;2615:	if (((statusB == statusA) && (statusA == TEAM_RED)) ||
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1312
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $1311
LABELV $1312
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1309
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $1309
LABELV $1311
line 2616
;2616:			((statusB == statusA) && (statusA == TEAM_BLUE))) {
line 2617
;2617:	} else {
ADDRGP4 $1310
JUMPV
LABELV $1309
line 2618
;2618:		lastDDSec = -100;
ADDRGP4 $1303
CNSTI4 -100
ASGNI4
line 2619
;2619:		return; //No team is dominating
ADDRGP4 $1302
JUMPV
LABELV $1310
line 2622
;2620:	}
;2621:
;2622:	if (statusA == TEAM_BLUE) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $1313
line 2623
;2623:		line = va("Blue scores in %i", (cgs.takeAt - cg.time) / 1000 + 1);
ADDRGP4 $1315
ARGP4
ADDRGP4 cgs+34828
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
ASGNP4
line 2624
;2624:		color = colorBlue;
ADDRLP4 28
ADDRGP4 colorBlue
ASGNP4
line 2625
;2625:	} else if (statusA == TEAM_RED) {
ADDRGP4 $1314
JUMPV
LABELV $1313
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $1318
line 2626
;2626:		line = va("Red scores in %i", (cgs.takeAt - cg.time) / 1000 + 1);
ADDRGP4 $1320
ARGP4
ADDRGP4 cgs+34828
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
ASGNP4
line 2627
;2627:		color = colorRed;
ADDRLP4 28
ADDRGP4 colorRed
ASGNP4
line 2628
;2628:	} else {
ADDRGP4 $1319
JUMPV
LABELV $1318
line 2629
;2629:		lastDDSec = -100;
ADDRGP4 $1303
CNSTI4 -100
ASGNI4
line 2630
;2630:		return;
ADDRGP4 $1302
JUMPV
LABELV $1319
LABELV $1314
line 2633
;2631:	}
;2632:
;2633:	if (cgs.takeAt == 0) {
ADDRGP4 cgs+34828
INDIRI4
CNSTI4 0
NEI4 $1323
line 2634
;2634:		return;
ADDRGP4 $1302
JUMPV
LABELV $1323
line 2637
;2635:	}
;2636:
;2637:	sec = (cgs.takeAt - cg.time) / 1000 + 1;
ADDRLP4 4
ADDRGP4 cgs+34828
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 1
ADDI4
ASGNI4
line 2639
;2638:
;2639:	if (sec < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1328
line 2640
;2640:		return;
ADDRGP4 $1302
JUMPV
LABELV $1328
line 2643
;2641:	}
;2642:
;2643:	if (sec != lastDDSec) {
ADDRLP4 4
INDIRI4
ADDRGP4 $1303
INDIRI4
EQI4 $1330
line 2645
;2644:		//A new number is being displayed... play the sound!
;2645:		switch (sec) {
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1334
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1337
ADDRLP4 4
INDIRI4
CNSTI4 3
EQI4 $1340
ADDRGP4 $1332
JUMPV
LABELV $1334
line 2647
;2646:			case 1:
;2647:				trap_S_StartLocalSound(cgs.media.count1Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1364
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2648
;2648:				break;
ADDRGP4 $1333
JUMPV
LABELV $1337
line 2650
;2649:			case 2:
;2650:				trap_S_StartLocalSound(cgs.media.count2Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1360
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2651
;2651:				break;
ADDRGP4 $1333
JUMPV
LABELV $1340
line 2653
;2652:			case 3:
;2653:				trap_S_StartLocalSound(cgs.media.count3Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1356
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2654
;2654:				break;
ADDRGP4 $1333
JUMPV
LABELV $1332
line 2656
;2655:			default:
;2656:				if (lastDDSec == -100) {
ADDRGP4 $1303
INDIRI4
CNSTI4 -100
NEI4 $1333
line 2657
;2657:					trap_S_StartLocalSound(cgs.media.doublerSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1380
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2658
;2658:				}
line 2659
;2659:				break;
LABELV $1333
line 2661
;2660:		}
;2661:	}
LABELV $1330
line 2662
;2662:	lastDDSec = sec;
ADDRGP4 $1303
ADDRLP4 4
INDIRI4
ASGNI4
line 2664
;2663:
;2664:	y = 100;
ADDRLP4 20
CNSTI4 100
ASGNI4
line 2667
;2665:
;2666:
;2667:	w = cg.centerPrintCharWidth * CG_DrawStrlen(line);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRGP4 cg+123948
INDIRI4
ADDRLP4 40
INDIRI4
MULI4
ASGNI4
line 2669
;2668:
;2669:	x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 16
CNSTI4 640
ADDRLP4 24
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2671
;2670:
;2671:	CG_DrawStringExt(x, y, line, color, qfalse, qtrue,
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+123948
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+123948
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2675
;2672:			cg.centerPrintCharWidth, (int) (cg.centerPrintCharWidth * 1.5), 0);
;2673:
;2674:#endif
;2675:}
LABELV $1302
endproc CG_DrawCenterDDString 48 36
proc CG_DrawCrosshair 92 36
line 2691
;2676:
;2677:
;2678:/*
;2679:================================================================================
;2680:
;2681:CROSSHAIR
;2682:
;2683:================================================================================
;2684: */
;2685:
;2686:/*
;2687:=================
;2688:CG_DrawCrosshair
;2689:=================
;2690: */
;2691:static void CG_DrawCrosshair(void) {
line 2696
;2692:	float w, h;
;2693:	qhandle_t hShader;
;2694:	float f;
;2695:	float x, y;
;2696:	int ca = 0; //only to get rid of the warning(not useful)
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2699
;2697:	int currentWeapon;
;2698:
;2699:	currentWeapon = cg.predictedPlayerState.weapon;
ADDRLP4 28
ADDRGP4 cg+107636+144
INDIRI4
ASGNI4
line 2701
;2700:
;2701:	if (!cg_drawCrosshair.integer) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1353
line 2702
;2702:		return;
ADDRGP4 $1350
JUMPV
LABELV $1353
line 2705
;2703:	}
;2704:
;2705:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1356
line 2706
;2706:		return;
ADDRGP4 $1350
JUMPV
LABELV $1356
line 2709
;2707:	}
;2708:
;2709:	if (cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1359
line 2710
;2710:		return;
ADDRGP4 $1350
JUMPV
LABELV $1359
line 2714
;2711:	}
;2712:
;2713:	// set color based on health
;2714:	if (cg_crosshairHealth.integer) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $1362
line 2717
;2715:		vec4_t hcolor;
;2716:
;2717:		CG_ColorForHealth(hcolor);
ADDRLP4 32
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 2718
;2718:		trap_R_SetColor(hcolor);
ADDRLP4 32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2719
;2719:	} else {
ADDRGP4 $1363
JUMPV
LABELV $1362
line 2721
;2720:		vec4_t color;
;2721:		color[0] = cg_crosshairColorRed.value;
ADDRLP4 32
ADDRGP4 cg_crosshairColorRed+8
INDIRF4
ASGNF4
line 2722
;2722:		color[1] = cg_crosshairColorGreen.value;
ADDRLP4 32+4
ADDRGP4 cg_crosshairColorGreen+8
INDIRF4
ASGNF4
line 2723
;2723:		color[2] = cg_crosshairColorBlue.value;
ADDRLP4 32+8
ADDRGP4 cg_crosshairColorBlue+8
INDIRF4
ASGNF4
line 2724
;2724:		color[3] = 1.0f;
ADDRLP4 32+12
CNSTF4 1065353216
ASGNF4
line 2725
;2725:		trap_R_SetColor(color);
ADDRLP4 32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2726
;2726:	}
LABELV $1363
line 2728
;2727:
;2728:	if (cg_differentCrosshairs.integer == 1) {
ADDRGP4 cg_differentCrosshairs+12
INDIRI4
CNSTI4 1
NEI4 $1371
line 2729
;2729:		switch (currentWeapon) {
ADDRLP4 32
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 1
LTI4 $1374
ADDRLP4 32
INDIRI4
CNSTI4 13
GTI4 $1374
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1417-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1417
address $1376
address $1379
address $1382
address $1385
address $1388
address $1391
address $1394
address $1397
address $1400
address $1403
address $1406
address $1409
address $1412
code
LABELV $1376
line 2731
;2730:			case 1:
;2731:				w = h = cg_ch1size.value;
ADDRLP4 36
ADDRGP4 cg_ch1size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 2732
;2732:				ca = cg_ch1.integer;
ADDRLP4 0
ADDRGP4 cg_ch1+12
INDIRI4
ASGNI4
line 2733
;2733:				break;
ADDRGP4 $1372
JUMPV
LABELV $1379
line 2735
;2734:			case 2:
;2735:				w = h = cg_ch2size.value;
ADDRLP4 40
ADDRGP4 cg_ch2size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 2736
;2736:				ca = cg_ch2.integer;
ADDRLP4 0
ADDRGP4 cg_ch2+12
INDIRI4
ASGNI4
line 2737
;2737:				break;
ADDRGP4 $1372
JUMPV
LABELV $1382
line 2739
;2738:			case 3:
;2739:				w = h = cg_ch3size.value;
ADDRLP4 44
ADDRGP4 cg_ch3size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 2740
;2740:				ca = cg_ch3.integer;
ADDRLP4 0
ADDRGP4 cg_ch3+12
INDIRI4
ASGNI4
line 2741
;2741:				break;
ADDRGP4 $1372
JUMPV
LABELV $1385
line 2743
;2742:			case 4:
;2743:				w = h = cg_ch4size.value;
ADDRLP4 48
ADDRGP4 cg_ch4size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 48
INDIRF4
ASGNF4
line 2744
;2744:				ca = cg_ch4.integer;
ADDRLP4 0
ADDRGP4 cg_ch4+12
INDIRI4
ASGNI4
line 2745
;2745:				break;
ADDRGP4 $1372
JUMPV
LABELV $1388
line 2747
;2746:			case 5:
;2747:				w = h = cg_ch5size.value;
ADDRLP4 52
ADDRGP4 cg_ch5size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 52
INDIRF4
ASGNF4
line 2748
;2748:				ca = cg_ch5.integer;
ADDRLP4 0
ADDRGP4 cg_ch5+12
INDIRI4
ASGNI4
line 2749
;2749:				break;
ADDRGP4 $1372
JUMPV
LABELV $1391
line 2751
;2750:			case 6:
;2751:				w = h = cg_ch6size.value;
ADDRLP4 56
ADDRGP4 cg_ch6size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 56
INDIRF4
ASGNF4
line 2752
;2752:				ca = cg_ch6.integer;
ADDRLP4 0
ADDRGP4 cg_ch6+12
INDIRI4
ASGNI4
line 2753
;2753:				break;
ADDRGP4 $1372
JUMPV
LABELV $1394
line 2755
;2754:			case 7:
;2755:				w = h = cg_ch7size.value;
ADDRLP4 60
ADDRGP4 cg_ch7size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 60
INDIRF4
ASGNF4
line 2756
;2756:				ca = cg_ch7.integer;
ADDRLP4 0
ADDRGP4 cg_ch7+12
INDIRI4
ASGNI4
line 2757
;2757:				break;
ADDRGP4 $1372
JUMPV
LABELV $1397
line 2759
;2758:			case 8:
;2759:				w = h = cg_ch8size.value;
ADDRLP4 64
ADDRGP4 cg_ch8size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 64
INDIRF4
ASGNF4
line 2760
;2760:				ca = cg_ch8.integer;
ADDRLP4 0
ADDRGP4 cg_ch8+12
INDIRI4
ASGNI4
line 2761
;2761:				break;
ADDRGP4 $1372
JUMPV
LABELV $1400
line 2763
;2762:			case 9:
;2763:				w = h = cg_ch9size.value;
ADDRLP4 68
ADDRGP4 cg_ch9size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 68
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 68
INDIRF4
ASGNF4
line 2764
;2764:				ca = cg_ch9.integer;
ADDRLP4 0
ADDRGP4 cg_ch9+12
INDIRI4
ASGNI4
line 2765
;2765:				break;
ADDRGP4 $1372
JUMPV
LABELV $1403
line 2767
;2766:			case 10:
;2767:				w = h = cg_ch10size.value;
ADDRLP4 72
ADDRGP4 cg_ch10size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 72
INDIRF4
ASGNF4
line 2768
;2768:				ca = cg_ch10.integer;
ADDRLP4 0
ADDRGP4 cg_ch10+12
INDIRI4
ASGNI4
line 2769
;2769:				break;
ADDRGP4 $1372
JUMPV
LABELV $1406
line 2771
;2770:			case 11:
;2771:				w = h = cg_ch11size.value;
ADDRLP4 76
ADDRGP4 cg_ch11size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 76
INDIRF4
ASGNF4
line 2772
;2772:				ca = cg_ch11.integer;
ADDRLP4 0
ADDRGP4 cg_ch11+12
INDIRI4
ASGNI4
line 2773
;2773:				break;
ADDRGP4 $1372
JUMPV
LABELV $1409
line 2775
;2774:			case 12:
;2775:				w = h = cg_ch12size.value;
ADDRLP4 80
ADDRGP4 cg_ch12size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 80
INDIRF4
ASGNF4
line 2776
;2776:				ca = cg_ch12.integer;
ADDRLP4 0
ADDRGP4 cg_ch12+12
INDIRI4
ASGNI4
line 2777
;2777:				break;
ADDRGP4 $1372
JUMPV
LABELV $1412
line 2779
;2778:			case 13:
;2779:				w = h = cg_ch13size.value;
ADDRLP4 84
ADDRGP4 cg_ch13size+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 84
INDIRF4
ASGNF4
line 2780
;2780:				ca = cg_ch13.integer;
ADDRLP4 0
ADDRGP4 cg_ch13+12
INDIRI4
ASGNI4
line 2781
;2781:				break;
ADDRGP4 $1372
JUMPV
LABELV $1374
line 2783
;2782:			default:
;2783:				w = h = cg_crosshairSize.value;
ADDRLP4 88
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 88
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 88
INDIRF4
ASGNF4
line 2784
;2784:				ca = cg_drawCrosshair.integer;
ADDRLP4 0
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2785
;2785:				break;
line 2787
;2786:		}
;2787:	} else {
ADDRGP4 $1372
JUMPV
LABELV $1371
line 2788
;2788:		w = h = cg_crosshairSize.value;
ADDRLP4 32
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 32
INDIRF4
ASGNF4
line 2789
;2789:		ca = cg_drawCrosshair.integer;
ADDRLP4 0
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2790
;2790:	}
LABELV $1372
line 2792
;2791:
;2792:	if (cg_crosshairPulse.integer) {
ADDRGP4 cg_crosshairPulse+12
INDIRI4
CNSTI4 0
EQI4 $1421
line 2794
;2793:		// pulse the size of the crosshair when picking up items
;2794:		f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125264
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2795
;2795:		if (f > 0 && f < ITEM_BLOB_TIME) {
ADDRLP4 32
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $1426
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $1426
line 2796
;2796:			f /= ITEM_BLOB_TIME;
ADDRLP4 24
ADDRLP4 24
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 2797
;2797:			w *= (1 + f);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2798
;2798:			h *= (1 + f);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2799
;2799:		}
LABELV $1426
line 2800
;2800:	}
LABELV $1421
line 2802
;2801:
;2802:	x = cg_crosshairX.integer - wideAdjustX; // leilei - widescreen adjust
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
ADDRGP4 wideAdjustX
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2803
;2803:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 2804
;2804:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2806
;2805:
;2806:	if (ca < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1430
line 2807
;2807:		ca = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2808
;2808:	}
LABELV $1430
line 2809
;2809:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
INDIRI4
ASGNI4
line 2811
;2810:
;2811:	if (!hShader)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1434
line 2812
;2812:		hShader = cgs.media.crosshairShader[ ca % 10 ];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
INDIRI4
ASGNI4
LABELV $1434
line 2814
;2813:
;2814:	trap_R_DrawStretchPic(x + cg.refdef.x + 0.5 * (cg.refdef.width - w),
ADDRLP4 32
CNSTF4 1056964608
ASGNF4
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109252
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+109252+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109252+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+109252+12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2818
;2815:			y + cg.refdef.y + 0.5 * (cg.refdef.height - h),
;2816:			w, h, 0, 0, 1, 1, hShader);
;2817:
;2818:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2819
;2819:}
LABELV $1350
endproc CG_DrawCrosshair 92 36
proc CG_DrawCrosshair3D 436 28
line 2826
;2820:
;2821:/*
;2822:=================
;2823:CG_DrawCrosshair3D
;2824:=================
;2825: */
;2826:static void CG_DrawCrosshair3D(void) {
line 2838
;2827:	float w, h;
;2828:	qhandle_t hShader;
;2829:	float f;
;2830:	int ca;
;2831:
;2832:	trace_t trace;
;2833:	vec3_t endpos;
;2834:	float stereoSep, zProj, maxdist, xmax;
;2835:	char rendererinfos[128];
;2836:	refEntity_t ent;
;2837:
;2838:	if (!cg_drawCrosshair.integer) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1446
line 2839
;2839:		return;
ADDRGP4 $1445
JUMPV
LABELV $1446
line 2842
;2840:	}
;2841:
;2842:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1449
line 2843
;2843:		return;
ADDRGP4 $1445
JUMPV
LABELV $1449
line 2846
;2844:	}
;2845:
;2846:	if (cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1452
line 2847
;2847:		return;
ADDRGP4 $1445
JUMPV
LABELV $1452
line 2850
;2848:	}
;2849:
;2850:	w = h = cg_crosshairSize.value;
ADDRLP4 408
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 404
ADDRLP4 408
INDIRF4
ASGNF4
ADDRLP4 396
ADDRLP4 408
INDIRF4
ASGNF4
line 2853
;2851:
;2852:	// pulse the size of the crosshair when picking up items
;2853:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 312
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125264
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2854
;2854:	if (f > 0 && f < ITEM_BLOB_TIME) {
ADDRLP4 312
INDIRF4
CNSTF4 0
LEF4 $1458
ADDRLP4 312
INDIRF4
CNSTF4 1128792064
GEF4 $1458
line 2855
;2855:		f /= ITEM_BLOB_TIME;
ADDRLP4 312
ADDRLP4 312
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 2856
;2856:		w *= (1 + f);
ADDRLP4 396
ADDRLP4 396
INDIRF4
ADDRLP4 312
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2857
;2857:		h *= (1 + f);
ADDRLP4 404
ADDRLP4 404
INDIRF4
ADDRLP4 312
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2858
;2858:	}
LABELV $1458
line 2860
;2859:
;2860:	ca = cg_drawCrosshair.integer;
ADDRLP4 316
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2861
;2861:	if (ca < 0) {
ADDRLP4 316
INDIRI4
CNSTI4 0
GEI4 $1461
line 2862
;2862:		ca = 0;
ADDRLP4 316
CNSTI4 0
ASGNI4
line 2863
;2863:	}
LABELV $1461
line 2864
;2864:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 332
ADDRLP4 316
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
INDIRI4
ASGNI4
line 2866
;2865:
;2866:	if (!hShader)
ADDRLP4 332
INDIRI4
CNSTI4 0
NEI4 $1465
line 2867
;2867:		hShader = cgs.media.crosshairShader[ ca % 10 ];
ADDRLP4 332
ADDRLP4 316
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+180268+288
ADDP4
INDIRI4
ASGNI4
LABELV $1465
line 2874
;2868:
;2869:	// Use a different method rendering the crosshair so players don't see two of them when
;2870:	// focusing their eyes at distant objects with high stereo separation
;2871:	// We are going to trace to the next shootable object and place the crosshair in front of it.
;2872:
;2873:	// first get all the important renderer information
;2874:	trap_Cvar_VariableStringBuffer("r_zProj", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1469
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2875
;2875:	zProj = atof(rendererinfos);
ADDRLP4 176
ARGP4
ADDRLP4 416
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 304
ADDRLP4 416
INDIRF4
ASGNF4
line 2876
;2876:	trap_Cvar_VariableStringBuffer("r_stereoSeparation", rendererinfos, sizeof (rendererinfos));
ADDRGP4 $1470
ARGP4
ADDRLP4 176
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2877
;2877:	stereoSep = zProj / atof(rendererinfos);
ADDRLP4 176
ARGP4
ADDRLP4 420
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 400
ADDRLP4 304
INDIRF4
ADDRLP4 420
INDIRF4
DIVF4
ASGNF4
line 2879
;2878:
;2879:	xmax = zProj * tan(cg.refdef.fov_x * M_PI / 360.0f);
CNSTF4 1078530011
ADDRGP4 cg+109252+16
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
ARGF4
ADDRLP4 424
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 392
ADDRLP4 304
INDIRF4
ADDRLP4 424
INDIRF4
MULF4
ASGNF4
line 2882
;2880:
;2881:	// let the trace run through until a change in stereo separation of the crosshair becomes less than one pixel.
;2882:	maxdist = cgs.glconfig.vidWidth * stereoSep * zProj / (2 * xmax);
ADDRLP4 308
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ADDRLP4 400
INDIRF4
MULF4
ADDRLP4 304
INDIRF4
MULF4
CNSTF4 1073741824
ADDRLP4 392
INDIRF4
MULF4
DIVF4
ASGNF4
line 2883
;2883:	VectorMA(cg.refdef.vieworg, maxdist, cg.refdef.viewaxis[0], endpos);
ADDRLP4 320
ADDRGP4 cg+109252+24
INDIRF4
ADDRGP4 cg+109252+36
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 320+4
ADDRGP4 cg+109252+24+4
INDIRF4
ADDRGP4 cg+109252+36+4
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 320+8
ADDRGP4 cg+109252+24+8
INDIRF4
ADDRGP4 cg+109252+36+8
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
line 2884
;2884:	CG_Trace(&trace, cg.refdef.vieworg, NULL, NULL, endpos, 0, MASK_SHOT);
ADDRLP4 336
ARGP4
ADDRGP4 cg+109252+24
ARGP4
ADDRLP4 432
CNSTP4 0
ASGNP4
ADDRLP4 432
INDIRP4
ARGP4
ADDRLP4 432
INDIRP4
ARGP4
ADDRLP4 320
ARGP4
CNSTI4 0
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2886
;2885:
;2886:	memset(&ent, 0, sizeof (ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2887
;2887:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2888
;2888:	ent.renderfx = RF_DEPTHHACK | RF_CROSSHAIR;
ADDRLP4 0+4
CNSTI4 24
ASGNI4
line 2890
;2889:
;2890:	VectorCopy(trace.endpos, ent.origin);
ADDRLP4 0+68
ADDRLP4 336+12
INDIRB
ASGNB 12
line 2893
;2891:
;2892:	// scale the crosshair so it appears the same size for all distances
;2893:	ent.radius = w / 640 * xmax * trace.fraction * maxdist / zProj;
ADDRLP4 0+132
ADDRLP4 396
INDIRF4
CNSTF4 1142947840
DIVF4
ADDRLP4 392
INDIRF4
MULF4
ADDRLP4 336+8
INDIRF4
MULF4
ADDRLP4 308
INDIRF4
MULF4
ADDRLP4 304
INDIRF4
DIVF4
ASGNF4
line 2894
;2894:	ent.customShader = hShader;
ADDRLP4 0+112
ADDRLP4 332
INDIRI4
ASGNI4
line 2896
;2895:
;2896:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2897
;2897:}
LABELV $1445
endproc CG_DrawCrosshair3D 436 28
proc CG_ScanForCrosshairEntity 96 28
line 2904
;2898:
;2899:/*
;2900:=================
;2901:CG_ScanForCrosshairEntity
;2902:=================
;2903: */
;2904:static void CG_ScanForCrosshairEntity(void) {
line 2909
;2905:	trace_t trace;
;2906:	vec3_t start, end;
;2907:	int content;
;2908:
;2909:	VectorCopy(cg.refdef.vieworg, start);
ADDRLP4 56
ADDRGP4 cg+109252+24
INDIRB
ASGNB 12
line 2910
;2910:	VectorMA(start, 131072, cg.refdef.viewaxis[0], end);
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109252+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109252+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+109252+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2912
;2911:
;2912:	CG_Trace(&trace, start, vec3_origin, vec3_origin, end,
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2914
;2913:			cg.snap->ps.clientNum, CONTENTS_SOLID | CONTENTS_BODY);
;2914:	if (trace.entityNum >= MAX_CLIENTS) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $1517
line 2915
;2915:		return;
ADDRGP4 $1501
JUMPV
LABELV $1517
line 2919
;2916:	}
;2917:
;2918:	// if the player is in fog, don't show it
;2919:	content = CG_PointContents(trace.endpos, 0);
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 92
INDIRI4
ASGNI4
line 2920
;2920:	if (content & CONTENTS_FOG) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1521
line 2921
;2921:		return;
ADDRGP4 $1501
JUMPV
LABELV $1521
line 2925
;2922:	}
;2923:
;2924:	// if the player is invisible, don't show it
;2925:	if (cg_entities[ trace.entityNum ].currentState.powerups & (1 << PW_INVIS)) {
CNSTI4 936
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1523
line 2926
;2926:		return;
ADDRGP4 $1501
JUMPV
LABELV $1523
line 2930
;2927:	}
;2928:
;2929:	// update the fade timer
;2930:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+124992
ADDRLP4 0+52
INDIRI4
ASGNI4
line 2931
;2931:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+124996
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2932
;2932:}
LABELV $1501
endproc CG_ScanForCrosshairEntity 96 28
proc CG_DrawCrosshairNames 20 16
line 2939
;2933:
;2934:/*
;2935:=====================
;2936:CG_DrawCrosshairNames
;2937:=====================
;2938: */
;2939:static void CG_DrawCrosshairNames(void) {
line 2944
;2940:	float *color;
;2941:	char *name;
;2942:	float w;
;2943:
;2944:	if (!cg_drawCrosshair.integer) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1532
line 2945
;2945:		return;
ADDRGP4 $1531
JUMPV
LABELV $1532
line 2947
;2946:	}
;2947:	if (!cg_drawCrosshairNames.integer) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $1535
line 2948
;2948:		return;
ADDRGP4 $1531
JUMPV
LABELV $1535
line 2950
;2949:	}
;2950:	if (cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1538
line 2951
;2951:		return;
ADDRGP4 $1531
JUMPV
LABELV $1538
line 2955
;2952:	}
;2953:
;2954:	// scan the known entities to see if the crosshair is sighted on one
;2955:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 2958
;2956:
;2957:	// draw the name of the player being looked at
;2958:	color = CG_FadeColor(cg.crosshairClientTime, 1000);
ADDRGP4 cg+124996
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2959
;2959:	if (!color) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1542
line 2960
;2960:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2961
;2961:		return;
ADDRGP4 $1531
JUMPV
LABELV $1542
line 2964
;2962:	}
;2963:
;2964:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
CNSTI4 2120
ADDRGP4 cg+124992
INDIRI4
MULI4
ADDRGP4 cgs+41152+4
ADDP4
ASGNP4
line 2970
;2965:#ifdef MISSIONPACK
;2966:	color[3] *= 0.5f;
;2967:	w = CG_Text_Width(name, 0.3f, 0);
;2968:	CG_Text_Paint(320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;2969:#else
;2970:	w = CG_DrawStrlen(name) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 2971
;2971:	CG_DrawBigString(320 - w / 2, 170, name, color[3] * 0.5f);
CNSTF4 1134559232
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2973
;2972:#endif
;2973:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2974
;2974:}
LABELV $1531
endproc CG_DrawCrosshairNames 20 16
proc CG_DrawSpectator 4 16
line 2984
;2975:
;2976:
;2977://==============================================================================
;2978:
;2979:/*
;2980:=================
;2981:CG_DrawSpectator
;2982:=================
;2983: */
;2984:static void CG_DrawSpectator(void) {
line 2985
;2985:	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $1548
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2986
;2986:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1549
line 2987
;2987:		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1552
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2988
;2988:	} else if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 $1550
JUMPV
LABELV $1549
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1553
line 2989
;2989:		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1556
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2990
;2990:	}
LABELV $1553
LABELV $1550
line 2991
;2991:}
LABELV $1547
endproc CG_DrawSpectator 4 16
proc CG_DrawVote 12 20
line 2998
;2992:
;2993:/*
;2994:=================
;2995:CG_DrawVote
;2996:=================
;2997: */
;2998:static void CG_DrawVote(void) {
line 3002
;2999:	char *s;
;3000:	int sec;
;3001:
;3002:	if (!cgs.voteTime) {
ADDRGP4 cgs+31684
INDIRI4
CNSTI4 0
NEI4 $1558
line 3003
;3003:		return;
ADDRGP4 $1557
JUMPV
LABELV $1558
line 3007
;3004:	}
;3005:
;3006:	// play a talk beep whenever it is modified
;3007:	if (cgs.voteModified) {
ADDRGP4 cgs+31696
INDIRI4
CNSTI4 0
EQI4 $1561
line 3008
;3008:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31696
CNSTI4 0
ASGNI4
line 3009
;3009:		trap_S_StartLocalSound(cgs.media.talkSound, CHAN_LOCAL_SOUND);
ADDRGP4 cgs+180268+1092
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3010
;3010:	}
LABELV $1561
line 3012
;3011:
;3012:	sec = (VOTE_TIME - (cg.time - cgs.voteTime)) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+31684
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3013
;3013:	if (sec < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1569
line 3014
;3014:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3015
;3015:	}
LABELV $1569
line 3022
;3016:#ifdef MISSIONPACK
;3017:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;3018:	CG_DrawSmallString(0, 58, s, 1.0F);
;3019:	s = "or press ESC then click Vote";
;3020:	CG_DrawSmallString(0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F);
;3021:#else
;3022:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
ADDRGP4 $1571
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+31700
ARGP4
ADDRGP4 cgs+31688
INDIRI4
ARGI4
ADDRGP4 cgs+31692
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 3023
;3023:	CG_DrawSmallString(0, 58, s, 1.0F);
CNSTI4 0
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3025
;3024:#endif
;3025:}
LABELV $1557
endproc CG_DrawVote 12 20
proc CG_DrawTeamVote 24 20
line 3032
;3026:
;3027:/*
;3028:=================
;3029:CG_DrawTeamVote
;3030:=================
;3031: */
;3032:static void CG_DrawTeamVote(void) {
line 3036
;3033:	char *s;
;3034:	int sec, cs_offset;
;3035:
;3036:	if (cgs.clientinfo[cg.clientNum].team == TEAM_RED)
CNSTI4 2120
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1576
line 3037
;3037:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1577
JUMPV
LABELV $1576
line 3038
;3038:	else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE)
CNSTI4 2120
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1575
line 3039
;3039:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3041
;3040:	else
;3041:		return;
LABELV $1582
LABELV $1577
line 3043
;3042:
;3043:	if (!cgs.teamVoteTime[cs_offset]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32724
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1586
line 3044
;3044:		return;
ADDRGP4 $1575
JUMPV
LABELV $1586
line 3048
;3045:	}
;3046:
;3047:	// play a talk beep whenever it is modified
;3048:	if (cgs.teamVoteModified[cs_offset]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1589
line 3049
;3049:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748
ADDP4
CNSTI4 0
ASGNI4
line 3050
;3050:		trap_S_StartLocalSound(cgs.media.talkSound, CHAN_LOCAL_SOUND);
ADDRGP4 cgs+180268+1092
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3051
;3051:	}
LABELV $1589
line 3053
;3052:
;3053:	sec = (VOTE_TIME - (cg.time - cgs.teamVoteTime[cs_offset])) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32724
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3054
;3054:	if (sec < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1597
line 3055
;3055:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3056
;3056:	}
LABELV $1597
line 3057
;3057:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1599
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32756
ADDP4
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32732
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 3059
;3058:			cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset]);
;3059:	CG_DrawSmallString(0, 90, s, 1.0F);
CNSTI4 0
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 3060
;3060:}
LABELV $1575
endproc CG_DrawTeamVote 24 20
proc CG_DrawScoreboard 20 16
line 3062
;3061:
;3062:static qboolean CG_DrawScoreboard(void) {
line 3127
;3063:#ifdef MISSIONPACK
;3064:	static qboolean firstTime = qtrue;
;3065:	float *fadeColor;
;3066:
;3067:	if (menuScoreboard) {
;3068:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;3069:	}
;3070:	if (cg_paused.integer) {
;3071:		cg.deferredPlayerLoading = 0;
;3072:		firstTime = qtrue;
;3073:		return qfalse;
;3074:	}
;3075:
;3076:	// should never happen in Team Arena
;3077:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
;3078:		cg.deferredPlayerLoading = 0;
;3079:		firstTime = qtrue;
;3080:		return qfalse;
;3081:	}
;3082:
;3083:	// don't draw scoreboard during death while warmup up
;3084:	if (cg.warmup && !cg.showScores) {
;3085:		return qfalse;
;3086:	}
;3087:
;3088:	if (cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
;3089:		fadeColor = colorWhite;
;3090:	} else {
;3091:		fadeColor = CG_FadeColor(cg.scoreFadeTime, FADE_TIME);
;3092:		if (!fadeColor) {
;3093:			// next time scoreboard comes up, don't print killer
;3094:			cg.deferredPlayerLoading = 0;
;3095:			cg.killerName[0] = 0;
;3096:			firstTime = qtrue;
;3097:			return qfalse;
;3098:		}
;3099:	}
;3100:
;3101:
;3102:	if (menuScoreboard == NULL) {
;3103:		if (CG_IsATeamGametype(cgs.gametype)) {
;3104:			menuScoreboard = Menus_FindByName("teamscore_menu");
;3105:		} else {
;3106:			menuScoreboard = Menus_FindByName("score_menu");
;3107:		}
;3108:	}
;3109:
;3110:	if (menuScoreboard) {
;3111:		if (firstTime) {
;3112:			CG_SetScoreSelection(menuScoreboard);
;3113:			firstTime = qfalse;
;3114:		}
;3115:		Menu_Paint(menuScoreboard, qtrue);
;3116:	}
;3117:
;3118:	// load any models that have been deferred
;3119:	if (++cg.deferredPlayerLoading > 10) {
;3120:		CG_LoadDeferredPlayers();
;3121:	}
;3122:
;3123:	return qtrue;
;3124:#else
;3125:	char *s;
;3126:	int w;
;3127:	if (cg.respawnTime && cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR && (!CG_IsARoundBasedGametype(cgs.gametype))) {
ADDRGP4 cg+156532
INDIRI4
CNSTI4 0
EQI4 $1604
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1604
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_IsARoundBasedGametype
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1604
line 3128
;3128:		if (cg.respawnTime > cg.time) {
ADDRGP4 cg+156532
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $1609
line 3129
;3129:			s = va("Respawn in: %2.2f", ((double) cg.respawnTime - (double) cg.time) / 1000.0);
ADDRGP4 $1613
ARGP4
ADDRGP4 cg+156532
INDIRI4
CVIF4 4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3130
;3130:			w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3131
;3131:			CG_DrawSmallStringColor(320 - w / 2, 400, s, colorYellow);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 400
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorYellow
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 3132
;3132:		} else {
ADDRGP4 $1610
JUMPV
LABELV $1609
line 3133
;3133:			s = va("Click FIRE to respawn");
ADDRGP4 $1616
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 3134
;3134:			w = CG_DrawStrlen(s) * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3135
;3135:			CG_DrawSmallStringColor(320 - w / 2, 400, "Click FIRE to respawn", colorGreen);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 $1616
ARGP4
ADDRGP4 colorGreen
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
line 3136
;3136:		}
LABELV $1610
line 3137
;3137:	}
LABELV $1604
line 3138
;3138:	return CG_DrawOldScoreboard();
ADDRLP4 12
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $1603
endproc CG_DrawScoreboard 20 16
export CG_DrawAccboard
proc CG_DrawAccboard 36 24
line 3148
;3139:#endif
;3140:}
;3141:
;3142:#define ACCBOARD_XPOS 500
;3143:#define ACCBOARD_YPOS 150
;3144:#define ACCBOARD_HEIGHT 20
;3145:#define ACCBOARD_WIDTH 75
;3146:#define ACCITEM_SIZE 16
;3147:
;3148:qboolean CG_DrawAccboard(void) {
line 3151
;3149:	int counter, i;
;3150:
;3151:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3153
;3152:
;3153:	if (!cg.showAcc) {
ADDRGP4 cg+114912
INDIRI4
CNSTI4 0
NEI4 $1618
line 3154
;3154:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1617
JUMPV
LABELV $1618
line 3156
;3155:	}
;3156:	trap_R_SetColor(colorWhite);
ADDRGP4 colorWhite
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3158
;3157:
;3158:	for (counter = 0; counter < WP_NUM_WEAPONS; counter++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1621
line 3159
;3159:		if (cg_weapons[counter + 2].weaponIcon && counter != WP_PROX_LAUNCHER && counter != WP_GRAPPLING_HOOK)
CNSTI4 172
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons+344+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1625
ADDRLP4 0
INDIRI4
CNSTI4 12
EQI4 $1625
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $1625
line 3160
;3160:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1625
line 3161
;3161:	}
LABELV $1622
line 3158
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $1621
line 3163
;3162:
;3163:	CG_DrawTeamBackground(ACCBOARD_XPOS, ACCBOARD_YPOS, ACCBOARD_WIDTH, ACCBOARD_HEIGHT * (i + 1), 0.33f, TEAM_BLUE);
CNSTI4 500
ARGI4
CNSTI4 150
ARGI4
CNSTI4 75
ARGI4
ADDRLP4 8
CNSTI4 20
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRI4
ADDI4
ARGI4
CNSTF4 1051260355
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 3165
;3164:
;3165:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3167
;3166:
;3167:	for (counter = 0; counter < WP_NUM_WEAPONS; counter++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1629
line 3168
;3168:		if (cg_weapons[counter + 2].weaponIcon && counter != WP_PROX_LAUNCHER && counter != WP_GRAPPLING_HOOK) {
CNSTI4 172
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons+344+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1633
ADDRLP4 0
INDIRI4
CNSTI4 12
EQI4 $1633
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $1633
line 3169
;3169:			CG_DrawPic(ACCBOARD_XPOS + 10, ACCBOARD_YPOS + 10 + i*ACCBOARD_HEIGHT, ACCITEM_SIZE, ACCITEM_SIZE, cg_weapons[counter + 2].weaponIcon);
CNSTF4 1140785152
ARGF4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 160
ADDI4
CVIF4 4
ARGF4
ADDRLP4 16
CNSTF4 1098907648
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 172
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons+344+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 3170
;3170:			if (cg.accuracys[counter][0] > 0)
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 cg+114796
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1639
line 3171
;3171:				CG_DrawSmallStringColor(ACCBOARD_XPOS + 10 + ACCITEM_SIZE + 10, ACCBOARD_YPOS + 10 + i * ACCBOARD_HEIGHT + ACCITEM_SIZE / 2 - SMALLCHAR_HEIGHT / 2,
ADDRGP4 $1642
ARGP4
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
CNSTF4 1120403456
ADDRLP4 20
INDIRI4
ADDRGP4 cg+114796+4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 20
INDIRI4
ADDRGP4 cg+114796
ADDP4
INDIRI4
CVIF4 4
DIVF4
CVFI4 4
ARGI4
ADDRGP4 $1646
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 536
ARGI4
ADDRLP4 28
CNSTI4 8
ASGNI4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 160
ADDI4
ADDRLP4 28
INDIRI4
ADDI4
ADDRLP4 28
INDIRI4
SUBI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
ADDRGP4 $1640
JUMPV
LABELV $1639
line 3174
;3172:					va("%i%s", (int) (((float) cg.accuracys[counter][1]*100) / ((float) (cg.accuracys[counter][0]))), "%"), colorWhite);
;3173:			else
;3174:				CG_DrawSmallStringColor(ACCBOARD_XPOS + 10 + ACCITEM_SIZE + 10, ACCBOARD_YPOS + 10 + i * ACCBOARD_HEIGHT + ACCITEM_SIZE / 2 - SMALLCHAR_HEIGHT / 2, "-%", colorWhite);
CNSTI4 536
ARGI4
ADDRLP4 32
CNSTI4 8
ASGNI4
CNSTI4 20
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 160
ADDI4
ADDRLP4 32
INDIRI4
ADDI4
ADDRLP4 32
INDIRI4
SUBI4
ARGI4
ADDRGP4 $1647
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 CG_DrawSmallStringColor
CALLV
pop
LABELV $1640
line 3175
;3175:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3176
;3176:		}
LABELV $1633
line 3177
;3177:	}
LABELV $1630
line 3167
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $1629
line 3179
;3178:
;3179:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 3180
;3180:	return qtrue;
CNSTI4 1
RETI4
LABELV $1617
endproc CG_DrawAccboard 36 24
proc CG_DrawIntermission 4 0
line 3193
;3181:}
;3182:
;3183:
;3184:
;3185:/*
;3186:=================
;3187:CG_DrawIntermission
;3188:=================
;3189: */
;3190:
;3191:void trap_Cmd_ExecuteText(int exec_when, const char *text); // leilei - for unlocks only...
;3192:
;3193:static void CG_DrawIntermission(void) {
line 3196
;3194:	//	int key;
;3195:#ifndef MISSIONPACK
;3196:	if (cgs.gametype == GT_SINGLE_PLAYER) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1649
line 3197
;3197:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 3198
;3198:		return;
ADDRGP4 $1648
JUMPV
LABELV $1649
line 3201
;3199:	}
;3200:#endif
;3201:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+114792
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 3202
;3202:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114788
ADDRLP4 0
INDIRI4
ASGNI4
line 3203
;3203:}
LABELV $1648
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 32 36
line 3210
;3204:
;3205:/*
;3206:=================
;3207:CG_DrawFollow
;3208:=================
;3209: */
;3210:static qboolean CG_DrawFollow(void) {
line 3215
;3211:	float x;
;3212:	vec4_t color;
;3213:	const char *name;
;3214:
;3215:	if (!(cg.snap->ps.pm_flags & PMF_FOLLOW)) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1656
line 3216
;3216:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1655
JUMPV
LABELV $1656
line 3218
;3217:	}
;3218:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 3219
;3219:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 3220
;3220:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 3221
;3221:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 3224
;3222:
;3223:
;3224:	CG_DrawBigString(320 - 9 * 8, 24, "following", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 $1662
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3226
;3225:
;3226:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
CNSTI4 2120
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+41152+4
ADDP4
ASGNP4
line 3228
;3227:
;3228:	x = 0.5 * (640 - GIANT_WIDTH * CG_DrawStrlen(name));
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 3230
;3229:
;3230:	CG_DrawStringExt(x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0);
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3232
;3231:
;3232:	return qtrue;
CNSTI4 1
RETI4
LABELV $1655
endproc CG_DrawFollow 32 36
proc CG_DrawAmmoWarning 12 16
line 3240
;3233:}
;3234:
;3235:/*
;3236:=================
;3237:CG_DrawAmmoWarning
;3238:=================
;3239: */
;3240:static void CG_DrawAmmoWarning(void) {
line 3245
;3241:	const char *s;
;3242:	int w;
;3243:
;3244:	//Don't report in instant gib same with RA
;3245:	if (cgs.nopickup)
ADDRGP4 cgs+34824
INDIRI4
CNSTI4 0
EQI4 $1667
line 3246
;3246:		return;
ADDRGP4 $1666
JUMPV
LABELV $1667
line 3248
;3247:
;3248:	if (cg_drawAmmoWarning.integer == 0) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $1670
line 3249
;3249:		return;
ADDRGP4 $1666
JUMPV
LABELV $1670
line 3252
;3250:	}
;3251:
;3252:	if (!cg.lowAmmoWarning) {
ADDRGP4 cg+124984
INDIRI4
CNSTI4 0
NEI4 $1673
line 3253
;3253:		return;
ADDRGP4 $1666
JUMPV
LABELV $1673
line 3256
;3254:	}
;3255:
;3256:	if (cg.lowAmmoWarning == 2) {
ADDRGP4 cg+124984
INDIRI4
CNSTI4 2
NEI4 $1676
line 3257
;3257:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $1679
ASGNP4
line 3258
;3258:	} else {
ADDRGP4 $1677
JUMPV
LABELV $1676
line 3259
;3259:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $1680
ASGNP4
line 3260
;3260:	}
LABELV $1677
line 3261
;3261:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 3262
;3262:	CG_DrawBigString(320 - w / 2, 64, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3263
;3263:}
LABELV $1666
endproc CG_DrawAmmoWarning 12 16
bss
align 4
LABELV $1682
skip 4
code
proc CG_DrawProxWarning 48 16
line 3271
;3264:
;3265:
;3266:/*
;3267:=================
;3268:CG_DrawProxWarning
;3269:=================
;3270:*/
;3271:static void CG_DrawProxWarning( void ) {
line 3277
;3272:	char s [32];
;3273:	int w;
;3274:	static int proxTime;
;3275:	int proxTick;
;3276:
;3277:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1683
line 3278
;3278:		proxTime = 0;
ADDRGP4 $1682
CNSTI4 0
ASGNI4
line 3279
;3279:		return;
ADDRGP4 $1681
JUMPV
LABELV $1683
line 3282
;3280:	}
;3281:
;3282:	if (proxTime == 0) {
ADDRGP4 $1682
INDIRI4
CNSTI4 0
NEI4 $1686
line 3283
;3283:		proxTime = cg.time;
ADDRGP4 $1682
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 3284
;3284:	}
LABELV $1686
line 3286
;3285:
;3286:	proxTick = 10 - ((cg.time - proxTime) / 1000);
ADDRLP4 32
CNSTI4 10
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 $1682
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
SUBI4
ASGNI4
line 3288
;3287:
;3288:	if (proxTick > 0 && proxTick <= 5) {
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $1690
ADDRLP4 32
INDIRI4
CNSTI4 5
GTI4 $1690
line 3289
;3289:		Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1692
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3290
;3290:	} else {
ADDRGP4 $1691
JUMPV
LABELV $1690
line 3291
;3291:		Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1693
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3292
;3292:	}
LABELV $1691
line 3294
;3293:
;3294:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 3295
;3295:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
CNSTI4 320
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 80
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 3296
;3296:}
LABELV $1681
endproc CG_DrawProxWarning 48 16
proc CG_DrawWarmup 56 36
line 3303
;3297:
;3298:/*
;3299:=================
;3300:CG_DrawWarmup
;3301:=================
;3302: */
;3303:static void CG_DrawWarmup(void) {
line 3312
;3304:	int w;
;3305:	int sec;
;3306:	int i;
;3307:	float scale __attribute__ ((unused));
;3308:	clientInfo_t *ci1, *ci2;
;3309:	int cw __attribute__ ((unused));
;3310:	const char *s;
;3311:
;3312:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+125248
INDIRI4
ASGNI4
line 3313
;3313:	if (!sec) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1697
line 3314
;3314:		return;
ADDRGP4 $1695
JUMPV
LABELV $1697
line 3317
;3315:	}
;3316:
;3317:	if (sec < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1699
line 3318
;3318:		s = "Waiting for players";
ADDRLP4 8
ADDRGP4 $1701
ASGNP4
line 3319
;3319:		w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 3320
;3320:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 3321
;3321:		cg.warmupCount = 0;
ADDRGP4 cg+125252
CNSTI4 0
ASGNI4
line 3322
;3322:		return;
ADDRGP4 $1695
JUMPV
LABELV $1699
line 3325
;3323:	}
;3324:
;3325:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1703
line 3327
;3326:		// find the two active players
;3327:		ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 3328
;3328:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 3329
;3329:		for (i = 0; i < cgs.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1709
JUMPV
LABELV $1706
line 3330
;3330:			if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE) {
ADDRLP4 32
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+41152
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1711
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+41152+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1711
line 3331
;3331:				if (!ci1) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1716
line 3332
;3332:					ci1 = &cgs.clientinfo[i];
ADDRLP4 20
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 3333
;3333:				} else {
ADDRGP4 $1717
JUMPV
LABELV $1716
line 3334
;3334:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 2120
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+41152
ADDP4
ASGNP4
line 3335
;3335:				}
LABELV $1717
line 3336
;3336:			}
LABELV $1711
line 3337
;3337:		}
LABELV $1707
line 3329
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1709
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31488
INDIRI4
LTI4 $1706
line 3339
;3338:
;3339:		if (ci1 && ci2) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1704
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1704
line 3340
;3340:			s = va("%s vs %s", ci1->name, ci2->name);
ADDRGP4 $1722
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 3345
;3341:#ifdef MISSIONPACK
;3342:			w = CG_Text_Width(s, 0.6f, 0);
;3343:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3344:#else
;3345:			w = CG_DrawStrlen(s);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 3346
;3346:			if (w > 640 / GIANT_WIDTH) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1723
line 3347
;3347:				cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 3348
;3348:			} else {
ADDRGP4 $1724
JUMPV
LABELV $1723
line 3349
;3349:				cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 3350
;3350:			}
LABELV $1724
line 3351
;3351:			CG_DrawStringExt(320 - w * cw / 2, 20, s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3354
;3352:					qfalse, qtrue, cw, (int) (cw * 1.5f), 0);
;3353:#endif
;3354:		}
line 3355
;3355:	} else {
ADDRGP4 $1704
JUMPV
LABELV $1703
line 3356
;3356:		if (cgs.gametype == GT_FFA) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 0
NEI4 $1725
line 3357
;3357:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $1728
ASGNP4
line 3358
;3358:		} else if (cgs.gametype == GT_TEAM) {
ADDRGP4 $1726
JUMPV
LABELV $1725
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1729
line 3359
;3359:			s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $1732
ASGNP4
line 3360
;3360:		} else if (cgs.gametype == GT_CTF) {
ADDRGP4 $1730
JUMPV
LABELV $1729
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1733
line 3361
;3361:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1736
ASGNP4
line 3362
;3362:		} else if (cgs.gametype == GT_ELIMINATION) {
ADDRGP4 $1734
JUMPV
LABELV $1733
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 8
NEI4 $1737
line 3363
;3363:			s = "Elimination";
ADDRLP4 8
ADDRGP4 $1740
ASGNP4
line 3364
;3364:		} else if (cgs.gametype == GT_CTF_ELIMINATION) {
ADDRGP4 $1738
JUMPV
LABELV $1737
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 9
NEI4 $1741
line 3365
;3365:			s = "CTF Elimination";
ADDRLP4 8
ADDRGP4 $1744
ASGNP4
line 3366
;3366:		} else if (cgs.gametype == GT_LMS) {
ADDRGP4 $1742
JUMPV
LABELV $1741
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 10
NEI4 $1745
line 3367
;3367:			s = "Last Man Standing";
ADDRLP4 8
ADDRGP4 $1748
ASGNP4
line 3368
;3368:		} else if (cgs.gametype == GT_DOUBLE_D) {
ADDRGP4 $1746
JUMPV
LABELV $1745
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 11
NEI4 $1749
line 3369
;3369:			s = "Double Domination";
ADDRLP4 8
ADDRGP4 $1752
ASGNP4
line 3370
;3370:		} else if (cgs.gametype == GT_1FCTF) {
ADDRGP4 $1750
JUMPV
LABELV $1749
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 5
NEI4 $1753
line 3371
;3371:			s = "One Flag CTF";
ADDRLP4 8
ADDRGP4 $1756
ASGNP4
line 3372
;3372:		} else if (cgs.gametype == GT_OBELISK) {
ADDRGP4 $1754
JUMPV
LABELV $1753
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 6
NEI4 $1757
line 3373
;3373:			s = "Overload";
ADDRLP4 8
ADDRGP4 $1760
ASGNP4
line 3374
;3374:		} else if (cgs.gametype == GT_HARVESTER) {
ADDRGP4 $1758
JUMPV
LABELV $1757
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 7
NEI4 $1761
line 3375
;3375:			s = "Harvester";
ADDRLP4 8
ADDRGP4 $1764
ASGNP4
line 3376
;3376:		} else if (cgs.gametype == GT_DOMINATION) {
ADDRGP4 $1762
JUMPV
LABELV $1761
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 12
NEI4 $1765
line 3377
;3377:			s = "Domination";
ADDRLP4 8
ADDRGP4 $1768
ASGNP4
line 3378
;3378:		} else if (cgs.gametype == GT_POSSESSION) {
ADDRGP4 $1766
JUMPV
LABELV $1765
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 13
NEI4 $1769
line 3379
;3379:			s = "Possession";
ADDRLP4 8
ADDRGP4 $1772
ASGNP4
line 3380
;3380:		} else {
ADDRGP4 $1770
JUMPV
LABELV $1769
line 3381
;3381:			s = "";
ADDRLP4 8
ADDRGP4 $1773
ASGNP4
line 3382
;3382:		}
LABELV $1770
LABELV $1766
LABELV $1762
LABELV $1758
LABELV $1754
LABELV $1750
LABELV $1746
LABELV $1742
LABELV $1738
LABELV $1734
LABELV $1730
LABELV $1726
line 3387
;3383:#ifdef MISSIONPACK
;3384:		w = CG_Text_Width(s, 0.6f, 0);
;3385:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3386:#else
;3387:		w = CG_DrawStrlen(s);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 3388
;3388:		if (w > 640 / GIANT_WIDTH) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1774
line 3389
;3389:			cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 3390
;3390:		} else {
ADDRGP4 $1775
JUMPV
LABELV $1774
line 3391
;3391:			cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 3392
;3392:		}
LABELV $1775
line 3393
;3393:		CG_DrawStringExt(320 - w * cw / 2, 25, s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1066192077
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3396
;3394:				qfalse, qtrue, cw, (int) (cw * 1.1f), 0);
;3395:#endif
;3396:	}
LABELV $1704
line 3398
;3397:
;3398:	sec = (sec - cg.time) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3399
;3399:	if (sec < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1777
line 3400
;3400:		cg.warmup = 0;
ADDRGP4 cg+125248
CNSTI4 0
ASGNI4
line 3401
;3401:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3402
;3402:	}
LABELV $1777
line 3403
;3403:	s = va("Starts in: %i", sec + 1);
ADDRGP4 $1780
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3404
;3404:	if (sec != cg.warmupCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+125252
INDIRI4
EQI4 $1781
line 3405
;3405:		cg.warmupCount = sec;
ADDRGP4 cg+125252
ADDRLP4 4
INDIRI4
ASGNI4
line 3406
;3406:		switch (sec) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1787
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1790
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1793
ADDRGP4 $1786
JUMPV
LABELV $1787
line 3408
;3407:			case 0:
;3408:				trap_S_StartLocalSound(cgs.media.count1Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1364
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3409
;3409:				break;
ADDRGP4 $1786
JUMPV
LABELV $1790
line 3411
;3410:			case 1:
;3411:				trap_S_StartLocalSound(cgs.media.count2Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1360
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3412
;3412:				break;
ADDRGP4 $1786
JUMPV
LABELV $1793
line 3414
;3413:			case 2:
;3414:				trap_S_StartLocalSound(cgs.media.count3Sound, CHAN_ANNOUNCER);
ADDRGP4 cgs+180268+1356
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3415
;3415:				break;
line 3417
;3416:			default:
;3417:				break;
LABELV $1786
line 3419
;3418:		}
;3419:	}
LABELV $1781
line 3420
;3420:	scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3421
;3421:	switch (cg.warmupCount) {
ADDRLP4 36
ADDRGP4 cg+125252
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1799
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $1800
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $1801
ADDRGP4 $1796
JUMPV
LABELV $1799
line 3423
;3422:		case 0:
;3423:			cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 3424
;3424:			scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 3425
;3425:			break;
ADDRGP4 $1797
JUMPV
LABELV $1800
line 3427
;3426:		case 1:
;3427:			cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 3428
;3428:			scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 3429
;3429:			break;
ADDRGP4 $1797
JUMPV
LABELV $1801
line 3431
;3430:		case 2:
;3431:			cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 3432
;3432:			scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 3433
;3433:			break;
ADDRGP4 $1797
JUMPV
LABELV $1796
line 3435
;3434:		default:
;3435:			cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 3436
;3436:			scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3437
;3437:			break;
LABELV $1797
line 3444
;3438:	}
;3439:
;3440:#ifdef MISSIONPACK
;3441:	w = CG_Text_Width(s, scale, 0);
;3442:	CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3443:#else
;3444:	w = CG_DrawStrlen(s);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 3445
;3445:	CG_DrawStringExt(320 - w * cw / 2, 70, s, colorWhite,
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3448
;3446:			qfalse, qtrue, cw, (int) (cw * 1.5), 0);
;3447:#endif
;3448:}
LABELV $1695
endproc CG_DrawWarmup 56 36
proc CG_Draw2D 16 4
line 3475
;3449:
;3450://==================================================================================
;3451:#ifdef MISSIONPACK
;3452:
;3453:/* 
;3454:=================
;3455:CG_DrawTimedMenus
;3456:=================
;3457: */
;3458:void CG_DrawTimedMenus(void) {
;3459:	if (cg.voiceTime) {
;3460:		int t = cg.time - cg.voiceTime;
;3461:		if (t > 2500) {
;3462:			Menus_CloseByName("voiceMenu");
;3463:			trap_Cvar_Set("cl_conXOffset", "0");
;3464:			cg.voiceTime = 0;
;3465:		}
;3466:	}
;3467:}
;3468:#endif
;3469:
;3470:/*
;3471:=================
;3472:CG_Draw2D
;3473:=================
;3474: */
;3475:static void CG_Draw2D(stereoFrame_t stereoFrame) {
line 3482
;3476:#ifdef MISSIONPACK
;3477:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;3478:		CG_CheckOrderPending();
;3479:	}
;3480:#endif
;3481:	// if we are taking a levelshot for the menu, don't draw anything
;3482:	if (cg.levelShot) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $1803
line 3483
;3483:		return;
ADDRGP4 $1802
JUMPV
LABELV $1803
line 3486
;3484:	}
;3485:
;3486:	if (cg_draw2D.integer == 0) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $1806
line 3487
;3487:		return;
ADDRGP4 $1802
JUMPV
LABELV $1806
line 3490
;3488:	}
;3489:
;3490:	if (cg.snap->ps.pm_type == PM_INTERMISSION) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1809
line 3491
;3491:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 3492
;3492:		return;
ADDRGP4 $1802
JUMPV
LABELV $1809
line 3500
;3493:	}
;3494:
;3495:	/*
;3496:		if (cg.cameraMode) {
;3497:			return;
;3498:		}
;3499:	 */
;3500:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR /*|| cg.snap->ps.pm_type == PM_SPECTATOR*/) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1812
line 3501
;3501:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 3503
;3502:
;3503:		if (stereoFrame == STEREO_CENTER)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1815
line 3504
;3504:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
LABELV $1815
line 3506
;3505:
;3506:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 3507
;3507:	} else {
ADDRGP4 $1813
JUMPV
LABELV $1812
line 3509
;3508:		// don't draw any status if dead or the scoreboard is being explicitly shown
;3509:		if (!cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+114784
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1817
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $1817
line 3517
;3510:
;3511:#ifdef MISSIONPACK
;3512:			if (cg_drawStatus.integer) {
;3513:				Menu_PaintAll();
;3514:				CG_DrawTimedMenus();
;3515:			}
;3516:#else
;3517:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 3520
;3518:#endif
;3519:
;3520:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 3522
;3521:
;3522:			CG_DrawProxWarning();
ADDRGP4 CG_DrawProxWarning
CALLV
pop
line 3523
;3523:			if (stereoFrame == STEREO_CENTER)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1821
line 3524
;3524:				CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
LABELV $1821
line 3525
;3525:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 3526
;3526:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 3529
;3527:
;3528:#ifndef MISSIONPACK
;3529:			CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 3530
;3530:			CG_DrawPersistantPowerup();
ADDRGP4 CG_DrawPersistantPowerup
CALLV
pop
line 3533
;3531:#endif
;3532:
;3533:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 3534
;3534:		}
LABELV $1817
line 3535
;3535:	}
LABELV $1813
line 3537
;3536:#ifndef MISSIONPACK
;3537:	if (CG_IsATeamGametype(cgs.gametype)) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 CG_IsATeamGametype
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1823
line 3538
;3538:		CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 3539
;3539:	}
LABELV $1823
line 3542
;3540:#endif
;3541:
;3542:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 3543
;3543:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 3545
;3544:
;3545:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 3552
;3546:
;3547:#ifdef MISSIONPACK
;3548:	if (!cg_paused.integer) {
;3549:		CG_DrawUpperRight(stereoFrame);
;3550:	}
;3551:#else
;3552:	CG_DrawUpperRight(stereoFrame);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 3556
;3553:#endif
;3554:
;3555:#ifndef MISSIONPACK
;3556:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 3557
;3557:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 3560
;3558:#endif
;3559:
;3560:	CG_DrawFragMessage();
ADDRGP4 CG_DrawFragMessage
CALLV
pop
line 3562
;3561:
;3562:	if (!CG_DrawFollow()) {
ADDRLP4 4
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1826
line 3563
;3563:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 3564
;3564:	}
LABELV $1826
line 3567
;3565:
;3566:	// don't draw center string if scoreboard is up
;3567:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 8
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114788
ADDRLP4 8
INDIRI4
ASGNI4
line 3568
;3568:	if (!cg.scoreBoardShowing) {
ADDRGP4 cg+114788
INDIRI4
CNSTI4 0
NEI4 $1829
line 3569
;3569:		CG_DrawCenterDDString();
ADDRGP4 CG_DrawCenterDDString
CALLV
pop
line 3570
;3570:		CG_DrawCenter1FctfString();
ADDRGP4 CG_DrawCenter1FctfString
CALLV
pop
line 3571
;3571:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 3572
;3572:	}
LABELV $1829
line 3574
;3573:
;3574:	cg.accBoardShowing = CG_DrawAccboard();
ADDRLP4 12
ADDRGP4 CG_DrawAccboard
CALLI4
ASGNI4
ADDRGP4 cg+114916
ADDRLP4 12
INDIRI4
ASGNI4
line 3575
;3575:}
LABELV $1802
endproc CG_Draw2D 16 4
export CG_DrawActive
proc CG_DrawActive 0 4
line 3584
;3576:
;3577:/*
;3578:=====================
;3579:CG_DrawActive
;3580:
;3581:Perform all drawing needed to completely fill the screen
;3582:=====================
;3583: */
;3584:void CG_DrawActive(stereoFrame_t stereoView) {
line 3586
;3585:	// optionally draw the info screen instead
;3586:	if (!cg.snap) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1834
line 3595
;3587:		// loadingscreen
;3588:#ifdef SCRIPTHUD
;3589:		menuDef_t *loading = Menus_FindByName("Loading");
;3590:		if (loading == NULL)
;3591:			//	if(!loading)
;3592:
;3593:#endif
;3594:			// end loadingscreen
;3595:			CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 3596
;3596:		return;
ADDRGP4 $1833
JUMPV
LABELV $1834
line 3600
;3597:	}
;3598:
;3599:	// optionally draw the tournement scoreboard instead
;3600:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1837
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1837
line 3601
;3601:			(cg.snap->ps.pm_flags & PMF_SCOREBOARD)) {
line 3602
;3602:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 3603
;3603:		return;
ADDRGP4 $1833
JUMPV
LABELV $1837
line 3607
;3604:	}
;3605:
;3606:	// clear around the rendered view if sized down
;3607:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 3609
;3608:
;3609:	if (stereoView != STEREO_CENTER)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $1841
line 3610
;3610:		CG_DrawCrosshair3D();
ADDRGP4 CG_DrawCrosshair3D
CALLV
pop
LABELV $1841
line 3613
;3611:
;3612:	// draw 3D view
;3613:	trap_R_RenderScene(&cg.refdef);
ADDRGP4 cg+109252
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 3616
;3614:
;3615:	// draw status bar and other floating elements
;3616:	CG_Draw2D(stereoView);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Draw2D
CALLV
pop
line 3617
;3617:}
LABELV $1833
endproc CG_DrawActive 0 4
import trap_Cmd_ExecuteText
bss
export lagometer
align 4
LABELV lagometer
skip 1544
import CG_IsARoundBasedGametype
import CG_UsesTheWhiteFlag
import CG_UsesTeamFlags
import CG_IsATeamGametype
import trap_R_LFX_ParticleEffect
import wideAdjustX
import initparticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import addChallenge
import getChallenge
import challenges_save
import challenges_init
import CG_DrawTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_TransitionEntity
import CG_ProcessSnapshots
import CG_SpurtBlood
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_LightningBoltBeam
import CG_InvulnerabilityJuiced
import CG_InvulnerabilityImpact
import CG_ObeliskPain
import CG_ObeliskExplode
import CG_KamikazeEffect
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponBar7
import CG_DrawWeaponBar6
import CG_DrawWeaponBar5
import CG_DrawWeaponBar4
import CG_DrawWeaponBar3
import CG_DrawWeaponBar2
import CG_DrawWeaponBar1
import CG_DrawWeaponBar0
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_BestWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_FairCvars
import SnapVectorTowards
import CG_GetCVar
import CG_BuildSpectatorString
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import CG_Cvar_ClampInt
import CG_PredictWeaponEffects
import cg_developer
import cg_leiChibi
import cg_missionpackChecks
import cg_teamChatBeep
import cg_chatBeep
import cg_weaponOrder
import cg_weaponBarStyle
import cg_crosshairColorBlue
import cg_crosshairColorGreen
import cg_crosshairColorRed
import cg_ch13size
import cg_ch13
import cg_ch12size
import cg_ch12
import cg_ch11size
import cg_ch11
import cg_ch10size
import cg_ch10
import cg_ch9size
import cg_ch9
import cg_ch8size
import cg_ch8
import cg_ch7size
import cg_ch7
import cg_ch6size
import cg_ch6
import cg_ch5size
import cg_ch5
import cg_ch4size
import cg_ch4
import cg_ch3size
import cg_ch3
import cg_ch2size
import cg_ch2
import cg_ch1size
import cg_ch1
import cg_differentCrosshairs
import cg_crosshairPulse
import cg_fragmsgsize
import cg_autovertex
import cg_vote_custom_commands
import cg_cyclegrapple
import cg_voteflags
import cg_voip_teamonly
import cg_hitsound
import cg_alwaysWeaponBar
import cl_timeNudge
import cg_optimizePrediction
import cg_projectileNudge
import sv_fps
import cg_cmdTimeNudge
import cg_delag
import cg_enableFS
import cg_enableQ
import cg_enableBreath
import cg_enableDust
import cg_obeliskRespawnDelay
import cg_music
import cg_trueLightning
import cg_oldPlasma
import cg_modelEyes_Fwd
import cg_modelEyes_Right
import cg_modelEyes_Up
import cg_cameraEyes_Up
import cg_cameraEyes_Fwd
import cg_cameraEyes
import cg_cameramode
import cg_deathcam
import cg_leiDebug
import cg_muzzleflashStyle
import cg_leiSuperGoreyAwesome
import cg_leiBrassNoise
import cg_leiGoreNoise
import cg_leiEnhancement
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_float
import pmove_msec
import pmove_fixed
import cg_obituaryOutput
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawSpeed
import cg_drawAttacker
import cg_lagometer
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewnudge
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_kickScale
import cg_bobmodel
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_bob
import cg_runroll
import cg_runpitch
import cg_centertime
import mod_sgspread
import mod_sgcount
import mod_lgrange
import mod_cgspread
import mod_mgspread
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $1780
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1773
byte 1 0
align 1
LABELV $1772
byte 1 80
byte 1 111
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1768
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1764
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1760
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1756
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $1752
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1748
byte 1 76
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1744
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 69
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1740
byte 1 69
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1736
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1732
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1728
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1722
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1701
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1693
byte 1 89
byte 1 79
byte 1 85
byte 1 32
byte 1 72
byte 1 65
byte 1 86
byte 1 69
byte 1 32
byte 1 66
byte 1 69
byte 1 69
byte 1 78
byte 1 32
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $1692
byte 1 73
byte 1 78
byte 1 84
byte 1 69
byte 1 82
byte 1 78
byte 1 65
byte 1 76
byte 1 32
byte 1 67
byte 1 79
byte 1 77
byte 1 66
byte 1 85
byte 1 83
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 32
byte 1 73
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1680
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $1679
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $1662
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1647
byte 1 45
byte 1 37
byte 1 0
align 1
LABELV $1646
byte 1 37
byte 1 0
align 1
LABELV $1642
byte 1 37
byte 1 105
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1616
byte 1 67
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1613
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 50
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $1599
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1571
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1556
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1552
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1548
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $1470
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 83
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1469
byte 1 114
byte 1 95
byte 1 122
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 0
align 1
LABELV $1320
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1315
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1301
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $1299
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 0
align 1
LABELV $1297
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 0
align 1
LABELV $1235
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $1170
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1166
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1135
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $908
byte 1 94
byte 1 49
byte 1 37
byte 1 51
byte 1 105
byte 1 37
byte 1 37
byte 1 32
byte 1 94
byte 1 52
byte 1 37
byte 1 51
byte 1 105
byte 1 37
byte 1 37
byte 1 0
align 1
LABELV $839
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $760
byte 1 40
byte 1 94
byte 1 49
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 77
byte 1 65
byte 1 84
byte 1 69
byte 1 94
byte 1 55
byte 1 41
byte 1 0
align 1
LABELV $751
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $724
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $721
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $654
byte 1 32
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $653
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $629
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $604
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $588
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $587
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $582
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $569
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $568
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 47
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 45
byte 1 32
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $564
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 47
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 43
byte 1 32
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $560
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 45
byte 1 32
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $556
byte 1 76
byte 1 77
byte 1 83
byte 1 58
byte 1 32
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 43
byte 1 32
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $551
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $547
byte 1 37
byte 1 100
byte 1 48
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $527
byte 1 83
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $526
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $523
byte 1 83
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $511
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $506
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $490
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $485
byte 1 37
byte 1 105
byte 1 117
byte 1 47
byte 1 115
byte 1 0
align 1
LABELV $479
byte 1 110
byte 1 0
align 1
LABELV $111
byte 1 37
byte 1 105
byte 1 0
