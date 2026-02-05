#include "script_component.hpp"

INFO("A3U fixes post-init");

[] call FUNC(halsStoreDialogInit);
[] call FUNC(fixSaveLoop);

nil;
