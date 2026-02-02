#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_assets_fnc_arsenalHelperOpenVehicleInventory

Description:
    BECAUSE STUPID PEOPLE KEEP PUTTING BOOKS WORTH OF CODE INTO CALLBACKS WE
    HAVE TO COPY/PASTE THE WHOLE "OPEN VEHICLE INVENTORY" CALLBACK HERE.

Parameters:
    0: _object - Arsenal helper sign <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(arsenalHelperOpenVehicleInventory),_this);

private _object = _this select 0;

private _script =  {
    params ["_object"];

    //check if player is looking at some object
    private _objectSelected = cursorObject;
    if(isNull _objectSelected)exitWith{hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR1"; };

    //check if object is in range
    if(_object distance cursorObject > 50) exitWith {hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR2";};

    //check if object has inventory
    private _className = typeOf _objectSelected;
    private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
    private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
    private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
    if !(_tb > 0  || _tm > 0 || _tw > 0) exitWith{hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR3";};

    //set type and object to use later
    uiNamespace setVariable ["jn_type", "containerArsenal"];
    uiNamespace setVariable ["jn_object",_object];
    uiNamespace setVariable ["jn_object_selected",_objectSelected];

    //start loading screen and timer to close it if something breaks
    ["jn_fnc_arsenal", "Loading Nutz™ Arsenal"] call bis_fnc_startloadingscreen;
    [] spawn {
        uiSleep 5;
        private _ids = missionNamespace getVariable["BIS_fnc_startLoadingScreen_ids",[]];
        if("jn_fnc_arsenal" in _ids)then{
            private _display =  uiNamespace getVariable["arsenalDisplay","No display"];
            titleText["ERROR DURING LOADING ARSENAL", "PLAIN"];
            _display closeDisplay 2;
            ["jn_fnc_arsenal"] call BIS_fnc_endLoadingScreen;
        };
    };

    //request server to open arsenal
    [clientOwner] remoteExecCall ["jn_fnc_arsenal_requestOpen",2];
};
private _conditionActive = {
    params ["_object"];
    alive player;
};
private _conditionColor = {
    params ["_object"];

    !isNull cursorObject
    &&{
        _object distance cursorObject < 10;
    }&&{
        //check if object has inventory
        private _className = typeOf cursorObject;
        private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
        private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
        private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");

        (_tb > 0  || _tm > 0 || _tw > 0);
    }//return
};

[localize "STR_A3AP_vehArsenal_header", localize "STR_A3AP_vehArsenal_desc"] call A3A_fnc_customHint;

[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;

nil;
