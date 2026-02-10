#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_autoGroupVehicles

Description:
    Auto-group A/A vehicles at mission start

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(autoGroupVehicles),_this);

[{
    private _grouped = [];
    private _ignore = parseSimpleArray GVAR(autoGroupIgnoreClasses);

    if !(_ignore isEqualType []) then {
        WARNING_2("%1(): vehicles classes list could not be parsed from %2",QFUNC(autoGroupVehicles),GVAR(autoGroupIgnoreClasses));
        _ignore = [];
    } else {
        _ignore = _ignore select { _x isEqualType "" };
    };

    _ignore pushBack "Air";

    private _vehicles = allUnitsUAV select {
        private _vehicle = _x;
        (_vehicle getVariable[QGVAR(autoGroup), true] isEqualTo true) && {
            (_vehicle getVariable["ownerSide", sideUnknown] isEqualTo side theBoss) &&
            { _ignore findIf { _vehicle isKindOf _x } isEqualTo -1 }
        }
    };

    while { _vehicles isNotEqualTo [] } do {
        private _vehicle = _vehicles deleteAt 0;
        private _cluster = [_vehicle];

        for "_i" from 0 to (count _vehicles - 1) do {
            private _other = _vehicles select _i;

            if (_cluster findIf { _x distance _other <= GVAR(autoGroupRadius) } >= 0) then {
                _cluster pushBack _other;
            };
        };

        _vehicles = _vehicles - _cluster;
        _grouped pushBack _cluster;
    };

    INFO_1("A/A auto-group found %1 A/A clusters",count _grouped);
    {
        INFO_2("group #%1 (%2x vehicles)",_foreachIndex,count _x);

        private _index = 0;
        _x apply {
            INFO_4("group #%1:%2 - %3 at %4",_foreachIndex,_index,typeOf _x,mapGridPosition _x);
            INC(_index);
        };

        [_x] call EFUNC(zeus,doCrewStatic);
    } forEach _grouped;
}, _this, AUTO_GROUP_DELAY] call CBA_fnc_waitAndExecute;

nil;
