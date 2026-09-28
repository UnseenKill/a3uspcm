#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3A_garrison_rework_fnc_openManager

Description:
    Open the advanced garrison manager dialog.

Parameters:

Optional:
    0: _location - optional location to preselect <STRING>

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

_this spawn {
    private _canOpen = true;
    private _inUsePlayer = missionNamespace getVariable QGVAR(agmInUse);

    if !(isNil { _inUsePlayer }) then {
        LOG_1("garrison manager in use by ""%1""",_inUsePlayer);

        private _canKick = [] call BIS_fnc_admin;
        _canKick = (_canKick isNotEqualTo 0) || { isServer && hasInterface };
        _canOpen = false;

        if !(_canKick) exitWith { LOG("Cannot kick current user, exiting.") };
        if !([format[LLSTRING(InUseWannaKick_Message), _inUsePlayer], LLSTRING(Dialog_MainTitle), true, true] call BIS_fnc_guiMessage) exitWith { LOG("User chose not to kick current user, exiting.") };

        [CBA_EVENT_TERMINATE_UI, [name player]] call CBA_fnc_remoteEvent;
        private _ready = waitUntil[{ isNil { missionNamespace getVariable QGVAR(agmInUse) } }, 5];
        _canOpen = !isNil "_ready";

        LOG_1("Ready status after attempting to terminate UI: %1",RETNIL(_ready));

        if !(_canOpen) then {
            ERROR("Failed to terminate UI and free up garrison manager.");
        };
    };

    if !(_canOpen) exitWith {
        playSound "A3AP_UiFailure";
        [LLSTRING(Dialog_MainTitle), format[LLSTRING(InUse_Message), _inUsePlayer]] call A3A_fnc_customHint;
    };

    missionNamespace setVariable[QGVAR(visibleMap), visibleMap];
    openMap true;

    waitUntil { !isNull findDisplay 12 };

    private _location = param[0, nil, [""]];
    missionNamespace setVariable[QGVAR(preselectedLocation), RETNIL(_location)];
    LOG_1("Preselected location: %1",RETNIL(_location));

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

    nil;
};

nil;
