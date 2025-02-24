#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilUnlockLoadout

Description:
    Unlock everything from unit loadout array

Parameters:
    0: _loadout - Unit loadout array <ARRAY>

Optional:

Example:
    (begin example)
    [getUnitLoadout player] call A3USPCM_fnc_utilUnlockLoadout;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_loadout",[],[[]]]
];

TRACE_1(QFUNCMAIN(utilUnlockLoadout),_this);

flatten _loadout select {
    (_x isEqualType "") && (_x isNotEqualTo "");
} apply {
    TRACE_1(QFUNCMAIN(utilUnlockLoadout),_x);
    [_x, true] call FUNCMAIN(utilUnlockArsenalItem);
};

nil;
