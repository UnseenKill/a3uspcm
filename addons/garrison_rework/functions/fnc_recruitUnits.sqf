#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_garrison_rework_fnc_recruitUnits

Description:
    Recruit/dismiss units for given location

Parameters:
    0: _location - marker name of location <STRING>
    1: _struct - structure with unit-type keys and recruitment delta <HASHMAP>

Optional:
    2: _completionKey - key to write to caller's mission namespace upon completion <STRING>

Example:

Returns:
    Nothing

Environment:
    Server, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(recruitUnits),_this);

if !assert(isServer) exitWith { ERROR_1("function ""%1"" not called on server",QFUNC(recruitUnits)) };
if !assert(canSuspend) exitWith { ERROR_1("function ""%1"" was `remoteExecCall`'ed",QFUNC(recruitUnits)) };

if !assert(params[
    ["_location", nil, [""]],
    ["_struct", nil, [createHashMap]]
]) exitWith {};

private _completionKey = param[2, nil, [""]];
private _moneyDelta = 0;
private _hrDelta = 0;
private _garrison = garrison getVariable _location;
private _garrisonLimit = [_location] call A3A_fnc_getGarrisonLimit;

try {
    if !assert(!isNil "_garrison") throw "No garrison for location";

    _garrison = +_garrison;

    _struct apply {
        private _unitType = _x;
        private _unitDelta = _y;
        private _unitName = A3A_faction_reb get _unitType;
        private _unitPrice = server getVariable _unitName;

        if !assert(!isNil "_unitName") throw format["No unit name for type ""%1""", _unitType];
        if !assert(!isNil "_unitPrice") throw format["No unit price for unit ""%1""", _unitName];

        TRACE_3(QFUNC(recruitUnits),_unitType,_unitDelta,_unitPrice);

        if (_unitDelta > 0) then {
            if ((count _garrison + _unitDelta) > _garrisonLimit) throw format["Garrison limit exceeded for location ""%1""; limit=%2", _location, _garrisonLimit];
            for "_i" from 1 to _unitDelta do {
                _garrison pushBack _unitName;
            };
        };

        if (_unitDelta < 0) then {
            for "_i" from 1 to abs(_unitDelta) do {
                private _index = _garrison find _unitName;
                if assert(_index >= 0) then {
                    _garrison deleteAt _index;
                };
            };
        };

        ADD(_moneyDelta,_unitDelta * _unitPrice);
        ADD(_hrDelta,_unitDelta);
    };

    private _hrAvail = server getVariable "hr";
    private _moneyAvail = server getVariable "resourcesFIA";

    TRACE_4(QFUNC(recruitUnits),_moneyDelta,_hrDelta,_moneyAvail,_hrAvail);
    TRACE_1(QFUNC(recruitUnits),_garrison);

    private _messages = [];

    if (_moneyDelta > _moneyAvail) then {
        _messages pushBack format["Not enough money: required=%1, available=%2", _moneyDelta, _moneyAvail];
    };
    if (_hrDelta > _hrAvail) then {
        _messages pushBack format["Not enough HR: required=%1, available=%2", _hrDelta, _hrAvail];
    };

    if (_messages isNotEqualTo []) throw format["Recruitment failed: %1", _messages joinString ", "];

    [-_hrDelta, -_moneyDelta] call A3A_fnc_resourcesFIA;
    garrison setVariable[_location, _garrison, true];

    [_location] call A3A_fnc_mrkUpdate;

    // Despawn if active garrison, then automatically respawn
	if (spawner getVariable _location isNotEqualTo 2) then {
        spawner setVariable[_location, 2];
    };

    if !(isNil "_completionKey") then {
        missionNamespace setVariable[_completionKey, true, remoteExecutedOwner];
    };
} catch {
    ERROR_2("while recruiting for ""%1"": %2",_location,_exception);

    if !(isNil "_completionKey") then {
        missionNamespace setVariable[_completionKey, _exception, remoteExecutedOwner];
    };
};

uiSleep 1.75;

nil;
