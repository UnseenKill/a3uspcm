#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAddToBuyableVehicles

Description:
    Adds the given static to the buyable vehicles list.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscAddToBuyableVehicles),_this);

[
    {
        params[["_target", objNull, [objNull]]];

        try {
            if (["LandVehicle", "Air", "Ship"] findIf { _target isKindOf _x } isEqualTo -1) then {
                throw format[localize LSTRING(Miscellaneous_AddToBuyableVehiclesHintNoVehicleText), getText(configOf _target >> "displayName")];
            };

            private _isArmed = [_target] call FUNCMAIN(utilIsArmedVehicle);
            private _key = switch true do {
                case (_isArmed && {_target isKindOf "Car"});
                case (_target isKindOf "Tank"): { "vehiclesLightArmed" };
                case (_target isKindOf "Helicopter"): { ["vehiclesCivHeli","vehiclesPlane"] select _isArmed };
                case (_target isKindOf "Plane"): { ["vehiclesCivPlane","vehiclesPlane"] select _isArmed };
                case (_target isKindOf "Ship"): { ["vehiclesCivBoat","vehiclesBoat"] select _isArmed };
                default { "vehiclesCivCar" };
            };

            private _index = (A3A_faction_reb get _key) findIf { _x isEqualTo typeOf _target };

            TRACE_3(QFUNCMAIN(miscAddToBuyableVehicles),_key,_index,typeOf _target);

            if (_index isNotEqualTo -1) then {
                throw format[localize LSTRING(Miscellaneous_AddToBuyableVehiclesHintAlreadyExistsText), getText(configOf _target >> "displayName")];
            };

            private _guiCaption = localize LSTRING(Miscellaneous_AddToBuyableVehiclesCaption);
            private _guiText = format[localize LSTRING(Miscellaneous_AddToBuyableVehiclesConfirmText), getText(configOf _target >> "displayName")];

            if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
                [(localize LSTRING(Miscellaneous_AddToBuyableVehiclesPricePromptText)) + ":", "3750", {
                    params[
                        ["_price","",[""]],
                        ["_params",[],[[]]]
                    ];

                    _params params[
                        ["_target",objNull,[objNull]],
                        ["_key","",[""]]
                    ];

                    private _config = [typeOf _target, parseNumber _price, _key];

                    A3A_faction_reb get _key pushBackUnique typeOf _target;
                    GVAR(AdditionalVehicles) pushBack _config;

                    private _hasBM = A3U_blackMarketStock findIf { _x select 0 isEqualTo typeOf _target } >= 0;

                    [
                        localize LSTRING(Miscellaneous_AddToBuyableVehiclesCaption),
                        format [localize ([LSTRING(Miscellaneous_AddToBuyableVehiclesHintSuccessText), LSTRING(Miscellaneous_AddToBuyableVehiclesHintSuccessBMWarningText)] select _hasBM), getText(configOf _target >> "displayName"), _price]
                    ] call A3A_fnc_customHint;

                    playSound "A3AP_UiSuccess";
                }, [_target, _key]] call FUNCMAIN(utilPromptText);
            };
        } catch {
            [
                localize LSTRING(Miscellaneous_AddToBuyableVehiclesCaption),
                _exception
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Miscellaneous_AddToBuyableVehiclesCaption), LSTRING(Miscellaneous_AddToBuyableVehiclesHintNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
