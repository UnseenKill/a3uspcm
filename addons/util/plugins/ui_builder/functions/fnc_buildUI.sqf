#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_buildUI

Description:
    Dynamically build UI from config class

Parameters:
    0: _config - Config class describing the UI structure <CONFIG>

Optional:
    1: _parent - Parent display of created control <DISPLAY>
        (default: displayNull, will create "RscDisplayEmpty" if null)

Example:
    (begin example)
    [configFile >> QADDON >> "Dialog"] call A3USPCM_util_ui_builder_fnc_buildUI;
    (end example)

Returns:
    <CONTROL>

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(buildUI),_this);

if !assert(params[
    ["_config", nil, [configNull]]
]) exitWith { controlNull };
if !assert(!isNull _config) exitWith { controlNull };

private _parent = param[1, nil, [displayNull]];
private _parentDisplay = RETNIL(_parent);

if (isNil "_parentDisplay" || { isNull _parentDisplay }) then {
    _parentDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";
};

if !assert(!isNull _parentDisplay) exitWith { controlNull };
if !assert(isNil QGVAR(buildUUID)) exitWith { controlNull };

GVAR(ignoreMap) = getArray(_config >> "ignoreMap");
GVAR(buildUUID) = [] call CBA_fnc_createUUID;
uiNamespace setVariable[GVAR(buildUUID), createHashMap];

private _masterControl = try {
    [_config, _parentDisplay, controlNull] call FUNC(buildControlsGroup);
} catch {
    if (isNil "_parent") then {
        _parentDisplay closeDisplay 0;
    };

    ERROR_2("Caught exception while building UI for %1: %2",configName _config,_exception);

    controlNull;
};

uiNamespace setVariable[GVAR(buildUUID), nil];
missionNamespace setVariable[QGVAR(buildUUID), nil];

_masterControl;
