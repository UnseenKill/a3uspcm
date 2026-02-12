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
    LLSTRING(ModuleCategory),
    "",
    {}
] call zen_context_menu_fnc_createAction, [], 29] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_FindEmplacements),
    LLSTRING(ModuleFSE_DisplayName),
    "",
    {
        params[["_position",[],[[]]]];
        [_position] call FUNC(findStaticEmplacements);
    },
    {
        nearestObjects[_this select 0, ["StaticWeapon"], FIND_STATIC_RADIUS, true] select { alive _x } isNotEqualTo [];
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_MountEmplacements),
    LLSTRING(ModuleMSE_DisplayName),
    "",
    {
        TRACE_1("Mounting static emplacements",_this);
        params["",["_units",[],[[]]]];
        [_units] call FUNC(doCrewStatic);
    },
    {
        [] isNotEqualTo (curatorSelected select 0 select {
            (alive _x) && { _x isKindOf "StaticWeapon" };
        });
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_FindGWH),
    LLSTRING(ModuleFindGWH_DisplayName),
    "",
    {
        call FUNC(findGWH);
    },
    {
        [] isNotEqualTo TEST_NOCIGS_IN_GWH(_this select 0);
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_TeleportGroup),
    LLSTRING(ModuleTeleportGroup_DisplayName),
    "",
    {
        call FUNC(teleportGroup);
    },
    { true }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_BlowupMines),
    LLSTRING(ModuleBlowupMines_DisplayName),
    "",
    {
        call FUNC(blowUpMines);
    },
    { 
        nearestMines[_this select 0, ["MineBase"], 300, false, true] select { alive _x } isNotEqualTo [];
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_ReorientObjects),
    LLSTRING(ModuleRO_DisplayName),
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
    QGVAR(zenMenu_GarageVehicles),
    LLSTRING(ModuleGarageVehicles_DisplayName),
    "",
    {
        call FUNC(garageVehicles);
    },
    {
        call FUNC(canGarageVehicles);
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

[[
    QGVAR(zenMenu_RemoveHC),
    LLSTRING(ModuleRemoveHC_DisplayName),
    "",
    {
        hcSelected theBoss apply { theBoss hcRemoveGroup _x };
    },
    {
        hcSelected theBoss isNotEqualTo [];
    }
] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;

if is3DENPreview then {
    [[
        QGVAR(zenMenu_3DENExec),
        "Exec module.sqf here",
        "",
        {
            call compile preprocessFileLineNumbers "module.sqf";
        },
        { true }
    ] call zen_context_menu_fnc_createAction, _parentPath, 0] call zen_context_menu_fnc_addAction;
};

nil;
