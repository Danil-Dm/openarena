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
// g_misc.c

#include "g_local.h"


/*QUAKED func_group (0 0 0) ?
Used to group brushes together just for editor convenience.  They are turned into normal brushes by the utilities.
*/


/*QUAKED info_camp (0 0.5 0) (-4 -4 -4) (4 4 4)
Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
*/
void SP_info_camp( gentity_t *self ) {
	G_SetOrigin( self, self->s.origin );
}


/*QUAKED info_null (0 0.5 0) (-4 -4 -4) (4 4 4)
Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
*/
void SP_info_null( gentity_t *self ) {
	G_FreeEntity( self );
}


/*QUAKED info_notnull (0 0.5 0) (-4 -4 -4) (4 4 4)
Used as a positional target for in-game calculation, like jumppad targets.
target_position does the same thing
*/
void SP_info_notnull( gentity_t *self ){
	G_SetOrigin( self, self->s.origin );
}


/*QUAKED light (0 1 0) (-8 -8 -8) (8 8 8) linear
Non-displayed light.
"light" overrides the default 300 intensity.
Linear checbox gives linear falloff instead of inverse square
Lights pointed at a target will be spotlights.
"radius" overrides the default 64 unit radius of a spotlight at the target point.
*/
void SP_light( gentity_t *self ) {
	G_FreeEntity( self );
}



/*
=================================================================================

TELEPORTERS

=================================================================================
*/

void TeleportPlayer( gentity_t *player, vec3_t origin, vec3_t angles ) {
	gentity_t	*tent;
	qboolean noAngles;

	noAngles = (angles[0] > 999999.0);
	// use temp events at source and destination to prevent the effect
	// from getting dropped by a second player event
	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR) {
		tent = G_TempEntity( player->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
		tent->s.clientNum = player->s.clientNum;

		tent = G_TempEntity( origin, EV_PLAYER_TELEPORT_IN );
		tent->s.clientNum = player->s.clientNum;
	}

	// unlink to make sure it can't possibly interfere with G_KillBox
	trap_UnlinkEntity (player);

	VectorCopy ( origin, player->client->ps.origin );
	player->client->ps.origin[2] += 1;

	if (!noAngles) {
		// spit the player out
		AngleVectors( angles, player->client->ps.velocity, NULL, NULL );
		VectorScale( player->client->ps.velocity, 400, player->client->ps.velocity );
		player->client->ps.pm_time = 160;		// hold time
		player->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;

		// set angles
		SetClientViewAngle(player, angles);
	}

	// toggle the teleport bit so the client knows to not lerp
	player->client->ps.eFlags ^= EF_TELEPORT_BIT;

//unlagged - backward reconciliation #3
	// we don't want players being backward-reconciled back through teleporters
	G_ResetHistory( player );
//unlagged - backward reconciliation #3

	// kill anything at the destination
	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR ) {
		G_KillBox (player);
	}

	// save results of pmove
	BG_PlayerStateToEntityState( &player->client->ps, &player->s, qtrue );

	// use the precise origin for linking
	VectorCopy( player->client->ps.origin, player->r.currentOrigin );

	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR && player->client->ps.pm_type != PM_SPECTATOR ) {
		trap_LinkEntity (player);
	}
}


/*QUAKED misc_teleporter_dest (1 0 0) (-32 -32 -24) (32 32 -16)
Point teleporters at these.
Now that we don't have teleport destination pads, this is just
an info_notnull
*/
void SP_misc_teleporter_dest( gentity_t *ent ) {
}


//===========================================================

/*QUAKED misc_model (1 0 0) (-16 -16 -16) (16 16 16)
"model"		arbitrary .md3 file to display
*/
void SP_misc_model( gentity_t *ent ) {
	char		*string;
	int			modelid;
	

	string = ent->model;
	modelid = atof( string );
	if(modelid == 1){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick.md3" );
	} else 
	if(modelid == 2){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass.md3" );
	} else
	if(modelid == 3){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood.md3" );
	} else 
	if(modelid == 4){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block.md3" );
	} else 
	if(modelid == 5){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block.md3" );
	} else 
	if(modelid == 6){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block.md3" );
	} else 
	if(modelid == 7){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick.md3" );
	} else 
	if(modelid == 8){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar.md3" );
	} else 
	if(modelid == 9){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian.md3" );
	} else 	
	if(modelid == 10){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass.md3" );
	} else 
	if(modelid == 11){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick2.md3" );
	} else 
	if(modelid == 12){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass2.md3" );
	} else
	if(modelid == 13){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood2.md3" );
	} else 
	if(modelid == 14){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block2.md3" );
	} else 
	if(modelid == 15){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block2.md3" );
	} else 
	if(modelid == 16){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block2.md3" );
	} else 
	if(modelid == 17){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick2.md3" );
	} else 
	if(modelid == 18){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar2.md3" );
	} else 
	if(modelid == 19){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian2.md3" );
	} else 	
	if(modelid == 20){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass2.md3" );
	} else 	
	if(modelid == 21){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick10.md3" );
	} else 
	if(modelid == 22){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass10.md3" );
	} else
	if(modelid == 23){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood10.md3" );
	} else 
	if(modelid == 24){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block10.md3" );
	} else 
	if(modelid == 25){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block10.md3" );
	} else 
	if(modelid == 26){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block10.md3" );
	} else 
	if(modelid == 27){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick10.md3" );
	} else 
	if(modelid == 28){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar10.md3" );
	} else 
	if(modelid == 29){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian10.md3" );
	} else 	
	if(modelid == 30){
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass10.md3" );
	}
	trap_LinkEntity (ent);

	G_SetOrigin( ent, ent->s.origin );
	VectorCopy( ent->s.angles, ent->s.apos.trBase );
	if(!modelid ){
	G_FreeEntity( ent );
	}
}

