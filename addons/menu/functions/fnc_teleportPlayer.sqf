#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_teleportPlayer

Description:
    Teleport player.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_teleportPlayer;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 requests teleportation",name player);

// remove old event handler in case of double-click on teleportation menu item
if !isNil QGVAR(Teleport_MapSingleClickEH) exitWith {
    INFO("ignoring double-click on teleportation menu item");
};

if !visibleMap then {
    openMap true;
};

[
    localize LSTRING(Teleport_TeleportHintStartCaption), 
    localize LSTRING(Teleport_TeleportHintStartText)
] call A3A_fnc_customHint;

GVAR(Teleport_Done) = false;
GVAR(Teleport_MapSingleClickEH) = addMissionEventHandler["MapSingleClick", {
	params["_units","_pos","_alt","_shift"];
    GVAR(Teleport_Done) = true;

    openMap false;
    INFO_2("teleporting %1 to %2",name player,mapGridPosition _pos);
    TRACE_2("teleporting",player,_pos);

    [_pos] spawn {
        params["_pos"];
        
        uiSleep 0.75;

        private _vehicle = vehicle player;
        private _canDamage = local _vehicle && isDamageAllowed _vehicle;

        if !_canDamage then {
            _vehicle setPosATL _pos;
        } else {
            _vehicle allowDamage false;
            _vehicle setPosATL _pos;
            [_vehicle] spawn {
                params ["_vehicle"];
                uiSleep 0.75;
                _vehicle allowDamage true;
            };
        };
    };
}];

[] spawn {
    waitUntil { GVAR(Teleport_Done) || !visibleMap };
    removeMissionEventHandler["MapSingleClick", GVAR(Teleport_MapSingleClickEH)];
    GVAR(Teleport_MapSingleClickEH) = nil;

    if !GVAR(Teleport_Done) exitWith {
        INFO("teleportation aborted");
        [
            localize LSTRING(Teleport_TeleportHintAbortCaption), 
            localize LSTRING(Teleport_TeleportHintAbortText)
        ] call A3A_fnc_customHint;
    };

    GVAR(Teleport_Done) = nil;
};

nil;
