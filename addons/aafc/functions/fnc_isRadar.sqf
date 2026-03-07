#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_isRadar

Description:
    Check if a unit is a radar unit

Parameters:
    0: _unit - Unit to check <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player] call A3USPCM_aafc_fnc_isRadar;
    (end example)

Returns:
    Boolean indicating if the unit is a radar unit <BOOL>

Environment:
    Client/Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(isRadar),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

(AA_TYPE_RADAR isEqualTo([_unit] call FUNC(getAAType)));
