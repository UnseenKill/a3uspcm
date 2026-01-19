#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_compat_rf_fnc_rsg60DumpAllAmmo

Description:
    Dump all ammo from RSG-60 mortar into player's backpack/ground

Parameters:
    0: _target - RSG60 object <OBJECT>
    1: _caller - Usually the player <OBJECT>
    2: _actionID - ID of the action being called <NUMBER>
    3: _arguments - Additional arguments <ARRAY>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(rsg60DumpAllAmmo),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_caller", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _target) exitWith {};
if !assert(!isNull _caller) exitWith {};

private _dumps = [];
private _time = 0;
private _lastMagazineName = "";
private _lastMagazineCount = 0;
private _unloadTime = getNumber(configOf _target >> "ace_csw" >> "ammoUnloadTime");
private _realToFakeMap = createHashMapFromArray(getArray(configOf _target >> QGVAR(magazines)) apply {
    [_x select 1, _x select 0]
});

magazinesAmmo _target apply {
    _x params["_magazineName","_magazineCount"];
    private _config = configFile >> "CfgMagazines" >> _magazineName;
    private _count = getNumber(_config >> "count");

    TRACE_3(QFUNC(rsg60DumpAllAmmo),_time,_magazineName,_magazineCount);

    _dumps pushBack[
        _time, getText(_config >> "displayName"), _lastMagazineName, _lastMagazineCount
    ];
    _lastMagazineName = _magazineName;
    _lastMagazineCount = _magazineCount;

    _time = _time + (_unloadTime * (_magazineCount / _count));
};

_dumps pushBack[_time - 0.1, "", _lastMagazineName, _lastMagazineCount];

// This, so we can show our own progress info text
private _oldInfo = ace_common_progressBarInfo;
ace_common_progressBarInfo = 0;

[
    _time,
    [0, _dumps, _oldInfo, _realToFakeMap, _target, _caller, objNull],
    { ace_common_progressBarInfo = (_this select 0 select 2) },
    { ace_common_progressBarInfo = (_this select 0 select 2) },
    "",
    {
        params["_args", "_elapsedTime", "_totalTime", "_errorCode"];
        _args params["_index","_dumps","","_realToFakeMap","_target","_caller","_gwh"];

        if (_elapsedTime >= (_dumps select _index select 0)) then {
            _dumps select _index params["", "_magazineDisplayName", "_magazineName", "_magazineCount"];

            playSound "ace_magazinerepack_soundRoundFinished";

            if (_magazineDisplayName isNotEqualTo "") then {
                (uiNamespace getVariable "ace_common_ctrlProgressBarTitle") ctrlSetText format[LLSTRING(RSG60_Dumping_Info), _magazineDisplayName];
            };

            if (_magazineName isNotEqualTo "") then {
                private _fakeMagazineName = _realToFakeMap getOrDefault[_magazineName, ""];

                TRACE_4(QFUNC(rsg60DumpAllAmmo),_elapsedTime,_fakeMagazineName,_magazineName,_magazineCount);

                if (_fakeMagazineName isNotEqualTo "") then {
                    playSound "ace_magazinerepack_soundMagazineFinished";
                    _target removeMagazineTurret[_magazineName, _target unitTurret _caller];

                    private _container = switch true do {
                        case (_caller canAddItemToBackpack _fakeMagazineName): { backpackContainer _caller };
                        case (isNull _gwh): {
                            _gwh = [] call FUNCMAIN(utilFindClosestGWH);
                            TRACE_1(QFUNC(rsg60DumpAllAmmo),_gwh);
                            _args set[6, _gwh];
                            _gwh;
                        };
                        default { _gwh };
                    };
                    _container addMagazineAmmoCargo[_fakeMagazineName, 1, _magazineCount];
                };
            };

            _args set[0, (_args#0) + 1];
        };

        true;
    },
    ["isNotInside"]
] call ace_common_fnc_progressBar;

nil;
