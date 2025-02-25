#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_teleportObjectBack

Description:
    Callback for user action "teleport back" on object

Parameters:
    0: _object - The rebel object to teleport back <OBJECT>

Optional:

Example:
    (begin example)
    [boxX] call A3USPCM_menu_fnc_teleportObjectBack;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_object", objNull, [objNull]]
];

if !assert(!isNull _object) exitWith {};
private _origin = _object getVariable[QGVAR(teleportOrigin), false];

if (_origin isEqualTo false) exitWith {
    TRACE_1("object has no teleport origin",_object);
};

_origin params["_position", "_vdau"];

_object setPosATL _position;
_object setVectorDirAndUp _vdau;
_object removeAction (_object getVariable[QGVAR(teleportActionId), 0]);
_object setVariable[QGVAR(teleportActionId), nil];
_object setVariable[QGVAR(teleportOrigin), nil];
_object setVariable[QGVAR(teleportReturnTimeout), nil];

private _callback = _object getVariable[QGVAR(teleportBackCallback), false];

if !(_callback isEqualType false) then {
    _object setVariable[QGVAR(teleportBackCallback), nil];
    [_object, _position] call _callback;
};

nil;
