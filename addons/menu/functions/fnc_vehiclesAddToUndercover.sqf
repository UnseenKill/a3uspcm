#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_vehiclesAddToUndercover

Description:
    Adds the selected vehicle to the player's undercover vehicles.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_vehiclesAddToUndercover;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(vehiclesAddToUndercover),_this);

[
    {
        params[["_target", objNull, [objNull]]];

        try {
            if !(_target isKindOf "LandVehicle") then {
                throw format[localize LSTRING(Vehicles_AddToUndercoverNoLandVehicleText), getText(configOf _target >> "displayName")];
            };

            private _class = typeOf _target;
            private _message = if (_class in GVAR(AdditionalUndercoverVehicles)) then {
                GVAR(AdditionalUndercoverVehicles) = GVAR(AdditionalUndercoverVehicles) - [_class];
                undercoverVehicles = undercoverVehicles - [_class];
                format[localize LSTRING(Vehicles_AddToUndercoverHintRemovedText), getText(configOf _target >> "displayName")];
            } else {
                GVAR(AdditionalUndercoverVehicles) pushBack _class;
                undercoverVehicles pushBackUnique _class;
                format[localize LSTRING(Vehicles_AddToUndercoverHintAddedText), getText(configOf _target >> "displayName")];
            };

            [
                localize LSTRING(Vehicles_AddToUndercoverCaption),
                _message
            ] call A3A_fnc_customHint;

            playSound "A3AP_UiSuccess";
        } catch {
            [
                localize LSTRING(Vehicles_AddToUndercoverCaption),
                _exception
            ] call A3A_fnc_customHint;

            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Vehicles_AddToUndercoverCaption), LSTRING(Vehicles_AddToUndercoverNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