//===========================================================

void locateCamera( gentity_t *ent ) {
	vec3_t		dir;
	gentity_t	*target;
	gentity_t	*owner;

	owner = G_PickTarget( ent->target );
	if ( !owner ) {
                G_Printf( "Couldn't find target for misc_partal_surface\n" );
		G_FreeEntity( ent );
		return;
	}
	ent->r.ownerNum = owner->s.number;

	// frame holds the rotate speed
	if ( owner->spawnflags & 1 ) {
		ent->s.frame = 25;
	} else if ( owner->spawnflags & 2 ) {
		ent->s.frame = 75;
	}

	// swing camera ?
	if ( owner->spawnflags & 4 ) {
		// set to 0 for no rotation at all
		ent->s.powerups = 0;
	}
	else {
		ent->s.powerups = 1;
	}

	// clientNum holds the rotate offset
	ent->s.clientNum = owner->s.clientNum;

	VectorCopy( owner->s.origin, ent->s.origin2 );

	// see if the portal_camera has a target
	target = G_PickTarget( owner->target );
	if ( target ) {
		VectorSubtract( target->s.origin, owner->s.origin, dir );
		VectorNormalize( dir );
	} else {
		G_SetMovedir( owner->s.angles, dir );
	}

	ent->s.eventParm = DirToByte( dir );
}

/*QUAKED misc_portal_surface (0 0 1) (-8 -8 -8) (8 8 8)
The portal surface nearest this entity will show a view from the targeted misc_portal_camera, or a mirror view if untargeted.
This must be within 64 world units of the surface!
*/
void SP_misc_portal_surface(gentity_t *ent) {
	VectorClear( ent->r.mins );
	VectorClear( ent->r.maxs );
	trap_LinkEntity (ent);

	ent->r.svFlags = SVF_PORTAL;
	ent->s.eType = ET_PORTAL;

	if ( !ent->target ) {
		VectorCopy( ent->s.origin, ent->s.origin2 );
	} else {
		ent->think = locateCamera;
		ent->nextthink = level.time + 100;
	}
}

/*QUAKED misc_portal_camera (0 0 1) (-8 -8 -8) (8 8 8) slowrotate fastrotate noswing
The target for a misc_portal_director.  You can set either angles or target another entity to determine the direction of view.
"roll" an angle modifier to orient the camera around the target vector;
*/
void SP_misc_portal_camera(gentity_t *ent) {
	float	roll;

	VectorClear( ent->r.mins );
	VectorClear( ent->r.maxs );
	trap_LinkEntity (ent);

	G_SpawnFloat( "roll", "0", &roll );

	ent->s.clientNum = roll/360.0 * 256;
}

/*
======================================================================

  SHOOTERS

======================================================================
*/

void Use_Shooter( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
	vec3_t		dir;
	float		deg;
	vec3_t		up, right;

	// see if we have a target
	if ( ent->enemy ) {
		VectorSubtract( ent->enemy->r.currentOrigin, ent->s.origin, dir );
		VectorNormalize( dir );
	} else {
		VectorCopy( ent->movedir, dir );
	}

	// randomize a bit
	PerpendicularVector( up, dir );
	CrossProduct( up, dir, right );

	deg = crandom() * ent->random;
	VectorMA( dir, deg, up, dir );

	deg = crandom() * ent->random;
	VectorMA( dir, deg, right, dir );

	VectorNormalize( dir );

	switch ( ent->s.weapon ) {
	case WP_GRENADE_LAUNCHER:
		fire_grenade( ent, ent->s.origin, dir );
		break;
	case WP_ROCKET_LAUNCHER:
		fire_rocket( ent, ent->s.origin, dir );
		break;
	case WP_PLASMAGUN:
		fire_plasma( ent, ent->s.origin, dir );
		break;
	}

	G_AddEvent( ent, EV_FIRE_WEAPON, 0 );
}


static void InitShooter_Finish( gentity_t *ent ) {
	ent->enemy = G_PickTarget( ent->target );
	ent->think = 0;
	ent->nextthink = 0;
}

