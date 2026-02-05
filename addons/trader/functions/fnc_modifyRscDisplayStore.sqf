#include "..\script_component.hpp"
#include "\x\A3A\addons\hals\Addons\store\dialog\idcs.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_trader_fnc_modifyRscDisplayStore

Description:
    Modifies the RscDisplayStore.

    Removes everything from destination dropdown, add airdrop container as only option.

Parameters:

Optional:

Returns:
    Nothing

Environment:
    Client, Scheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(modifyRscDisplayStore),_this);

private["_control","_index"];
private _display = findDisplay IDD_DISPLAY_STORE;

_control = _display displayCtrl IDC_BUY_ITEM_COMBO;
lbClear _control;
_index = _control lbAdd LLSTRING(RscDisplayStore_AirdropTarget);
_control lbSetPicture[_index, "\a3\ui_f\data\igui\cfg\simpletasks\types\Container_ca.paa"];
_control lbSetData[_index, GVAR(airdropContainer) call BIS_fnc_netId];
_control setVariable[QGVAR(locked), true];
_control lbSetCurSel _index;
_control setVariable[QGVAR(locked), nil];

// For some reason, the destination combo repopulates after _each_ purchase.
// That luckily leads to an LBSelChanged event firing, so we can use that to
// enforce our "one destination only" policy.
_control ctrlAddEventHandler["LBSelChanged", {
    params["_control"];

    // Ignore our own `lbSetCurSel` above.
    if !(_control getVariable[QGVAR(locked), false]) then {
        [] spawn FUNC(modifyRscDisplayStore);
    };
}];

nil;
