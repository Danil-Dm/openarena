# OpenArenaPlus gamecode
[![Build Status](https://travis-ci.org/OpenArena/gamecode.svg?branch=master)](https://travis-ci.org/OpenArena/gamecode) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/90453976351f455f89d42651658fa63a)](https://www.codacy.com/app/github_43/gamecode_2?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=OpenArena/gamecode&amp;utm_campaign=Badge_Grade)

## This legacy code is no longer being developed ##
Follow Arena Unlimited 

## Description ##
This is a mod that adds new variables, such as elimination_items, weapon settings: delay, damage, spread damage, explode, splash radius, vampire, infinity, count, speed, timeout, bounce, gravity, bouncemodifier. Runes settings: Speed, Gravity, Infammo, Firespeed. Respawn time: Armor, health, weapon, ammo, holdable, powerups, flag.

# Variable List:

g_spawnselect "0" // Set spawn without deleting items 1-on 0-off

elimination_items "0" // Items in elimination modes, last-man-standing

elimination_flame "0" // Flamethrower

elimination_antimatter "0" // Antimatter

elimination_quad "0" // Quad

elimination_haste "0" // Speed

elimination_regen "0" // Regeneration

elimination_invis "0" // Invisibility

elimination_bsuit "0" // Battle Shield

elimination_flight "0" // Flight

g_drowndamage "1" // Damage from lack of air

g_runes "1" // Runes
g_spawnprotect "500" // Immortality time when spawn

g_respawnwait "1700" // respawn time 2

g_jumpheight "270" // Jump height

g_ammolimit "200" // Weapon limit

g_droppeditemtime "30" // Time to remove excess items

g_autoflagreturn "30" // Auto flag return time

g_armorprotect "0.66" // Armor protection level

g_noplayerclip "0" // No invisible walls

g_falldamagesmall "5" // Drop Damage Small

g_falldamagebig "10" // Drop Damage Large

g_randomteleport "0" // Random Teleports

g_maxweaponpickup "1" // Maximum Weapon Pickup

g_lavadamage "30" // Lava Damage

g_slimedamage "10" // Slime damage

g_waterdamage "0" // Water Damage

// Respawn time of items

g_flagrespawn "-1" // Flag respawn

g_poweruprespawn "120" // Respawn bonuses

g_megahealthrespawn "35" // Respawn of the large first-aid kit

g_holdablerespawn "60" // Respawn of fed items

g_healthrespawn "35" // Respawn Lives

g_armorrespawn "25" // Respawn armor

g_ammorespawn "30" // Respawn of ammunition

g_weaponrespawn "5" // Weapon respawn

g_weaponteamrespawn "30" // Command weapon respawn

// Set powerups
// Time

g_quadtime "30" // Quad

g_bsuittime "30" // Battle Shield

g_hastetime "30" // Speed

g_invistime "30" // Invisibility

g_regentime "30" // Regeneration

g_flighttime "60" // Flight

// Are common

g_fasthealthregen "15" // Fast Regeneration

g_slowhealthregen "5" // Slow regeneration

g_speedfactor "1.3" // Speed Bonus Multiplier

g_hastefirespeed "1.3" // Speed bonus firing speed

g_portalhealth "200" // Life of the portable portal

g_portaltimeout "120" // Portable Portal Time

g_medkitinf "0" // Infinite First Aid Kit

g_teleporterinf "0" // Infinite Teleporter

g_invulinf "0" // Infinite Shield

g_kamikazeinf "0" // Infinite Kamikaze

g_portalinf "0" // Infinite Portal

g_medkitlimit "200" // First aid kit limit

g_medkitmodifier "100" // First aid kit quantity

// Rune S

g_scoutspeedfactor "1.5" // S Movement Speed

g_scoutfirespeed "1.5" // S Speed of fire

g_scoutdamagefactor "1" // S Damage Multiplier

g_scoutgravitymodifier "1" // S Gravity factor

g_scouthealthmodifier "-1" // S Armor and Life Multiplier

g_scout_infammo "0" // S Infinite Ammo

// Rune D

g_doublerspeedfactor "1.0" // D Movement speed

g_doublerfirespeed "1.0" // D Speed of fire

g_doublerdamagefactor "2" // D Damage Multiplier

g_doublergravitymodifier "1" // D Gravity factor

g_doublerhealthmodifier "-1" // D Armor and life multiplier

g_doubler_infammo "0" // D Infinite Ammunition

// Rune G

g_guardspeedfactor "1.0" // G Movement speed

g_guardfirespeed "1.0" // G Speed of fire

g_guarddamagefactor "1.0" // G Damage Multiplier

g_guardhealthmodifier "2.0" // G Armor and Life Multiplier

g_guardgravitymodifier "1" // G Gravity factor

g_guard_infammo "0" // G Infinite ammunition

// Rune A

g_ammoregenspeedfactor "1.0" // A Movement Speed

g_ammoregenfirespeed "1.3" // A Speed of fire

g_ammoregendamagefactor "1.0" // A Damage Multiplier

g_ammoregen_infammo "0" // A Infinite Ammunition

g_ammoregengravitymodifier "1" // A Gravity factor

g_ammoregenhealthmodifier "-1" // A Armor and life multiplier

// Shield Shell

g_invultime "10" // Shield shell time

g_invulmove "0" // Shield-shell flight

// Configure commands
// Red

g_teamred_speed "320"

g_teamred_gravityModifier "1"

g_teamred_firespeed "1"

g_teamred_damage "1"

g_teamred_infammo "0"
// blue

g_teamblue_speed "320"

g_teamblue_gravityModifier "1"

g_teamblue_firespeed "1"

g_teamblue_damage "1"

g_teamblue_infammo "0"

// Weapon Settings

// damage damage

// sdamage damage at a distance

// delay

// speed

// bounce jumping 0-no 1-setting 2-super

// spread spread

// gravity-gravity 0-no 1-is

// radius radius

// timeout time

// range

// inf-infinity 0-no 1-on

// vampire-vampire 0-no 1-on

// count

// explode explosion

// ammocount-the amount of ammunition in the boxes

// weaponcount-the amount of ammunition in the weapon

// bouncemodifier-setting jump (bounce 1)


// Hook

g_ghspeed "800"

g_ghtimeout "10000"

// gauntlet

g_gdelay "400"

g_gdamage "50"

g_grange "32"

// machinegun

g_mgammocount "50"

g_mgweaponcount "50"

g_mgdelay "100"

g_mgdamage "7"

g_mgspread "200"

g_mgexplode "0"

g_mgsdamage "50"

g_mgsradius "70"

g_mgvampire "0"

g_mginf "0"

// Shotgun

g_sgammocount "10"

g_sgweaponcount "10"

g_sgdelay "1000"

g_sgdamage "10"

g_sgspread "700"

g_sgexplode "0"

g_sgsdamage "45"

g_sgsradius "35"

g_sgcount "11"

g_sgvampire "0"

g_sginf "0"

// Grenades

g_glammocount "5"

g_glweaponcount "10"

g_gldelay "800"

g_glspeed "700"

g_glbounce "1"

g_glgravity "1"

g_gltimeout "2500"

g_glsradius "120"

g_glsdamage "100"

g_gldamage "100"

g_glvampire "0"

g_glinf "0"

g_glbouncemodifier "0.65"

// rockets

g_rlammocount "5"

g_rlweaponcount "10"

g_rldelay "800"

g_rlspeed "900"

g_rlbounce "0"

g_rlgravity "0"

g_rltimeout "15000"

g_rlsradius "120"

g_rlsdamage "100"

g_rldamage "100"

g_rlvampire "0"

g_rlinf "0"

g_rlbouncemodifier "0.65"

// Lightning

g_lgammocount "60"

g_lgweaponcount "100"

g_lgrange "768"

g_lgdelay "50"

g_lgdamage "8"

g_lgvampire "0"

g_lgexplode "0"

g_lgsdamage "70"

g_lgsradius "75"

g_lginf "0"

// Railgun

g_rgammocount "10"

g_rgweaponcount "10"

g_rgdelay "1500"

g_rgdamage "100"

g_rgvampire "0"

g_rginf "0"

// Plasmagun

g_pgammocount "30"

g_pgweaponcount "50"

g_pgdelay "100"

g_pgspeed "2000"

g_pgbounce "0"

g_pggravity "0"

g_pgtimeout "10000"

g_pgsradius "20"

g_pgsdamage "15"

g_pgdamage "20"

g_pgvampire "0"

g_pginf "0"

g_pgbouncemodifier "0.65"

// Bfg

g_bfgammocount "15"

g_bfgweaponcount "20"

g_bfgdelay "200"

g_bfgspeed "2000"

g_bfgbounce "0"

g_bfggravity "0"

g_bfgtimeout "10000"

g_bfgsradius "120"

g_bfgsdamage "100"

g_bfgdamage "100"

g_bfgvampire "0"

g_bfginf "0"

g_bfgbouncemodifier "0.65"

// Nailgun

g_ngammocount "20"

g_ngweaponcount "10"

g_ngdelay "1000"

g_ngspeed "555"

g_ngbounce "0"

g_nggravity "0"

g_ngtimeout "10000"

g_ngcount "15"

g_ngspread "500"

g_ngdamage "20"

g_ngvampire "0"

g_nginf "0"

g_ngbouncemodifier "0.65"

// Mines

g_plammocount "10"

g_plweaponcount "5"

g_pldelay "800"

g_plspeed "700"

g_plgravity "1"

g_pltimeout "3000"

g_plsradius "150"

g_plsdamage "100"

g_pldamage "0"

g_plvampire "0"

g_plinf "0"


// Chaingun

g_cgammocount "100"

g_cgweaponcount "100"

g_cgdelay "30"

g_cgspread "600"

g_cgdamage "7"

g_cgvampire "0"

g_cginf "0"

// Flamethrower

g_ftweaponcount "100"

g_ftdelay "40"

g_ftspeed "300"

g_ftbounce "0"

g_ftgravity "0"

g_fttimeout "1500"

g_ftsradius "20"

g_ftsdamage "15"

g_ftdamage "20"

g_ftvampire "0"

g_ftinf "0"

g_ftbouncemodifier "0.65"

// Antimatter

g_amweaponcount "50"

g_amdelay "40"

g_amspeed "600"

g_ambounce "1"

g_amgravity "1"

g_amtimeout "1000"

g_amsradius "0"

g_amsdamage "0"

g_amdamage "6"

g_amvampire "0"

g_aminf "0"

g_ambouncemodifier "0.65"

## Building ##

You need a C-compiler (tested with gcc and clang) and GNU make then just type
```
make
```
and the qvm-files will be build. Ready to be packed into a pk3-file.

See https://github.com/OpenArena/gamecode/wiki/Build-instruction for more details.

See http://openarena.wikia.com/wiki/OpenArena_eXpanded for alternative build options

## Extracting entities ##
It is possible to extract entity definition for use with GtkRadiant and NetRadiant like this:

```
cd code/game
./extract_entities.sh > openarena.def
```

## Links ##
Development documentation is located here: https://github.com/OpenArena/gamecode/wiki

The development board on the OpenArena forum: http://openarena.ws/board/index.php?board=30.0

In particular the Open Arena Expanded topic: http://openarena.ws/board/index.php?topic=1908.0

## License ##

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
