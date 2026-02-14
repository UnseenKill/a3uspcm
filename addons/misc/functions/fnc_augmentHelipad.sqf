#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_misc_fnc_augmentHelipad

Description:
    Add landing lights to A3U helipads.

Parameters:
    0: _object - Helipad object <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(augmentHelipad),_this);
//#define ATTACH_LIGHTS

if !assert(params[
    ["_object", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _object) exitWith {};

// Let the lights move around with the preview object, sacrifice some of the
// precision of not doing that.
private _attachLights = !(isNil "A3A_building_EHDB");

if (GVAR(augmentHelipads) isEqualTo "none") exitWith {};
if !(isClass(configFile >> "CfgPatches" >> "A3_Data_F_Heli")) exitWith {
    ERROR("Helicopters DLC not detected, cannot augment helipads.");
};

private _config = configFile >> QPREFIX >> QADDON >> "AugmentHelipads";
private _pattern = [_config >> GVAR(augmentHelipads), "STRING", GVAR(augmentHelipadsCustom)] call CBA_fnc_getConfigEntry;
private _typeMap = createHashMapFromArray getArray(_config >> "patternTypeMap");
private _types = _pattern splitString "," apply {
    trim _x splitString "=" params["_type",["_offset", "0", [""]]];
    [_type, parseNumber _offset];
};

TRACE_2(QFUNC(augmentHelipad),_pattern,_types);

if (_types isEqualTo []) exitWith {
    WARNING_1("No valid pattern entries found for augmentHelipads in %1, not adding lights.",str _pattern);
};

// Clean up old lights; only used in debugging, since this is a postInit handler...
_object getVariable[QGVAR(lights), []] apply {
    if (_x getVariable[QGVAR(augmentHelipadLight), false]) then {
        detach _x;
        deleteVehicle _x;
    };
};

// Set up lights
private _stepAngle = 360 / (count _types); // Halp, step angle, I'm stuck!
private _angle = -_stepAngle;
private _circular = getText(configOf _object >> "model") find "Square" isEqualTo -1;
private _radius = [5.6, 7] select _circular;

if (isNil { _object getVariable QGVAR(ehDeleted) }) then {
    _object setVariable[QGVAR(ehDeleted), _object addEventHandler["Deleted", {
        params["_object"];
        INFO_1("Cleaning up lights after %1 deletion.",_object);
        _object getVariable[QGVAR(lights), []] apply {
            if (_x getVariable[QGVAR(augmentHelipadLight), false]) then {
                detach _x;
                deleteVehicle _x;
            };
        };
    }]];
};

_object setVariable[QGVAR(lights), _types apply {
    ADD(_angle,_stepAngle);

    _x params["_type","_offsetDistance"];
    private _class = _typeMap get _type;

    if (isNil "_class") then {
        WARNING_2("Invalid light type in pattern %1 for augmentHelipads: %2",str _pattern,str _type);
        _class = "Land_PortableHelipadLight_01_F";
    };

    private _offsetAngle = [_angle] call FUNCMAIN(utilNormalizeDirection);
    private _offset = if (_circular) then {
        [cos _offsetAngle, sin _offsetAngle, 0] vectorMultiply(_radius + _offsetDistance)
    } else {
        // Position along the sides of the square of the helipad model
        private _sideLength = (_radius + _offsetDistance) * 2;
        private _sideIndex = floor(_offsetAngle / 90) mod 4;
        private _angleOnSide = _offsetAngle mod 90;
        private _t = _angleOnSide / 90;
        private _posOnSide = _t * _sideLength - _sideLength / 2;
        private _sideIndex = floor(_offsetAngle / 90) mod 4;
        private _angleOnSide = _offsetAngle mod 90;
        private _posOnSide = (_angleOnSide / 90) * _sideLength - _sideLength / 2;

        switch (_sideIndex) do {
            case 0: { [_sideLength / 2, _posOnSide, 0] };
            case 1: { [-_posOnSide, _sideLength / 2, 0] };
            case 2: { [-_sideLength / 2, -_posOnSide, 0] };
            case 3: { [_posOnSide, -_sideLength / 2, 0] };
        };
    };

    TRACE_4(QFUNC(augmentHelipad),_circular,_class,_offsetAngle,_offset);
    private _light = createVehicle[_class, [0,0,0], [], 0, "NONE"];

    if (_attachLights) then {
        _light attachTo[_object, _offset];
    } else {
        private _pos = _object modelToWorld _offset;
        _pos set[2, getTerrainHeightASL _pos];
        _light setVectorUp surfaceNormal _pos;
        _light setPosASL _pos;
    };

    _light setVariable[QGVAR(augmentHelipadLight), true];
    _light;
}];

nil;
