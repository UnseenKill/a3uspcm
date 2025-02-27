#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilGenerateUniqueID

Description:
    Generate a unique hexadecimal ID string

Parameters:

Optional:
    0: _length - Optionally overrides default lenght of eight charactes <NUMBER>

Example:
    (begin example)
    [] call A3USPCM_fnc_utilGenerateUniqueID;
    (end example)

Returns:
    Unique ID <STRING>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_length", 8, [0]]
];

if !assert(_length > 0) exitWith {"deadbeef"};

private _id = "";
for "_i" from 1 to _length do {
    _id = _id + ("0123456789abcdef" select[floor random 16, 1]);
};

TRACE_1(QFUNCMAIN(utilGenerateUniqueID),_id);

_id;
