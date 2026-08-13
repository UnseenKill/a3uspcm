#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletTargetsOnContactUpdate

Description:
    CBA_EVENT_AAFC_CONTACT_UPDATE event handler

Parameters:
    0: _unit - Reported contact unit to update <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletTargetsOnContactUpdate),_this);

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private _contactKey = _unit getVariable QGVAR(contactKey);
if (isNil "_contactKey") exitWith {
    [_unit] spawn {
        params[["_unit", objNull, [objNull]]];

        private _timeout = diag_tickTime + 5;
        waitUntil {
            uiSleep 0.1;
            (!isNull _unit && { !isNil { _unit getVariable QGVAR(contactKey) } }) || { diag_tickTime > _timeout }
        };

        private _contactKey = _unit getVariable QGVAR(contactKey);
        if !assert(!isNil "_contactKey") exitWith {};

        _timeout = diag_tickTime + 1;
        waitUntil {
            uiSleep 0.1;
            (!isNil { GVAR(contacts) get _contactKey }) || { diag_tickTime > _timeout }
        };

        [_contactKey] call FUNC(tabletTargetsUpdateContact);
    };
};

if (isNil { GVAR(contacts) get _contactKey }) exitWith {
    [_contactKey] spawn {
        params[["_contactKey", nil, [""]]];

        private _timeout = diag_tickTime + 1;
        waitUntil {
            uiSleep 0.1;
            (!isNil { GVAR(contacts) get _contactKey }) || { diag_tickTime > _timeout }
        };

        [_contactKey] call FUNC(tabletTargetsUpdateContact);
    };
};

if !(alive _unit) exitWith {
    [_contactKey] spawn {
        params[["_contactKey", nil, [""]]];

        private _timeout = diag_tickTime + 1;
        waitUntil {
            uiSleep 0.1;
            (isNil { GVAR(contacts) get _contactKey }) || { diag_tickTime > _timeout }
        };

        [_contactKey] call FUNC(tabletTargetsUpdateContact);
    };
};

[_contactKey] spawn FUNC(tabletTargetsUpdateContact);

nil;