void InitShooter( gentity_t *ent, int weapon ) {
	ent->use = Use_Shooter;
	ent->s.weapon = weapon;

	RegisterItem( BG_FindItemForWeapon( weapon ) );

	G_SetMovedir( ent->s.angles, ent->movedir );

	if ( !ent->random ) {
		ent->random = 1.0;
	}
	ent->random = sin( M_PI * ent->random / 180 );
	// target might be a moving object, so we can't set movedir for it
	if ( ent->target ) {
		ent->think = InitShooter_Finish;
		ent->nextthink = level.time + 500;
	}
	trap_LinkEntity( ent );
}

/*QUAKED shooter_rocket (1 0 0) (-16 -16 -16) (16 16 16)
Fires at either the target or the current direction.
"random" the number of degrees of deviance from the taget. (1.0 default)
*/
void SP_shooter_rocket( gentity_t *ent ) {
	InitShooter( ent, WP_ROCKET_LAUNCHER );
}

/*QUAKED shooter_plasma (1 0 0) (-16 -16 -16) (16 16 16)
Fires at either the target or the current direction.
"random" is the number of degrees of deviance from the taget. (1.0 default)
*/
void SP_shooter_plasma( gentity_t *ent ) {
	InitShooter( ent, WP_PLASMAGUN);
}

/*QUAKED shooter_grenade (1 0 0) (-16 -16 -16) (16 16 16)
Fires at either the target or the current direction.
"random" is the number of degrees of deviance from the taget. (1.0 default)
*/
void SP_shooter_grenade( gentity_t *ent ) {
	InitShooter( ent, WP_GRENADE_LAUNCHER);
}

static void PortalDie (gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod) {
	G_FreeEntity( self );
	//FIXME do something more interesting
}

static void BlockDie (gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod) {
	G_FreeEntity( self );
	//FIXME do something more interesting
}


void DropPortalDestination( gentity_t *player ) {
	gentity_t	*ent;
	vec3_t		snapped;

	// create the portal destination
	ent = G_Spawn();
	ent->s.modelindex = G_ModelIndex( "models/powerups/teleporter/tele_exit.md3" );

	VectorCopy( player->s.pos.trBase, snapped );
	SnapVector( snapped );
	G_SetOrigin( ent, snapped );
	VectorCopy( player->r.mins, ent->r.mins );
	VectorCopy( player->r.maxs, ent->r.maxs );

	ent->classname = "hi_portal destination";
	ent->s.pos.trType = TR_STATIONARY;

	ent->r.contents = CONTENTS_CORPSE;
	ent->takedamage = qtrue;
	ent->health = g_portalhealth.integer;
	ent->die = PortalDie;

	VectorCopy( player->s.apos.trBase, ent->s.angles );

	ent->think = G_FreeEntity;
	ent->nextthink = level.time + g_portaltimeout.integer * 1000;

	trap_LinkEntity( ent );

	player->client->portalID = ++level.portalSequence;
	ent->count = player->client->portalID;

	// give the item back so they can drop the source now
	player->client->ps.stats[STAT_HOLDABLE_ITEM] = BG_FindItem( "Portal" ) - bg_itemlist;
}


static void PortalTouch( gentity_t *self, gentity_t *other, trace_t *trace) {
	gentity_t	*destination;

	// see if we will even let other try to use it
	if( other->health <= 0 ) {
		return;
	}
	if( !other->client ) {
		return;
	}
//	if( other->client->ps.persistant[PERS_TEAM] != self->spawnflags ) {
//		return;
//	}
if(g_portalgrabitems.integer == 1){
		other->client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
//		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_MACHINEGUN );
		other->client->ps.ammo[WP_MACHINEGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_SHOTGUN );
		other->client->ps.ammo[WP_SHOTGUN] = 0;	
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_GRENADE_LAUNCHER );
		other->client->ps.ammo[WP_GRENADE_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_ROCKET_LAUNCHER );
		other->client->ps.ammo[WP_ROCKET_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_LIGHTNING );
		other->client->ps.ammo[WP_LIGHTNING] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_RAILGUN );
		other->client->ps.ammo[WP_RAILGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_PLASMAGUN );
		other->client->ps.ammo[WP_PLASMAGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_BFG );
		other->client->ps.ammo[WP_BFG] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_GRAPPLING_HOOK );
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_NAILGUN );
		other->client->ps.ammo[WP_NAILGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_PROX_LAUNCHER );
		other->client->ps.ammo[WP_PROX_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_CHAINGUN );
		other->client->ps.ammo[WP_CHAINGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_FLAMETHROWER );
		other->client->ps.ammo[WP_FLAMETHROWER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_ANTIMATTER );
		other->client->ps.ammo[WP_ANTIMATTER] = 0;
       other->client->ps.powerups[PW_QUAD] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_REGEN] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_HASTE] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_BATTLESUIT] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_INVIS] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_FLIGHT] =  level.time - ( level.time % 1000 );
	   other->client->ps.stats[STAT_HOLDABLE_ITEM] = 0;
}
	if ( other->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_NEUTRALFLAG ), 0 );
		other->client->ps.powerups[PW_NEUTRALFLAG] = 0;
	}
	else if ( other->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_REDFLAG ), 0 );
		other->client->ps.powerups[PW_REDFLAG] = 0;
	}
	else if ( other->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_BLUEFLAG ), 0 );
		other->client->ps.powerups[PW_BLUEFLAG] = 0;
	}

	// find the destination
	destination = NULL;
	while( (destination = G_Find(destination, FOFS(classname), "hi_portal destination")) != NULL ) {
		if( destination->count == self->count ) {
			break;
		}
	}

	// if there is not one, die!
	if( !destination ) {
		if( self->pos1[0] || self->pos1[1] || self->pos1[2] ) {
			TeleportPlayer( other, self->pos1, self->s.angles );
		}
		G_Damage( other, other, other, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG );
		return;
	}

	TeleportPlayer( other, destination->s.pos.trBase, destination->s.angles );
}

