#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_a3uChangeParameter

Description:
    Change A3U parameter menu callback

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
TRACE_1(QFUNC(a3uChangeParameter),_this);

params[
    ["_variable","",[""]],
    ["_prompt","",[""]],
    ["_type","",[""]]
];

private _value = call compile _variable;

if !(_value isEqualType "") then {
    _value = str _value;
};

[_prompt, _value, {
    TRACE_1(QFUNC(a3uChangeParameter),_this);
    params[
        ["_input", "", [""]],
        ["_params", [], [[]]]
    ];

    if (_input isEqualTo "") exitWith {};

    _params params[
        ["_variable", "", [""]],
        ["_type", "", [""]]
    ];

    private _original = call compile _variable;
    private["_value"];

    switch _type do {
        case "NUMBER": {
            _value = parseNumber _input;
            if (_value isEqualType false) then {
                WARNING_2("%1(%2) - invalid value",QFUNC(a3uChangeParameter),_input);
            };
        };

        default { 
            ERROR_2("%1(%2) - invalid type",QFUNC(a3uChangeParameter),_type);
        };
    };

    if !isNil "_value" then {
        if !(_value isEqualType _original) then {
            WARNING_4("%1(%2) - value type mismatch (original=%3,input=%4)",QFUNC(a3uChangeParameter),_value,typeName _original,typeName _value);
        } else {
            INFO_5("%1(%2) change from %3 (%4) to %5",QFUNC(a3uChangeParameter),_variable,_original,typeName _original,_value);
            call compile format["%1 = %2", _variable, _value];
        };
    };
}, [_variable, _type]] call FUNCMAIN(utilPromptText);

nil;
