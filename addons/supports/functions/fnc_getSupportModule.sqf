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

    _module = createVehicle[
        _class,
        [0, 100 * count(keys GVAR(moduleProviders)), 0],
        [],
        0,
        "NONE"
    ];

    private _supporter = [] call FUNC(getSupportProviderModule);
    _module synchronizeObjectsAdd[_supporter];

    allCurators apply {
        _x addCuratorEditableObjects[[_module], false];
    };
};

_module;
