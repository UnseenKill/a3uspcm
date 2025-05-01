#include "script_component.hpp"

INFO("A3U fixes post-init");

[] call FUNC(fixCargoLoadedStaticsMounting);
[] call FUNC(halsStoreDialogInit);
[] call FUNC(fixSaveLoop);

nil;
