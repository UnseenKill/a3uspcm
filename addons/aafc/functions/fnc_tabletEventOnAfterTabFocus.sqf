#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_tabletEventOnAfterTabFocus

Description:
    CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_AFTER event handler. Set focus on tabhost.

Parameters:
    0: _focusedTab - Tab info data of focused tab <HASHMAP>

Optional:
    1: _unfocusedTab - Tab info data of previously focused tab <HASHMAP>

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(tabletEventOnAfterTabFocus),_this);

if !assert(params[
    ["_focusedTab", nil, [createHashMap]]
]) exitWith {};

[{
    params["_focusedTab"];
    private _ctlTabHost = _focusedTab get "tabhost";
    ctrlSetFocus _ctlTabHost;
}, [_focusedTab]] call CBA_fnc_execNextFrame;

nil;
