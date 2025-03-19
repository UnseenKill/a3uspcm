#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_Loadout_fnc_getLoadoutMenuChildren

Description:
    Get vehicle loadout menu children for ACE interaction w/ vehicles

Parameters:
    0: _target - Target vehicle <OBJECT>
    1: _player - Player <OBJECT>

Optional:

Example:
    (begin example)
    [vehicle player, player] call A3USPCM_Loadout_fnc_getLoadoutMenuChildren;
    (end)

Returns:
    Actions <ARRAY>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_target", objNull, [objNull]],
    ["_player", objNull, [objNull]]
];

if !assert(!isNull _target) exitWith { [] };
if !assert(!isNull _player) exitWith { [] };

[
    [
        [
            QGVAR(MenuLoadoutManage),
            localize LSTRING(MenuLoadoutManage),
            "",
            {},
            { !(GVAR(Loadouts) isEqualType false) },
            {
                private _index = 0;

                GVAR(Loadouts) apply {
                    private _loadout = _x;
                    _index = _index + 1;

                    [
                        [
                            format["%1_%2", QGVAR(MenuLoadoutManage), _index],
                            format["#%1 %2", _index, _loadout select 0],
                            "",
                            { 
                                params["_target","_player","_parameters"];
                                _parameters params["_loadout",""];
                                [{ call FUNC(restoreLoadout) }, [_target, _player, _loadout]] call CBA_fnc_execNextFrame;
                            },
                            { true },
                            {
                                params["_target","","_parameters"];
                                _parameters params["_loadout","_index"];
                                
                                [
                                    [
                                        [
                                            format["%1_%2_apply", QGVAR(MenuLoadoutManage), _index],
                                            localize LSTRING(MenuLoadoutApply),
                                            "",
                                            { [{ call FUNC(restoreLoadout) }, _this] call CBA_fnc_execNextFrame },
                                            { true },
                                            {},
                                            _loadout
                                        ] call ace_interact_menu_fnc_createAction,
                                        [],
                                        _target
                                    ],
                                    [
                                        [
                                            format["%1_%2_rename", QGVAR(MenuLoadoutManage), _index],
                                            localize LSTRING(MenuLoadoutRename),
                                            QPATHTOEF(assets,ui\loadout-edit.paa),
                                            { [{ call FUNC(renameLoadout) }, _this] call CBA_fnc_execNextFrame },
                                            { true },
                                            {},
                                            _index - 1
                                        ] call ace_interact_menu_fnc_createAction,
                                        [],
                                        _target
                                    ],
                                    [
                                        [
                                            format["%1_%2_overwrite", QGVAR(MenuLoadoutManage), _index],
                                            localize LSTRING(MenuLoadoutOverwrite),
                                            QPATHTOEF(assets,ui\loadout-save.paa),
                                            { [{ call FUNC(overwriteLoadout) }, _this] call CBA_fnc_execNextFrame },
                                            { [_this select 0] call FUNCMAIN(utilVehicleHasCargo) },
                                            {},
                                            _index - 1
                                        ] call ace_interact_menu_fnc_createAction,
                                        [],
                                        _target
                                    ],
                                    [
                                        [
                                            format["%1_%2_delete", QGVAR(MenuLoadoutManage), _index],
                                            localize LSTRING(MenuLoadoutDelete),
                                            QPATHTOEF(assets,ui\loadout-delete.paa),
                                            { [{ call FUNC(deleteLoadout) }, _this] call CBA_fnc_execNextFrame },
                                            { true },
                                            {},
                                            _index - 1
                                        ] call ace_interact_menu_fnc_createAction,
                                        [],
                                        _target
                                    ],
                                    [
                                        [
                                            format["%1_%2_dump", QGVAR(MenuLoadoutManage), _index],
                                            localize LSTRING(MenuLoadoutDump),
                                            "",
                                            { [{ call FUNC(dumpLoadout) }, _this] call CBA_fnc_execNextFrame },
                                            { true },
                                            {},
                                            _index - 1
                                        ] call ace_interact_menu_fnc_createAction,
                                        [],
                                        _target
                                    ]
                                ]
                            },
                            [_loadout, _index]
                        ] call ace_interact_menu_fnc_createAction,
                        [],
                        _target
                    ]
                };
            }
        ] call ace_interact_menu_fnc_createAction,
        [],
        _target
    ],
    [
        [
            QGVAR(MenuLoadConfig),
            localize LSTRING(MenuConfigLoadout),
            "",
            { [{ [] call FUNC(getLoadouts) }, _this] call CBA_fnc_execNextFrame },
            { GVAR(Loadouts) isEqualType false }
        ] call ace_interact_menu_fnc_createAction,
        [],
        _target
    ],
    [
        [
            QGVAR(MenuLoadoutSave),
            localize LSTRING(MenuLoadoutSave),
            QPATHTOEF(assets,ui\loadout-save.paa),
            { [{ call FUNC(saveLoadout) }, _this] call CBA_fnc_execNextFrame },
            { call FUNCMAIN(utilVehicleHasCargo) }
        ] call ace_interact_menu_fnc_createAction,
        [],
        _target
    ],
    [
        [
            QGVAR(MenuLoadoutCargoSpace),
            localize LSTRING(MenuLoadoutCargoSpace),
            QPATHTOEF(assets,ui\loadout-edit.paa),
            { [{ call FUNC(changeCargoSpace) }, _this] call CBA_fnc_execNextFrame },
            { true }
        ] call ace_interact_menu_fnc_createAction,
        [],
        _target
    ]
];
