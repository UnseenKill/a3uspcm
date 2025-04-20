#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_onAceTrenchesFinished

Description:
    Event handler for ACE Trenches finished event.

Parameters:
    0: _player - Digging player <OBJECT>
    1: _trench - Trench object <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onAceTrenchesFinished),_this);

params[
    ["_player",objNull,[objNull]],
    ["_trench",objNull,[objNull]]
];

if !assert(!isNull _player) exitWith {};
if !assert(!isNull _trench) exitWith {};

if (count A3A_buildingsToSave < A3A_builderLimit) then {
    A3A_buildingsToSave pushBack _trench;
};

nil;
