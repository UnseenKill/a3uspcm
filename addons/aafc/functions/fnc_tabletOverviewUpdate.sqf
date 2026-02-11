#include "..\script_component.hpp"
#include "..\RscConst.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletOverviewUpdate

Description:
    Update tablet overview controls after tab focus

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
    _control ctrlSetText LLSTRING(Tablet_TabhostOverview_HintNoGroups_Text);
    _control ctrlCommit 0;
};

private _aaTypes = createHashMapFromArray[
    [AA_TYPE_UNKNOWN, [0, "???", LLSTRING(AAType_Unknown)]],
    [AA_TYPE_CIWS, [1, "CIWS", LLSTRING(AAType_CIWS)]],
    [AA_TYPE_LRSAM, [3, "LR/SAM", LLSTRING(AAType_LRSAM)]],
    [AA_TYPE_RADAR, [9, "RDR", LLSTRING(AAType_RADAR)]],
    [AA_TYPE_SPAAG, [4, "SPAAG", LLSTRING(AAType_SPAAG)]],
    [AA_TYPE_SRSAM, [2, "SR/SAM", LLSTRING(AAType_SRSAM)]]
];

private _dotColors = [
    [[0.2,0.2,0.2,1], QUOTE(!alive _vehicle)],
    [[1,1,1,0], QUOTE(_aaType isEqualTo QUOTE(AA_TYPE_RADAR))],
    [[0.8,0.6,0,1], QUOTE(isNull gunner _vehicle)],
    [[0.6,0,0,1], QUOTE(unitCombatMode gunner _vehicle isEqualTo QQUOTE(BLUE))],
    [[0,0.8,0,1], QUOTE(true)]
];

