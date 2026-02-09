#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_enforceROE

Description:
    Set ROE mode and enforce it.

Parameters:
    0: _roeMode - New ROE mode <TYPE>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(enforceROE),_this);

if !assert(params[
    ["_roeMode", nil, [0]]
]) exitWith {};

GVAR(groups) apply {
    _x getVariable QGVAR(vehicles) apply {
        private _vehicle = _x;
        private _aaType = [_x] call FUNC(getAAType);

        TRACE_3(QFUNC(enforceROE),_roeMode,_vehicle,_aaType);
    };
};

nil;
