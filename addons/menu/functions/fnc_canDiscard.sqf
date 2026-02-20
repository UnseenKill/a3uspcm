#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_canDiscard

Description:
    Callback condition if container's contents can be discarded from arsenal

Parameters:
    0: _container - Container object <OBJECT>

Optional:

Example:
    (begin example)
    [box1] call A3USPCM_menu_fnc_canDiscard;
    (end example)

Returns:
    <BOOL>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
call FUNC(canUnlock);
