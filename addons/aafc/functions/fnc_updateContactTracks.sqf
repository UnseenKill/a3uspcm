#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_updateContactTracks

Description:
    Update the contact tracks for all tracked units

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_2(QFUNC(updateContactTracks),_this,canSuspend);

if !canSuspend exitWith { _this spawn FUNC(updateContactTracks) };

if !(GVAR(contactTracker) isEqualType false) exitWith {
    TRACE_1("Contact tracking already running",_this);
};

GVAR(contactTracker) = [] spawn {
    INFO("Contact tracking started");

    while { count GVAR(contacts) > 0 } do {
        uiSleep 0.125;

        values GVAR(contacts) select {
            _x get "nextUpdate" < diag_tickTime
        } apply {
            private _contact = _x;
            private _key = _contact get "key";
            private _unit = _contact get "unit";
            private _marker = _contact get "marker";

            if (isNull _unit) then {
                WARNING_1("Unit for contact '%1' is null, removing contact",_key);
                GVAR(contacts) deleteAt _key;
                deleteMarker _marker;
                continue;
            };

            switch true do {
                case !(_contact get "alive"): {
                    INFO_1("Unit for contact '%1' is dead, removing contact",_key);
                    GVAR(contacts) deleteAt _key;
                    deleteMarker _marker;
                    continue;
                };

                case (_contact get "alive" isNotEqualTo alive _unit): {
                    INFO_3("Contact '%1' alive state changed (alive=%2;unit=%3)",_key,alive _unit,_unit);
                    if !assert(!alive _unit) then { continue };

                    _contact set["alive", false];
                    _contact set["nextUpdate", diag_tickTime + GVAR(contactTrackDeadInterval)];
                    _marker setMarkerColorLocal "ColorGrey";
                    _marker setMarkerAlpha 0.5; // Dim the marker for dead units
                };

                default {
                    _marker setMarkerPosLocal getPosATL _unit;
                    _marker setMarkerDir getDir _unit;
                    _contact set["lastPos", getPosATL _unit];
                    _contact set["lastDir", getDir _unit];
                    _contact set["lastSpeed", speed _unit];
                    _contact set["nextUpdate", diag_tickTime + GVAR(contactUpdateInterval)];
                };
            };
        };
    };

    INFO("Contact tracking stopped");
};

waitUntil { scriptDone GVAR(contactTracker) };
INFO("Contact tracking script has finished");

GVAR(contactTracker) = false;

nil;
