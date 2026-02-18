#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_arsenalDiscard

Description:
    Discard contents of container from arsenal

Parameters:
    0: _container - Container object <OBJECT>

Optional:

Example:
    (begin example)
    [box1] call A3USPCM_menu_fnc_arsenalDiscard;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(arsenalDiscard),_this);

params[
    ["_container", objNull, [objNull]]
];

if !assert(!isNull _container) exitWith { false };

[_container, false] call FUNC(arsenalProcessContainer);

nil;
