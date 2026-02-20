#define COMPONENT aafc
#include "\z\a3uspcm\addons\main\script_mod.hpp"
#include "\z\a3uspcm\addons\main\script_macros.hpp"

// Wait this many seconds after client init done before auto-grouping A/A
#ifdef __A3USPCM_PRODUCTION__
    #define AUTO_GROUP_DELAY 15
#else
    #define AUTO_GROUP_DELAY ([15,1] select is3DENPreview)
#endif // __A3USPCM_PRODUCTION__

#define AA_TYPE_UNKNOWN QUOTE(unknown)
#define AA_TYPE_RADAR QUOTE(radar)
#define AA_TYPE_CIWS QUOTE(ciws)
#define AA_TYPE_SRSAM QUOTE(srSAM)
#define AA_TYPE_LRSAM QUOTE(lrSAM)
#define AA_TYPE_SPAAG QUOTE(selfPropelledAA)

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

// Parameters: [Object contact]
#define CBA_EVENT_AAFC_CONTACT_ADDED QUOTE(TRIPLES(ADDON,events,contactAdded))
// Parameters: [Object contact]
#define CBA_EVENT_AAFC_CONTACT_UPDATE QUOTE(TRIPLES(ADDON,events,contactUpdate))
// Parameters: []
#define CBA_EVENT_AAFC_ROE_MONITOR QUOTE(TRIPLES(ADDON,events,ROEMonitor))
// Parameters: [Number roeLevel]
#define CBA_EVENT_AAFC_SET_ROE_GLOBAL QUOTE(TRIPLES(ADDON,events,setROEGlobal))
// Parameters: [Object unitOrVehicle, Boolean canFire]
#define CBA_EVENT_AAFC_SET_UNIT_CANFIRE QUOTE(TRIPLES(ADDON,events,setUnitCanFire))
// Parameters: [Object sender, String message]
#define CBA_EVENT_AAFC_SIDECHAT QUOTE(TRIPLES(ADDON,events,sideChat))
// Parameters: [Object sender, String message]
#define CBA_EVENT_AAFC_SIDECHAT_CONTACT QUOTE(TRIPLES(ADDON,events,sideChatContact))
// Parameters: [Object sender, String message]
#define CBA_EVENT_AAFC_SIDECHAT_FIRED QUOTE(TRIPLES(ADDON,events,sideChatFired))
// Parameters: [Object vehicle]
#define CBA_EVENT_AAFC_START_CONTACT_TRACK QUOTE(TRIPLES(ADDON,events,startContactTrack))
// Parameters: [Group group]
#define CBA_EVENT_AAFC_UPDATE_GROUP QUOTE(TRIPLES(ADDON,events,updateGroup))
// Parameters: [Object vehicle, Number roeLevel, Boolean allowFire]
#define CBA_EVENT_AAFC_UNIT_ROE_CHANGED QUOTE(TRIPLES(ADDON,events,unitROEChanged))

#ifdef __A3USPCM_PRODUCTION__
    #define CBA_EVENT_GLOBAL(eventName,params) [eventName, params] call CBA_fnc_globalEvent
    #define CBA_EVENT_LOCAL(eventName,params) [eventName, params] call CBA_fnc_localEvent
    #define CBA_EVENT_REMOTE(eventName,params) [eventName, params] call CBA_fnc_remoteEvent
    #define CBA_EVENT_SERVER(eventName,params) [eventName, params] call CBA_fnc_serverEvent
#else
    #define CBA_EVENT_GLOBAL(eventName,params) if true then { \
        TRACE_1("CBA_EVENT_GLOBAL:"+eventName,params); \
        [eventName, params] call CBA_fnc_globalEvent; \
    }
    #define CBA_EVENT_LOCAL(eventName,params) if true then { \
        TRACE_1("CBA_EVENT_LOCAL:"+eventName,params); \
        [eventName, params] call CBA_fnc_localEvent; \
    }
    #define CBA_EVENT_REMOTE(eventName,params) if true then { \
        TRACE_1("CBA_EVENT_REMOTE:"+eventName,params); \
        [eventName, params] call CBA_fnc_remoteEvent; \
    }
    #define CBA_EVENT_SERVER(eventName,params) if true then { \
        TRACE_1("CBA_EVENT_SERVER:"+eventName,params); \
        [eventName, params] call CBA_fnc_serverEvent; \
    }
#endif // __A3USPCM_PRODUCTION__

#define CBA_UI_SUBSCRIBE(eventName,function) \
    TRACE_1("CBA_UI_SUBSCRIBE",eventName); \
    uiNamespace getVariable QGVAR(events) pushBack[eventName, [eventName, function] call CBA_fnc_addEventHandler]
