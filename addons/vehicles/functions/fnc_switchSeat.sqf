#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_switchSeat

Description:
    Reliably get into the gunner seat or any other configured seat of a vehicle.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(switchSeat),_this);

private _vehicle = objectParent player;
if isNull(_vehicle) exitWith {};

private _index = GVAR(seatsConfig) findIf { _vehicle isKindOf (_x select 0) };
private _config = switch true do {
    case (_index isNotEqualTo -1): { GVAR(seatsConfig) select _index select 1 };
    case GVAR(seatsUseFallback): { [[-1], ["GUNNER", [0]]] };
    default { nil };
};

if (isNil "_config") exitWith { systemChat "Vehicle not configured and fallback disabled"  };

private _currentTurret = objectParent player unitTurret player;
private _wantIndex = switch true do {
    case (_currentTurret isEqualTo []): { 0 };

    default {
        private _currentIndex = _config findIf {
            private _thisTurret = _x;
            if (count _x isEqualTo 2 && { _x select 0 isEqualType "" }) then {
                _thisTurret = _x select 1;
            };
            _currentTurret isEqualTo _thisTurret;
        };

        _currentIndex = 0 max _currentIndex; // if not found, go to first seat

        if (_currentIndex > 0) then {
            if (!isNil { player getVariable QGVAR(nextSeatSwitchBefore) } && { player getVariable QGVAR(nextSeatSwitchBefore) < diag_tickTime}) then {
                _currentIndex = -1;
            };
        };

        INC(_currentIndex);
        if (_currentIndex >= count _config) then {
            _currentIndex = 0;
        };
        _currentIndex;
    };
};

private _position = _config select _wantIndex;
if !assert(!isNil "_position") exitWith {};

TRACE_3(QFUNC(switchSeat),_currentTurret,_wantIndex,_position);

if (!(_position isEqualType [])) then {
    // Switch to cargo seat
    player action["MoveToCargo", _vehicle, _position];
} else {
    private _cameraView = "INTERNAL";

    if (count _position isEqualTo 2 && { _position select 0 isEqualType "" }) then {
        _cameraView = _position select 0;
        _position = _position select 1;
    };

    if (_position isEqualTo [-1]) then {
        player action["MoveToDriver", _vehicle];
    } else {
        player action["MoveToTurret", _vehicle, _position];
    };

    if (_cameraView isNotEqualTo cameraView) then {
        player switchCamera _cameraView;
    };
};

player setVariable[QGVAR(nextSeatSwitchBefore), diag_tickTime + GVAR(seatsSwitchSequenceInterval)];

nil;
