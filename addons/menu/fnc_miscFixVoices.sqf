#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscFixVoices

Description:
    Plain old english, please.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3USPCM_fnc_miscFixVoices;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscFixVoices),_this);

private _voices = ["Male01ENG", "Male02ENG", "Male03ENG", "Male04ENG", "Male05ENG", "Male06ENG", "Male07ENG", "Male08ENG", "Male09ENG", "Male10ENG", "Male11ENG", "Male12ENG"];

A3A_faction_reb set["voices", _voices];

private _voice = selectRandom _voices;

[_voice, units group player] remoteExec[QFUNCMAIN(utilSetUnitsSpeaker), 0];

systemChat format["Voices set to %1", _voice];

nil;
