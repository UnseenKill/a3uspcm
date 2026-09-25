#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_updateLocations

Description:
    CBA_EVENT_UPDATE_LOCATIONS event handler

Parameters:

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(updateLocations),_this);

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _control = _controls get "ListLocations";

lnbClear _control;

private _closeLocation = {
    params[["_format","",[""]], ["_entry",nil,[createHashMap]]];

    private _loc = nearestLocations[_entry get "position", ["NameCityCapital","NameCity","NameVillage"], 1500, _entry get "position"];

    if (_loc isNotEqualTo []) exitWith { format[_format, text(_loc select 0)] };
    format[_format, mapGridPosition(_entry get "position")];
};

private _entries = markersX apply {
    private _entry = createHashMapFromArray[
        ["picture", ""],
        ["marker", _x],
        ["position", markerPos _x],
        ["side", sidesX getVariable[_x, sideUnknown]]
    ];

    _entry set["color", switch (_entry get "side") do {
        case east: { GVAR(markerColorsCache) get "colorOPFOR" };
        case west: { GVAR(markerColorsCache) get "colorBLUFOR" };
        case resistance: { GVAR(markerColorsCache) get "ColorGUER" };
        case civilian: { GVAR(markerColorsCache) get "ColorCIV" };
        default { GVAR(markerColorsCache) get "ColorUNKNOWN" };
    }];

    private _label = switch true do {
        case(_x isEqualTo "Synd_HQ"): {
            _entry set["picture", "\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa"];
            [LLSTRING(Dialog_LocationsList_SyndicateHQ_Label), _entry] call _closeLocation;
        };
        case(_x in citiesX): {
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Ruin_CA.paa"];
            _x;
        };
        case(_x in resourcesX): {
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Rock_CA.paa"];
            [LLSTRING(Dialog_LocationsList_Resource_Label), _entry] call _closeLocation;
        };
        case(_x in outposts): {
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\bunker_CA.paa"];
            [LLSTRING(Dialog_LocationsList_Outpost_Label), _entry] call _closeLocation;
        };
        case(_x in factories): {
            _entry set["picture", "\A3\ui_f\data\map\markers\nato\u_installation.paa"];
            [LLSTRING(Dialog_LocationsList_Factory_Label), _entry] call _closeLocation;
        };
        case(_x in milbases): {
            _entry set["picture", "\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa"];
            [LLSTRING(Dialog_LocationsList_MilBase_Label), _entry] call _closeLocation;
        };
        case(_x in airportsX): {
            _entry set["picture", "\a3\ui_f\data\igui\cfg\simpletasks\types\Plane_ca.paa"];
            [LLSTRING(Dialog_LocationsList_Airport_Label), _entry] call _closeLocation;
        };
        case(_x in seaports): {
            _entry set["picture", "\A3\ui_f\data\map\markers\nato\n_naval.paa"];
            [LLSTRING(Dialog_LocationsList_Seaport_Label), _entry] call _closeLocation;
        };
        case(_x in aapostsFIA): {
            _entry set["picture", "\A3\ui_f\data\igui\cfg\simpletasks\types\defend_ca.paa"];
            [LLSTRING(Dialog_LocationsList_AApost_Label), _entry] call _closeLocation;
        };
        case(_x in atpostsFIA): {
            _entry set["picture", "\A3\ui_f\data\igui\cfg\simpletasks\types\defend_ca.paa"];
            [LLSTRING(Dialog_LocationsList_ATpost_Label), _entry] call _closeLocation;
        };
        case(_x in hmgpostsFIA): {
            _entry set["picture", "\A3\ui_f\data\igui\cfg\simpletasks\types\defend_ca.paa"];
            [LLSTRING(Dialog_LocationsList_HMGpost_Label), _entry] call _closeLocation;
        };
        case (_x in roadblocksFIA): {
            _entry set["picture", "\A3\ui_f\data\igui\cfg\simpletasks\types\defend_ca.paa"];
            [LLSTRING(Dialog_LocationsList_Roadblock_Label), _entry] call _closeLocation;
        };
        case (_x in watchpostsFIA): {
            _entry set["picture", "\A3\ui_f\data\igui\cfg\simpletasks\types\defend_ca.paa"];
            [LLSTRING(Dialog_LocationsList_Watchpost_Label), _entry] call _closeLocation;
        };
        default { format["UNK(%1)", _x] };
    };

    [_label, _entry];
};

_control setVariable[QGVAR(entries), []];

_entries sort true;
_entries apply {
    _x params[["_label", ""], ["_entry", nil, [createHashMap]]];

    private _index = _control lnbAddRow[_label];

    _control getVariable QGVAR(entries) pushBack _entry;

    [_control, _index] call FUNC(updateGarrisonInfo);

    _control lnbSetPicture[[_index, 0], _entry get "picture"];
    _control lnbSetPictureColor[[_index, 0], _entry get "color"];
};

_control lnbSetCurSelRow -1;

nil;
