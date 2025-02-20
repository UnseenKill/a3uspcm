#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_reorientObject

Description:
    Reorient objects in selection.

Parameters:
    0: _logic - module logic object <OBJECT>
    1: _units - units affected <ARRAY>
    2: _activated - module activation state <BOOL>

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1("A3USPCM_zeus_fnc_reorientObject",_this);

_this spawn {
    params[
        ["_logic", objNull, [objNull]],
        ["_units", [], []],
        ["_activated", false, [false]]
    ];

    for "_wait" from 0 to (REORIENT_OBJECT_WAIT - 1) do {
        systemChat format["Reorienting selection in %1 seconds.", REORIENT_OBJECT_WAIT - _wait];
        uiSleep 1;
    };

    if (_logic isKindOf "Module_F") then {
        deleteVehicle _logic;
    };

    curatorSelected select 0 apply {
        TRACE_1("Reorienting object",_x);
        systemChat format["%1 reoriented", getText(configOf _x >> "displayName")];
        _x setVectorUp[0,0,1];
    };
};

nil;
