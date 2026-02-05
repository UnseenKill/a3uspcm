#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_mortarCargoLoadAction

Description:
    When unloading a mortar, add event handlers for the mortar to be able to be loaded again.

Parameters:
    0: _mortar - Mortar <TYPE>
    1: _vehicle - Vehicle to cargo load mortar into <OBJECT>

Optional:

Example:
    (begin example)
    [mortar1] call A3USPCM_fixes_fnc_mortarCargoLoadAction;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(mortarCargoLoadAction),_this);

params[
    ["_mortar", objNull, [objNull,""]],
    ["_vehicle", objNull, [objNull,""]]
];

if !assert(!isNull _mortar) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

if !isNull(_mortar getVariable[QGVAR(cargoLoadVehicle), objNull]) exitWith {};

private _ehID = _mortar addEventHandler["GetIn", {
    params[
        ["_mortar", objNull, [objNull,""]],
        ["_role", "", [""]],
        ["_unit", objNull, [objNull]]
    ];

    if !assert(!isNull _mortar) exitWith {};
    if !assert(!isNull _unit) exitWith {};

    if (_unit in playableUnits) exitWith {};
    if (_unit getVariable[QGVAR(getOutAndCargoLoad), false] isNotEqualTo false) exitWith {
        _unit setUserActionText[_unit getVariable[QGVAR(getOutAndCargoLoad), -1], LLSTRING(Text_Action_GetOutAndCargoLoad)];
    };

    if !isNull(_mortar getVariable[QGVAR(owner), objNull]) then {
        private _owner = _mortar getVariable QGVAR(owner);
        _owner removeAction(_owner getVariable[QGVAR(getOutAndCargoLoad), -1]);
        _owner setVariable[QGVAR(getOutAndCargoLoad), nil, true];
    };

    _mortar setVariable[QGVAR(owner), _unit, true];

    private _actionId = _unit addAction[
        LLSTRING(Text_Action_GetOutAndCargoLoad),
        {
            call FUNC(mortarGetOutAndCargoLoad);
        },
        [_mortar], 0, false, true, "", "alive _target", 75
    ];
    
    private _ehID = _unit addEventHandler["GetOutMan", {
        params[
            ["_unit", objNull, [objNull,""]],
            ["_role", "", [""]],
            ["_mortar", objNull, [objNull,""]]
        ];

        if !assert(!isNull _unit) exitWith {};
        if !assert(!isNull _mortar) exitWith {};

        if !alive(_mortar) exitWith {
            _unit removeAction(_unit getVariable[QGVAR(getOutAndCargoLoad), -1]);
            _unit setVariable[QGVAR(getOutAndCargoLoad), nil, true];
        };

        _unit setUserActionText[_unit getVariable[QGVAR(getOutAndCargoLoad), -1], LLSTRING(Text_Action_CargoLoadMortar)];
    }];

    _unit setVariable[QGVAR(getOutAndCargoLoad), _actionId, true];
    _unit setVariable[QGVAR(GetOutMan_EH), _ehID, true];
}];

_mortar setVariable[QGVAR(cargoLoadVehicle), _vehicle, true];
_mortar setVariable[QGVAR(GetIn_EH), _ehID, true];

nil;
