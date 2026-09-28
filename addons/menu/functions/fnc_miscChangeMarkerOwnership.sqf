
#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscChangeMarkerOwnership

Description:
    Changes the ownership of a map location marker.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscChangeMarkerOwnership;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscChangeMarkerOwnership),_this);

if !(isNil QGVAR(ownershipMapClickEH)) exitWith { LOG_1("%1(): duplicate execution ignored",QFUNCMAIN(miscChangeMarkerOwnership)) };
if !(visibleMap) then {
    openMap true;
};

[] spawn {
    [LLSTRING(Miscellaneous_ChangeMarkerOwnershipCaption), LLSTRING(Miscellaneous_ChangeMarkerOwnershipHint)] call A3A_fnc_customHint;

    GVAR(ownershipMapClickEH) = addMissionEventHandler["MapSingleClick", {
    	params["","_position"];

        private _marker = [markersX, _position] call BIS_fnc_nearestPosition;
        private _distance = _position distance2D markerPos _marker;
        TRACE_3(QFUNCMAIN(miscChangeMarkerOwnership),_position,_marker,_distance);

        if (_distance > 250) exitWith {};

        [_marker] spawn {
            params["_marker"];

            private _owner = sidesX getVariable[_marker, sideUnknown];
            private _newOwner = [teamPlayer, west] select(_owner isEqualTo teamPlayer);
            private _guiCaption = LLSTRING(Miscellaneous_ChangeMarkerOwnershipCaption);
            private _guiText = format[LLSTRING(Miscellaneous_ChangeMarkerOwnershipConfirmation), _marker, _owner, _newOwner];

            if !([_guiText, _guiCaption, true, true] call BIS_fnc_guiMessage) exitWith {};

            LOG_4("%1(): changing location owner of ""%2"" from ""%3"" to ""%4""",QFUNCMAIN(miscChangeMarkerOwnership),_marker,_owner,_newOwner);

            [_newOwner, _marker] remoteExec["A3A_fnc_markerChange", 2];
        };
    }];

    waitUntil { !visibleMap };
    removeMissionEventHandler["MapSingleClick", GVAR(ownershipMapClickEH)];
    GVAR(ownershipMapClickEH) = nil;
};

nil;
