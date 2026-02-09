#define COMPONENT aafc
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Wait this many seconds after client init done before auto-grouping A/A
#define AUTO_GROUP_DELAY 15

#define MODE_OPENFIRE QGVAR(ModeOpenFire)
#define MODE_HOLDFIRE QGVAR(ModeHoldFire)

// Parameters: [Display display]
#define CBA_EVENT_AAFC_DIALOG_CLOSED QGVAR(TRIPLES(ADDON,events,dialogClosed))
// Parameters: [Display display]
#define CBA_EVENT_AAFC_DIALOG_OPENED QGVAR(TRIPLES(ADDON,events,dialogOpened))
// Parameters: [Number idcNewTab]
#define CBA_EVENT_AAFC_DIALOG_SWITCHTAB QGVAR(TRIPLES(ADDON,events,dialogSwitchTab))
// Parameters: [Hashmap focusedTab[, Hashmap unfocusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_AFTER QGVAR(TRIPLES(ADDON,events,dialogTabFocusAfter))
// Parameters: [Hashmap focusedTab[, Hashmap unfocusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE QGVAR(TRIPLES(ADDON,events,dialogTabFocusBefore))
// Parameters: [Hashmap unfocusedTab[, Hashmap focusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_AFTER QGVAR(TRIPLES(ADDON,events,dialogTabUnfocusAfter))
// Parameters: [Hashmap unfocusedTab[, Hashmap focusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_BEFORE QGVAR(TRIPLES(ADDON,events,dialogTabUnfocusBefore))