// [Individual groups tabhost] -------------------------------------------------
private _index = -1;
private _groups = GVAR(groups) apply { [groupId _x, _x] };
_groups sort true;
_groups apply {
    private _group = _x select -1;
    private _backgroundColor = [1,1,1,[0.1, 0.25] select (_index mod 2)];
    private _nonMajorColumnColor = [0.7,0.7,0.7,1];

    _startY = -UI_GRID_H - pixelH * 4;

    CBA_EVENT_LOCAL(CBA_EVENT_AAFC_UPDATE_GROUP,[_group]);

    INC(_index);
    ADD(_startX,16 * UI_GRID_W + pixelW * 4);

    // [Group name label] ------------------------------------------------------
    _control = _display ctrlCreate[QGVAR(RscText), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX, 0, 16 * UI_GRID_W, UI_GRID_H];
    _control ctrlSetText format["%1", groupId _group];
    _control ctrlSetBackgroundColor _backgroundColor;
    _control ctrlCommit 0;

    // [Unlink from ROE button] ------------------------------------------------
    _control = _display ctrlCreate[QGVAR(RscButtonUnlink), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX + UI_GRID_W * 15, 0, UI_GRID_W, UI_GRID_H];
    _control ctrlSetTooltip LLSTRING(Tablet_TabhostOverview_BtnUnlink_Tooltip);
    [{
        params["_control","_group"];
        _control ctrlEnable !(_group getVariable[QGVAR(unlinkROE), false]);
        _control ctrlShow !(_group getVariable[QGVAR(unlinkROE), false]);
    }, [_control, _group], 3] call CBA_fnc_execAfterNFrames;
    _control ctrlCommit 0;
    _control setVariable[QGVAR(group), _group];
    _control setVariable[QGVAR(unlink), true];
    _control ctrlAddEventHandler["ButtonClick", {
        TRACE_1(QFUNC(tabletOverviewUpdate),_this);
        params["_control"];

        _control getVariable QGVAR(group) setVariable[QGVAR(unlinkROE), true];
        _control ctrlEnable false;
        _control ctrlShow false;
        allControls ctrlParentControlsGroup _control apply {
            if ((_x getVariable[QGVAR(link), false]) &&
                {_x getVariable[QGVAR(group), grpNull] isEqualTo (_control getVariable QGVAR(group))}) exitWith {
                TRACE_1(QFUNC(tabletOverviewUpdate),_x);
                _x ctrlEnable true;
                _x ctrlShow true;
                _x ctrlCommit 0;
            };
        };
    }];

    // [Link to ROE button] ----------------------------------------------------
    _control = _display ctrlCreate[QGVAR(RscButtonLink), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX + UI_GRID_W * 15, 0, UI_GRID_W, UI_GRID_H];
    _control ctrlSetTooltip LLSTRING(Tablet_TabhostOverview_BtnLink_Tooltip);
    _control ctrlSetTextColor [0.5,0,0,1];
    [{
        params["_control","_group"];
        _control ctrlEnable (_group getVariable[QGVAR(unlinkROE), false]);
        _control ctrlShow (_group getVariable[QGVAR(unlinkROE), false]);
    }, [_control, _group], 3] call CBA_fnc_execAfterNFrames;
    _control ctrlCommit 0;
    _control setVariable[QGVAR(group), _group];
    _control setVariable[QGVAR(link), true];
    _control ctrlAddEventHandler["ButtonClick", {
        TRACE_1(QFUNC(tabletOverviewUpdate),_this);
        params["_control"];

        _control getVariable QGVAR(group) setVariable[QGVAR(unlinkROE), false];
        _control ctrlEnable false;
        _control ctrlShow false;
        allControls ctrlParentControlsGroup _control apply {
            if ((_x getVariable[QGVAR(unlink), false]) &&
                {_x getVariable[QGVAR(group), grpNull] isEqualTo (_control getVariable QGVAR(group))}) exitWith {
                TRACE_1(QFUNC(tabletOverviewUpdate),_x);
                _x ctrlEnable true;
                _x ctrlShow true;
                _x ctrlCommit 0;
            };
        };
    }];

    // [Unit/vehicle list] -----------------------------------------------------
    _control = _display ctrlCreate[QGVAR(RscListNBox), 0, _ctlTabHost];
    _control ctrlSetPosition[_startX, UI_GRID_H + pixelH * 4, 16 * UI_GRID_W, _th - UI_GRID_H - pixelH * 4];
    lnbClear _control;

    _control lnbAddColumn 0;
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 2 * UI_GRID_W, 0, 1];
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 4 * UI_GRID_W, 0, 1];
    _control lnbAddColumn linearConversion[0, UI_GRID_W * 16, 7 * UI_GRID_W, 0, 1];
    _control ctrlCommit 0;

    _control ctrlAddEventHandler["LBDblClick", {
        TRACE_1(QFUNC(tabletOverviewUpdate),_this);
        params["_control","_index"];

        private _data = _control lnbData[_index, 0] splitString ",";
        if (_data select 0 isNotEqualTo "2") exitWith { /* fuck me this is hacky */ };
        private _group = (_control lnbData[_index, 2]) call BIS_fnc_groupFromNetId;
        private _vehicle = (_control lnbData[_index, 1]) call BIS_fnc_objectFromNetId;

        if !(_group getVariable[QGVAR(unlinkROE), false]) exitWith {};
        private _holdingFire = unitCombatMode gunner _vehicle isEqualTo "BLUE";

        crew _vehicle select { alive _x } apply {
            _x setUnitCombatMode(["BLUE", "YELLOW"] select _holdingFire);
        };

        CBA_EVENT_LOCAL(CBA_EVENT_AAFC_SET_ROE_GLOBAL,[GVAR(globalROE)]);
    }];

    _group getVariable QGVAR(vehicles) select { !isNull _x } apply {
        private _vehicle = _x;
        private _aaType = [_vehicle] call FUNC(getAAType);
        private _aaTypeInfo = _aaTypes getOrDefault[_aaType, ["0", "???", LLSTRING(AAType_Unknown)]];
        _aaTypeInfo params["_aaTypeSort","_aaTypeShort","_aaTypeLong"];

        private _columnData = [];

        _columnData pushBack([0, [2, 1] select isNull gunner _vehicle] select alive _vehicle);
        _columnData pushBack _aaTypeSort;
        _columnData pushBack groupId gunner _vehicle;

        private _index = _control lnbAddRow[
            ["", "F"] select(alive _vehicle && { !isNull gunner _vehicle } && { unitCombatMode gunner _vehicle isNotEqualTo "BLUE" }),
            (((1 - damage _vehicle) * 100) toFixed 0) + "%",
            _aaTypeShort,
            getText(configOf _vehicle >> "displayName")
        ];

        _control lnbSetData[[_index, 0], _columnData joinString ","];
        _control lnbSetData[[_index, 1], _vehicle call BIS_fnc_netId];
        _control lnbSetData[[_index, 2], _group call BIS_fnc_netId];

        TRACE_2(QFUNC(tabletOverviewFocus),_vehicle,_columnData);

        private _dotColor = {
            _x params["_color","_code"];
            if (call compile _code) exitWith { _color };
        } forEach _dotColors;

        private _combatModeInfo = switch true do {
            case (isNull gunner _vehicle): { LLSTRING(Tablet_TabhostOverview_HintNoGunner_Text) };
            default { [LLSTRING(Tablet_TabhostOverview_BtnFireAtWill_Text), LLSTRING(Tablet_TabhostOverview_BtnHoldFire_Text)] select (unitCombatMode _vehicle isEqualTo "BLUE") };
        };

        private _gunnerInfo = switch true do {
            case (isNull gunner _vehicle): { LLSTRING(Tablet_TabhostOverview_HintNoGunner_Text) };
            case (getText(configOf gunner _vehicle >> "simulation") isEqualTo "UAVPilot"): {
                getText(configOf gunner _vehicle >> "displayName"); // Will most likely result in "AI"
            };
            default { name gunner _vehicle };
        };

        _control lnbSetPicture[[_index, 0], QPATHTOEF(assets,ui\bullet-point.paa)];
        _control lnbSetPictureColor[[_index, 0], RETDEF(_dotColor,[ARR_4(1,0,1,1)])];
        _control lnbSetTooltip[[_index, 0], format[
            LLSTRING(Tablet_TabhostOverview_HintLnbUnits_Tooltip),
            getText(configOf _vehicle >> "displayName"),
            _combatModeInfo, (damage _vehicle * 100) toFixed 0, "%",
            _gunnerInfo, RETDEF(_aaTypeLong,"WTF")
        ]];

        _control lnbSetColor[[_index, 1], [damage _vehicle, [1,1,1,1], [1,0,0,1]] call FUNCMAIN(utilInterpolateColor)];
        _control lnbSetColor[[_index, 2], _nonMajorColumnColor];
    };

    [_control, 0] lnbSortBy["DATA"];
};

// [ROE buttons update] --------------------------------------------------------

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

nil;
