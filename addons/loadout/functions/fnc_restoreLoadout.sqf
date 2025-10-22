#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_restoreLoadout

Description:
    ACE action to restore a saved loadout

Parameters:
    0: _vehicle - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>
    2: _loadout - Loadout to restore <ARRAY>

Optional:
    3: _client - Client invoking the function <NUMBER>

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(restoreLoadout),_this);

params[
    ["_vehicle", objNull, [objNull]],
    ["_player", objNull, [objNull]],
    ["_loadout", [], [[]]],
    ["_client", 2, [0]]
];

if !assert(!isNull _vehicle) exitWith {};
if !assert(!isNull _player) exitWith {};
if !assert(_loadout isNotEqualTo []) exitWith {};

if (!isServer && hasInterface) exitWith {
    [_vehicle, _player, _loadout, clientOwner] remoteExec[QFUNC(restoreLoadout), 2];
};

INFO_3("apply loadout %1 to vehicle %2 (player=%3)",_loadout select 0,typeOf _vehicle,name _player);

private _serialized = [_vehicle] call FUNC(serializeLoadout);
private _continue = try {
    if (_serialized isEqualType []) then {
        private _timeout = _vehicle getVariable[QGVAR(Timeout), 0];

        if (_timeout < diag_tickTime) then {
            [
                localize LSTRING(HintLoadoutRestoreCaption),
                format[localize LSTRING(HintLoadoutForceLoadoutText), FORCE_LOADOUT_TIMEOUT]
            ] remoteExec["A3A_fnc_customHint", _client];

            _vehicle setVariable[QGVAR(Timeout), diag_tickTime + FORCE_LOADOUT_TIMEOUT];
            throw "stop";
        };

        _vehicle setVariable[QGVAR(Timeout), nil];
    };

    true;
} catch {
    "A3AP_UiFailure" remoteExec["playSound", _client];
    false;
};

if !_continue exitWith {};

_loadout params["_title","_aceCargo","_inventory",["_turretsMagsInfo",false],["_cargoSpace",false],["_turretWeapons",false],["_maxLoad",false]];
_inventory params["_backpacks","_weapons","_magazines","_items"];

TRACE_1("_title",_title);
TRACE_1("_aceCargo",_aceCargo);
TRACE_1("_backpacks",_backpacks);
TRACE_1("_weapons",_weapons);
TRACE_1("_magazines",_magazines);
TRACE_1("_items",_items);

private _error = try {
    if !([_vehicle, objNull, GVAR(unloadWheels)] call FUNCMAIN(utilAceCargoUnload)) then { throw LSTRING(HintLoadoutErrorAceUnload) };
    if !([_vehicle, _player, _aceCargo] call FUNCMAIN(utilAceCargoLoad)) then { throw LSTRING(HintLoadoutErrorAceLoad) };
} catch {
    if (_exception isEqualType []) then {
        _exception select 0;
    } else {
        localize _exception;
    };
};

if !(isNil "_error") exitWith {
    [localize LSTRING(HintLoadoutRestoreCaption), _error] remoteExec["A3A_fnc_customHint", _client];
};

clearBackpackCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

if (_maxLoad isNotEqualTo false) then {
    TRACE_2("setting max load",_vehicle,_maxLoad);
    _vehicle setMaxLoad _maxLoad;
};


private _messages = [];
private _actions = [
    ["backpack", _backpacks, configFile >> "CfgVehicles", { params["_vehicle","_item","_count"]; _vehicle addBackpackCargoGlobal[_item,_count]; }],
    ["magazine", _magazines, configFile >> "CfgMagazines", { params["_vehicle","_item","_count"]; _vehicle addMagazineCargoGlobal[_item,_count]; }],
    ["item", _items, configFile >> "CfgWeapons", { params["_vehicle","_item","_count"]; _vehicle addItemCargoGlobal[_item,_count]; }]
];

