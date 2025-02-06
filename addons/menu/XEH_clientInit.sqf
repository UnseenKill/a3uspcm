#include "script_component.hpp"

if !hasInterface exitWith {};

LOG("A3USPCM: client initialization");

[] call A3USPCM_fnc_initializeDiary;

nil;
