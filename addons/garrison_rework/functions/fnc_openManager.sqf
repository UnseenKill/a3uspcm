#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3A_garrison_rework_fnc_openManager

Description:
    Open the advanced garrison manager dialog.

Parameters:

Optional:

Example:
    (begin example)
    [] call A3A_garrison_rework_fnc_openManager;
    (end example)

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(openManager),_this);

[] spawn {
    openMap true;

    waitUntil { !isNull findDisplay 12 };

    private _display = findDisplay 12 createDisplay QGVAR(RscDisplayEmpty);
    private _config = configFile >> QGVAR(Config) >> "Dialog";
    private _control = [_config, _display] call ESFUNC(util,ui_builder,buildUI);

#ifdef __EVIL_BITCH_MONSTER_OF_DEATH__
    _control ctrlSetFade 0;
    _control ctrlCommit 0;
#else
    private _position = ctrlPosition _control;
    _control ctrlSetPositionY(safeZoneY + safeZoneH);
    _control ctrlCommit 0;

    [{
        params["_control","_py"];
        _control ctrlSetFade 0;
        _control ctrlSetPositionY _py;
        _control ctrlCommit 0.25;
    }, [_control, _position select 1]] call CBA_fnc_execNextFrame;
#endif

    //[_control] call ESFUNC(util,ui_builder,dumpControl);

    nil;
};

nil;
