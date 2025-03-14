#include "script_component.hpp"

ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

GVAR(markerColors) = createHashMapFromArray(
    "true" configClasses(configFile >> "CfgMarkerColors") apply {
        private _color = getArray(_x >> "color") apply {
            if !(_x isEqualType "") then {
                _x;
            } else {
                [] call compile _x;
            };
        };

        [configName _x, _color];
    }
);

