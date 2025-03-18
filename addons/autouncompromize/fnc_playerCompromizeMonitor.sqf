#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_autouncompromize_fnc_playerCompromizeMonitor

Description:
    Monitors player's compromise level and triggers escape zone

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_2(QFUNC(playerCompromizeMonitor),_this,isServer);

if !isServer exitWith {};
if (GVAR(escapeZoneRadius) <= 0) exitWith { INFO("auto-uncompromize feature deactivated") };

while { alive player } do {
    INFO_1("player '%1' compromize monitor loop beginning",name player);
    waitUntil { uiSleep 1; (!alive player) || (player getVariable["compromised", 0] > 0) };

    if (!alive player) then { uiSleep 30; continue };

    private _var = player getVariable["compromised", 0];
    INFO_2("player '%1' compromized until %2",name player,_var);

    if (_var < 1) then { uiSleep 10; continue };

    private _trigger = createTrigger["EmptyDetector", getPos player];
    _trigger setTriggerArea[GVAR(escapeZoneRadius), GVAR(escapeZoneRadius), 0, false];
    _trigger setTriggerActivation["ANYPLAYER", "NOT PRESENT", true];
    _trigger setTriggerStatements[
        "this",
        format["[thisTrigger,thisList] call %1", QFUNC(escapeZoneTriggerOn)],
        format["[thisTrigger] call %1", QFUNC(escapeZoneTriggerOff)]
    ];

    [
        localize LSTRING(EscapeCaption),
        format[localize LSTRING(EscapeText), GVAR(escapeZoneRadius)]
    ] call A3A_fnc_customHint;

#ifndef __A3USPCM_PRODUCTION__
    private _marker = createMarkerLocal[[] call FUNCMAIN(utilGenerateUniqueId), getPos player];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerSizeLocal [GVAR(escapeZoneRadius), GVAR(escapeZoneRadius)];
    _marker setMarkerColorLocal "ColorRed";
    _marker setMarkerAlphaLocal 0.5;
    _marker setMarkerBrush "DIAGGRID";
#endif

    waitUntil { !alive player || captive player || isNull _trigger };
    TRACE_2(QFUNC(playerCompromizeMonitor),alive player,isNull _trigger);

    // player died or went undercover
    if !(isNull _trigger) then { 
        deleteVehicle _trigger;
    };

    if (alive player && !captive player) then {
        [] call FUNCMAIN(miscUncompromise);
    };

#ifndef __A3USPCM_PRODUCTION__
    deleteMarkerLocal _marker;
#endif
};

INFO_1("player '%1' compromize monitor ended",name player);

nil;
