#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilAceCargoGetLoaded

Description:
    Get ACE cargo loaded into vehicle

Parameters:
    0: _vehicle - Vehicle to retrieve cargo from <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player] call A3USPCM_fnc_utilAceCargoGetLoaded;
    (end example)

Returns:
    Array of strings of cargo <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicle", objNull, [objNull]]
];

if !assert(!isNull _vehicle) exitWith {[]};

ACE_VEHICLE_CARGO(_vehicle) apply {
    if (_x isEqualType objNull) then {
        typeOf _x;
    } else {
        _x;
    };
};
