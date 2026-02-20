#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscUnstick

Description:
    Get soldiers of the squad unstuck so they can move again.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscUnstick),_this);

[groupSelectedUnits player] spawn {
    params[["_units", [], [[]]]];

    if (_units isEqualTo []) then {
        private _timeout = 5;

        while { _timeout > 0 } do {
            systemChat format[LLSTRING(Miscellaneous_UnstickTimeoutText), _timeout];
            DEC(_timeout);
            uiSleep 1;
        };

        _units = groupSelectedUnits player;
    };

    _units = _units select { isNull objectParent _x };

    if (_units isEqualTo []) exitWith {
        [LLSTRING(Miscellaneous_UnstickCaption), LLSTRING(Miscellaneous_UnstickErrorNoSelectionText)] call A3A_fnc_customHint;
        playSound "A3AP_UiFailure";
    };

    private _unstick = {
        params[["_unit", objNull, [objNull]], ["_group", grpNull, [grpNull]]];

        TRACE_2("cloning",typeOf _unit,name _unit);

        private _loadout = getUnitLoadout _unit;
        private _clone = _group createUnit[typeOf _unit, [0,0,0], [], 0, "NONE"];
        private _pos = getPosATL _unit;
        private _vdup = [vectorDir _unit, vectorUp _unit];

        _clone setUnitLoadout _loadout;
        _clone setFace face _unit;
        _clone setName name _unit;
        _clone setNameSound nameSound _unit;
        _clone setPitch pitch _unit;
        _clone setSpeaker speaker _unit;
        _clone setSkill skill _unit;
        _clone setUnitPos unitPos _unit;
        _clone setVariable["owner", player];
        _clone setVariable[QGVAR(assignedTeam), assignedTeam _unit];
        _clone setVariable[QGVAR(groupId), groupId _unit];

        deleteVehicle _unit;

        _clone setPosATL _pos;
        _clone setVectorDirAndUp _vdup;

        [{
            params["_clone"];

            _clone joinAs[group player, _clone getVariable GVAR(groupId)];
            _clone assignTeam(_clone getVariable QGVAR(assignedTeam));

            _clone setVariable[QGVAR(assignedTeam), nil];
            _clone setVariable[QGVAR(groupId), nil];

        }, [_clone], 0.15] call CBA_fnc_waitAndExecute;

        _clone;
    };

    private _group = createGroup side player;
    _units apply { [_x, _group] call _unstick };
    deleteGroup _group;
};

nil;
