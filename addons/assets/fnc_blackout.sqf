#include "script_component.hpp"
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
private _lights = _position nearObjects["Lamps_base_F", _range];

if isClass(configFile >> "CfgPatches" >> "gm_core") then {
    _lights = _lights + (_position nearObjects["gm_lamp_euro_80_base", _range]);
};

_lights = _lights select { (alive _x) && (_x getVariable[QGVAR(EmpEffect), false] isEqualTo false) };

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
