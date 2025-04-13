#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

[
    ELSTRING(main,Title),
    QGVAR(CenterOnHQ),
    [LSTRING(CenterOnHQText), LSTRING(CenterOnHQTooltip)],
    {},
    {
        [] call FUNC(centerOnHQ);
    }
] call CBA_fnc_addKeybind;

[
    ELSTRING(main,Title),
    QGVAR(CenterOnPlayer),
    [LSTRING(CenterOnPlayerText), LSTRING(CenterOnPlayerTooltip)],
    {},
    {
        [] call FUNC(centerOnPlayer);
    }
] call CBA_fnc_addKeybind;

GVAR(groupsCount) = 0;
