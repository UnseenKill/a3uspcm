#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_advanced_ai_orders_fnc_showNotification

Description:
    Show a notification to the player.

Parameters:
    0: _player - Player to show notification to <OBJECT>
    1: _caption - Notification caption <STRING>
    2: _message - Notification message <STRING>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(showNotification),_this);

if !assert(params[
    ["_player", nil, [objNull]],
    ["_caption", nil, [""]],
    ["_message", nil, [""]]
]) exitWith {};
if !assert(!isNull _player) exitWith {};

_player groupChat format["%1: %2", _caption, _message];

nil;
