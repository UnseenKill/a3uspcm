#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_onMenuInit

Description:
    Receive the menu init event

Parameters:
    0: _player - Player for which to create record <OBJECT>
    1: _entry - Diary entry <OBJECT>
    2: _config - Config for diary record <CONFIG>

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(onMenuInit),_this);

params[
    ["_player", objNull, [objNull]],
    ["_entry", diaryRecordNull, [diaryRecordNull]],
    ["_config", configNull, [configNull]]
];

if !assert(!isNull _player) exitWith {};
if !assert(!isNull _entry) exitWith {};
if !assert(!isNull _config) exitWith {};

GVAR(updateContext) = _this;

nil;
