#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_initReportHandler

Description:
    Initialize feedback handler for enemy detection and outgoing missiles

Parameters:
    0: _group - AA group <OBJECT>

Optional:

Example:

Returns:
    Nothing

Scope:
    Server, Unscheduled

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !assert(params[
    ["_group", nil, [grpNull]]
]) exitWith {};
if !assert(!isNull _group) exitWith {};

_group addEventHandler["EnemyDetected", {
    params[
        ["_group", nil, [grpNull]],
        ["_enemy", nil, [objNull]]
    ];

    INFO_3("'%1' detected enemy '%2' (isAir=%3)",_group,_enemy,_enemy isKindOf "Air");

    if (GVAR(reportAirOnly) && !(_enemy isKindOf "Air")) exitWith {};

    if (!isNil { _enemy getVariable QGVAR(mseDetected) }) exitWith {};
    _enemy setVariable[QGVAR(mseDetected), createHashMap];

    CBA_EVENT_LOCAL(CBA_EVENT_AAFC_START_CONTACT_TRACK,[_enemy]);

    if GVAR(sideChatContact) then {
        private _message = format[
            LLSTRING(Message_EnemyDetected), 
            DISPLAY_NAME_UNIT(_enemy), 
            mapGridPosition getPosATL _enemy, 
            abs((leader _group distance _enemy) / 1000) toFixed 1, 
            getDir _enemy toFixed 1, speed _enemy toFixed 1
        ];
        CBA_EVENT_REMOTE(CBA_EVENT_AAFC_SIDECHAT,[ARR_2(leader _group,_message)]);
    };

    if GVAR(playContactSound) then {
        playSound QEGVAR(assets,AafcContact);
    };

    player reveal _enemy;

    _enemy addEventHandler["IncomingMissile", {
        params["_unit","_ammo","_vehicle","_instigator","_projectile"];

        TRACE_5("Incoming missile",_unit,_ammo,_vehicle,_instigator,_projectile);

        if isNil("_projectile") exitWith {};
        if isNil("_vehicle") exitWith {};

        if !(_vehicle isEqualType objNull) exitWith { WARNING_1("Vehicle '%1' is not an object",_vehicle) };
        if isNull(_projectile) exitWith {};
        if isNull(_vehicle) exitWith {};

        [_vehicle] call FUNC(reloadCheck);

        if !GVAR(sideChatFired) exitWith {};

        private _key = hashValue _projectile;

        if (_key in (_unit getVariable QGVAR(mseDetected))) exitWith { TRACE_1("Ignoring duplicate missile report",_projectile) };
        _unit getVariable QGVAR(mseDetected) set[_key, true];

        private _sender = _instigator;

        if (isNull _sender) then {
            _sender = gunner _vehicle;
        };

        if (isNull _sender) then {
            WARNING_2("No sender for incoming missile (veh=%1,instigator=%2)",_vehicle,_instigator);
        } else {
            private _missile = if isClass(configFile >> "CfgMagazines" >> _ammo) then {
                DISPLAY_NAME_CLASS(CfgMagazines,_ammo);
            } else {
                if isClass(configFile >> "CfgWeapons" >> _ammo) then {
                    DISPLAY_NAME_CLASS(CfgWeapons,_ammo);
                } else {
                    _ammo;
                };
            };

            _sender sideChat format[LLSTRING(Message_EnemyFiredAt), _missile, DISPLAY_NAME_UNIT(_unit)];
        };
    }];
}];

nil;
