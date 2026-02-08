#define COMPONENT advanced_ai_orders
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

#define PAD_WIDTH 70

#define CBA_EVENT_ADVANCE_FORWARD QUOTE(TRIPLES(PREFIX,events,advanceForward))
#define CBA_EVENT_AAIO_RADIO_EQUIPPED QUOTE(TRIPLES(PREFIX,events,aaioRadioEquipped))
#define CBA_EVENT_AAIO_RADIO_UNEQUIPPED QUOTE(TRIPLES(PREFIX,events,aaioRadioUnequipped))
#define CBA_EVENT_PLAYER_LOADOUT_CHANGED QUOTE(TRIPLES(PREFIX,events,playerLoadoutChanged))
#define CBA_EVENT_SAD_TERMINATE QUOTE(TRIPLES(PREFIX,events,sadTerminate))
#define CBA_EVENT_SEARCH_AND_DESTROY QUOTE(TRIPLES(PREFIX,events,searchAndDestroy))
#define CBA_EVENT_ADVANCE_CYCLE_REFERENCE QUOTE(TRIPLES(PREFIX,events,advanceCycleReference))
#define CBA_EVENT_SECURITY_GUARD_FRONT QUOTE(TRIPLES(PREFIX,events,securityGuardFront))
#define CBA_EVENT_SECURITY_GUARD_REAR QUOTE(TRIPLES(PREFIX,events,securityGuardRear))
#define CBA_EVENT_SECURITY_PULL360 QUOTE(TRIPLES(PREFIX,events,securityPull360))
#define CBA_EVENT_SECURITY_RETURN_TO_POSITION QUOTE(TRIPLES(PREFIX,events,securityReturnToPosition))
#define CBA_EVENT_SETTINGS_SET_SAD_RALLY_DISTANCE QUOTE(TRIPLES(PREFIX,events,settingsSetSADRallyDistance))
#define CBA_EVENT_SETTINGS_SET_SAD_STAGING_DISTANCE QUOTE(TRIPLES(PREFIX,events,settingsSetSADStagingDistance))
#define CBA_EVENT_SETTINGS_SET_SAD_SWEEP_TIME QUOTE(TRIPLES(PREFIX,events,settingsSetSADSweepTime))
#define CBA_EVENT_SETTINGS_SET_SECURITY_DISTANCE QUOTE(TRIPLES(PREFIX,events,settingsSetSecurityDistance))
#define CBA_EVENT_SHOW_NOTIFICATION QUOTE(TRIPLES(PREFIX,events,showNotification))
#define CBA_EVENT_UPDATE_COMMS_MENU QUOTE(TRIPLES(PREFIX,events,updateCommsMenu))
