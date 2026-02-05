#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_unlockPurgeArsenal

Description:
    Remove items in arsenal missing after maybe a mod deactivation.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(unlockPurgeArsenal),_this);

#define KEEP(class) ([class] call {\
    params["_item"]; \
    ["CfgMagazines","CfgWeapons","CfgVehicles","CfgGlasses"] findIf { \
        isClass(configFile >> _x >> _item); \
    } isNotEqualTo -1; \
})

private _purged = 0;

jna_datalist = jna_datalist apply {
    _x apply {
        if !KEEP(_x # 0) then {
            TRACE_1(QFUNC(unlockPurgeArsenal),_x);
            INC(_purged);
        };

        _x;
    } select { KEEP(_x # 0) };
};

[
    LLSTRING(Unlocks_PurgeArsenalCaption),
    format[LLSTRING(Unlocks_PurgeArsenalTextSuccess), _purged]
] call A3A_fnc_customHint;

playSound "A3AP_UiSuccess";


nil;
