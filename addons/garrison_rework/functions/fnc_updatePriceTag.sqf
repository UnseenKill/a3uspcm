#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_updatePriceTag

Description:
    CBA_EVENT_DIALOG_UPDATE_PRICETAG event handler

Parameters:
    0: _group - Recruitment control group <CONTROL>

Optional:

Example:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
#pragma hemtt ignore_variables ["_y"]
TRACE_1(QFUNC(updatePriceTag),_this);

if !assert(params[
    ["_group", nil, [controlNull]]
]) exitWith {};
if !assert(!isNull _group) exitWith {};

private _control = _group getVariable QUIBVAR(controls) get "PriceTagTotal";

if (isNil { _group getVariable QGVAR(garrisonInfo) }) exitWith {
    _control ctrlSetText "";
};

private _garrisonInfo = _group getVariable QGVAR(garrisonInfo);
private _spend = [_garrisonInfo, 0, {
    private _price = _y get "slider" getVariable QGVAR(unitPrice);
    private _delta = (_y get "unitCountOriginal") - (_y get "unitCount");

    TRACE_3(QFUNC(updatePriceTag),_x,_price,_delta);

    _accumulator + (_price * _delta);
}] call CBA_fnc_inject;

TRACE_1(QFUNC(updatePriceTag),_spend);

if (_spend isEqualTo 0) then {
    _control ctrlSetTextColor[0.75, 0.75, 0.75, 1];
    _spend = "0";
} else {
    _control ctrlSetTextColor([[0.6, 0, 0, 1], [0, 0.6, 0, 1]] select(_spend > 0));
    _spend = format["%1", [_spend, 0, 0, true] call CBA_fnc_formatNumber];
};

_control ctrlSetText format["%1 %2", _spend, A3A_faction_civ get "currencySymbol"];

nil;
