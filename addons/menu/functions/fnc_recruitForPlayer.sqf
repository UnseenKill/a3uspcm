#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitForPlayer

Description:
    Recruit a unit to player squad.

Parameters:
    0: _typeUnit - Type of unit to recruit <STRING>

Optional:

Example:
    (begin example)
    ["unitMG"] call A3USPCM_fnc_recruitForPlayer;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
_this spawn {
    params[
        ["_typeUnit", "", [""]]
    ];

    INFO_2("player %1 wants %2 recruited",name player,_typeUnit);
    TRACE_1(QFUNCMAIN(recruitForPlayer),GVAR(recruitSkipEnemyCheck));

    recruitCooldown = 0;

    if !GVAR(recruitSkipEnemyCheck) then {
        [A3A_faction_reb get _typeUnit] call A3A_fnc_reinfPlayer;
    } else {
        private _copy = A3A_fnc_enemyNearCheck;
        A3A_fnc_enemyNearCheck = { false };
        [A3A_faction_reb get _typeUnit] call A3A_fnc_reinfPlayer;
        A3A_fnc_enemyNearCheck = _copy;
    };
};

nil;
