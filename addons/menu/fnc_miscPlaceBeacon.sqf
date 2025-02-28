#include "script_component.hpp"
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
        localize LSTRING(Miscellaneous_PlaceBeaconCaption),
        format[localize LSTRING(Miscellaneous_PlaceBeaconHintNoMoneyText), GVAR(dsbCost)]
    ] call A3A_fnc_customHint;
    playSound "A3AP_UiFailure";
};

private _beacon = QEGVAR(assets,DespawnSuppressionBeacon) createVehicle getPosATL player;
_beacon say3D QEGVAR(assets,RadioWave);

if (GVAR(dsbCost) > 0) then {
    [-GVAR(dsbCost)] call A3A_fnc_resourcesPlayer;
};

openMap false;

nil;
