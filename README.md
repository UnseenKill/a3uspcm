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
 * Teleportation
   * Teleport self anywhere on map without wait delay or "enemies close" checks
   * Teleport stragglers in player group to self
 * Replenish player squad outside of HQ
   * Recruit new squad mates in the field
   * "Enemies close" checks still apply
 * Resources
   * Add money to player and own faction
   * See other factions' resources
 * Instant healing
   * Heal self/group instantly
   * Useful when you've driven your Polaris/Qilin through one of those deadly bushes
 * Vehicle loadout management
   * Remember a vehicle's inventory and make it available to apply such loadout
   * Save-game safe
   * Requires items present in arsenal to apply loadout
   * Remember/restore ACE3 cargo items
 * Zeus modules
   * Module that adds any static emplacement in a 100m radius to Zeus curatable objects
   * Module that crews any static emplacement in Zeus' object selection

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

A3USPCM is designed to work - and is tested - in Antistasi Ultimate Singleplayer (i.e. locally, LAN-hosted servers), **only**.

It _might_ work with other Antistasi variants (Community, Plus), but that's also untested.

Features mentioned above are available via the map diary (look for entry **A3U Singleplayer Cheat Menu**).

Vehicle loadout functions are available through ACE3 interaction menu with vehicles.

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
