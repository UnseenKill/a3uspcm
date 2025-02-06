#include "script_component.hpp"
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
            QGVAR(MenuSaveLoadout),
            localize LSTRING(MenuSaveLoadout),
            "",
            { [{ call FUNC(saveLoadout) }, _this] call CBA_fnc_execNextFrame },
            { true }
        ] call ace_interact_menu_fnc_createAction,
        [],
        _target
    ],
    [
        [
            QGVAR(MenuRestoreLoadout),
            localize LSTRING(MenuRestoreLoadout),
            "",
            {},
            { !(GVAR(Loadouts) isEqualType false) },
            {
                private _index = 0;
                GVAR(Loadouts) apply {
                    _index = _index + 1;

                    [
                        [
                            format["%1_%2", QGVAR(MenuRestoreLoadout), _index],
                            format["#%1 %2", _index, _x select 0],
                            "",
                            { [{ call FUNC(restoreLoadout) }, _this] call CBA_fnc_execNextFrame },
                            { true },
                            {},
                            _x
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
    ]
];
