#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_zeus_fnc_updateZenMenu

Description:
    Add module calls to Zen context menu.

Parameters:

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if !isClass(configFile >> "CfgPatches" >> "zen_context_menu") exitWith {};
if !GVAR(enhanceZenContextMenu) exitWith { INFO("zen context menu enhancements disabled") };

private _parentPath = [[
    QGVAR(zenMainMenu),
    localize LSTRING(ModuleCategory),
    "",
    {}
] call zen_context_menu_fnc_createAction, [], 29] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_FindEmplacements),
    localize LSTRING(ModuleFSE_DisplayName),
    "",
    {
        params[["_position",[],[[]]]];
        [_position] call FUNC(findStaticEmplacements);
    },
    {
        [] isEqualTo (curatorSelected select 0 select {
            _x isKindOf "StaticWeapon";
        });
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_MountEmplacements),
    localize LSTRING(ModuleMSE_DisplayName),
    "",
    {
        TRACE_1("Mounting static emplacements",_this);
        params["",["_units",[],[[]]]];
        [_units] call FUNC(doCrewStatic);
    },
    {
        [] isNotEqualTo (curatorSelected select 0 select {
            _x isKindOf "StaticWeapon";
        });
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_TeleportGroup),
    localize LSTRING(ModuleTeleportGroup_DisplayName),
    "",
    {
        call FUNC(teleportGroup);
    },
    { true }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_ReorientObjects),
    localize LSTRING(ModuleRO_DisplayName),
    "",
    {
        params["",["_units",[],[[]]]];
        _units apply { _x setVectorUp[0,0,1] };
    },
    {
        curatorSelected select 0 isNotEqualTo [];
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_RemoveHC),
    localize LSTRING(ModuleRemoveHC_DisplayName),
    "",
    {
        hcSelected theBoss apply { theBoss hcRemoveGroup _x };
    },
    {
        hcSelected theBoss isNotEqualTo [];
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

nil;
