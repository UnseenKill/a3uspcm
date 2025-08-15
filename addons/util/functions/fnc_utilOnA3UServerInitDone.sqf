#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_utilOnA3UServerInitDone

Description:
    Function to be called when A3U has finished server initializing

Parameters:
    0: _callback - function to be called <CODE>

Optional:

Example:
    (begin example)
    [{ hint "Done" }] call A3USPCM_fnc_utilOnA3UServerInitDone;
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
if is3DEN exitWith {};

//TRACE_1(QFUNCMAIN(utilOnA3UServerInitDone),_this);

params[["_callback", {}, [{}]]];

GVAR(ServerInitCallbacks) pushBack _callback;

nil;
