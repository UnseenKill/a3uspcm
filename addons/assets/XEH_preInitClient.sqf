#include "script_component.hpp"

[{
    [] spawn FUNC(initBuildableObjects);
    [] call FUNC(initItemContextMenu);
}] call FUNCMAIN(utilOnA3UClientInitDone);
