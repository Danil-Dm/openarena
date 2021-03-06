export LogAcc
code
proc LogAcc 1064 24
file "../../../code/game/g_playerstore.c"
line 46
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
;25:#define MAX_PLAYERS_STORED 32
;26:
;27:#define GUID_SIZE 32
;28:
;29:typedef struct {
;30:	char guid[GUID_SIZE+1]; //The guid is 32 chars long
;31:	int age; //int that grows each time a new player is stored. The lowest number is always replaced. Reset to 0 then retrieved.
;32:	int	persistant[MAX_PERSISTANT]; //This is the only information we need to save
;33:	int timePlayed;
;34:	int	accuracy[WP_NUM_WEAPONS][2];
;35:} playerstore_t;
;36:
;37:static playerstore_t playerstore[MAX_PLAYERS_STORED];
;38:
;39:static int nextAge;
;40:
;41:/**
;42: * Logs all accuracy values for a given client. This should be called just before the game ends and then a client leaves.
;43: * @param clientNum
;44: */
;45:void LogAcc(int clientNum)
;46:{
line 49
;47:	char buffer[1024];
;48:	int i;
;49:	qboolean first = qtrue;
ADDRLP4 1028
CNSTI4 1
ASGNI4
line 50
;50:	Com_sprintf(buffer,sizeof(buffer),"Accuracy: %i ",clientNum);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $62
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 51
;51:	for(i=0; i<WP_NUM_WEAPONS; ++i) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $63
line 52
;52:		char *tmp = va("%sf%i\\%i\\h%i\\%i",first ? "" : "\\",i,level.clients[clientNum].accuracy[i][0],i,level.clients[clientNum].accuracy[i][1]);
ADDRGP4 $67
ARGP4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $71
ADDRLP4 1036
ADDRGP4 $68
ASGNP4
ADDRGP4 $72
JUMPV
LABELV $71
ADDRLP4 1036
ADDRGP4 $69
ASGNP4
LABELV $72
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1044
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 2116
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 2004
ADDP4
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1044
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1048
INDIRP4
ASGNP4
line 53
;53:		if(strlen(tmp)+strlen(buffer)+1+1<sizeof(buffer)) /* +1 \n +1 \0 */
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRLP4 1052
INDIRI4
ADDRLP4 1056
INDIRI4
ADDI4
ADDRLP4 1060
INDIRI4
ADDI4
ADDRLP4 1060
INDIRI4
ADDI4
CVIU4 4
CNSTU4 1024
GEU4 $73
line 54
;54:			strcat(buffer,tmp);
ADDRLP4 4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $73
line 55
;55:		first = qfalse;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 56
;56:	}
LABELV $64
line 51
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $63
line 57
;57:	G_LogPrintf("%s\n",buffer);
ADDRGP4 $75
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 58
;58:}
LABELV $61
endproc LogAcc 1064 24
export PlayerStoreInit
proc PlayerStoreInit 0 12
line 64
;59:
;60:/**
;61: *Resets the player store. Should be called everytime game.qvm is loaded.
;62: */
;63:void PlayerStoreInit( void )
;64:{
line 65
;65:	memset(playerstore,0,sizeof(playerstore));
ADDRGP4 playerstore
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 66
;66:	nextAge = 1;
ADDRGP4 nextAge
CNSTI4 1
ASGNI4
line 67
;67:}
LABELV $76
endproc PlayerStoreInit 0 12
export PlayerStore_store
proc PlayerStore_store 28 12
line 70
;68:
;69:void PlayerStore_store(const char* guid, playerState_t ps)
;70:{
line 71
;71:	int place2store = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 72
;72:	int lowestAge = 32000;
ADDRLP4 8
CNSTI4 32000
ASGNI4
line 74
;73:	int i;
;74:	LogAcc(ps.clientNum);
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 LogAcc
CALLV
pop
line 75
;75:	if(strlen(guid)<32) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 32
GEI4 $78
line 76
;76:		G_LogPrintf("Playerstore: Failed to store player. Invalid guid: %s\n",guid);
ADDRGP4 $80
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 77
;77:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 79
;78:	}
;79:	for(i=0; i<MAX_PLAYERS_STORED; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $81
line 80
;80:		if(Q_strequal(guid,playerstore[i].guid)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $85
line 81
;81:			place2store=i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 82
;82:		}
LABELV $85
line 83
;83:	}
LABELV $82
line 79
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $81
line 85
;84:
;85:	if(place2store<0)
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $87
line 86
;86:		for(i=0; i<MAX_PLAYERS_STORED; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $89
line 87
;87:			if(playerstore[i].age < lowestAge) {
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+36
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $93
line 88
;88:				place2store = i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 89
;89:				lowestAge = playerstore[i].age;
ADDRLP4 8
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+36
ADDP4
INDIRI4
ASGNI4
line 90
;90:			}
LABELV $93
line 91
;91:		}
LABELV $90
line 86
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $89
LABELV $87
line 94
;92:
;93:	//Make sure we don't store in -1
;94:	if(place2store<0)
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $97
line 95
;95:		place2store = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $97
line 97
;96:	//place2store is now the place to store to.
;97:	playerstore[place2store].age = nextAge++;
ADDRLP4 20
ADDRGP4 nextAge
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore+36
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 98
;98:	Q_strncpyz(playerstore[place2store].guid,guid,GUID_SIZE+1);
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 99
;99:	memcpy(playerstore[place2store].persistant,ps.persistant,sizeof(int[MAX_PERSISTANT]));
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore+40
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 100
;100:	memcpy(playerstore[place2store].accuracy,level.clients[ps.clientNum].accuracy, sizeof(playerstore[0].accuracy) );
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore+108
ADDP4
ARGP4
CNSTI4 2116
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 2004
ADDP4
ARGP4
CNSTI4 112
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 101
;101:	playerstore[place2store].timePlayed = level.time - level.clients[ps.clientNum].pers.enterTime;
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore+104
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2116
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
ASGNI4
line 102
;102:	G_LogPrintf("Playerstore: Stored player with guid: %s in %u\n", playerstore[place2store].guid,place2store);
ADDRGP4 $105
ARGP4
CNSTI4 220
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 playerstore
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 103
;103:}
LABELV $77
endproc PlayerStore_store 28 12
export PlayerStore_restore
proc PlayerStore_restore 12 12
line 106
;104:
;105:void PlayerStore_restore(const char* guid, playerState_t *ps)
;106:{
line 108
;107:	int i;
;108:	if(strlen(guid)<32) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
GEI4 $107
line 109
;109:		G_LogPrintf("Playerstore: Failed to restore player. Invalid guid: %s\n",guid);
ADDRGP4 $109
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 110
;110:		return;
ADDRGP4 $106
JUMPV
LABELV $107
line 112
;111:	}
;112:	for(i=0; i<MAX_PLAYERS_STORED; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $110
line 113
;113:		if(Q_strequaln(guid,playerstore[i].guid,GUID_SIZE) && playerstore[i].age != -1) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 8
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $114
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+36
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $114
line 114
;114:			memcpy(ps->persistant,playerstore[i].persistant,sizeof(int[MAX_PERSISTANT]));
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ARGP4
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+40
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 115
;115:			memcpy(level.clients[ps->clientNum].accuracy, playerstore[i].accuracy,sizeof(playerstore[0].accuracy) );
CNSTI4 2116
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 2004
ADDP4
ARGP4
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+108
ADDP4
ARGP4
CNSTI4 112
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 116
;116:			level.clients[ps->clientNum].pers.enterTime = level.time - playerstore[i].timePlayed;
CNSTI4 2116
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+104
ADDP4
INDIRI4
SUBI4
ASGNI4
line 118
;117:			//Never ever restore a player with negative score
;118:			if(ps->persistant[PERS_SCORE]<0)
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 0
GEI4 $122
line 119
;119:				ps->persistant[PERS_SCORE]=0;
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 0
ASGNI4
LABELV $122
line 120
;120:			playerstore[i].age = -1;
CNSTI4 220
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 playerstore+36
ADDP4
CNSTI4 -1
ASGNI4
line 121
;121:			G_LogPrintf("Restored player with guid: %s\n",guid);
ADDRGP4 $125
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 122
;122:			return;
ADDRGP4 $106
JUMPV
LABELV $114
line 124
;123:		}
;124:	}
LABELV $111
line 112
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $110
line 125
;125:	G_LogPrintf("Playerstore: Nothing to restore. Guid: %s\n",guid);
ADDRGP4 $126
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 126
;126:}
LABELV $106
endproc PlayerStore_restore 12 12
bss
align 4
LABELV nextAge
skip 4
align 4
LABELV playerstore
skip 7040
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
LABELV $126
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 32
byte 1 71
byte 1 117
byte 1 105
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 82
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $109
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 32
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $105
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 83
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $80
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 32
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $75
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $69
byte 1 92
byte 1 0
align 1
LABELV $68
byte 1 0
align 1
LABELV $67
byte 1 37
byte 1 115
byte 1 102
byte 1 37
byte 1 105
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 104
byte 1 37
byte 1 105
byte 1 92
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $62
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
