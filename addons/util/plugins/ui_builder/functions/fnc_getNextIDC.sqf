#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_util_ui_builder_fnc_getNextIDC

Description:
    Get the next available IDC based on the current IDC base.

Parameters:

Optional:

Example:

Returns:
    <NUMBER> - the next available IDC based on the current IDC base.

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(getNextIDC),GVAR(idcBase));

if (GVAR(idcBase) < 0) exitWith { -1 };

private _nextIDC = GVAR(idcBase);
GVAR(idcBase) = _nextIDC + 1;

_nextIDC;
