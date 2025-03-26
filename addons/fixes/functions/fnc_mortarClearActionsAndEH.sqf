#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_mortarClearActionsAndEH

Description:
    Remove all user actions and event handlers for mortar

Parameters:
    0: _mortar - Mortar <OBJECT>

Optional:

Example:
    (begin example)
    [mortar1] call A3USPCM_fixes_fnc_mortarClearActionsAndEH;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(mortarClearActionsAndEH),_this);

params[
    ["_mortar", objNull, [objNull,""]]
];

if !assert(!isNull _mortar) exitWith {};

_mortar removeEventHandler["GetIn", _mortar getVariable[QGVAR(GetIn_EH), -1]];
_mortar setVariable[QGVAR(GetIn_EH), nil, true];
_mortar setVariable[QGVAR(cargoLoadVehicle), nil, true];
_mortar setVariable[QGVAR(owner), nil, true];

units group player apply {
    _x removeAction(_x getVariable[QGVAR(getOutAndCargoLoad), -1]);
    _x setVariable[QGVAR(getOutAndCargoLoad), nil, true];
    _x removeEventHandler["GetOutMan", _x getVariable[QGVAR(GetOutMan_EH), -1]];
    _x setVariable[QGVAR(GetOutMan_EH), nil, true];
};

nil;
