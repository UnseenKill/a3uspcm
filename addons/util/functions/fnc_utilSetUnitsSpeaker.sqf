#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilSetUnitsSpeaker

Description:
    Sets the speaking voice for a group of units.

Parameters:
    0: _voice - Voice to set <STRING>
    1: _units - Units to set voice for <ARRAY>

Optional:

Example:
    (begin example)
    ["Male01ENG", units group player] call A3USPCM_fnc_utilSetUnitsSpeaker;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(utilSetUnitsSpeaker),_this);

params[
    ["_voice", "", [""]],
    ["_units", [], [[]]]
];

if (_voice == "" || _units isEqualTo []) exitWith {};

{
    _x setSpeaker _voice;
} forEach _units;

nil;
