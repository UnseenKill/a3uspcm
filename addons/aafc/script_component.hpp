#define COMPONENT aafc
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Wait this many seconds after client init done before auto-grouping A/A
#define AUTO_GROUP_DELAY 15

#define MODE_OPENFIRE QGVAR(ModeOpenFire)
#define MODE_HOLDFIRE QGVAR(ModeHoldFire)

#define ROE_FIREATWILL 0
#define ROE_CIWSONLY 1
#define ROE_SRSAM 2
#define ROE_LRSAM 3
#define ROE_HOLDFIRE 4

// Parameters: [Display display]
#define CBA_EVENT_AAFC_DIALOG_CLOSED QUOTE(TRIPLES(ADDON,events,dialogClosed))
// Parameters: [Display display]
#define CBA_EVENT_AAFC_DIALOG_OPENED QUOTE(TRIPLES(ADDON,events,dialogOpened))
// Parameters: [Display display, Control ctlTabHost, Hashmap tabInfo]
#define CBA_EVENT_AAFC_DIALOG_TABSETUP QUOTE(TRIPLES(ADDON,events,dialogSetupTab))
// Parameters: [Number idcNewTab]
#define CBA_EVENT_AAFC_DIALOG_TABSWITCH QUOTE(TRIPLES(ADDON,events,dialogSwitchTab))
// Parameters: [Hashmap focusedTab[, Hashmap unfocusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_AFTER QUOTE(TRIPLES(ADDON,events,dialogTabFocusAfter))
// Parameters: [Hashmap focusedTab[, Hashmap unfocusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_FOCUS_BEFORE QUOTE(TRIPLES(ADDON,events,dialogTabFocusBefore))
// Parameters: [Hashmap unfocusedTab[, Hashmap focusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_AFTER QUOTE(TRIPLES(ADDON,events,dialogTabUnfocusAfter))
// Parameters: [Hashmap unfocusedTab[, Hashmap focusedTab]]
#define CBA_EVENT_AAFC_DIALOG_TAB_UNFOCUS_BEFORE QUOTE(TRIPLES(ADDON,events,dialogTabUnfocusBefore))

// Parameters: [Number roeLevel]
#define CBA_EVENT_AAFC_SET_ROE_GLOBAL QUOTE(TRIPLES(ADDON,events,setROEGlobal))
// Parameters: [Group group]
#define CBA_EVENT_AAFC_UPDATE_GROUP QUOTE(TRIPLES(ADDON,events,updateGroup))

#ifdef __A3USPCM_PRODUCTION__
    #define CBA_TRIGGER(eventName,params) [eventName, params] call CBA_fnc_localEvent
#else
    #define CBA_TRIGGER(eventName,params) if true then { \
        TRACE_1("CBA_TRIGGER:"+eventName,params); \
        [eventName, params] call CBA_fnc_localEvent; \
    }
#endif // __A3USPCM_PRODUCTION__
