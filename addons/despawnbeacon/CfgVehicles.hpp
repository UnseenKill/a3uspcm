class DefaultEventHandlers;

class CfgVehicles {
    class Man;
    class ThingX;

    class EGVAR(assets,DespawnSuppressionBeacon) : ThingX {
        class ACE_Actions {
            class ACE_MainActions {
                condition = QUOTE(true);
                displayName = ECSTRING(assets,ACE_MainActions_Interactions_DisplayName);
                distance = 3;
                position = QUOTE([ARR_3(0,0,-0.61)]);

                class ace_attach_AttachVehicle {
                    displayName = "$STR_ace_attach_AttachDetach";
                    icon = QUOTE(\z\ace\addons\attach\UI\attach_ca.paa);
                    condition = QUOTE(call ace_attach_fnc_canAttach);
                    insertChildren = QUOTE(call ace_attach_fnc_getChildrenActions);
                };

                class ace_attach_DetachVehicle {
                    displayName = "$STR_ace_attach_Detach";
                    icon = QUOTE(\z\ace\addons\attach\UI\detach_ca.paa);
                    statement = QUOTE(ace_attach_fnc_detach);
                    condition = QUOTE(call ace_attach_fnc_canDetach);
                };

                class GVAR(ActionBeaconActivate) {
                    displayName = CSTRING(ActionActivateText);
                    statement = QUOTE(call FUNC(activateBeacon));
                    condition = QUOTE(call FUNC(canActivate));
                };

                class GVAR(ActionBeaconDeactivate) {
                    displayName = CSTRING(ActionDeactivateText);
                    statement = QUOTE(call FUNC(deactivateBeacon));
                    condition = QUOTE(call FUNC(canDeactivate));
                };

                class GVAR(ActionBeaconPack) {
                    displayName = CSTRING(ActionBeaconPackText);
                    statement = QUOTE(call FUNC(packBeacon));
                    condition = QUOTE(call FUNC(canPack));
                };
            };
        };

        SLX_XEH_DISABLED = 0;
        class EventHandlers: DefaultEventHandlers {};
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
