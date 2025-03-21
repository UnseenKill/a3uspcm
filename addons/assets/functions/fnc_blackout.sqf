#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_blackout

Description:
    EMP blackout simulation

Parameters:
    0: _position - Center of effect <ARRAY>

Optional:

Example:
    (begin example)
    [getPos player] call A3USPCM_assets_fnc_blackout;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(blackout),_this);

params[
    ["_position",[],[[]]]
];

private _duration = GVAR(empEffectDuration);
private _range = GVAR(empEffectRangeBlackout);
private _classes = ["Lamps_base_F","PowerLines_Small_base_F"];

if isClass(configFile >> "CfgPatches" >> "gm_core") then {
    _classes = _classes + ["gm_lamp_euro_80_base"];
};

if (GVAR(empEffectsLights) isEqualType []) then {
    _classes = _classes + GVAR(empEffectsLights);
};

private _lights = nearestObjects[_position, _classes, _range] select {
    (alive _x) && (_x getVariable[QGVAR(EmpEffect), false] isEqualTo false)
};

if (_lights isEqualTo []) exitWith {};

_lights apply {
    _x setVariable[QGVAR(EmpEffect), false];
    [_x, 0.25, "OFF"] call FUNCMAIN(utilLightFlicker);
};

[{
    params["_lights"];

    _lights apply {
        _x setVariable[QGVAR(EmpEffect), nil];
        [_x] spawn {
            params["_light"];
            uiSleep ((random 100) / 100);
            [_light, 0.5] call FUNCMAIN(utilLightFlicker);
        };
    };
}, [_lights], _duration] call CBA_fnc_waitAndExecute;

nil;
