#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_onResizeLocations

Description:
    CBA_EVENT_UPDATE_LOCATIONS event handler

    Used to bring the header control and list control into sync.

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
TRACE_1(QFUNC(onResizeLocations),_this);

private _display = uiNamespace getVariable QGVAR(display);
private _rootControl = _display getVariable QGVAR(rootControl);
private _controls = _rootControl getVariable QUIBVAR(controls);
private _headerControl = _controls get "ListLocationsHeader";
private _listboxControl = _controls get "ListLocations";

private _rows = lnbSize _listboxControl select 0;

if (_rows < 11) then {
    while { lnbSize _headerControl select 0 > 1 } do {
        _headerControl lnbDeleteRow 1;
    };
} else {
    if (lnbSize _headerControl select 0 isEqualTo 1) then {
        for "_i" from 0 to 8 do {
            _headerControl lnbAddRow [""];
        };
    };
};

nil;
