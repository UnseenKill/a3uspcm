A3USPCM
=======

**Arma ]|[ Antistasi Ultimate Singleplayer Cheat Menu**

[![pipeline status](https://gitlab.perfect-co.de/arma3/a3uspcm/badges/dev/pipeline.svg)](https://gitlab.perfect-co.de/arma3/a3uspcm/-/commits/dev)
[![Latest Release](https://gitlab.perfect-co.de/arma3/a3uspcm/-/badges/release.svg)](https://gitlab.perfect-co.de/arma3/a3uspcm/-/releases)

Features
--------

 * Gameplay Tools
   * Add player's team (and vehicle) to Zeus curated objects
   * Add lootbox functionality to any cursor object
   * Create lootbox on the spot
   * Repair damaged (outpost) buildings around player
   * Substitute lame-ass civilian prop plane air support vehicles with F-18
   * Substitute civilian helicopters with MH-9 (some GM helicopters can't slingload -> no lootbox for you...)
   * Uncompromize team and self so you can go undercover again
   * Show roadblocks on map
   * Find intel around player's position (configurable via addon options)
   * Emergency invincibility hot-button; press it quickly if you see the APFSDS flying towards you (configurable via addon controls; NO default button).
   * Add any building you're looking at to base buildable object list
   * Access your air assets from any garage. They *are* air assets after all, right?
 * AA Fire Control
   * Enemy detection side chat messages
   * Fire information side chat messages
   * Change ROE of specific groups or all groups
 * Despawn Suppression Beacon™
   * Tired of dying, respawning and teleporting back to the battlefield only to find the loot and vehicles gone?
   * Tire no more: place the *Despawn Suppression Beacon™* in the respawn radius of a location (default 1.1km) and die as often as you like. Nothing will despawn.
 * Teleportation
   * Teleport self anywhere on map without wait delay or "enemies close" checks
   * Teleport stragglers in player group to self
   * (Temporarily) teleport HQ objects (arsenal, garage, map, flag) to your position
 * Replenish player squad outside of HQ
   * Recruit new squad mates in the field
   * "Enemies close" checks can be suppressed via addon settings
 * Resources
   * Add money to player and own faction
   * Add HR to faction
   * See other factions' resources
 * Instant healing
   * Heal self/group instantly
   * Useful when you've driven your Polaris/Qilin through one of those deadly bushes
 * Unlocks
   * Unlock ACE3 Painkillers for arsenal
   * Unlock breaching charges for tanks and APCs
   * Unlock your current loadout
 * Vehicle loadout management
   * Remember a vehicle's inventory and make it available to apply such loadout
   * Save-game safe
   * Requires items present in arsenal to apply loadout
   * Remember/restore ACE3 cargo items
   * Change maximum cargo of a vehicle
   * Dump contents of supply boxes to the ground so you can pick'em up with a lootbox
 * Zeus modules
   * Module that adds any static emplacement in a 100m radius to Zeus curatable objects
   * Module that crews any static emplacement in Zeus' object selection
   * Module to reorient an object in-game to point upwards (not aligned to surface normal)

Installation
------------

### Sources

A3USPCM is available at [my personal gitlab][gitlab-a3uspcm].

### Building

#### Prerequisites

In order to get working .pbos out of source codes, you'll need:

* Arma 2.18
* [Arma 3 Tools][arma-tools]
* [Git][git]
* [HEMTT][hemtt] - An opinionated build system for Arma 3 mods
* Sources from [here][gitlab-a3uspcm]

#### Creating .pbos

The mod's .pbos are created with HEMTT; a casual `hemtt build` should do the trick.

Usage
-----

A3USPCM is designed to work - and is tested - in Antistasi Ultimate Singleplayer (i.e. locally, LAN-hosted servers), **only**. That means fero zucks have been given in regards to what'll happen if a non-host player executes any of the options available in the menu.

It _might_ work with other Antistasi variants (Community, Plus), but that's also untested.

Features mentioned above are available via the map diary (look for entry **A3U Singleplayer Cheat Menu**).

Vehicle loadout functions are available through ACE3 interaction menu with vehicles.

### AA control

This mod allows you to control groups of anti-air assets. You may order them to cease or commence fire via the diary.

#### Creating AA groups

1. While being Zeus and [Zeus Enhanced][zen] is enabled in your mod list, right click in the vicinity of anti-air assets you've placed as static emplacements in your outposts, HQs or ABs.
2. Select menu option **Find static emplacements**
3. All static emplacements in that radius are available as Zeus curatable objects now
4. Select units you wish to group into an AA battery
5. Right click again and select **Crew selected static emplacements**\*
6. Group should appear in curatable groups list in Zeus
7. Group should announce their combat readiness in group chat

\* If, in the meantime, Antistasi AI has mounted some of your statics in selection, you'll have to eject them first. When unsure how to do that, place the **Crew selected static emplacements** module in Zeus; you'll have five seconds to select any static you wanted crewed and all previous crew will be ejected and replaced with controllable AI.

#### Changing AA ROE

Once groups have been created, they are available for fire control via the **AA fire control** diary option.

### Required mods

 * [Antistasi Ultimate - Mod](https://steamcommunity.com/sharedfiles/filedetails/?id=3020755032)
 * [ACE3](https://steamcommunity.com/sharedfiles/filedetails/?id=463939057) - Healing and vehicle loadout works _exclusively_ with ACE3

Bugs
----

¯\\_(ツ)_/¯

Authors
---

* gor3Splatter

[arma-tools]: https://store.steampowered.com/app/233800/Arma_3_Tools/
[git]: https://git-scm.com/downloads
[gitlab]: https://gitlab.perfect-co.de/gor3Splatter
[gitlab-a3uspcm]: https://gitlab.perfect-co.de/arma3/a3uspcm
[hemtt]: https://github.com/BrettMayson/HEMTT
[zen]: https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631
