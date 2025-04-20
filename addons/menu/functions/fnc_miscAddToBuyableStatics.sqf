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
                throw format[localize LSTRING(Miscellaneous_AddToBuyableStaticsHintNoEmplacementText), getText(configOf _target >> "displayName")];
            };

            private _index = (A3A_faction_reb get "staticMGs") findIf { _x isEqualTo typeOf _target };

            if (_index isNotEqualTo -1) then {
                throw format[localize LSTRING(Miscellaneous_AddToBuyableStaticsHintAlreadyExistsText), getText(configOf _target >> "displayName")];
            };

            private _guiCaption = localize LSTRING(Miscellaneous_AddToBuyableStaticsCaption);
            private _guiText = format[localize LSTRING(Miscellaneous_AddToBuyableStaticsConfirmText), getText(configOf _target >> "displayName")];

            if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
                [(localize LSTRING(Miscellaneous_AddToBuyableStaticsPricePromptText)) + ":", "1750", {
                    params[["_price","",[""]],["_target",objNull,[objNull]]];

                    private _static = [typeOf _target, parseNumber _price];

                    A3A_faction_reb get "staticMGs" pushBackUnique typeOf _target;
                    GVAR(AdditionalStatics) pushBack _static;

                    [QGVAR(AdditionalStatics), GVAR(AdditionalStatics)] call A3A_fnc_setStatVariable;

                    [
                        localize LSTRING(Miscellaneous_AddToBuyableStaticsCaption),
                        format [localize LSTRING(Miscellaneous_AddToBuyableStaticsHintSuccessText), getText(configOf _target >> "displayName"), _price]
                    ] call A3A_fnc_customHint;

                    playSound "A3AP_UiSuccess";
                }, _target] call FUNCMAIN(utilPromptText);
            };
        } catch {
            [
                localize LSTRING(Miscellaneous_AddToBuyableStaticsCaption),
                _exception
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Miscellaneous_AddToBuyableStaticsCaption), LSTRING(Miscellaneous_AddToBuyableStaticsHintNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
