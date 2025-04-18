#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_traderMove

Description:
    Removes current trader positon, rollbacks variables and assigns new find trader task.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(traderMove),_this);

if (disableTrader) exitWith {
    INFO("Trader is disabled.");

    [
        localize LSTRING(Trader_MoveCaption),
        localize LSTRING(Trader_HintFeatureDisabled)
    ] call A3A_fnc_customHint;
};

INFO_1("'%1' wants trader to move",name player);

if (!isNil QGVAR(Trader_MoveInProgress)) exitWith {};

[
    localize LSTRING(Trader_MoveCaption),
    localize LSTRING(Trader_HintChooseNewLocation)
] call A3A_fnc_customHint;

GVAR(Trader_PositionCandidates) = controlsX select {(!isOnRoad getMarkerPos _x) /*&& (sidesX getVariable [_x,sideUnknown] != teamPlayer)*/};
GVAR(Trader_Markers) = GVAR(Trader_PositionCandidates) apply {
    private _marker = createMarkerLocal[[] call FUNCMAIN(utilGenerateUniqueId),markerPos _x];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal "hd_unknown_noShadow";
    _marker setMarkerColorLocal "ColorOrange";
    _marker;
};

GVAR(Trader_MoveInProgress) = true;
GVAR(Trader_MoveDone) = false;
GVAR(Trader_MapSingleClickEH) = addMissionEventHandler["MapSingleClick", {
	params["_units","_pos","_alt","_shift"];
    INFO_2("new trader position: %1 (%2)",_pos,mapGridPosition _pos);

    GVAR(Trader_MoveDone) = true;
    GVAR(Trader_Position) = [GVAR(Trader_PositionCandidates), _pos] call BIS_fnc_nearestPosition;
    TRACE_1(GVAR(Trader_Position),GVAR(Trader_Position));

    openMap false;
}];

[] spawn {
    waitUntil { GVAR(Trader_MoveDone) || !visibleMap };
    removeMissionEventHandler["MapSingleClick", GVAR(Trader_MapSingleClickEH)];
    GVAR(Trader_MapSingleClickEH) = nil;
    GVAR(Trader_MoveInProgress) = nil;
    GVAR(Trader_Markers) apply { deleteMarker _x };
    GVAR(Trader_Markers) = nil;
    GVAR(Trader_PositionCandidates) = nil;

    if (!GVAR(Trader_MoveDone)) exitWith {
        INFO("Trader move aborted.");

        [
            localize LSTRING(Trader_MoveCaption),
            localize LSTRING(Trader_HintMoveAborted)
        ] call A3A_fnc_customHint;
    };

    INFO_1("Trader move done. --> %1",GVAR(Trader_Position));

    isTraderQuestAssigned = false;
    isTraderQuestCompleted = false;
    publicVariable "isTraderQuestAssigned";
    publicVariable "isTraderQuestCompleted";

    if (!isNil "traderMarker") then {
        INFO("Deleting trader markers.");

        deleteMarker "TraderMarker";
        traderMarker = nil;
        publicVariable "traderMarker";
    };

    if (!isNil "traderX") then {
        INFO("Deleting trader.");

        deleteVehicle traderX;
        publicVariable "traderX";
    };

    if (!isNil "traderObjects") then {
        INFO("Deleting trader objects.");

        {
            deleteVehicle _x;
        } forEach traderObjects;
        
        sleep 1.5;

        traderObjects = nil;
        publicVariable "traderObjects";
    };

    [[GVAR(Trader_Position)],"A3A_fnc_ENC_Trader"] remoteExec ["A3A_fnc_scheduler",2];
};

nil;
