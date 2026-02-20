#include "..\script_component.hpp"
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

private _items = flatten _loadout select {
    (_x isEqualType "") && { _x isNotEqualTo "" };
};

[_items, true] call FUNCMAIN(utilUnlockArsenalItem);

nil;
