#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_onEventSupportStartSpecialistMission

Description:
    Event handler

Parameters:
    0: _supportType - Support type <STRING>

Optional:
    1: _delay - Delay in seconds <NUMBER> (default: 3.5)

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onEventSupportStartSpecialistMission),_this);

params[
    ["_supportType", nil, [""]],
    ["_delay", 3.5, [0]]
];

if (GVAR(supportSpecialistsMissions) getOrDefault[_supportType, false]) exitWith {
    ERROR_2("%1(%2): another mission is active",QFUNC(onEventSupportStartSpecialistMission),_supportType);
};

[
    {
        params[
            ["_supportType", "", [""]]
        ];

        private _requester = owner theBoss;
		private _possibleMarkers = [citiesX, petros, true] call A3A_fnc_findIfNearAndHostile;

        if (count _possibleMarkers == 0) exitWith { 
            [petros, "globalChat", "I have no specialist missions for you. Move our HQ closer to the enemy."] remoteExec["A3A_fnc_commsMP", _requester];
            [petros, "hint", "Specialist Missions require Cities or Airports closer than 4Km from your HQ.", "Missions"] remoteExec["A3A_fnc_commsMP", _requester];
        };

        private _site = selectRandom _possibleMarkers;

        [[_site, _supportType], QFUNC(startSpecialistMission)] remoteExec["A3A_fnc_scheduler", 2];
    },
    _this,
    _delay
] call CBA_fnc_waitAndExecute;

nil;
