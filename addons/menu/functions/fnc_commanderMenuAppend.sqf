#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_commanderMenuAppend

Description:
    Append A3USPCM menu to commander menu

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(appendCommanderMenu),_this);

if (GVAR(injectA3USPCMTab) isEqualTo -1) exitWith {};

GVAR(SCRT_fnc_ui_populateCommanderMenu) = SCRT_fnc_ui_populateCommanderMenu;
SCRT_fnc_ui_populateCommanderMenu = {
    TRACE_1(QFUNC(SCRT_fnc_ui_populateCommanderMenu),_this);

    call GVAR(SCRT_fnc_ui_populateCommanderMenu);

    private _injectTab = [QUOTE(PREFIX), 61198200];

    if (GVAR(injectA3USPCMTab) isEqualTo false) exitWith {
        menuSliderArray pushBack _injectTab;
    };

    if (GVAR(injectA3USPCMTab) isEqualTo true) exitWith {
        menuSliderArray = [_injectTab] + menuSliderArray;
    };
};

nil;
