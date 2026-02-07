#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_securityPull360

Description:
    Make selected units pull security in a 360 degree radius around them.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(securityPull360),_this);

// [degrees,maxUnitsCount,minUnitsCount]
private _positionsTemplate = [
    [-40, nil, nil],
    [40, nil, nil],
    [120, nil, 4],
    [180, 3, nil],
    [210, nil, 4]
];

[_positionsTemplate, player, [player] call FUNC(getGroupSelection), vehicle player, GVAR(securityDistance)] call FUNC(pullSecurity);
showCommandingMenu "";

nil;
