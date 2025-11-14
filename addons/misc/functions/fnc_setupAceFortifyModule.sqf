#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_setupAceFortifyModule

Description:
    Sets up the ACE3 fortification module at mission start.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_misc_fnc_setupAceFortifyModule;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(setupAceFortifyModule),_this);

private _group = createGroup[sideLogic, true];
private _init = [
    QUOTE(GVAR(aceFortifyModule) = this)
];

_init pushBack "this setVariable['Side',3]";
_init pushBack format["this setVariable['Preset','%1']", GVAR(aceFortifyPreset)];

_init = _init joinString (";" + endl);

TRACE_1(QFUNC(setupAceFortifyModule),_init);

"acex_fortify_setupModule" createUnit[
    markerPos "Synd_HQ",
    _group,
    _init
];

if (isNil QGVAR(aceFortifyModule)) exitWith {
    ERROR("something went wrong creating the fortification module");
};

allCurators apply {
    _x addCuratorEditableObjects[[GVAR(aceFortifyModule)], false];
};

player synchronizeObjectsAdd[GVAR(aceFortifyModule)];

[GVAR(aceFortifyModule), "", true] call ace_fortify_fnc_setupModule;

INFO_1("Created %1",GVAR(aceFortifyModule));

nil;
