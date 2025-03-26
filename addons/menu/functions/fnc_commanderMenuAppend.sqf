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

GVAR(SCRT_fnc_ui_populateCommanderMenu) = SCRT_fnc_ui_populateCommanderMenu;
SCRT_fnc_ui_populateCommanderMenu = {
    TRACE_1(QFUNC(SCRT_fnc_ui_populateCommanderMenu),_this);

    call GVAR(SCRT_fnc_ui_populateCommanderMenu);
    menuSliderArray pushBack[QUOTE(PREFIX), 61198200];
};

nil;
