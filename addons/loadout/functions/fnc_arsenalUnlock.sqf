#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_loadout_fnc_arsenalUnlock

Description:
    Unlock contents of container in arsenal

Parameters:
    0: _container - Container object <OBJECT>

Optional:

Example:
    (begin example)
    [box1] call A3USPCM_loadout_fnc_arsenalUnlock;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(arsenalUnlock),_this);

params[
    ["_container", objNull, [objNull]]
];

if !assert(!isNull _container) exitWith { false };

[_container, true] call FUNC(arsenalProcessContainer);

nil;
