#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_vehicles_fnc_meepMeepDoAction

Description:
    Scroll-wheel menu interaction for meep meep action. Do the thing.

Parameters:
    0: _target - The original target object <OBJECT>
    1: _player - The player object <OBJECT>

Optional:

Returns:
    <BOOL> Always true.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(meepMeepDoAction),_this);

if !assert(params[
    ["_target", nil, [objNull]],
    ["_player", nil, [objNull]]
]) exitWith { true };
if !assert(!isNull _target) exitWith { true };
if !assert(!isNull _player) exitWith { true };

if ((_target getVariable[QGVAR(meepMeepActiveUntil), 0]) > diag_tickTime) exitWith {
    [_target, LLSTRING(MeepMeep_AnnounceCommanderWait_Text), false] call FUNC(meepMeepFeedback);
    true;
};

private _targets = [_target, call FUNC(meepMeepGetTargets)] call FUNC(meepMeepValidateTargets);

// Validation has filtered everything out
if !(_targets isEqualType []) exitWith { true };

// Nothing to validate, road is clear
if (_targets isEqualTo []) exitWith {
    [_target, LLSTRING(MeepMeep_AnnounceCommanderNoTargets_Text), false] call FUNC(meepMeepFeedback);
    true;
};

[_target] call FUNC(meepMeepPlaySound);
[_target, _player, _targets] spawn FUNC(meepMeepShooUnits);

true;
