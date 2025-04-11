#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_blowUpMines

Description:
    Blow up mines in a given area.

Parameters:
    0: _position - Right click position <ARRAY>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(blowUpMines),_this);

params[
    ["_position",nil,[[]]]
];

systemChat "Fire in the hole.";

nearestMines[_position, ["MineBase"], 300, false] apply {
    _x spawn {
        uiSleep(3 + (random 0.5));
        _this setDamage[1, true, player];
    };
};

nil;
