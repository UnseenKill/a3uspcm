#include "script_component.hpp"

[{
    INFO("loading stored markers");
    [] call FUNC(loadMarkers);
}] call FUNCMAIN(utilOnA3UServerInitDone);

[CBA_EVENT_SERVER_SAVEGAME_BEFORE, {
    INFO("saving permanent markers");

    if (isNil QGVAR(storedMarkers)) exitWith {};
    if !(GVAR(storedMarkers) isEqualType createHashMap) exitWith {
        WARNING("Invalid markers data type, expected hash map");
        TRACE_1("invalid value",GVAR(storedMarkers));
    };

    GVAR(storedMarkers) apply { TRACE_2(CBA_EVENT_SERVER_SAVEGAME_BEFORE,_x,_y) };

    private _index = 499;
    private _storedData = GVAR(storedMarkers) apply {
        INC(_index);
        private _id = format["%1#%2", QGVAR(markerId), _index];
        TRACE_3(CBA_EVENT_SERVER_SAVEGAME_BEFORE,_x,_id,_y);
        [_id, _y];
    };

    [QGVAR(storedMarkers), _storedData] call A3A_fnc_setStatVariable;
}] call CBA_fnc_addEventHandler;

nil;
