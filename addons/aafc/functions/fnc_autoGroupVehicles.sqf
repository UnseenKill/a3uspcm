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
_this spawn {
    TRACE_1(QFUNC(autoGroupVehicles),_this);

    uiSleep AUTO_GROUP_DELAY;

    private _grouped = [];
    private _vehicles = allUnitsUAV select {
        _x getVariable["ownerSide", sideUnknown] isEqualTo side theBoss
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

        [_x] call A3USPCM_zeus_fnc_doCrewStatic;
    } forEach _grouped;
};

nil;
