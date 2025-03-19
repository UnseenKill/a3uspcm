#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_aafc_fnc_updateMenu

Description:
    Update the menu

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
GVAR(updateContext) params[
    ["_player", objNull, [objNull]],
    ["_record", diaryRecordNull, [diaryRecordNull]],
    ["_config", configNull, [configNull]]
];

[_player, _record, _config] call EFUNC(menu,updateDiaryRecord);

nil;
