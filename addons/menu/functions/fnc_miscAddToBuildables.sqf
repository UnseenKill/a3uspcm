#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAddToBuildables

Description:
    Add the current cursor target to list of base building objects

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscAddToBuildables),_this);

[
    {
        params[["_target", objNull, [objNull]]];

        try {
            if !(_target isKindOf "Building") then {
                throw format[LLSTRING(Miscellaneous_AddToBuildablesHintNoBuildingText), getText(configOf _target >> "displayName")];
            };

            private _index = A3A_buildableObjects findIf { _x select 0 isEqualTo typeOf _target };

            if (_index isNotEqualTo -1) then {
                throw format[LLSTRING(Miscellaneous_AddToBuildablesHintAlreadyExistsText), getText(configOf _target >> "displayName")];
            };

            private _guiCaption = LLSTRING(Miscellaneous_AddToBuildablesCaption);
            private _guiText = format[LLSTRING(Miscellaneous_AddToBuildablesConfirmText), getText(configOf _target >> "displayName")];

            if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
                [(LLSTRING(Miscellaneous_AddToBuildablesPricePromptText)) + ":", "150", {
                    params[["_price","",[""]],["_target",objNull,[objNull]]];

                    private _buildable = [typeOf _target, parseNumber _price];

                    A3A_buildableObjects pushBack _buildable;
                    GVAR(AdditionalBuildables) pushBack _buildable;

                    [
                        LLSTRING(Miscellaneous_AddToBuildablesCaption),
                        format [LLSTRING(Miscellaneous_AddToBuildablesHintSuccessText), getText(configOf _target >> "displayName"), _price]
                    ] call A3A_fnc_customHint;

                    playSound "A3AP_UiSuccess";
                }, _target] call FUNCMAIN(utilPromptText);
            };
        } catch {
            [
                LLSTRING(Miscellaneous_AddToBuildablesCaption),
                _exception
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };
    },
    nil,
    [LSTRING(Miscellaneous_AddToBuildablesCaption), LSTRING(Miscellaneous_AddToBuildablesHintNoTargetText)]
] call FUNCMAIN(utilCursorTargetAction);

nil;
