#include "..\script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_getSADMenuItems

Description:
    Return menu items for running Search and Destroy missions.

Parameters:
    0: _item - Sub menu config <CONFIG>
    1: _key - Menu namespace key <STRING>
    2: _path - Menu breadcrumbs <ARRAY>

Optional:

Returns:
    <ARRAY> Menu items

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getSADMenuItems),_this);

if !assert(params[
    ["_item", nil, [configNull]],
    ["_key", nil, [""]],
    ["_path", nil, [[]]]
]) exitWith {[]};

private _index = -1;
missionNamespace getVariable[QGVAR(sadMissions), createHashMap] apply {
    private _event = _x;
    private _mission = _y;
    INC(_index);

    [
        format["%1: %2", LLSTRING(Menu_OrdersSADShort_DisplayName), groupId(_mission get "group")],
        [DIK_1 + _index], "", -5,
        [["expression", format[QUOTE([ARR_2(QUOTE(CBA_EVENT_SAD_TERMINATE),[ARR_2(player,QQUOTE(%1))])] call CBA_fnc_localEvent), _event]]],
        "1", "1", ""
    ]
};
