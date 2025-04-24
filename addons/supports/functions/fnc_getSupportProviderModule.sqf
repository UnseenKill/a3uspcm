#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_getSupportProviderModule

Description:
    Return the support provider module for the commander.

Parameters:

Optional:

Example:

Returns:
    <OBJECT>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if (isNull GVAR(moduleSupportProvider)) then {
    GVAR(moduleSupportProvider) = createVehicle[
        "A3USPCM_supports_moduleSupportProvider",
        [0, -100, 0],
        [],
        0,
        "NONE"
    ];
    
    allCurators apply {
        _x addCuratorEditableObjects[[GVAR(moduleSupportProvider)], false];
    };

    theBoss synchronizeObjectsAdd[GVAR(moduleSupportProvider)];
};

GVAR(moduleSupportProvider);
