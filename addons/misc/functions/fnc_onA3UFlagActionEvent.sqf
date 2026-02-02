#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_onA3UFlagActionEvent

Description:
    Event handler for CBA_EVENT_A3U_FLAGACTION event.

Parameters:
    0: _object - Flag object from initial `A3A_fnc_flagAction` call <OBJECT>
    1: _type - Flag action type <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onA3UFlagActionEvent),_this);

if !assert(params[
    ["_object", nil, [objNull]],
    ["_type", nil, [""]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

private _marker = [airportsX + resourcesX + factories + outposts + seaports + milbases, getPosATL _object] call BIS_fnc_nearestPosition;

if !assert(_marker isEqualType "") exitWith {};

// Add "reveal this location on map" action
if (hideEnemyMarkers && { _type isEqualTo "take" }) then {
    private _markerAlpha = markerAlpha("Dum" + _marker);

    TRACE_2(QFUNC(onA3UFlagActionEvent),_marker,_markerAlpha);

    if (_markerAlpha > 0) then {
        INFO_1("Marker %1 already revealed, skipping adding flag action.",str _marker);
    } else {
        INFO_2("Marker %1 not revealed yet, adding flag action to %2.",str _marker,_object);

        _object setVariable[QGVAR(marker), _marker];
        _object addAction[
            LLSTRING(FlagAction_Reveal_Text),
            { call FUNC(revealLocation) },
            nil, 5.5, false, true, "",
            QUOTE((isNull objectParent _this) && { !isNil { _originalTarget getVariable QQGVAR(marker) } }),
            4
        ];
    };
};

nil;
