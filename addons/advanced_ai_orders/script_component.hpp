#define COMPONENT advanced_ai_orders
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

#define CBA_EVENT_PLAYER_LOADOUT_CHANGED QUOTE(TRIPLES(PREFIX,events,playerLoadoutChanged))
#define CBA_EVENT_AAIO_RADIO_EQUIPPED QUOTE(TRIPLES(PREFIX,events,aaioRadioEquipped))
#define CBA_EVENT_AAIO_RADIO_UNEQUIPPED QUOTE(TRIPLES(PREFIX,events,aaioRadioUnequipped))
#define CBA_EVENT_SETTINGS_SET_SECURITY_DISTANCE QUOTE(TRIPLES(PREFIX,events,settingsSetSecurityDistance))
#define CBA_EVENT_SECURITY_PULL360 QUOTE(TRIPLES(PREFIX,events,securityPull360))