static void PortalTouches( gentity_t *other ) {
	gentity_t	*destination;
	vec3_t		dest;
	vec3_t		o;
	vec3_t		angles;
	
	angles[0] = 0;
	angles[1] = 0;
	angles[2] = 0;

	o[0] = sl_px;
	o[1] = sl_py;
	o[2] = sl_pz;
	VectorCopy (o, dest);

	// see if we will even let other try to use it
	if( other->health <= 0 ) {
		return;
	}
	if( !other->client ) {
		return;
	}
//	if( other->client->ps.persistant[PERS_TEAM] != self->spawnflags ) {
//		return;
//	}
if(g_portalgrabitems.integer == 1){
		other->client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
//		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_MACHINEGUN );
		other->client->ps.ammo[WP_MACHINEGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_SHOTGUN );
		other->client->ps.ammo[WP_SHOTGUN] = 0;	
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_GRENADE_LAUNCHER );
		other->client->ps.ammo[WP_GRENADE_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_ROCKET_LAUNCHER );
		other->client->ps.ammo[WP_ROCKET_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_LIGHTNING );
		other->client->ps.ammo[WP_LIGHTNING] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_RAILGUN );
		other->client->ps.ammo[WP_RAILGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_PLASMAGUN );
		other->client->ps.ammo[WP_PLASMAGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_BFG );
		other->client->ps.ammo[WP_BFG] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_GRAPPLING_HOOK );
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_NAILGUN );
		other->client->ps.ammo[WP_NAILGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_PROX_LAUNCHER );
		other->client->ps.ammo[WP_PROX_LAUNCHER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_CHAINGUN );
		other->client->ps.ammo[WP_CHAINGUN] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_FLAMETHROWER );
		other->client->ps.ammo[WP_FLAMETHROWER] = 0;
		other->client->ps.stats[STAT_WEAPONS] &= ~( 1 << WP_ANTIMATTER );
		other->client->ps.ammo[WP_ANTIMATTER] = 0;
       other->client->ps.powerups[PW_QUAD] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_REGEN] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_HASTE] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_BATTLESUIT] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_INVIS] =  level.time - ( level.time % 1000 );
       other->client->ps.powerups[PW_FLIGHT] =  level.time - ( level.time % 1000 );
	   other->client->ps.stats[STAT_HOLDABLE_ITEM] = 0;
}
	if ( other->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_NEUTRALFLAG ), 0 );
		other->client->ps.powerups[PW_NEUTRALFLAG] = 0;
	}
	else if ( other->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_REDFLAG ), 0 );
		other->client->ps.powerups[PW_REDFLAG] = 0;
	}
	else if ( other->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
		Drop_Item( other, BG_FindItemForPowerup( PW_BLUEFLAG ), 0 );
		other->client->ps.powerups[PW_BLUEFLAG] = 0;
	}

	// if there is not one, die!
	if( sl_py == 0 ) {
		return;
	}

	TeleportPlayer( other, dest, angles );
}

static void PortalEnable( gentity_t *self ) {
	self->touch = PortalTouch;
	self->think = G_FreeEntity;
	self->nextthink = level.time + g_portaltimeout.integer * 1000;
}

static void BlockDel( gentity_t *self ) {
	self->think = G_FreeEntity;
	self->nextthink = level.time + 1 * 1000;
}

static void BlockEnable( gentity_t *self ) {
	self->r.contents = CONTENTS_SOLID;
	self->think = BlockDel;
	self->nextthink = level.time + g_buildingtime.integer * 1000;
}




