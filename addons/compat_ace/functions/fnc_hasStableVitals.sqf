#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_compat_ace_fnc_hasStableVitals

Description:
    Override function of ace_medical_status_fnc_hasStableVitals to fake stable
    vitals for auto-wakeup functionality.

Parameters:
    0: _unit - Unit to query <OBJECT>

Optional:

Returns:
    <BOOL> true if the unit has stable vitals, false otherwise

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(hasStableVitals),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith { false };
if !assert(!isNull _unit) exitWith { false };

if !(isNil { _unit getVariable QGVAR(hasStableVitals) }) exitWith {
    if (_unit getVariable QGVAR(hasStableVitals) > diag_tickTime) then {
        true;
    } else {
        _unit setVariable[QGVAR(hasStableVitals), nil];
        call ace_medical_status_fnc_hasStableVitals;
    };
};

call ace_medical_status_fnc_hasStableVitals;
