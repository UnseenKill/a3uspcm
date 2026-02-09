#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletOverviewUpdate

Description:
    Update tablet overview controls after ROE change

Parameters:
    0: _newROE - New ROE mode <NUMBER>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletOverviewUpdate),_this);

private _display = uiNamespace getVariable QGVAR(display);
private _tab = _display getVariable QGVAR(tabs) get IDC_TABHOST_OVERVIEW;

if !assert(!isNil "_tab") exitWith {};
if !(_tab get "active") exitWith {};

private _ctlTabHost = _tab get "ctlGroupsHost";
private["_tabHost","_control","_startX","_startY"];

// Delete what's left from previous call or the placeholder
allControls _ctlTabHost apply { ctrlDelete _x };

ctrlPosition _ctlTabHost params["","","_tw","_th"];
_startX = -16 * UI_GRID_W;


if (GVAR(groups) isEqualTo []) exitWith {
    _control = _display ctrlCreate[QGVAR(RscTextCentered), 0, _ctlTabHost];
    _control ctrlSetPosition[0, 0, _tw, _th];
    _control ctrlSetText "No A/A groups assigned, yet.";
    _control ctrlCommit 0;
};

private _aaTypes = createHashMapFromArray[
    [AA_TYPE_UNKNOWN, [0, "???", "Unknown"]],
    [AA_TYPE_CIWS, [1, "CIWS", "Close-in weapon system"]],
    [AA_TYPE_LRSAM, [3, "LR/SAM", "Long-range SAM"]],
    [AA_TYPE_RADAR, [9, "RDR", "Radar"]],
    [AA_TYPE_SPAA, [4, "SPAAG", "Self propelled AA"]],
    [AA_TYPE_SRSAM, [2, "SR/SAM", "Short-range SAM"]]
];

private _index = -1;
private _groups = GVAR(groups) apply { [groupId _x, _x] };
_groups sort true;
_groups apply {
    private _group = _x select -1;
    private _backgroundColor = [1,1,1,[0.1, 0.25] select (_index mod 2)];
    private _nonMajorColumnColor = [0.7,0.7,0.7,1];

    _startY = -UI_GRID_H - pixelH * 4;

    CBA_TRIGGER(CBA_EVENT_AAFC_UPDATE_GROUP,[_group]);

    INC(_index);
    ADD(_startX,16 * UI_GRID_W + pixelW * 4);

    _control = _display ctrlCreate[QGVAR(RscText), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX, 0, 16 * UI_GRID_W, UI_GRID_H];
    _control ctrlSetText format["%1", groupId _group];
    _control ctrlSetBackgroundColor _backgroundColor;
    _control ctrlCommit 0;

    _control = _display ctrlCreate[QGVAR(RscListNBox), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX, UI_GRID_H + pixelH * 4, 16 * UI_GRID_W, _th - UI_GRID_H - pixelH * 4];
    lnbClear _control;

    // For some reason, when dynamically creating a listbox, it comes pre-filled with columns.
    // No way to read out the count, hence the hack.
    lnbGetColumnsPosition _control apply { _control lnbDeleteColumn 0 };

    _control lnbAddColumn 0;
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 1 * UI_GRID_W, 0, 1];
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 3 * UI_GRID_W, 0, 1];
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 6 * UI_GRID_W, 0, 1];
    _control ctrlCommit 0;

    _group getVariable QGVAR(vehicles) select { !isNull _x } apply {
        private _aaTypeInfo = _aaTypes getOrDefault[[_x] call FUNC(getAAType), ["0", "???", "Unknown"]];
        _aaTypeInfo params["_aaTypeSort","_aaTypeShort","_aaTypeLong"];

        private _columnData = [];

        _columnData pushBack([0, [2, 1] select isNull gunner _x] select alive _x);
        _columnData pushBack _aaTypeSort;
        _columnData pushBack groupId gunner _x;

        private _index = _control lnbAddRow[
            "",
            (((1 - damage _x) * 100) toFixed 0) + "%",
            _aaTypeShort,
            getText(configOf _x >> "displayName")
        ];

        _control lnbSetData[[_index, 0], str _columnData];
        _control lnbSetData[[_index, 1], _x call BIS_fnc_netId];

        TRACE_2(QFUNC(tabletOverviewFocus),_x,_columnData);

        private _combatModeInfo = switch true do {
            case (isNull gunner _x): { "No gunner" };
            default { ["Fire at will", "Hold fire"] select (unitCombatMode _x isEqualTo "BLUE") };
        };

        private _gunnerInfo = switch true do {
            case (isNull gunner _x): { "No gunner" };
            case (getText(configOf gunner _x >> "simulation") isEqualTo "UAVPilot"): {
                getText(configOf gunner _x >> "displayName"); // Will most likely result in "AI"
            };
            default { name gunner _x };
        };

        _control lnbSetPicture[[_index, 0], QPATHTOEF(assets,ui\bullet-point.paa)];
        _control lnbSetPictureColor[[_index, 0], [[[0,0.8,0,1], [0.8,0.6,0,1]] select(unitCombatMode gunner _x isEqualTo "ERROR"), [0.6,0,0,1]] select(unitCombatMode gunner _x isEqualTo "BLUE")];
        _control lnbSetTooltip[[_index, 0], format[
            [
                "%1",
                "",
                "Damage: %3%4",
                "Type: %6",
                "Combat mode: %2",
                "Gunner: %5"
            ] joinString "\n",
            getText(configOf _x >> "displayName"),
            _combatModeInfo, (damage _x * 100) toFixed 0, "%",
            _gunnerInfo, RETDEF(_aaTypeLong,"WTF")
        ]];

        _control lnbSetColor[[_index, 1], [damage _x, [1,1,1,1], [1,0,0,1]] call FUNCMAIN(utilInterpolateColor)];
        _control lnbSetColor[[_index, 2], _nonMajorColumnColor];
    };

    [_control, 0] lnbSortBy["DATA"];
};

[
    [ROE_FIREATWILL, "btnFireAtWill"],
    [ROE_CIWSONLY, "btnCIWSOnly"],
    [ROE_SRSAM, "btnSRSAM"],
    [ROE_LRSAM, "btnLRSAM"],
    [ROE_HOLDFIRE, "btnHoldFire"]
] apply {
    _x params["_mode","_btnName"];
    
    private _button = _tab get _btnName;
    private _color = [
        GET_CONFIG_COLOR(QGVAR(RscButton),QUOTE(colorBackground)),
        GET_CONFIG_COLOR(QGVAR(RscButton),QUOTE(colorBackgroundActive))
    ] select(GVAR(globalROE) isEqualTo _mode);

    _button ctrlSetBackgroundColor _color;
};

STEAL_FOCUS();

nil;
