#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_timerCreate

Description:
    Create a timer

Parameters:
    0: _minutes - Timer expiration <NUMBER>

Optional:

Example:
    (begin example)
    [360] call A3USPCM_menu_fnc_timerCreate;
    (end example)

Returns:
    Timer "object" <HASHMAP>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(timerCreate),_this);

params[
    ["_minutes",nil,[0]]
];

if !assert(!isNil "_minutes") exitWith {};

createHashMapFromArray[
    ["uid", [] call FUNCMAIN(utilGenerateUniqueId)],
    ["expiration", _minutes],
    ["start", dateToNumber date],
    ["year", date select 0],
    ["handle", false]
];
