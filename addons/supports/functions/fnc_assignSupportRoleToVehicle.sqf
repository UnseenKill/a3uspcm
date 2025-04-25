#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_assignSupportRoleToVehicle

Description:
    Callback function to assign a support role to a vehicle.

Parameters:
    0: _vehicle - Target <OBJECT>
    1: _player - Caller <OBJECT>
    2: _supportType - Support type <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(assignSupportRoleToVehicle),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_supportType", "", [""]]
];

if !assert(!isNull _vehicle) exitWith { false };
if !assert(!isNull _player) exitWith { false };

private _module = [_supportType] call FUNC(getSupportModule);

if (crew _vehicle isEqualTo []) then {
    _module synchronizeObjectsAdd[_vehicle];

    private _group = side _player createVehicleCrew _vehicle;
    _player hcSetGroup[_group];
} else {
    private _seats = createHashMapFromArray[
        ["driver", driver _vehicle],
        ["gunner", gunner _vehicle],
        ["commander", commander _vehicle]
    ];
    private _nonCargo = values _seats;
    private _cargo = [];

    crew _vehicle apply {
        if !(_x in _nonCargo) then {
            _cargo pushBack _x;
        };

        moveOut _x;
        doStop _x;
    };

    _module synchronizeObjectsAdd[_vehicle];

    _vehicle moveInDriver(_seats getOrDefault["driver", objNull]);
    _vehicle moveInGunner(_seats getOrDefault["gunner", objNull]);
    _vehicle moveInCommander(_seats getOrDefault["commander", objNull]);
    _cargo apply {
        _vehicle moveInCargo _x;
    };
};

_vehicle setVariable[QGVAR(supportType), _supportType, true];
group(crew _vehicle select 0) setVariable[QGVAR(supportType), _supportType, true];

TRACE_3(QFUNC(assignSupportRoleToVehicle),_module,_vehicle,synchronizedObjects _module apply { typeOf _x });

allCurators apply {
    _x addCuratorEditableObjects[[_vehicle], true];
};

nil;
