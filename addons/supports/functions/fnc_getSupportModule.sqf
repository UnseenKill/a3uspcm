#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_getSupportModule

Description:
    Return the support module for the given support role.

Parameters:
    0: _role - Support role <STRING>

Optional:

Example:

Returns:
    <OBJECT>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getSupportModule),_this);

if !assert(params[
    ["_role", nil, [""]]
]) exitWith { objNull };

private _module = GVAR(moduleProviders) getOrDefault[_role, objNull];

if (isNull _module) then {
    private _map = createHashMapFromArray SUPPORT_MODULES_MAP;
    private _class = _map getOrDefault[_role, false];

    if (_class isEqualTo false) exitWith { throw "something went wrong" };

    INFO_2("creating %1 module for %2 support",_class,_role);

    private _supporter = [] call FUNC(getSupportProviderModule);
    // allow bleed through for this special case...
    private _position = if isNil "_vehicle" then {
        markerPos "Synd_HQ"
    } else {
        getPos _vehicle
    };

    GVAR(_module) = false;

    _class createUnit[
        _position,
        group _supporter,
        [
            QUOTE(GVAR(_module) = this),
            "this setVariable['BIS_fnc_initModules_disableAutoActivation',false,true]"
        ] joinString (";" + endl)
    ];

    if (isNil QGVAR(_module)) exitWith {
        ERROR("something went wrong creating the support module");
    };

    _module = GVAR(_module);
    GVAR(_module) = nil;

    _supporter synchronizeObjectsAdd[_module];

    _module setVariable["bis_fnc_moduleExecute_activate", true];
    _module setVariable["bis_fnc_initModules_activate", true];

    GVAR(moduleProviders) set[_role, _module];

    allCurators apply {
        _x addCuratorEditableObjects[[_module], false];
    };
};

_module;
