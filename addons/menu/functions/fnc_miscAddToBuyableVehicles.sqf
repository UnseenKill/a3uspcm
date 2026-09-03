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
                throw format[LLSTRING(Miscellaneous_AddToBuyableVehiclesHintNoVehicleText), getText(configOf _target >> "displayName")];
            };

            private _className = typeOf _target;
            private _key = [_target] call FUNCMAIN(utilGetVehicleTemplateKey);
            private _additionalIndex = GVAR(AdditionalVehicles) findIf { (_x select 0) isEqualTo _className };
            private _index = (A3A_faction_reb get _key) findIf { _x isEqualTo _className };

            TRACE_3(QFUNCMAIN(miscAddToBuyableVehicles),_key,_index,_className);

            if (_index isNotEqualTo -1 && { _additionalIndex isEqualTo -1 }) then {
                throw format[LLSTRING(Miscellaneous_AddToBuyableVehiclesHintAlreadyExistsText), getText(configOf _target >> "displayName")];
            };

            private _guiCaption = LLSTRING(Miscellaneous_AddToBuyableVehiclesCaption);
            private _guiText = format[LLSTRING(Miscellaneous_AddToBuyableVehiclesConfirmText), getText(configOf _target >> "displayName")];
            private _defaultPrice = "3750";
            if (_additionalIndex isNotEqualTo -1) then {
                _defaultPrice = str ((GVAR(AdditionalVehicles) select _additionalIndex) select 1);
            };

            if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
                [(LLSTRING(Miscellaneous_AddToBuyableVehiclesPricePromptText)) + ":", _defaultPrice, {
                    params[
                        ["_price","",[""]],
                        ["_params",[],[[]]]
                    ];

                    _params params[
                        ["_target",objNull,[objNull]],
                        ["_key","",[""]]
                    ];

                    private _typeMap = createHashMapFromArray[
                        ["vehiclesLightArmed", "TANK"],
                        ["vehiclesCivCar", "UNARMEDCAR"],
                        ["vehiclesCivHeli", "HELI"],
                        ["vehiclesCivPlane", "PLANE"],
                        ["vehiclesCivBoat", "BOAT"],
                        ["vehiclesPlane", "PLANE"],
                        ["vehiclesBoat", "BOAT"]
                    ];

                    private _className = typeOf _target;
                    private _priceValue = parseNumber _price;
                    private _config = [_className, _priceValue, _key];
                    private _additionalIndex = GVAR(AdditionalVehicles) findIf { (_x select 0) isEqualTo _className };

                    if (_priceValue <= 0) exitWith {
                        if (_additionalIndex isNotEqualTo -1) then {
                            GVAR(AdditionalVehicles) deleteAt _additionalIndex;
                        };

                        private _factionIndex = (A3A_faction_reb get _key) find _className;
                        if (_factionIndex isNotEqualTo -1) then {
                            A3A_faction_reb get _key deleteAt _factionIndex;
                        };

                        A3U_blackMarketStock apply {
                            if (_className in _y) exitWith {
                                _y deleteAt _className;
                            };
                        };

                        server setVariable[_className, nil, true];
                        [CBA_EVENT_MENU_SYNCGVAR, [player, QGVAR(AdditionalVehicles), GVAR(AdditionalVehicles)]] call CBA_fnc_serverEvent;

                        [
                            LLSTRING(Miscellaneous_AddToBuyableVehiclesCaption),
                            format [LLSTRING(Miscellaneous_AddToBuyableVehiclesHintRemovedText), getText(configOf _target >> "displayName")]
                        ] call A3A_fnc_customHint;

                        playSound "A3AP_UiSuccess";
                    };

                    A3A_faction_reb get _key pushBackUnique _className;
                    if (_additionalIndex isEqualTo -1) then {
                        GVAR(AdditionalVehicles) pushBack _config;
                    } else {
                        GVAR(AdditionalVehicles) set[_additionalIndex, _config];
                    };
                    [CBA_EVENT_MENU_SYNCGVAR, [player, QGVAR(AdditionalVehicles), GVAR(AdditionalVehicles)]] call CBA_fnc_serverEvent;

                    server setVariable[_className, _priceValue, true];
                    A3U_blackMarketStock getOrDefault[_typeMap getOrDefault[_key, "UNARMEDCAR"], createHashMap, true] set[_className, _priceValue, true];

                    private _currentPrice = [_className] call A3A_fnc_vehiclePrice;

                    [
                        LLSTRING(Miscellaneous_AddToBuyableVehiclesCaption),
                        format [localize ([LSTRING(Miscellaneous_AddToBuyableVehiclesHintSuccessText), LSTRING(Miscellaneous_AddToBuyableVehiclesHintSuccessBMWarningText)] select _hasBM), getText(configOf _target >> "displayName"), _priceValue, _currentPrice]
                    ] call A3A_fnc_customHint;

                    playSound "A3AP_UiSuccess";
                }, [_target, _key]] call FUNCMAIN(utilPromptText);
            };
        } catch {
            [
                LLSTRING(Miscellaneous_AddToBuyableVehiclesCaption),
                _exception
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Miscellaneous_AddToBuyableVehiclesCaption), LSTRING(Miscellaneous_AddToBuyableVehiclesHintNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
