class DefaultEventHandlers;

class CfgVehicles {
    class Land_PCSet_Intel_01_F;
    class Land_PhoneBooth_02_F;

    class EGVAR(assets,RemoteTraderPhoneBooth): Land_PhoneBooth_02_F {
        class ACE_Actions {
            class ACE_MainActions {
                condition = QUOTE(true);
                displayName = ECSTRING(assets,ACE_MainActions_Interactions_DisplayName);
                distance = 6;
                position = QUOTE([ARR_3(0,0,0)]);

                class GVAR(RemoteTraderMenu) {
                    displayName = CSTRING(MenuRemoteTrader);
                    condition = QUOTE(call FUNC(canUseRemoteTraderMenu));
                    statement = QUOTE(call FUNC(runRemoteTraderMenu));
                };
            };
        };

        SLX_XEH_DISABLED = 0;
        class EventHandlers: DefaultEventHandlers {};
    };

    class EGVAR(assets,RemoteTraderTerminal): Land_PCSet_Intel_01_F {
        ace_dragging_canCarry = 1;

        class ACE_Actions {
            class ACE_MainActions {
                condition = QUOTE(true);
                displayName = ECSTRING(assets,ACE_MainActions_Interactions_DisplayName);
                distance = 4;
                position = QUOTE([ARR_3(0,0,0.15)]);

                class GVAR(RemoteTraderMenu) {
                    displayName = CSTRING(MenuRemoteTrader);
                    condition = QUOTE(call FUNC(canUseRemoteTraderMenu));
                    statement = QUOTE(call FUNC(runRemoteTraderMenu));
                };
            };
        };

        SLX_XEH_DISABLED = 0;
        class EventHandlers: DefaultEventHandlers {};
    };
};
