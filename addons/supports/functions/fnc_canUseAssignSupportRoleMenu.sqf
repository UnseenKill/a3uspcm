#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_canUseAssignSupportRoleMenu

Description:
    Callback function to check if the assign support role menu can be opened.

Parameters:
    0: _param1 - description <TYPE>
    1: _param2 - description <TYPE>

Optional:
    2: _param3 - description <TYPE>

Example:
    (begin example)
    ["param1", "param2"] call PREFIX_fnc_name;
    (end example)

Returns:
    Return description <TYPE>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(canUseAssignSupportRoleMenu),_this);

true;
