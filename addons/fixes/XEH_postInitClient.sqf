#include "script_component.hpp"

INFO("A3U fixes post-init (client)");

[] call FUNC(fixCargoLoadedStaticsMounting);
[] call FUNC(halsStoreDialogInit);

nil;
