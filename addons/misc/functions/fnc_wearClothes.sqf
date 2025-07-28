#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_wearClothes

Description:
    Context menu action for uniforms

Parameters:
    0: _player - Player <OBJECT>
    1: _container - Container with uniform <TYPE>
    2: _uniformClass - Uniform class <STRING>

Optional:

Example:

Returns:
    `false`

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(wearClothes),_this);

_this spawn {
    params[
        ["_player",objNull,[objNull]],
        ["_container",objNull,[objNull]],
        ["_uniformClass","",[""]]
    ];

    while { dialog } do { closeDialog 0 };

    if !EGVAR(main,AceHaveAddon) then {
        _player playActionNow "MedicOther";
    } else {
        [_player, "MedicOther"] call ace_common_fnc_doGesture;
    };

    playSound selectRandom["OMIntelGrabBody_01","OMIntelGrabBody_02","OMIntelGrabBody_03"];
    uiSleep 1.75;

    private _uc = uniform _player;
    private _temp = "B_CargoNet_01_ammo_F" createVehicleLocal(getPosATL _player vectorAdd [0,0,-50]);
    _temp enableSimulation false;

    clearBackpackCargo _temp;
    clearItemCargo _temp;
    clearMagazineCargo _temp;
    clearWeaponCargo _temp;

    [uniformContainer _player, _temp, false] call FUNCMAIN(utilContainerCargoCopy);

    playSound selectRandom["OMIntelGrabBody_01","OMIntelGrabBody_02","OMIntelGrabBody_03"];
    uiSleep 1.25;

    player forceAddUniform _uniformClass;

    playSound selectRandom["OMIntelGrabBody_01","OMIntelGrabBody_02","OMIntelGrabBody_03"];
    uiSleep 1;

    _container addItemCargo[_uc, 1];
    [_temp, uniformContainer _player] call FUNCMAIN(utilContainerCargoCopy);
    deleteVehicle _temp;
};

false;
