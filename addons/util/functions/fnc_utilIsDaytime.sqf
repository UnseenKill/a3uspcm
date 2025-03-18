#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilIsDaytime

Description:
    Measuring ambient brightness to determine if it is daytime or nighttime.

Parameters:

Optional:

Example:
    (begin example)
    private _isDay = [] call A3USPCM_fnc_utilIsDaytime;
    (end example)

Returns:
    Whether it's day or not <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[["_cacheTtl",30,[0]]];

private _data = localNamespace getVariable[QGVAR(IsDayTime), false];
private _haveCached = false;
private _isItDaytime = false;

if (_data isNotEqualTo false) then {
    _data params["_stamp","_result"];

    if (_stamp + _cacheTtl > diag_tickTime) then {
        _haveCached = true;
        _isItDaytime = _result;
    }
};

if !_haveCached then {
    _isItDaytime = if (1 != sunOrMoon) then {
        false;
    } else {
        getLighting params["","_brightness"];
        _brightness >= 30;
    };

    localNamespace setVariable[QGVAR(IsDayTime), [diag_tickTime, _isItDaytime]];
};

_isItDaytime;
