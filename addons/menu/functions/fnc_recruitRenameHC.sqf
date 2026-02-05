#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitRenameHC

Description:
    Rename a high command group

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(recruitRenameHC),_this);

[] spawn {
    private _timeout = 5;

    while { _timeout > 0 } do {
        systemChat format[LLSTRING(Recruitment_RenameCountdownText), _timeout];
        DEC(_timeout);
        uiSleep 1;
    };

    private _units = hcSelected theBoss;

    if (count _units isNotEqualTo 1) exitWith {
        [
            LLSTRING(Recruitment_RenameHCCaption),
            LLSTRING(Recruitment_RenameHCError)
        ] call A3A_fnc_customHint;

        playSound "A3AP_UiFailure";
    };

    _units params["_group"];
    private _name = groupId _group;

    [(LLSTRING(Recruitment_RenameHCCaption)) + ":", _name, {
        params[["_name","",[""]],["_group",grpNull,[grpNull]]];

        if !(assert !isNull _group) exitWith {};
        if (_name isEqualTo "") exitWith {};

        INFO_3("%1 renamed group %2 to '%3'",name player,groupId _group,_name);

        _group setGroupId[_name];
    }, _group] call FUNCMAIN(utilPromptText);

};

nil;
