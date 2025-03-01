#include "script_component.hpp"
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

if visibleMap then {
    openMap false;
};

[] spawn {
    uiSleep 2.5;

    [cursorTarget] spawn {
        params[["_target", objNull, [objNull]]];

        if (isNull _target) exitWith {
            [
                localize LSTRING(Miscellaneous_AddToBuildablesCaption),
                localize LSTRING(Miscellaneous_AddToBuildablesHintNoTargetText)
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };

        if !(_target isKindOf "Building") exitWith {
            [
                localize LSTRING(Miscellaneous_AddToBuildablesCaption),
                format[localize LSTRING(Miscellaneous_AddToBuildablesHintNoBuildingText), getText(configOf _target >> "displayName")]
            ] call A3A_fnc_customHint;

            playSound "A3AP_UiFailure";
        };

        private _index = A3A_buildableObjects findIf { _x select 0 isEqualTo typeOf _target };

        if (_index isNotEqualTo -1) exitWith {
            [
                localize LSTRING(Miscellaneous_AddToBuildablesCaption),
                format[localize LSTRING(Miscellaneous_AddToBuildablesHintAlreadyExistsText), getText(configOf _target >> "displayName")]
            ] call A3A_fnc_customHint;
            playSound "A3AP_UiFailure";
        };

        private _guiCaption = localize LSTRING(Miscellaneous_AddToBuildablesCaption);
        private _guiText = format[localize LSTRING(Miscellaneous_AddToBuildablesConfirmText), getText(configOf _target >> "displayName")];

        if ([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) then {
            [(localize LSTRING(Miscellaneous_AddToBuildablesPricePromptText)) + ":", "150", {
                params[["_price","",[""]],["_target",objNull,[objNull]]];

                A3A_buildableObjects pushBack[typeOf _target, parseNumber _price];

                [
                    localize LSTRING(Miscellaneous_AddToBuildablesCaption),
                    format [localize LSTRING(Miscellaneous_AddToBuildablesHintSuccessText), getText(configOf _target >> "displayName"), _price]
                ] call A3A_fnc_customHint;

                playSound "A3AP_UiSuccess";
            }, _target] call FUNCMAIN(utilPromptText);
        };
    };
};

nil;