void DropPortalSource( gentity_t *player ) {
	gentity_t	*ent;
	gentity_t	*destination;
	vec3_t		snapped;
	vec3_t		lastpos;

	// create the portal source
	ent = G_Spawn();
	ent->s.modelindex = G_ModelIndex( "models/powerups/teleporter/tele_enter.md3" );

	VectorCopy( player->s.pos.trBase, snapped );
	VectorCopy( snapped, lastpos );
	sl_px = lastpos[0];
	sl_py = lastpos[1];
	sl_pz = lastpos[2];
	SnapVector( snapped );
	G_SetOrigin( ent, snapped );
	VectorCopy( player->r.mins, ent->r.mins );
	VectorCopy( player->r.maxs, ent->r.maxs );

	ent->classname = "hi_portal source";
	ent->s.pos.trType = TR_STATIONARY;

	ent->r.contents = CONTENTS_CORPSE | CONTENTS_TRIGGER;
	ent->takedamage = qtrue;
	ent->health = g_portalhealth.integer;
	ent->die = PortalDie;

	trap_LinkEntity( ent );

	ent->count = player->client->portalID;
	player->client->portalID = 0;

//	ent->spawnflags = player->client->ps.persistant[PERS_TEAM];

	ent->nextthink = level.time + 1000;
	ent->think = PortalEnable;

	// find the destination
	destination = NULL;
	while( (destination = G_Find(destination, FOFS(classname), "hi_portal destination")) != NULL ) {
		if( destination->count == ent->count ) {
			VectorCopy( destination->s.pos.trBase, ent->pos1 );
			break;
		}
	}

}

