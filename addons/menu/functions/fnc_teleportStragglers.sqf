#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_teleportStragglers

Description:
    Summon far away team members to the player's location.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_teleportStragglers;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */

INFO_1("player %1 summoned stragglers",name player);

if (count units group player isEqualTo 1) exitWith {
    [
        LLSTRING(Teleport_StragglersHintCaption), 
        LLSTRING(Teleport_StragglersHintNoTeam)
    ] call A3A_fnc_customHint;
};

private _stragglers = units group player select {
    _x distance player > STRAGGLERS_MIN_DISTANCE
};

TRACE_1("team",_stragglers);

if (_stragglers isEqualTo []) exitWith {
    [
        LLSTRING(Teleport_StragglersHintCaption), 
        format[LLSTRING(Teleport_StragglersHintNoStragglers), STRAGGLERS_MIN_DISTANCE]
    ] call A3A_fnc_customHint;
};

_stragglers spawn {
    private _count = 0;

    _this apply {
        uiSleep 0.5;
        private _position = getPosATL player findEmptyPosition[10, 40, typeOf _x];

        INFO_1("beaming straggler %1",name _x);
        TRACE_2("beaming straggler",_x,_position);

        if (_position isEqualTo []) then {
            TRACE_1("no position found for",_x);
        } else {
            _x setPosATL _position;
            _count = _count + 1;
        };
    };

    if (_count isEqualTo 0) exitWith {
        [
            LLSTRING(Teleport_StragglersHintCaption), 
            LLSTRING(Teleport_StragglersHintNoPosition)
        ] call A3A_fnc_customHint;
    };

    if (_count isEqualTo count _this) then {
        [
            LLSTRING(Teleport_StragglersHintCaption), 
            LLSTRING(Teleport_StragglersHintSummonedAll)
        ] call A3A_fnc_customHint;
    } else {
        [
            LLSTRING(Teleport_StragglersHintCaption), 
            format[LLSTRING(Teleport_StragglersHintSummonedPartial), _count, count _this]
        ] call A3A_fnc_customHint;
    };
};

nil;
