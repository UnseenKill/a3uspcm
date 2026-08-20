#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAddToBuyableStatics

Description:
    Adds the given static to the buyable statics list.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscAddToBuyableStatics),_this);

[
    {
        params[["_target", objNull, [objNull]]];

        try {
            if !(_target isKindOf "StaticWeapon") then {
                throw format[LLSTRING(Miscellaneous_AddToBuyableStaticsHintNoEmplacementText), getText(configOf _target >> "displayName")];
            };

            private _className = typeOf _target;
            private _additionalIndex = GVAR(AdditionalStatics) findIf { (_x select 0) isEqualTo _className };
            private _index = (A3A_faction_reb get "staticMGs") findIf { _x isEqualTo _className };

            if (_index isNotEqualTo -1 && { _additionalIndex isEqualTo -1 }) then {
                throw format[LLSTRING(Miscellaneous_AddToBuyableStaticsHintAlreadyExistsText), getText(configOf _target >> "displayName")];
            };

            private _guiCaption = LLSTRING(Miscellaneous_AddToBuyableStaticsCaption);
            private _guiText = format[LLSTRING(Miscellaneous_AddToBuyableStaticsConfirmText), getText(configOf _target >> "displayName")];
            private _defaultPrice = "1750";
            if (_additionalIndex isNotEqualTo -1) then {
                _defaultPrice = str ((GVAR(AdditionalStatics) select _additionalIndex) select 1);
            };

            if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
                [(LLSTRING(Miscellaneous_AddToBuyableStaticsPricePromptText)) + ":", _defaultPrice, {
                    params[["_price","",[""]],["_target",objNull,[objNull]]];

                    private _className = typeOf _target;
                    private _priceValue = parseNumber _price;
                    private _static = [_className, _priceValue];
                    private _additionalIndex = GVAR(AdditionalStatics) findIf { (_x select 0) isEqualTo _className };

                    if (_priceValue <= 0) exitWith {
                        if (_additionalIndex isNotEqualTo -1) then {
                            GVAR(AdditionalStatics) deleteAt _additionalIndex;
                        };

                        private _factionIndex = (A3A_faction_reb get "staticMGs") find _className;
                        if (_factionIndex isNotEqualTo -1) then {
                            A3A_faction_reb get "staticMGs" deleteAt _factionIndex;
                        };

                        private _bmIndex = A3U_blackMarketStock findIf { (_x select 0) isEqualTo _className };
                        if (_bmIndex isNotEqualTo -1) then {
                            A3U_blackMarketStock deleteAt _bmIndex;
                        };

                        server setVariable[_className, nil, true];
                        [CBA_EVENT_MENU_SYNCGVAR, [player, QGVAR(AdditionalStatics), GVAR(AdditionalStatics)]] call CBA_fnc_serverEvent;

                        [
                            LLSTRING(Miscellaneous_AddToBuyableStaticsCaption),
                            format [LLSTRING(Miscellaneous_AddToBuyableStaticsHintRemovedText), getText(configOf _target >> "displayName")]
                        ] call A3A_fnc_customHint;

                        playSound "A3AP_UiSuccess";
                    };

                    A3A_faction_reb get "staticMGs" pushBackUnique _className;
                    if (_additionalIndex isEqualTo -1) then {
                        GVAR(AdditionalStatics) pushBack _static;
                    } else {
                        GVAR(AdditionalStatics) set[_additionalIndex, _static];
                    };
                    [CBA_EVENT_MENU_SYNCGVAR, [player, QGVAR(AdditionalStatics), GVAR(AdditionalStatics)]] call CBA_fnc_serverEvent;

                    server setVariable[_className, _priceValue, true];

                    private _bmIndex = A3U_blackMarketStock findIf { (_x select 0) isEqualTo _className };
                    private _bmConfig = [_className, _priceValue, "STATICMG", {true}];

                    if (_bmIndex isEqualTo -1) then {
                        A3U_blackMarketStock pushBack _bmConfig;
                    } else {
                        (A3U_blackMarketStock select _bmIndex) set[1, _priceValue];
                    };

                    private _currentPrice = [_className] call A3A_fnc_vehiclePrice;
    
                    [
                        LLSTRING(Miscellaneous_AddToBuyableStaticsCaption),
                        format [LLSTRING(Miscellaneous_AddToBuyableStaticsHintSuccessText), getText(configOf _target >> "displayName"), _priceValue, _currentPrice]
                    ] call A3A_fnc_customHint;

                    playSound "A3AP_UiSuccess";
                }, _target] call FUNCMAIN(utilPromptText);
            };
        } catch {
            [
                LLSTRING(Miscellaneous_AddToBuyableStaticsCaption),
                _exception
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Miscellaneous_AddToBuyableStaticsCaption), LSTRING(Miscellaneous_AddToBuyableStaticsHintNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
