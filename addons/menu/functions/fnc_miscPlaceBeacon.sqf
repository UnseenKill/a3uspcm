#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscPlaceBeacon

Description:
    Buy a DSB

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscPlaceBeacon),_this);

if ((player getVariable["moneyX", 0] < GVAR(dsbCost))) exitWith {
    [
        LLSTRING(Miscellaneous_PlaceBeaconCaption),
        format[LLSTRING(Miscellaneous_PlaceBeaconHintNoMoneyText), GVAR(dsbCost)]
    ] call A3A_fnc_customHint;
    playSound "A3AP_UiFailure";
};

[] spawn {
    private _activate = false;
    private _position = player modelToWorld[0,1,0];

    if (customWaypointPosition isNotEqualTo []) then {
        if ([LLSTRING(Miscellaneous_PlaceBeaconConfirmPositionText), LLSTRING(Miscellaneous_PlaceBeaconCaption), true, true] call BIS_fnc_guiMessage) then {
            _activate = true;
            _position = customWaypointPosition;
        };
    };

    private _beacon = createVehicle[QEGVAR(assets,DespawnSuppressionBeacon), _position, [], 5, "NONE"];
    _beacon say3D QEGVAR(assets,RadioWave);

    if (_activate) then {
        [LINKEFUNC(despawnbeacon,activateBeacon), [_beacon]] call CBA_fnc_execNextFrame;
    };

    if (GVAR(dsbCost) > 0) then {
        [-GVAR(dsbCost)] call A3A_fnc_resourcesPlayer;
    };
};

nil;
