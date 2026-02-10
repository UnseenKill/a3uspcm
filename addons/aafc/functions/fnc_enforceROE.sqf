#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_enforceROE

Description:
    Set ROE mode and enforce it.

Parameters:
    0: _roeMode - New ROE mode <TYPE>

Optional:

Returns:
    Nothing

Environment:
    Server, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(enforceROE),_this);

if !assert(isServer) exitWith {};
if !assert(params[
    ["_roeMode", nil, [0]]
]) exitWith {};

private _roeMap = createHashMapFromArray[
    [ROE_HOLDFIRE, []],
    [ROE_FIREATWILL, [AA_TYPE_CIWS, AA_TYPE_SPAA, AA_TYPE_SRSAM, AA_TYPE_LRSAM]],
    [ROE_CIWSONLY, [AA_TYPE_CIWS]],
    [ROE_SRSAM, [AA_TYPE_CIWS, AA_TYPE_SPAA, AA_TYPE_SRSAM]],
    [ROE_LRSAM, [AA_TYPE_CIWS, AA_TYPE_SPAA, AA_TYPE_SRSAM, AA_TYPE_LRSAM]]
];

private _allowTypes = _roeMap get _roeMode;
private _updateEventsFor = [];

GVAR(groups) select { !(_x getVariable[QGVAR(unlinkROE), false]) } apply {
    _x setVariable[QGVAR(vehicles), _x getVariable QGVAR(vehicles) select { !isNull _x }, true];
    _x getVariable QGVAR(vehicles) apply {
        private _vehicle = _x;
        private _aaType = [_x] call FUNC(getAAType);
        private _combatMode = ["BLUE","YELLOW"] select (_aaType in _allowTypes);

        TRACE_4(QFUNC(enforceROE),_roeMode,_vehicle,_aaType,_combatMode);
        crew _x select { alive _x } apply {
            TRACE_2(QFUNC(enforceROE),_x,_combatMode);

            if (unitCombatMode _x isNotEqualTo _combatMode) then {
                _updateEventsFor pushBack[_vehicle, _roeMode, _combatMode isNotEqualTo "BLUE"];
                _x setUnitCombatMode _combatMode;
            };
        };
    };
};

CBA_EVENT_REMOTE(CBA_EVENT_AAFC_SET_ROE_GLOBAL,[_roeMode]);

_updateEventsFor apply {
    CBA_EVENT_GLOBAL(CBA_EVENT_AAFC_UNIT_ROE_CHANGED,_x);
};

nil;
