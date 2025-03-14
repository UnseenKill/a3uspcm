#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_fnc_updateList

Description:
    Update garrison list

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
private _display = uiNamespace getVariable [QGVAR(menuDisplay), displayNull];
if !assert(!isNull _display) exitWith {};

private _states = missionNamespace getVariable QGVAR(dialogCheckBoxes);
private _listbox = _display displayCtrl IDC_RSCA3USPCMGARRISONMANAGERDIALOG_LISTOVERVIEW;
lnbClear _listbox;

private _showBLUFOR = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBLUFOR;
private _showINDEP = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWINDEP;
private _showOPFOR = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOPFOR;

private _showBases = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBASES;
private _showOutposts = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOUTPOSTS;
private _showResources = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWRESOURCES;
private _showTowns = _states get IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWTOWNS;

private _colors = createHashMapFromArray
    ("true" configClasses(configFile >> "CfgMarkerColors") apply {
        private _color = getArray(_x >> "color") apply {
            if !(_x isEqualType "") then {
                _x;
            } else {
                [] call compile _x;
            };
        };

        [configName _x, _color];
    }
);

private _closeLocation = {
    params[["_format","",[""]], ["_entry",false,[createHashMap]]];

    private _loc = nearestLocations[_entry get "position", ["NameCityCapital","NameCity","NameVillage"], 1500, _entry get "position"];

    if (_loc isNotEqualTo []) exitWith { format[_format, text(_loc select 0)] };
    format[_format, mapGridPosition(_entry get "position")];
};

private _entries = markersX select {
    (
        (_showBases && _x in (milbases + airportsX + seaports)) ||
        (_showOutposts && _x in outposts) ||
        (_showResources && _x in (resourcesX + factories)) ||
        (_showTowns && _x in citiesX)
    ) && (
        (_showBLUFOR && sidesX getVariable[_x, sideUnknown] isEqualTo west) ||
        (_showINDEP && sidesX getVariable[_x, sideUnknown] isEqualTo resistance) ||
        (_showOPFOR && sidesX getVariable[_x, sideUnknown] isEqualTo east)
    )
} apply {
    private _entry = createHashMapFromArray[
        ["picture", ""],
        ["marker", _x],
        ["position", markerPos _x],
        ["side", sidesX getVariable[_x, sideUnknown]]
    ];

    _entry set["color", switch (_entry get "side") do {
        case east: { "colorOPFOR" };
        case west: { "colorBLUFOR" };
        case resistance: { "ColorGUER" };
        case civilian: { "ColorCIV" };
        default { "ColorUNKNOWN" };
    }];

    private _label = switch true do {
        case(_x in citiesX): { 
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Ruin_CA.paa"];
            _x;
        };
        case(_x in resourcesX): { 
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Rock_CA.paa"];
            ["Resource near %1", _entry] call _closeLocation;
        };
        case(_x in outposts): { 
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\bunker_CA.paa"];
            ["Outpost near %1", _entry] call _closeLocation;
        };
        case(_x in factories): { 
            _entry set["picture", "\A3\ui_f\data\map\markers\nato\u_installation.paa"];
            ["Factory near %1", _entry] call _closeLocation;
        };
        case(_x in milbases): { 
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa"];
            ["Military base near %1", _entry] call _closeLocation;
        };
        case(_x in airportsX): { 
            _entry set["picture", "\a3\ui_f\data\igui\cfg\simpletasks\types\Plane_ca.paa"];
            ["Airport near %1", _entry] call _closeLocation;
        };
        case(_x in seaports): { 
            _entry set["picture", "\A3\ui_f\data\map\markers\nato\n_naval.paa"];
            ["Seaport near %1", _entry] call _closeLocation;
        };
        default { format["UNK(%1)", _x] };
    };

    [_label, _entry];
};

private _index = _listbox lnbAddRow[""];
{
    _x params["_text","_tooltip"];
    _listbox lnbSetText[[_index, _forEachIndex + 1], _text];
    _listbox lnbSetTooltip[[_index, _forEachIndex + 1], _tooltip];
} forEach GVAR(lbColumns);

_entries sort true;
_entries apply {
    _x params[["_label", ""], ["_entry", false, [createHashMap]]];

    private _index = _listbox lnbAddRow["", _label, "4", "2", "0", "0", "A"];
    private _color = _colors getOrDefault[_entry get "color", [1,0,1,1]];

    _listbox lnbSetColor[[_index, 1], _color];
    _listbox lnbSetPicture[[_index, 0], _entry get "picture"];
    _listbox lnbSetPictureColor[[_index, 0], _color];
};

nil;
