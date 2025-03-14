#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_fnc_onMenuOpen

Description:
    Open garrison editor

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
disableSerialization;

TRACE_1(QFUNC(onMenuOpen),_this);

params[["_display",displayNull,[displayNull]]];

if !assert(!isNull _display) exitWith {};

uiNamespace setVariable [QGVAR(menuDisplay), _display];

private["_control"];
private _checkStates = missionNamespace getVariable[QGVAR(dialogCheckBoxes), createHashMapFromArray [
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBLUFOR, false],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOPFOR, false],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWINDEP, true],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBASES, false],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOUTPOSTS, false],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWRESOURCES, false],
    [IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWTOWNS, true]
]];

#define LB_ITEM(NAME,TYPE) [localize LSTRING(TRIPLES(RscA3USPCMGarrisonManagerDialog_ListOverview_Column,NAME,Caption)), localize LSTRING(TRIPLES(RscA3USPCMGarrisonManagerDialog_ListOverview_Column,NAME,Tooltip)), TYPE]
GVAR(lbColumns) = [
    LB_ITEM(Name,""),
    LB_ITEM(SquadLdr,"unitSL"),
    LB_ITEM(Medic,"unitMedic"),
    LB_ITEM(Marksman,"unitSniper"),
    LB_ITEM(Rifleman,"unitRifle"),
    LB_ITEM(Grenadier,"unitGL"),
    LB_ITEM(Autorifleman,"unitMG"),
    LB_ITEM(AT,"unitLAT"),
    LB_ITEM(Crew,"unitCrew"),
    LB_ITEM(Sapper,"unitExp"),
    LB_ITEM(Engineer,"unitEng"),
    LB_ITEM(AASpecialist,"unitAA"),
    LB_ITEM(ATSpecialist,"unitAT"),
];
#undef LB_ITEM

missionNamespace setVariable[QGVAR(dialogCheckBoxes), _checkStates];

_checkStates apply {
    private _control = _display displayCtrl _x;

    _control ctrlEnable true;
    _control cbSetChecked _y;
    _control ctrlAddEventHandler["CheckedChanged", {
        params[["_control",controlNull,[controlNull]],["_state",0,[0]]];
        missionNamespace getVariable QGVAR(dialogCheckBoxes) set[ctrlIDC _control, [false, true] select _state];
        [] call FUNC(updateList);
    }];
};

_display displayCtrl IDC_RSCA3USPCMGARRISONMANAGERDIALOG_BTNCLOSE ctrlAddEventHandler["ButtonClick", {
    closeDialog 0;
}];

private _rightMargin = 0.35;
private _width = (1 - _rightMargin) / (count GVAR(lbColumns) - 1);

_control = _display displayCtrl IDC_RSCA3USPCMGARRISONMANAGERDIALOG_LISTOVERVIEW;
_control lnbAddColumn 0.025;
_control lnbAddColumn _rightMargin;

for "_j" from 1 to (count GVAR(lbColumns) - 1) do {
    _rightMargin = _rightMargin + _width;
    _control lnbAddColumn _rightMargin;
};

[] call FUNC(updateList);

nil;
