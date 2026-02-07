#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_updateCommsMenu

Description:
    Updates the AAIO comms menu for the player.

Parameters:
    0: _unit - Unit whose comms menu should be updated <OBJECT>

Optional:

Example:
    (begin example)
    [_unit] call FUNC(updateCommsMenu);
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(updateCommsMenu),_this);

#define PAD_WIDTH 70

if !assert(params[
    ["_unit", nil, [objNull]]
]) exitWith {};
if !assert(!isNull _unit) exitWith {};

private _config = [configFile, missionConfigFile] select is3DENPreview;
_config = _config >> QPREFIX >> QADDON >> "Menu" >> "Definitions";

private _buildMenu = {
    if !assert(params[
        ["_config", nil, [configNull]],
        ["_prefix", nil, [""]],
        ["_path", nil, []]
    ]) exitWith {};
    if !assert(!isNull _config) exitWith {[]};

    ((QUOTE(!isNull inheritsFrom _x) configClasses _config) apply {
        private _item = _x;

        if (!(call compile getText(_item >> "conditionVisible"))) then {
            continueWith[];
        };

        // Addition isText check needed for separators
        private _isActive = ["0", getText(_item >> "isActive")] select(isText(_item >> "conditionActive") && {call compile getText(_item >> "conditionActive")});

        if !isNumber(_item >> "subMenu") then {
            private _title = getText(_item >> "itemName");
            private _selected = isText(_item >> "selected") && { getText(_item >> "selected") isNotEqualTo "" } && { call compile getText(_item >> "selected") };
            private _expression = [["expression", ""]];

            if (_selected) then {
                _title = parseText format["&gt; <t color='#00c8fd'>%1</t>", _title];
            } else {
                _title = [_title, PAD_WIDTH, false] call FUNCMAIN(utilPadString);
            };

            if (getNumber(_item >> "command") isEqualTo -5) then {
                _expression pushBack["expression", format[QUOTE([ARR_5(_caller,_pos,_target,_is3D,_id)] call {%1}), getText(_item >> "expression")]];
            };

            if (getNumber(_item >> "updateAfterExecution") isNotEqualTo 0) then {
                // Yeah, it's an array of arrays, but only the last one gets executed, so...
                (_expression select -1) params["","_code"];
                _expression = [["expression", format["%1;%2", _code, QUOTE([player] call FUNC(updateCommsMenu))]]];
            };

            continueWith[
                _title,
                getArray(_item >> "assignedKey"),
                "",
                getNumber(_item >> "command"),
                _expression,
                getText(_item >> "isVisible"),
                _isActive,
                getText(_item >> "iconPath")
            ];
        };

        private _key = format["%1_%2", _prefix, configName _item];
        private _thisPath = _path + [getText(_item >> "displayName")];
        private _items = if (getText(_item >> "subMenuFrom") isEqualTo "") then {
            [_item, _key, _thisPath] call _buildMenu;
        } else {
            [_item, _key, _thisPath] call compile getText(_item >> "subMenuFrom");
        };

        missionNamespace setVariable[_key, [[_thisPath joinString " >> ", true]] + _items];

        [
            [_thisPath select -1, PAD_WIDTH, false] call FUNCMAIN(utilPadString),
            getArray(_item >> "assignedKey"),
            format["#USER:%1", _key],
            getNumber(_item >> "command"), [],
            getText(_item >> "isVisible"),
            _isActive,
            getText(_item >> "iconPath")
        ];
    }) - [[]];
};

GVAR(topLevelMenu) = [[LLSTRING(Menu_Title), true]];

private _menu = [_config, QGVAR(topLevelMenu), [LLSTRING(Menu_Title)]] call _buildMenu;
GVAR(topLevelMenu) append _menu;

nil;
