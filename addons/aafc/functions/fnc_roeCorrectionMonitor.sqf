#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_roeCorrectionMonitor

Description:
    Monitor ROE for all groups and correct if needed

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(roeCorrectionMonitor),_this);

if isNull player exitWith {};
if (player isNotEqualTo theBoss) exitWith {};

INFO("Starting ROE correction monitor for commander");

private _expectSettings = createHashMapFromArray[
    [MODE_OPENFIRE, ["RED", "COMBAT"]],
    [MODE_HOLDFIRE, ["BLUE", "SAFE"]]
];

while { alive theBoss } do {
    uiSleep GVAR(roeCorrectionInterval);

    {
        private _mode = _x getVariable[QGVAR(ROE), [MODE_HOLDFIRE, MODE_OPENFIRE] select(GVAR(defaultInitialMode) isEqualTo "FC_DEFAULT_ANGRY")];
        private _behaviors = [];
        units _x apply { _behaviors pushBackUnique combatBehaviour _x };
        
        private _expect = _expectSettings get _mode;
        private _current = [combatMode _x, _behaviors joinString ","];

        TRACE_4(QFUNC(roeCorrectionMonitor),_x,_mode,_expect,_current);

        if (_expect isNotEqualTo _current) then {
            INFO_4("%1: Correcting ROE for %2 (current=%3; expect=%4)", QFUNC(roeCorrectionMonitor), _x, _current, _expect);
            [_x, _mode, false] call EFUNC(aafc,toggleROE);
        };
    } forEach (GVAR(groups) - [grpNull]);
};

INFO("Stopping ROE correction monitor for dead commander");

nil;
