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
    _button ctrlSetActiveColor [1,0,0,1];
};

nil;
