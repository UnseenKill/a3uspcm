#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_compat_ace_fnc_onAceMedicalUnconscious

Description:
    CBA event handler for "ace_unconscious" event.

Parameters:
    0: _unit - the unit that triggered the event <OBJECT>
    1: _isUnconscious - boolean indicating if the unit is unconscious <BOOL>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onAceMedicalUnconscious),_this);

params["_unit","_isUnconscious"];

if (!_isUnconscious || {EGVAR(menu,autoWakeUpDelay) isEqualTo 0} || {_unit isNotEqualTo player}) exitWith {};

TRACE_1(QFUNC(onAceMedicalUnconscious),EGVAR(menu,autoWakeUpDelay));
INFO_1("Waking player up in %1 seconds",EGVAR(menu,autoWakeUpDelay));

GVAR(magicalEffectsGVARs) = [
    [0.5, ACE_QEGVAR(medical_treatment,treatmentTimeTourniquet)],
    [0.5, ACE_QEGVAR(medical_treatment,treatmentTimeTrainedTourniquet)]
];

[{
    private _ttlMagicEffects = EGVAR(menu,autoWakeUpMagicEffectsDuration);
    TRACE_1(QFUNC(onAceMedicalUnconscious),_this);

    INFO_1("Trying to wake player up; increased bandages effectiveness for %1 seconds",_ttlMagicEffects);

    _this setVariable[QGVAR(hasStableVitals), diag_tickTime + _ttlMagicEffects];
    [{
        params["_player","_gvars"];
        _player setVariable[QGVAR(hasStableVitals), nil];
        _gvars apply {
            _x params["_name","_value"];
            TRACE_2(QFUNC(onAceMedicalUnconscious),_name,_value);
            missionNamespace setVariable[_name, _value];
        };
    }, [_this, (GVAR(magicalEffectsGVARs) apply {
        _x params["_coeff","_name"];
        private _value = missionNamespace getVariable _name;
        if !assert(!isNil "_value") then {
            ERROR_1("No such GVAR %1",_name);
            [];
        } else {
            TRACE_3(QFUNC(onAceMedicalUnconscious),_name,_value,_coeff);
            missionNamespace setVariable[_name, _value * _coeff];
            [_name, _value];
        };
    }) - [[]]], _ttlMagicEffects] call CBA_fnc_waitAndExecute;

    [ACE_QEGVAR(medical,wakeup), _this] call CBA_fnc_localEvent;
}, _unit, EGVAR(menu,autoWakeUpDelay)] call CBA_fnc_waitAndExecute;

nil;
