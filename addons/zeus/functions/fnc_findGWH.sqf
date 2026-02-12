#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_findGWH

Description:
    Find ground weapon holders

Parameters:
    0: _position - Right click position <ARRAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(findGWH),_this);

params[
    ["_position",nil,[[]]]
];

allCurators apply {
    _x addCuratorEditableObjects[TEST_NOCIGS_IN_GWH(_position), false];
};

nil;
