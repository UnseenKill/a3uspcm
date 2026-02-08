#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_getSecurityReferenceMenuItemName

Description:
    What a long function name.

Parameters:

Optional:

Returns:
    <STRING> Menu item name to use for the security reference menu item.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getSecurityReferenceMenuItemName),_this);

if (isNil QGVAR(securityReferenceSetting)) exitWith {"No reference set; menu item shouldn't be visible"};

TRACE_1(QFUNC(getSecurityReferenceMenuItemName),GVAR(securityReferenceSetting));

switch true do {
    case (GVAR(securityReferenceSetting) isEqualType []): {
        format[LLSTRING(OrdersSecurity_Item_CycleReference_DisplayName), mapGridPosition GVAR(securityReferenceSetting)];
    };
    case (GVAR(securityReferenceSetting) isEqualType objNull): {
        private _name = if (GVAR(securityReferenceSetting) isKindOf "CAManBase") then {
            name GVAR(securityReferenceSetting);
        } else {
            private _config = configOf GVAR(securityReferenceSetting);

            if (getText(_config >> "displayNameShort") isNotEqualTo "") then {
                getText(_config >> "displayNameShort");
            } else {
                getText(_config >> "displayName");
            };
        };

        format[LLSTRING(OrdersSecurity_Item_CycleReference_DisplayName), _name];
    };
    default {
        WARNING_1("Invalid security reference type: %1",GVAR(securityReferenceSetting));
        "Invalid reference; refer to logs";
    }
};
