#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilPromptText

Description:
    Simple text input prompt

Parameters:
    0: _title - Title of the prompt <STRING>
    1: _default - Default value <STRING>
    2: _callback - Callback function <CODE>

Optional:
    3: _params - Additional parameters for the callback function <ANY>

Example:
    (begin example)
    ["The answer", "42", {
        params["_answer","_params"];
        hint format["You answered: %1", _answer];
    }] call A3USPCM_fnc_utilPromptText;
    (end)

Returns:

Author:
    goreSplatter
---------------------------------------------------------------------------- */
params[
    ["_title", "", [""]],
    ["_default", "", [""]],
    ["_callback", {}, [{}]],
    ["_params", []]
];

GVAR(promptMenu) = createHashMapFromArray[
    ["caption", _title],
    ["prefill", _default],
    ["callback", _callback],
    ["params", _params]
];

createDialog QGVAR(promptMenu);

nil;
