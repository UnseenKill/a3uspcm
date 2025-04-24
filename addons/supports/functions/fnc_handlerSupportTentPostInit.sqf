#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_handlerSupportTentPostInit

Description:
    Post-init handler for support tents (server side)

Parameters:
    0: _param1 - description <TYPE>
    1: _param2 - description <TYPE>

Optional:
    2: _param3 - description <TYPE>

Example:
    (begin example)
    ["param1", "param2"] call PREFIX_fnc_name;
    (end example)

Returns:
    Return description <TYPE>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerSupportTentPostInit),_this);

params[
    ["_tent",objNull,[objNull]]
];

if !assert(!isNull _tent) exitWith {};

getArray(configOf _tent >> QGVAR(attachObjects)) apply {
    _x params["_class","_pos","_vdup"];

    private _object = createSimpleObject[_class, [0,0,100], false];
    _object attachTo[_tent, _pos];
    _object setVectorDirAndUp _vdup;
};

nil;
