#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_promptText

Description:
    Internal function used to recognize input

Parameters:

Optional:

Example:

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
private _display = uiNamespace getVariable QGVAR(menuDisplay);

if (isNil "_display") exitWith {};

private _ctrlEditText = ctrlText 100;
_ctrlEditText = _ctrlEditText select[0, 32];

[_ctrlEditText, GVAR(promptMenu) get "params"] call (GVAR(promptMenu) get "callback");
GVAR(promptMenu) = nil;

nil;
