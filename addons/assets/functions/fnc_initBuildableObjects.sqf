#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_initBuildableObjects

Description:
    Initialize the list of buildable objects available for construction.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(initBuildableObjects),_this);

waitUntil { !isNil { missionNamespace getVariable "A3A_buildableObjects" } };

uiSleep 1.5;

private _before = "A3AU_RebHelipad_Square_F";
private _index = (A3A_buildableObjects findIf { _x select 0 isEqualTo _before }) max 0;
private _buildableObjects = [
    [QGVAR(SignHelperArsenal), 1250],
    [QGVAR(SignHelperGarage), 1250]
];

A3A_buildableObjects insert[_index, _buildableObjects];

nil;
