#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_mountStaticEmplacements

Description:
    This module creates a crew and mounts any static emplacements selected by zeus.

Parameters:
    0: _logic - module logic object <OBJECT>
    1: _units - units affected <ARRAY>
    2: _activated - module activation state <BOOL>

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1("A3USPCM_zeus_fnc_mountStaticEmplacements",_this);

if (!hasInterface && { isServer }) exitWith {
    if !(_this params[["_logic", objNull, [objNull]]]) exitWith {};

    private _curatorOwner = owner _logic;

    if (_curatorOwner > 2) then {
        _this remoteExecCall[QFUNC(mountStaticEmplacements), _curatorOwner];
    } else {
        WARNING_1("No curator client owner found for module '%1'",_logic);
    };
};

_this spawn {
    params[
        ["_logic", objNull, [objNull]],
        ["_units", [], []],
        ["_activated", false, [false]]
    ];

    for "_wait" from 0 to (CREW_STATIC_WAIT - 1) do {
        systemChat format["Crewing selection in %1 seconds.", CREW_STATIC_WAIT - _wait];
        uiSleep 1;
    };

    if (_logic isKindOf "Module_F") then {
        deleteVehicle _logic;
    };

    private _statics = curatorSelected select 0 select {
        _x isKindOf "StaticWeapon";
    };

    if (_statics isEqualTo []) exitWith {
        INFO("No statics selected by Zeus.");
        systemChat LLSTRING(ModuleMSE_NoStaticsFound);
    };

    [_statics] call FUNC(doCrewStatic);
};

nil;
