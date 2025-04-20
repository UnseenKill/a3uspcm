#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_toggleROEAll

Description:
    Toggle ROE for all groups

Parameters:
    0: _mode - Mode to set ("openFire","holdFire") <STRING>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(toggleROEAll),_this);

params[
    ["_mode", "", [""]]
];

private _groups = GVAR(groups) - [grpNull];

if (_groups isEqualTo []) exitWith {
    [
        localize LSTRING(ROE_Caption),
        localize LSTRING(ROE_NoGroups)
    ] call A3A_fnc_customHint;
};

if (_mode isEqualTo "") then {
    _mode = [MODE_OPENFIRE, MODE_HOLDFIRE] select ((_groups select 0) getVariable[QGVAR(ROE), MODE_OPENFIRE] isEqualTo MODE_OPENFIRE);
    TRACE_2(QFUNC(toggleROEAll),_this,_mode);
};

{
    [_x, _mode, false] call EFUNC(aafc,toggleROE);
} forEach _groups;

[] call FUNC(updateMenu);

nil;
