#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_recruitLaunchAGM

Description:
    Launch advanced garrison manager

Parameters:

Optional:
    0: _location - The location to preselect <STRING>

Example:
    (begin example)
    [] call A3USPCM_fnc_recruitLaunchAGM;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(recruitLaunchAGM),_this);

private _location = param[0, nil, [""]];

createDialog QEGVAR(garrison,dialog);

if !(isNil "_location") then {
    [{
        ["A3USPCM_garrison_event_preselectLocation", _this] call CBA_fnc_localEvent;
    }, [_location]] call CBA_fnc_execNextFrame;
};

nil;
