#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_onMenuInit

Description:
    Receive the menu init event

Parameters:
    0: _name - Menu name <STRING>
    1: _entry - Diary entry <OBJECT>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_name", "", [""]],
    ["_entry", diaryRecordNull, [diaryRecordNull]]
];

if !assert(_name isNotEqualTo "") exitWith {};
if !assert(!isNull _entry) exitWith {};


nil;
