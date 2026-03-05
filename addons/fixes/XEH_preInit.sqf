#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

[FUNC(fixLandingLights)] call FUNCMAIN(utilOnA3UServerInitDone);
