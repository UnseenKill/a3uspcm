#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_radarStrobeLight

Description:
    Attach a strobe light to a radar vehicle.

Parameters:
    0: _vehicle - The radar vehicle to attach the strobe light to <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(radarStrobeLight),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _vehicle) exitWith {};

if !(isNil { _vehicle getVariable QGVAR(radarStrobeLight) }) exitWith {};

private _color = [configOf _vehicle >> QGVAR(strobeColor), "ARRAY", []] call CBA_fnc_getConfigEntry;
private _offset = [configOf _vehicle >> QGVAR(strobePosition), "ARRAY", []] call CBA_fnc_getConfigEntry;

if (_color isEqualTo [] || { _offset isEqualTo [] }) exitWith {
    WARNING_1("No strobe config for %1",typeOf _vehicle);
};

private _light = "#lightpoint" createVehicleLocal[0,0,0];
_light setLightBrightness 1;
_light setLightUseFlare true;
_light setLightFlareSize 0.50;
_light setLightFlareMaxDistance 10;
_light setLightIntensity 14250;
_light setLightAmbient _color;
_light setLightColor _color;
_light attachTo[_vehicle, _offset];
_vehicle setVariable[QGVAR(radarStrobeLight), _light];

_vehicle addEventHandler["Deleted", {
    params["_vehicle"];
    if !(isNil { _vehicle getVariable QGVAR(radarStrobeLight) }) then {
        deleteVehicle (_vehicle getVariable QGVAR(radarStrobeLight));
    };
}];

_light spawn {
    private _update = {
        params["_light","_intensity","_update","_cycleLights"];
        if (isNull _light) exitWith {};

        _light setLightIntensity _intensity;

        if (_intensity < 500) exitWith {
            [_update, [_light, _intensity + 30, _update, _cycleLights]] call CBA_fnc_execNextFrame;
        };

        [{
            params["_light","_update","_cycleLights"];
            if (isNull _light) exitWith {};
            _light setLightIntensity 0;

            [{
                params["_light","_update","_cycleLights"];
                if (isNull _light) exitWith {};
                _light setLightIntensity 14250;

                [_cycleLights, [_light, _cycleLights, _update]] call CBA_fnc_execNextFrame;
            }, [_light, _update, _cycleLights], 75] call CBA_fnc_execAfterNFrames;
        }, [_light, _update, _cycleLights], 5] call CBA_fnc_execAfterNFrames;
    };

    private _cycleLights = {
        params["_light","_cycleLights","_update"];
        if (isNull _light) exitWith {};

        if ([] call FUNCMAIN(utilIsDaytime)) exitWith {
            _light setLightIntensity 0;
            [_cycleLights, [_light, _cycleLights, _update], 600] call CBA_fnc_waitAndExecute;
        };

        if (player distance _light > 450) exitWith {
            _light setLightIntensity 0;
            [_cycleLights, [_light, _cycleLights, _update], 30] call CBA_fnc_waitAndExecute;
        };

        [_update, [_light, 0, _update, _cycleLights]] call CBA_fnc_execNextFrame;
    };

    [_cycleLights, [_this, _cycleLights, _update]] call CBA_fnc_execNextFrame;
};

nil;
