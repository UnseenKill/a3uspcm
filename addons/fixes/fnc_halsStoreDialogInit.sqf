#include "script_component.hpp"
#include "\x\A3A\addons\hals\Addons\store\dialog\idcs.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fixes_fnc_halsStoreDialogInit

Description:
    Overwrite HALs store dialog init function

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fixes_fnc_halsStoreDialogInit;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(halsStoreDialogInit),_this);

disableSerialization;

[] call {
    GVAR(halsStoreOriginalCode) = HALs_store_fnc_openStore;
    HALs_store_fnc_openStore = {
        TRACE_1(QFUNC(halsStoreDialogInit),_this);
        call GVAR(halsStoreOriginalCode);

        waitUntil { !isNull findDisplay IDD_DISPLAY_STORE };
        private _display = findDisplay IDD_DISPLAY_STORE;
        [_display] call FUNC(halsStoreDialogAdjust);
    };
};

nil;
