#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_getGroupMenuText

Description:
    Get the menu text for a group

Parameters:
    0: _group - Group to get menu text for <OBJECT>

Optional:

Example:

Returns:
    Menu text <STRING>

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_group", grpNull, [grpNull]]
];

if !assert(!isNull _group) exitWith {""};

groupId _group;
