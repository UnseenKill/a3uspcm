#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_emergencyInvincibility

Description:
    Toggle invincibility for player, squad mates, all their vehicles.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_menu_fnc_emergencyInvincibility;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(emergencyInvincibility),_this);

private _canGoInvincible = try {
    if (isDamageAllowed player && GVAR(emergencyInvincibilityCooldown) > 0) then {
        private _lastUsed = player getVariable[QGVAR(emergencyInvincibilityLastUsed), false];
        if (_lastUsed isNotEqualTo false) then {
            if (diag_tickTime < _lastUsed + GVAR(emergencyInvincibilityCooldown)) exitWith {
                [
                    localize LSTRING(Hotkeys_EmergencyInvincibility),
                    format[localize LSTRING(Miscellaneous_EmergencyInvincibilityCooldownHintText), round(_lastUsed + GVAR(emergencyInvincibilityCooldown) - diag_tickTime)]
                ] call A3A_fnc_customHint;

                playSound "A3AP_UiFailure";
                throw false;
            };
        };
    };

    true;
} catch {
    false;
};

if !_canGoInvincible exitWith {};

private _invincible = !isDamageAllowed player;

if (!_invincible && GVAR(emergencyInvincibilityCooldown) > 0) then {
    player setVariable[QGVAR(emergencyInvincibilityLastUsed), diag_tickTime];
};

units group player apply {
    TRACE_4(QFUNCMAIN(emergencyInvincibility),_invincible,_x,objectParent _x,getConnectedUAV _x);

    _x allowDamage _invincible;

    if !isNull(objectParent _x) then {
        objectParent _x allowDamage _invincible;
    };

    if !isNull(getConnectedUAV _x) then {
        getConnectedUAV _x allowDamage _invincible;
    };
};

[
    localize LSTRING(Hotkeys_EmergencyInvincibility),
    localize([LSTRING(Miscellaneous_EmergencyInvincibilityOnHintText), LSTRING(Miscellaneous_EmergencyInvincibilityOffHintText)] select _invincible)
] call A3A_fnc_customHint;

playSound(["A3AP_UiSuccess","A3AP_UiFailure"] select _invincible);

if (!_invincible && GVAR(emergencyInvincibilityDuration) > 0) then {
    [diag_tickTime + GVAR(emergencyInvincibilityDuration)] spawn {
        params[["_endTime",0,[0]]];

        waitUntil { uiSleep 1; diag_tickTime >= _endTime };

        if (!isDamageAllowed player) then {
            [] call FUNCMAIN(emergencyInvincibility);
        };
    };
};

nil;
