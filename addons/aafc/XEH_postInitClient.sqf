#include "script_component.hpp"

[CBA_EVENT_AAFC_CONTACT_UPDATE, {
    if !assert(params[
        ["_contact", nil, [objNull]]
    ]) exitWith {};
    if !assert(!isNull _contact) exitWith {};

    player reveal _contact;
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_RADAR_STROBE, { call FUNC(radarStrobeLight) }] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SIDECHAT, {
    if !assert(params[
        ["_sender", nil, [objNull]],
        ["_message", nil, [""]]
    ]) exitWith {};
    if !assert(!isNull _sender) exitWith {};

    _sender sideChat _message;
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SIDECHAT_CONTACT, {
    if !assert(params[
        ["_sender", nil, [objNull]],
        ["_message", nil, [""]]
    ]) exitWith {};
    if !assert(!isNull _sender) exitWith {};

    if GVAR(sideChatContact) then {
        _sender sideChat _message;
    };

    if GVAR(playContactSound) then {
        playSound QEGVAR(assets,AafcContact);
    };
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_SIDECHAT_FIRED, {
    if !assert(params[
        ["_sender", nil, [objNull]],
        ["_message", nil, [""]]
    ]) exitWith {};
    if !assert(!isNull _sender) exitWith {};
    if !GVAR(sideChatFired) exitWith {};
    _sender sideChat _message;
}] call CBA_fnc_addEventHandler;

[CBA_EVENT_AAFC_UPDATE_GROUP, {
    if !assert(params[
        ["_group", nil, [grpNull]]
    ]) exitWith {};

    units _group apply { objectParent _x } select { !isNull _x } apply {
        _group getVariable QGVAR(vehicles) pushBackUnique _x;

        if !(_x in assignedVehicles _group) then {
            _group addVehicle _x;
        };
    };
}] call CBA_fnc_addEventHandler;

nil;
