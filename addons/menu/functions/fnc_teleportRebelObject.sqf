#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_teleportRebelObject

Description:
    Teleport a rebel base object to player

Parameters:
    0: _objectVariableName - Name of global variable that holds the object <STRING>

Optional:
    1: _teleportCallback - Code to execute once teleportation occured <CODE>

Example:
    (begin example)
    ["boxX", {
        params["_object","_position"];
    }] call A3USPCM_fnc_teleportRebelObject;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_objectVariableName", "", [""]],
    ["_teleportCallback", {}, [{}]]
];

INFO_3("'%1' wants '%2' teleported to them at %3",name player,_objectVariableName,position player);

private _object = missionNamespace getVariable _objectVariableName;

if (isNil "_object") exitWith {
    ERROR_1("global variable '%1' not found",_objectVariableName);
};

if !assert(_object isEqualType objNull) exitWith {
    ERROR_2("found global object '%1' but it's no the right type (have: %2)",_objectVariableName,typeName _object);
};

if (_object getVariable[QGVAR(teleportOrigin), false] isEqualTo false) then {
    _object setVariable[QGVAR(teleportOrigin), [
        getPosATL _object,
        [vectorDir _object, vectorUp _object]
    ]];

    [_object] spawn FUNC(teleportObjectBackTimer);
    _object setVariable[QGVAR(teleportActionId), _object addAction[
        format["<t color='#ff0000'>%1</t>", localize LSTRING(Teleport_TeleportObjectBack)],
        {
            params[
                ["_object", objNull, [objNull]],
                ["_caller", objNull, [objNull]],
                ["_actionID", 0, [0]]
            ];

            _object removeAction _actionID;
            [_object] call FUNC(teleportObjectBack);
        }
    ]];
};

private _position = getPosATL player findEmptyPosition[2, 10, typeOf _object];

if (_position isEqualTo []) then {
    WARNING_2("failed to find suitable position for '%1' near '%2'",_objectVariableName,name player);
    _position = getPosATL player;
};

_object setPosATL _position;
_object setVectorUp surfaceNormal getPos _object;
_object setVariable[QGVAR(teleportReturnTimeout), diag_tickTime + TELEPORT_BACK_TIMEOUT];

[_object, _position] spawn _teleportCallback;

TRACE_2("teleported to",_objectVariableName,_position);
TRACE_2("return timeout set",_objectVariableName,TELEPORT_BACK_TIMEOUT);

[
    localize LSTRING(DiaryTeleportCaption),
    format[localize LSTRING(Teleport_TeleportSuccess), getText(configOf _object >> "displayName"), TELEPORT_BACK_TIMEOUT]
] call A3A_fnc_customHint;

nil;
