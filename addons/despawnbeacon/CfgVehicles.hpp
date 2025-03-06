class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Man;
    class ThingX;

    class EGVAR(assets,DespawnSuppressionBeacon) : ThingX {
        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(Unpack) {
                    displayName = CSTRING(ActionBeaconUnpackText);
                    condition = QUOTE([ACE_player] call FUNC(canUnpack));
                    statement = QUOTE([ACE_player] call FUNC(unpackBeacon));
                    exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                    showDisabled = 0;
                    priority = 0;
                };        
            };
        };
    };
};