// backwards compatibility for old loadouts
if (_weapons select 0 isNotEqualTo "0xdeadbeef") then {
    _actions = [
        ["weapon", _weapons, configFile >> "CfgWeapons", { params["_vehicle","_item","_count"]; _vehicle addWeaponCargoGlobal[_item,_count]; }]
    ] + _actions;
} else {
    private _missing = [];
    private _checkItem = {
        params["_item","_config"];

        if (_item isEqualTo "") exitWith { _item };

        private _index = _item call jn_fnc_arsenal_itemType;
        private _arsenal = jna_datalist select _index;
        private _count = [_arsenal, _item] call jn_fnc_arsenal_itemCount;

        if (_count < 0) exitWith { _item };
        if (_count == 0) exitWith {
            _missing pushBack getText(_config >> _item >> "displayName");
            "";
        };

        [_index, _item, 1] call jn_fnc_arsenal_removeItem;
        _item;
    };

    _weapons select 1 apply {
        _x params["_weapon","_muzzle","_flashlite","_scope","_magPrimary","_magSecondary","_bipod"];

        if ([_weapon, configFile >> "CfgWeapons"] call _checkItem isEqualTo _weapon) then {
            _muzzle = [_muzzle, configFile >> "CfgWeapons"] call _checkItem;
            _flashlite = [_flashlite, configFile >> "CfgWeapons"] call _checkItem;
            _scope = [_scope, configFile >> "CfgWeapons"] call _checkItem;
            _bipod = [_bipod, configFile >> "CfgWeapons"] call _checkItem;

            if (_magPrimary isNotEqualTo []) then {
                if ([_magPrimary select 0, configFile >> "CfgMagazines"] call _checkItem isEqualTo "") then {
                    _magPrimary = [];
                };
            };

            if (_magSecondary isNotEqualTo []) then {
                if ([_magSecondary select 0, configFile >> "CfgMagazines"] call _checkItem isEqualTo "") then {
                    _magSecondary = [];
                };
            };

            _vehicle addWeaponWithAttachmentsCargoGlobal[[_weapon, _muzzle, _flashlite, _scope, _magPrimary, _magSecondary, _bipod], 1];
        };
    };

    _missing apply {
        _messages pushBack format[localize LSTRING(HintLoadoutItemMissingText), _x];
    };
};

{
    _x params["_type","_items","_baseConfig","_callback"];

    {
        private _index = _x call jn_fnc_arsenal_itemType;
        private _arsenal = jna_datalist select _index;
        private _count = [_arsenal, _x] call jn_fnc_arsenal_itemCount;

        TRACE_3(_type,_index,_x,_count);

        if (_count < 0) then {
            [_vehicle, _x, _y] call _callback;
        } else {
            private _displayName = [_baseConfig >> _x >> "displayName", "STRING", _x] call CBA_fnc_getConfigEntry;

            if (_count == 0) then {
                _messages pushBack format[localize LSTRING(HintLoadoutItemMissingText), _displayName];
            } else {
                if (_y > _count) then {
                    _messages pushBack format[localize LSTRING(HintLoadoutItemExcessText), _displayName, _y - _count];
                    _y = _count;
                };

                if !(_vehicle canAdd[_x, _y]) then {
                    _messages pushBack format[localize LSTRING(HintLoadoutItemNoSpaceText), _displayName, _y];
                } else {
                    [_vehicle, _x, _y] call _callback;
                    [_index, _x, _y] call jn_fnc_arsenal_removeItem;
                };
            };
        };
    } forEach ((_items # 0) createHashMapFromArray (_items # 1));
} forEach _actions;

if (_turretsMagsInfo isNotEqualTo false) then {
    TRACE_1("trying to apply turret magazines",_turretsMagsInfo);

    _turretsMagsInfo params["_vehicleClass","_turretsMags"];

    if !(_vehicle isKindOf _vehicleClass) then {
        INFO_2("vehicle %1 is not of class %2; skipping turret mags",typeOf _vehicle,_vehicleClass);
    } else {
        private _current = magazinesAllTurrets _vehicle;

        _current apply {
            _vehicle removeMagazineTurret[_x # 0, _x # 1];
        };

        _turretsMags apply {
            _vehicle addMagazineTurret[_x # 0, _x # 1, _x # 2];
        };
    };
};

if (EGVAR(main,AceHaveAddon) && { _cargoSpace isNotEqualTo false }) then {
    TRACE_1("setting cargo space",_cargoSpace);
    [_vehicle, _cargoSpace] call ace_cargo_fnc_setSpace;
};

if (_turretWeapons isNotEqualTo false) then {
    TRACE_1("restoring weapons turrets",_turretWeapons);
    _turretWeapons params["_vehicleClass","_turrets","_weapons"];

    if !(_vehicle isKindOf _vehicleClass) then {
        INFO_2("vehicle %1 is not of class %2; skipping turret weapons",typeOf _vehicle,_vehicleClass);
    } else {
        private _modded = [];

        {
            private _path = _x;

            _vehicle weaponsTurret _path apply {
                _vehicle removeWeaponTurret[_x, _path];
            };

            _weapons select _foreachIndex apply {
                _vehicle addWeaponTurret[_x, _path];
            };

            _modded pushBack _path;
        } forEach _turrets;

        _vehicle setVariable[QGVAR(moddedTurrets), _modded, true];
    };
};

private _message = [LSTRING(HintLoadoutRestoredPartialText), LSTRING(HintLoadoutRestoredText)] select (_messages isEqualTo []);

[
    localize LSTRING(HintLoadoutRestoreCaption),
    format[localize _message, _title, getText(configOf _vehicle >> "displayName")]
] remoteExec["A3A_fnc_customHint", _client];

(["A3AP_UiFailure","A3AP_UiSuccess"] select (_messages isEqualTo [])) remoteExec["playSound", _client];

_messages apply { _x remoteExec["systemChat", _client] };

nil;
