#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_intelCleanupMarker

Description:
    Clean up a single intel marker

Parameters:
    0: _key - marker key in QVAR(IntelMarkers) <STRING>

Optional:

Example:
    (begin example)
    ["marker"] call A3USPCM_menu_fnc_intelCleanupMarker;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_key", "", [""]]
];

if (_key in GVAR(IntelMarkers)) then {
    private _data = GVAR(IntelMarkers) get _key;
    _data params["_created","_icon","_object","_flag"];

    deleteMarker _key;
    deleteMarker _icon;
    deleteVehicle _flag;
    _object setVariable[QGVAR(intelMarker), nil];

    GVAR(IntelMarkers) deleteAt _key;
};

nil;
