#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_fnc_promptInitEdit

Description:
    Initialize editing control

Parameters:
    0: _control - Editor <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(promptInitEdit),_this);

params[
    ["_control", controlNull, [controlNull]]
];

if !assert(!isNull _control) exitWith {};

private _prefill = GVAR(promptMenu) get 'prefill';

_control ctrlSetText _prefill;
_control ctrlSetTextSelection[0, count _prefill];
_control ctrlAddEventHandler["KeyUp", {
    params ["_displayOrControl","_key","_shift","_ctrl","_alt"];

    if (_key isEqualTo DIK_RETURN) then {
        call FUNC(promptReturn);
    };
}];

nil;
