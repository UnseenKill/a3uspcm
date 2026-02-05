#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityGuardRear

Description:
    Guard points behind center.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityGuardRear),_this);

// [degrees,maxUnitsCount,minUnitsCount]
private _positionsTemplate = [
    [140, nil, nil],
    [220, nil, nil],
    [180, 3, nil],
    [-245, nil, 4],
    [245, nil, 4]
];

[_positionsTemplate, player, groupSelectedUnits player, vehicle player, GVAR(securityDistance)] call FUNC(pullSecurity);
showCommandingMenu "";

nil;

