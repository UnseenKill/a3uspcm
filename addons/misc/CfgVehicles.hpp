class DefaultEventHandlers;

class CfgVehicles {
    class Helipad_base_F;
    class Man;

    class A3AU_RebHelipad_base_F: Helipad_base_F {
        SLX_XEH_DISABLED = 0;
        class EventHandlers: DefaultEventHandlers {};
    };

    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(SnapNeck) {
                    displayName = CSTRING(SnapNeck);
                    condition = QUOTE(call FUNC(canSnapNeck));
                    icon = QPATHTOEF(assets,ui\dead-face.paa);
                    statement = QUOTE(call FUNC(snapNeck));
                    exceptions[] = {"isNotInside", "isNotSitting"};
                };
            };
        };
        class ACE_SelfActions {
            class GVAR(SquashSnake) {
                displayName = CSTRING(SquashSnake);
                condition = QUOTE(call FUNC(canSquashSnake));
                icon = QPATHTOEF(assets,ui\dead-face.paa);
                statement = QUOTE(call FUNC(squashSnake));
            };
        };
    };
};
