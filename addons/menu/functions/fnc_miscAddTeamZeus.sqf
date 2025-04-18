#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscAddTeamZeus

Description:
    Add team members to curatable objects.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscAddTeamZeus;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscAddTeamZeus),_this);

INFO_1("player %1 wants team added to Zeus objects",name theBoss);

if (!isServer && hasInterface) exitWith { [] remoteExec[QFUNCMAIN(miscAddTeamZeus), 2] };

allCurators apply {
    _x addCuratorEditableObjects[allUnitsUAV select {
        theBoss in (UAVControl _x - ["", objNull]);
    }, true];
    _x addCuratorEditableObjects[units group theBoss, true];
    _x addCuratorEditableObjects[flatten(units group theBoss apply {
        if isNull objectParent _x then {
            [];
        } else {
            [objectParent _x] + (((objectParent _x) getVariable["ace_cargo_loaded", []]) select { _x isEqualType objNull });
        };
    }), true];
};

nil;
