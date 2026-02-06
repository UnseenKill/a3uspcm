#include "script_component.hpp"

GVAR(refuseRereadYieldChance) = 5;

[{
    [] spawn FUNC(initBuildableObjects);
    [] call FUNC(initItemContextMenu);
}] call FUNCMAIN(utilOnA3UClientInitDone);
