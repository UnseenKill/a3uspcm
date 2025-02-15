#include "script_component.hpp"
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
        systemChat localize LSTRING(ModuleMSE_NoStaticsFound);
    };

    private _group = createGroup independent;

    _statics apply {
        crew _x apply { moveOut _x };

        [_group, _x] spawn {
            uiSleep 0.5;
            params["_group","_vehicle"];
            private _unit = _group createUnit["I_crew_F", getPosATL _vehicle, [], 0, "NONE"];
            
            _unit moveInGunner _vehicle;
            _unit setSkill 1;
            _vehicle setVariable[QGVAR(crewed), true, true];

            TRACE_2("Crewed static",_vehicle,_unit);

            allCurators apply {
                _x addCuratorEditableObjects[[_vehicle], true];
            };
        };
    };
};

nil;
