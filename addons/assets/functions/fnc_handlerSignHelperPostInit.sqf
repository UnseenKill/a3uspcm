#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_handlerSignHelperPostInit

Description:
    Helper signs post init event handler.

Parameters:
    0: _object - Helper sign <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerSignHelperPostInit),_this);

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};

private _onInit = getText(configOf _object >> QGVAR(UserActions) >> "onObjectInit");

if (_onInit isNotEqualTo "") then {
    [_object] call compile _onInit;
};

"true" configClasses(configOf _object >> QGVAR(UserActions)) apply {
    private _displayName = if (getText(_x >> "displayNameCode") isNotEqualTo "") then {
        [_object] call compile getText(_x >> "displayNameCode");
    } else {
        getText(_x >> "displayName")
    };

    _object addAction[
        _displayName,
        compile getText(_x >> "statement"),
        [],
        getNumber(_x >> "priority"),
        [false, true] select getNumber(_x >> "showWindow"),
        [false, true] select getNumber(_x >> "hideOnUse"),
        "",
        getText(_x >> "condition"),
        getNumber(_x >> "radius")
    ];
};

nil;
