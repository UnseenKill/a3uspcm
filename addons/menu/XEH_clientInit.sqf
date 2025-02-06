#include "script_component.hpp"

if !hasInterface exitWith {};

INFO_1(localize LSTRING(InitMessage),QUOTE(VERSION_STR));

[] call FUNC(diaryInitialize);

nil;