void G_AddProp( void ) {
	gentity_t	*ent;
	vec3_t		snapped;
	vec3_t		o;

	o[0] = mod_oasb_x;
	o[1] = mod_oasb_y;
	o[2] = mod_oasb_z;
	VectorCopy (o, snapped);



	// create the portal destination
	ent = G_Spawn();
	VectorCopy( snapped, ent->s.origin );
	VectorCopy( snapped, ent->s.pos.trBase );
	VectorCopy( snapped, ent->r.currentOrigin );
	ent->s.eType = ET_GENERAL;
	ent->s.pos.trType = TR_STATIONARY;
	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.angles[0] = oasb_angle0.integer;
	ent->s.angles[1] = oasb_angle1.integer;
	ent->s.angles[2] = oasb_angle2.integer;
	VectorCopy( ent->s.angles, ent->s.apos.trBase );
	if(oasb_noclip.integer){
	ent->r.contents = CONTENTS_WATER;
	}
	ent->takedamage = qfalse;
	if(oasb_hp.integer){
	ent->health = oasb_hp.integer;
	ent->takedamage = qtrue;
	}
	if(oasb_phys.integer){
	ent->physicsObject = qtrue;
	ent->physicsBounce = oasb_physbounce.value;
	ent->s.pos.trType = TR_GRAVITY;
	ent->s.pos.trTime = level.time;
	}
	ent->die = PortalDie;
	
	ent->classname = "Model md3";
	VectorSet( ent->r.mins, 0, 0, 0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( oasb_id.string );
	
	
	if(oasb_id.integer == 1){
	ent->classname = "Prop_Stone_Brick";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick.md3" );
	}
	
	if(oasb_id.integer == 2){
	ent->classname = "Prop_Glass";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass.md3" );
	}
	
	if(oasb_id.integer == 3){
	ent->classname = "Prop_Wood";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood.md3" );
	}
	
	if(oasb_id.integer == 4){
	ent->classname = "Prop_Steel_Block";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block.md3" );
	}
	
	if(oasb_id.integer == 5){
	ent->classname = "Prop_Gold_Block";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block.md3" );
	}
	
	if(oasb_id.integer == 6){
	ent->classname = "Prop_Diamond_Block";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block.md3" );
	}
	
	if(oasb_id.integer == 7){
	ent->classname = "Prop_Brick";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick.md3" );
	}
	
	if(oasb_id.integer == 8){
	ent->classname = "Prop_Bar";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar.md3" );
	}
	
	if(oasb_id.integer == 9){
	ent->classname = "Prop_Obsidian";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian.md3" );
	}
	
	if(oasb_id.integer == 10){
	ent->classname = "Prop_Obsidian_Glass";
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass.md3" );
	}
	
	if(oasb_id.integer == 11){
	ent->classname = "Prop_Stone_Brick2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick2.md3" );
	}
	
	if(oasb_id.integer == 12){
	ent->classname = "Prop_Glass2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass2.md3" );
	}
	
	if(oasb_id.integer == 13){
	ent->classname = "Prop_Wood2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood2.md3" );
	}
	
	if(oasb_id.integer == 14){
	ent->classname = "Prop_Steel_Block2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block2.md3" );
	}
	
	if(oasb_id.integer == 15){
	ent->classname = "Prop_Gold_Block2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block2.md3" );
	}
	
	if(oasb_id.integer == 16){
	ent->classname = "Prop_Diamond_Block2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block2.md3" );
	}
	
	if(oasb_id.integer == 17){
	ent->classname = "Prop_Brick2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick2.md3" );
	}
	
	if(oasb_id.integer == 18){
	ent->classname = "Prop_Bar2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar2.md3" );
	}
	
	if(oasb_id.integer == 19){
	ent->classname = "Prop_Obsidian2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian2.md3" );
	}
	
	if(oasb_id.integer == 20){
	ent->classname = "Prop_Obsidian_Glass2";
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass2.md3" );
	}

	if(oasb_id.integer == 21){
	ent->classname = "Prop_Stone_Brick10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick10.md3" );
	}
	
	if(oasb_id.integer == 22){
	ent->classname = "Prop_Glass10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass10.md3" );
	}
	
	if(oasb_id.integer == 23){
	ent->classname = "Prop_Wood10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood10.md3" );
	}
	
	if(oasb_id.integer == 24){
	ent->classname = "Prop_Steel_Block10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block10.md3" );
	}
	
	if(oasb_id.integer == 25){
	ent->classname = "Prop_Gold_Block10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block10.md3" );
	}
	
	if(oasb_id.integer == 26){
	ent->classname = "Prop_Diamond_Block10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block10.md3" );
	}
	
	if(oasb_id.integer == 27){
	ent->classname = "Prop_Brick10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick10.md3" );
	}
	
	if(oasb_id.integer == 28){
	ent->classname = "Prop_Bar10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar10.md3" );
	}
	
	if(oasb_id.integer == 29){
	ent->classname = "Prop_Obsidian10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian10.md3" );
	}
	
	if(oasb_id.integer == 30){
	ent->classname = "Prop_Obsidian_Glass10";
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass10.md3" );
	}
	
	if(oasb_id.integer == 31){
	ent->classname = "Prop_Basketball";
	VectorSet( ent->r.mins, -8, -9, -1);
	VectorSet( ent->r.maxs, 9, 8, 16 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_basketball.md3" );
	}
	
	if(oasb_id.integer == 32){
	ent->classname = "Prop_Soccerball";
	VectorSet( ent->r.mins, -8, -9, -1);
	VectorSet( ent->r.maxs, 9, 8, 16 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_soccerball.md3" );
	}
	
	if(oasb_id.integer == 33){
	ent->classname = "Prop_softball";
	VectorSet( ent->r.mins, -2, -2, -2);
	VectorSet( ent->r.maxs, 2, 2, 2 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_softball.md3" );
	}
	
	if(oasb_id.integer == 34){
	ent->classname = "Prop_tennisball";
	VectorSet( ent->r.mins, -2, -2, -2);
	VectorSet( ent->r.maxs, 2, 2, 2 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_tennisball.md3" );
	}
	
	if(oasb_id.integer == 35){
	ent->classname = "Prop_Apple";
	VectorSet( ent->r.mins, -5, -5, -4);
	VectorSet( ent->r.maxs, 5, 5, 5 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_fruits/apple.md3" );
	}
	
	if(oasb_id.integer == 36){
	ent->classname = "Prop_Car_Black";
	VectorSet( ent->r.mins, -34, -93, 0);
	VectorSet( ent->r.maxs, 34, 93, 51 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_nascars/padcar_black.md3" );
	}
	
	if(oasb_id.integer == 3333){
	ent->classname = "Secret1";
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret1.md3" );
	}

	if(oasb_id.integer == 3334){
	ent->classname = "Secret2";
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret2.md3" );
	}
	
	if(oasb_id.integer == 3335){
	ent->classname = "Secret3";
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret3.md3" );
	}

	trap_LinkEntity( ent );
}

void G_BuildProp( gentity_t *client ) {
	gentity_t	*ent;
	vec3_t		snapped;
	vec3_t		o;
	int		ox;
	int		oy;
	int		oz;
	vec3_t		pxyz;

	VectorCopy( client->s.pos.trBase, pxyz );

	ox = pxyz[0] / 10;
	oy = pxyz[1] / 10;
	oz = pxyz[2];
	
	o[0] = ox * 10;
	o[1] = oy * 10;
	o[2] = oz - client->oasbheight;
	VectorCopy (o, snapped);



	// create the portal destination
	ent = G_Spawn();
//	VectorCopy( client->s.pos.trBase, snapped );	
	VectorCopy( snapped, ent->s.origin );
	VectorCopy( snapped, ent->s.pos.trBase );
	VectorCopy( snapped, ent->r.currentOrigin );
	ent->s.eType = ET_GENERAL;
	ent->s.pos.trType = TR_STATIONARY;
	ent->classname = "func_prop";
//	ent->r.contents = CONTENTS_SOLID | CONTENTS_BODY;
	ent->s.angles[0] = oasb_angle0.integer;
	ent->s.angles[1] = oasb_angle1.integer;
	ent->s.angles[2] = oasb_angle2.integer;
if (client->oasbheight >= 35){
	ent->nextthink = level.time + 0;
}
if (client->oasbheight < 35){
	ent->nextthink = level.time + 3000;
}
	ent->think = BlockEnable;
	VectorCopy( ent->s.angles, ent->s.apos.trBase );
//	if(oasb_noclip.integer){
	ent->r.contents = CONTENTS_WATER;
//	}
	ent->takedamage = qfalse;
	if(oasb_hp.integer){
	ent->health = oasb_hp.integer;
	ent->takedamage = qtrue;
	}
	if(oasb_phys.integer){
	ent->physicsObject = qtrue;
	ent->physicsBounce = oasb_physbounce.value;
	ent->s.pos.trType = TR_GRAVITY;
	ent->s.pos.trTime = level.time;
	}
	ent->die = BlockDie;
	
//	ent->classname = "Model_Md3";
	VectorSet( ent->r.mins, 0, 0, 0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( oasb_id.string );
	
	
	if(client->oasbid == 1){
	ent->count = 1;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick.md3" );
	}
	
	if(client->oasbid == 2){
	ent->count = 2;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass.md3" );
	}
	
	if(client->oasbid == 3){
	ent->count = 3;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood.md3" );
	}
	
	if(client->oasbid == 4){
	ent->count = 4;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block.md3" );
	}
	
	if(client->oasbid == 5){
	ent->count = 5;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block.md3" );
	}
	
	if(client->oasbid == 6){
	ent->count = 6;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block.md3" );
	}
	
	if(client->oasbid == 7){
	ent->count = 7;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick.md3" );
	}
	
	if(client->oasbid == 8){
	ent->count = 8;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar.md3" );
	}
	
	if(client->oasbid == 9){
	ent->count = 9;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian.md3" );
	}
	
	if(client->oasbid == 10){
	ent->count = 10;
	VectorSet( ent->r.mins, -25, -25, -25);
	VectorSet( ent->r.maxs, 25, 25, 25 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass.md3" );
	}
	
	if(client->oasbid == 11){
	ent->count = 11;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick2.md3" );
	}
	
	if(client->oasbid == 12){
	ent->count = 12;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass2.md3" );
	}
	
	if(client->oasbid == 13){
	ent->count = 13;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood2.md3" );
	}
	
	if(client->oasbid == 14){
	ent->count = 14;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block2.md3" );
	}
	
	if(client->oasbid == 15){
	ent->count = 15;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block2.md3" );
	}
	
	if(client->oasbid == 16){
	ent->count = 16;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block2.md3" );
	}
	
	if(client->oasbid == 17){
	ent->count = 17;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick2.md3" );
	}
	
	if(client->oasbid == 18){
	ent->count = 18;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar2.md3" );
	}
	
	if(client->oasbid == 19){
	ent->count = 19;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian2.md3" );
	}
	
	if(client->oasbid == 20){
	ent->count = 20;
	VectorSet( ent->r.mins, -50, -50, -50);
	VectorSet( ent->r.maxs, 50, 50, 50 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass2.md3" );
	}

	if(client->oasbid == 21){
	ent->count = 21;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/stone_brick10.md3" );
	}
	
	if(client->oasbid == 22){
	ent->count = 22;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/glass10.md3" );
	}
	
	if(client->oasbid == 23){
	ent->count = 23;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/wood10.md3" );
	}
	
	if(client->oasbid == 24){
	ent->count = 24;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/steel_block10.md3" );
	}
	
	if(client->oasbid == 25){
	ent->count = 25;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/gold_block10.md3" );
	}
	
	if(client->oasbid == 26){
	ent->count = 26;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/diamond_block10.md3" );
	}
	
	if(client->oasbid == 27){
	ent->count = 27;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/brick10.md3" );
	}
	
	if(client->oasbid == 28){
	ent->count = 28;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/bar10.md3" );
	}
	
	if(client->oasbid == 29){
	ent->count = 29;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidian10.md3" );
	}
	
	if(client->oasbid == 30){
	ent->count = 30;
	VectorSet( ent->r.mins, -250, -250, -250);
	VectorSet( ent->r.maxs, 250, 250, 250 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/obsidianglass10.md3" );
	}
	
	if(client->oasbid == 31){
	ent->count = 31;
	VectorSet( ent->r.mins, -8, -9, -1);
	VectorSet( ent->r.maxs, 9, 8, 16 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_basketball.md3" );
	}
	
	if(client->oasbid == 32){
	ent->count = 32;
	VectorSet( ent->r.mins, -8, -9, -1);
	VectorSet( ent->r.maxs, 9, 8, 16 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_soccerball.md3" );
	}
	
	if(client->oasbid == 33){
	ent->count = 33;
	VectorSet( ent->r.mins, -2, -2, -2);
	VectorSet( ent->r.maxs, 2, 2, 2 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_softball.md3" );
	}
	
	if(client->oasbid == 34){
	ent->count = 34;
	VectorSet( ent->r.mins, -2, -2, -2);
	VectorSet( ent->r.maxs, 2, 2, 2 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_ball/pad_tennisball.md3" );
	}
	
	if(client->oasbid == 35){
	ent->count = 35;
	VectorSet( ent->r.mins, -5, -5, -4);
	VectorSet( ent->r.maxs, 5, 5, 5 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_fruits/apple.md3" );
	}
	
	if(client->oasbid == 36){
	ent->count = 36;
	VectorSet( ent->r.mins, -34, -93, 0);
	VectorSet( ent->r.maxs, 34, 93, 51 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/pad_nascars/padcar_black.md3" );
	}
	
	if(client->oasbid == 3333){
	ent->count = 3333;
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret1.md3" );
	}

	if(client->oasbid == 3334){
	ent->count = 3334;
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret2.md3" );
	}
	
	if(client->oasbid == 3335){
	ent->count = 3335;
	VectorSet( ent->r.mins, 0, 0, -0);
	VectorSet( ent->r.maxs, 0, 0, 0 );
	ent->s.modelindex = G_ModelIndex( "models/mapobjects/oasb/secret3.md3" );
	}

	trap_LinkEntity( ent );
}


void G_AddItem( void ) {
	gentity_t	*ent;
	vec3_t		snapped;
	vec3_t		o;
	gitem_t		*item;
	char		*name;
	
	name = oasb_itemid.string;
	
	o[0] = mod_oasb_x;
	o[1] = mod_oasb_y;
	o[2] = mod_oasb_z;
	VectorCopy (o, snapped);
	item = BG_FindItem (name);
	if (!item) {
		return;
	}

	// create the portal destination
	ent = G_Spawn();
	VectorCopy( snapped, ent->s.origin );
	ent->classname = oasb_itemid.string;
	G_SpawnItem (ent, item);
	FinishSpawningItem(ent);
}

void G_Regit( int itemnumid ) {
	gentity_t	*ent;
	vec3_t		snapped;
	vec3_t		o;
	gitem_t		*item;
	char		*name;
	
	if (itemnumid == 1){
	name = "Armor Shard";
	}
	if (itemnumid == 2){
	name = "Armor";
	}
	if (itemnumid == 3){
	name = "Heavy Shard";
	}
	if (itemnumid == 4){
	name = "5 Health";
	}
	if (itemnumid == 5){
	name = "25 Health";
	}
	if (itemnumid == 6){
	name = "50 Health";
	}
	if (itemnumid == 7){
	name = "Mega Health";
	}
	if (itemnumid == 8){
	name = "Gauntlet";
	}
	if (itemnumid == 9){
	name = "Shotgun";
	}
	if (itemnumid == 10){
	name = "Machinegun";
	}
	if (itemnumid == 11){
	name = "Grenade Launcher";
	}
	if (itemnumid == 12){
	name = "Rocket Launcher";
	}
	if (itemnumid == 13){
	name = "Lightning Gun";
	}
	if (itemnumid == 14){
	name = "Railgun";
	}
	if (itemnumid == 15){
	name = "Plasma Gun";
	}
	if (itemnumid == 16){
	name = "BFG10K";
	}
	if (itemnumid == 17){
	name = "Grappling Hook";
	}
	if (itemnumid == 18){
	name = "Shells";
	}
	if (itemnumid == 19){
	name = "Bullets";
	}
	
	o[0] = 0;
	o[1] = 0;
	o[2] = -50;
	VectorCopy (o, snapped);
	item = BG_FindItem (name);
	if (!item) {
		return;
	}

	// create the portal destination
	ent = G_Spawn();
	VectorCopy( snapped, ent->s.origin );
	ent->classname = name;
	G_SpawnItem (ent, item);
	FinishSpawningItem(ent);
}


void Svcmd_AddProp_f( void ) {

	G_AddProp();
}

void Svcmd_SendClientCmd_f( void ) {

trap_EA_Command(oasb_clientid.integer, oasb_text.string);

}

void Svcmd_SendClientMusic_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "cmusic %s", oasb_text.string));

}

void Svcmd_SendClientSound_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "csound %s", oasb_text.string));

}

void Svcmd_SendClientModel_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "cmodel %s", oasb_text.string));

}

void Svcmd_SendClientTorso_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "ctorso %s", oasb_text.string));

}

void Svcmd_SendClientTorsoSkin_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "ctorsoskin %s", oasb_text.string));

}

void Svcmd_SendClientHead_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "chead %s", oasb_text.string));

}

void Svcmd_SendClientHeadSkin_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "cheadskin %s", oasb_text.string));

}

void Svcmd_SendClientLegs_f( void ) {

//trap_EA_Command(oasb_clientid.integer, oasb_text.string);
trap_SendServerCommand(oasb_clientid.integer, va( "clegs %s", oasb_text.string));

}

void Svcmd_ReplaceTexture( void ) {;

AddRemap(tex_name.string, tex_newname.string, level.time * 0.001); 
trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());

}

void Svcmd_AddItem_f( void ) {

	G_AddItem();
}

void Svcmd_RCM( void ) {

	CustomModRun = 0;
}
