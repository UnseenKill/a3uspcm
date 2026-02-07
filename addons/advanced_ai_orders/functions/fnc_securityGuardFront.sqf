#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityGuardFront

Description:
    Guard points in front of center.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityGuardFront),_this);

// [degrees,maxUnitsCount,minUnitsCount]
private _positionsTemplate = [
    [-40, nil, nil],
    [40, nil, nil],
    [0, 3, nil],
    [-65, nil, 4],
    [65, nil, 4]
];

[_positionsTemplate, player, [player] call FUNC(getGroupSelection), vehicle player, GVAR(securityDistance)] call FUNC(pullSecurity);
showCommandingMenu "";

nil;

