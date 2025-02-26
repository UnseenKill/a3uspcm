#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_doCrewStatic

Description:
    Crew vehicles with a gunner.

Parameters:
    0: _vehicles - Array of vehicles to crew

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_vehicles", [], [[]]]
];

if !assert(_vehicles isNotEqualTo []) exitWith {};

private _group = createGroup independent;
private _crewClassKey = ["crewClassName","crewClassNameAI"] select GVAR(moduleMSE_useAI);
private _crewClassType = [configFile >> QGVAR(Config) >> "moduleMSE" >> _crewClassKey, "STRING"] call CBA_fnc_getConfigEntry;

GVAR(groupsCount) = GVAR(groupsCount) + 1;

private _groupName = format["%1 %2-%3",
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupName", "STRING"] call CBA_fnc_getConfigEntry,
    [configFile >> QGVAR(Config) >> "moduleMSE" >> "groupPrefix", "NUMBER"] call CBA_fnc_getConfigEntry,
    GVAR(groupsCount)];

TRACE_1(QFUNC(doCrewStatic),_groupName);
_group setGroupIdGlobal[_groupName];

_vehicles apply {
    crew _x apply {
        _x allowDamage false;
        moveOut _x;
        _x spawn {
            uiSleep 3.5;
            _this allowDamage true;
        };
    };

    [_group, _x, _crewClassType] spawn {
        uiSleep 0.5;
        params["_group","_vehicle","_type"];
        private _unit = _group createUnit[_type, getPosATL _vehicle, [], 0, "NONE"];
        
        _unit moveInGunner _vehicle;
        _unit setSkill 1;
        _vehicle setVariable[QGVAR(crewed), true, true];

        TRACE_2("Crewed static",_vehicle,_unit);

        allCurators apply {
            _x addCuratorEditableObjects[[_vehicle], true];
        };
    };
};

_group addEventHandler["EnemyDetected", {
    params[["_group",grpNull,[grpNull]],["_enemy",objNull,[objNull]]];

    if (_enemy getVariable[QGVAR(mseDetected), false] isNotEqualTo false) exitWith {};
    _enemy setVariable[QGVAR(mseDetected), createHashMap];

    leader _group sideChat format[
        localize LSTRING(ModuleMSE_Message_EnemyDetected), 
        DISPLAY_NAME_UNIT(_enemy), 
        mapGridPosition getPosATL _enemy, 
        abs((leader _group distance _enemy) / 1000) toFixed 1, 
        getDir _enemy toFixed 1, speed _enemy toFixed 1
    ];

    INFO_2("'%1' detected enemy '%2'",_group,_enemy);

    _enemy addEventHandler["IncomingMissile", {
        params[["_unit",objNull,[objNull]], ["_ammo","",[""]], ["_vehicle",objNull,[objNull]], ["_instigator",objNull,[objNull]]];

        TRACE_4("Incoming missile",_unit,_ammo,_vehicle,_instigator);

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

                _sender sideChat format[localize LSTRING(ModuleMSE_Message_EnemyFiredAt), _missile, DISPLAY_NAME_UNIT(_unit)];
            };
        };
    }];
}];

if !(GVAR(moduleMSE_useAI)) then {
    [_group] spawn {
        if !assert(params[["_group",grpNull,[grpNull]]]) exitWith {};
        if !assert(!isNull _group) exitWith {};

        uiSleep 5;

        INFO_2("transferring group %1 to HC (theBoss=%2)",_group,theBoss);
        theBoss hcSetGroup[_group];
        _group setCombatBehaviour "COMBAT";
        _group setCombatMode "RED";
    };
};

nil;
