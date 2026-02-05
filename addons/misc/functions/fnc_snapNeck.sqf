#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_snapNeck

Description:
    Snap target's neck

Parameters:
    0: _target - target object <OBJECT>
    1: _player - player object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(snapNeck),_this);

params[
    ["_target",objNull,[objNull]],
    ["_player",objNull,[objNull]]
];

if !assert(!isNull _target) exitWith {};
if !assert(!isNull _player) exitWith {};

[
    1.75,
    _this,
    {
        params["_params"];
        _params params[
            ["_target",objNull,[objNull]],
            ["_player",objNull,[objNull]]
        ];

        playSound selectRandom["ACE_fracture_1","ACE_fracture_2","ACE_fracture_3","ACE_fracture_4"];
        //[_target, [1, true, _player]] remoteExec["setDamage", 2];
        [_target, 10, "Head", QGVAR(neckSnap), _player] remoteExec["ace_medical_fnc_addDamageToUnit", 2];
    },
    {},
    LLSTRING(SnappingNeckProgressText)
] call ace_common_fnc_progressBar;

nil;
