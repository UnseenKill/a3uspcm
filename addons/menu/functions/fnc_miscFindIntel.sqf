#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscFindIntel

Description:
    This function is used to find intel in the mission. It will display a map
    marker to the player with the location of the intel.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscFindIntel;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
private _radius = GVAR(findIntelRadius);
private _useLargeFlags = GVAR(findIntelUseLargeFlags);
private _usePrecision = GVAR(findIntelPreciseMarker);
private _config = GVAR(DiaryConfig);
private _chemlights = getArray(_config >> "Intel" >> "chemlights");
private _flags = getArray(_config >> "Intel" >> "flags");
private _laptops = getArray(_config >> "Intel" >> "laptops");

_flags = _flags select EGVAR(main,AceHaveAddon);

INFO_2("'%1' is searching for intel (radius=%2m)",name player,_radius);
TRACE_3(QFUNCMAIN(miscFindIntel),_radius,_laptops,_config);

private _sl = nearestObjects[player, ["CAManBase"], _radius, true] select {
    (!alive _x) && { _x getVariable[QGVAR(hasIntel), false] } &&
    { !(_x getVariable["intelSearchDone", false]) } &&
    {_x getVariable["side", west] isNotEqualTo side player}
};

private _laptops = nearestObjects[player, _laptops, _radius, true];
private _intelFound = 0;

(_sl + _laptops) select {
    _x getVariable[QGVAR(intelMarker), false] isEqualTo false;
} apply {
    private _object = _x;
    private _pos = getPosATL _object;
    TRACE_2(QGVAR(miscFindIntel),_object,_pos);

    _object setVariable[QGVAR(intelMarker), true];

    private _marker = if _usePrecision then {
        [] call FUNCMAIN(utilGenerateUniqueID);
    } else {
        private _index = keys GVAR(IntelMarkers) findIf {
            _pos inArea _x;
        };

        if (_index isNotEqualTo -1) then {
            false;
        } else {
            _pos = [_pos, INTEL_MARKER_RADIUS] call FUNCMAIN(utilSpreadPoint);
            [] call FUNCMAIN(utilGenerateUniqueID);
        };
    };

    if (_marker isNotEqualTo false) then {
        _marker = createMarker[_marker, _pos];
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerSizeLocal[INTEL_MARKER_RADIUS, INTEL_MARKER_RADIUS];
        _marker setMarkerAlpha 0;

        private _icon = createMarker[format["%1_icon", _marker], _pos];
        _icon setMarkerShapeLocal "ICON";
        _icon setMarkerTypeLocal "loc_search";
        _icon setMarkerShadowLocal false;
        _icon setMarkerColor "ColorPink";

        private _class = if !([] call FUNCMAIN(utilIsDaytime)) then {
            selectRandom _chemlights;
        } else {
            _flags select _useLargeFlags;
        };
        private _flag = createVehicle[_class, [_pos # 0, _pos # 1], [], 0, "CAN_COLLIDE"];
        _flag setDir random 360;

        if EGVAR(main,AceHaveAddon) then {
            [_flag, _flag] call ace_common_fnc_claim; // disables ALL ACE3 interactions
        };

        _flag addAction[
            localize LSTRING(Miscellaneous_FindIntelCleanupActionText),
            {
                TRACE_1("cleanup intel marker",_this);

                params["_object","_player","_action","_marker"];
                _object removeAction _action;
                [_marker] call FUNC(intelCleanupMarker);
            },
            _marker, 1.5, true, true, "", "true", 5
        ];

        _intelFound = _intelFound + 1;
        GVAR(IntelMarkers) set[_marker, [diag_tickTime, _icon, _object, _flag]];
    };
};

INFO_1("Found %1 intel",_intelFound);

private _message = if (_intelFound isEqualTo 0) then {
    format[localize LSTRING(Miscellaneous_FindIntel_NoIntelFoundText), _radius];
} else {
    format[localize LSTRING(Miscellaneous_FindIntel_IntelFoundText), _intelFound];
};

[localize LSTRING(Miscellaneous_FindIntelCaption), _message] call A3A_fnc_customHint;
[] call FUNC(intelCleanupHandler);

nil;
