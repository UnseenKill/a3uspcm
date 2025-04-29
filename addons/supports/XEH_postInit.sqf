#include "script_component.hpp"

["Mortar_01_base_F"] call FUNC(addArtillerySupportActions);
["TwinMortar_base_RF"] call FUNC(addArtillerySupportActions);

if !is3DENPreview then {
    GVAR(postInitDone) = true;
};

nil;
