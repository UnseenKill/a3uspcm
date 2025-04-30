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
    private _group = createGroup[sideLogic, true];
    private _init = [
        QUOTE(GVAR(moduleSupportProvider) = this)/*,
        "this setVariable['BIS_SUPP_custom_HQ','petros',true]"*/
    ];

    {
        _init pushBack format["this setVariable['BIS_SUPP_limit_%1','-1',true]", _x];
    } forEach [
        "Artillery",
		"CAS_Heli",
		"CAS_Bombing",
		"UAV",
		"Drop",
		"Transport"
    ];

    _init pushBack "this setVariable['BIS_fnc_initModules_disableAutoActivation',false,true]";

    _init = _init joinString (";" + endl);

    //TRACE_1(QFUNC(getSupportProviderModule),_init);

    "SupportRequester" createUnit[
        markerPos "Synd_HQ",
        _group,
        _init
    ];

    if (isNil QGVAR(moduleSupportProvider)) exitWith {
        ERROR("something went wrong creating the support provider module");
    };

    allCurators apply {
        _x addCuratorEditableObjects[[GVAR(moduleSupportProvider)], false];
    };

    theBoss synchronizeObjectsAdd[GVAR(moduleSupportProvider)];
};

GVAR(moduleSupportProvider);
