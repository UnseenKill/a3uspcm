#include "script_component.hpp"
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

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {};

_group addEventHandler["EnemyDetected", {
    params[["_group",grpNull,[grpNull]],["_enemy",objNull,[objNull]]];

    if (_enemy getVariable[QGVAR(mseDetected), false] isNotEqualTo false) exitWith {};
    _enemy setVariable[QGVAR(mseDetected), createHashMap];

    if GVAR(sideChatContact) then {
        leader _group sideChat format[
            localize LSTRING(Message_EnemyDetected), 
            DISPLAY_NAME_UNIT(_enemy), 
            mapGridPosition getPosATL _enemy, 
            abs((leader _group distance _enemy) / 1000) toFixed 1, 
            getDir _enemy toFixed 1, speed _enemy toFixed 1
        ];
    };

    INFO_2("'%1' detected enemy '%2'",_group,_enemy);

    _enemy addEventHandler["IncomingMissile", {
        params[["_unit",objNull,[objNull]], ["_ammo","",[""]], ["_vehicle",objNull,[objNull]], ["_instigator",objNull,[objNull]]];

        TRACE_4("Incoming missile",_unit,_ammo,_vehicle,_instigator);

        if !GVAR(sideChatFired) exitWith {};

        private _sender = _instigator;

        if (isNull _sender) then {
            _sender = gunner _vehicle;
        };

        if (isNull _sender) then {
            WARNING_2("No sender for incoming missile (veh=%1,instigator=%2)",_vehicle,_instigator);
        } else {
            private _key = hashValue _sender;
            private _nextReport = _unit getVariable QGVAR(mseDetected) getOrDefault[_key, 0];

            if (_nextReport > diag_tickTime) then {
                TRACE_3("Ignoring missile report",_sender,_nextReport,diag_tickTime);
            } else {
                _unit getVariable QGVAR(mseDetected) set[_key, diag_tickTime + (CREW_FIRE_REPORT_INTERVAL_MS / 1000)];

                private _missile = if isClass(configFile >> "CfgMagazines" >> _ammo) then {
                    DISPLAY_NAME_CLASS(CfgMagazines,_ammo);
                } else {
                    if isClass(configFile >> "CfgWeapons" >> _ammo) then {
                        DISPLAY_NAME_CLASS(CfgWeapons,_ammo);
                    } else {
                        _ammo;
                    };
                };

                _sender sideChat format[localize LSTRING(Message_EnemyFiredAt), _missile, DISPLAY_NAME_UNIT(_unit)];
            };
        };
    }];
}];

nil;
