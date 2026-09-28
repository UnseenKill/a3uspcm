#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_fnc_openManager

Description:
    Open AGM

Parameters:

Optional:
    0: _location - The location to preselect <STRING>

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(openManager),_this);

private _location = param[0, nil, [""]];

createDialog QEGVAR(garrison,dialog);

if !(isNil "_location") then {
    [{
        ["A3USPCM_garrison_event_preselectLocation", _this] call CBA_fnc_localEvent;
    }, [_location]] call CBA_fnc_execNextFrame;
};

nil;
