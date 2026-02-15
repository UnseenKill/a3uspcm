class DefaultEventHandlers;

#define KICKAI_ACTION_FOR_VEHICLE(className,parentClass) \
    class className : parentClass { \
        class ACE_Actions { \
            class ACE_MainActions { \
                class GVAR(KickAICrew) { \
                    displayName = CSTRING(KickAICrew); \
                    condition = QUOTE(crew(_this select 0) findIf {getText(configOf _x >> QQUOTE(simulation)) isEqualTo QQUOTE(UAVPilot)} != -1); \
                    statement = QUOTE(crew(_this select 0) apply { deleteVehicle _x }); \
                }; \
            }; \
        }; \
    }

class CfgVehicles {
    class Air;
    class Helipad_base_F;
    class LandVehicle;
    class Man;
    class Ship;

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

    KICKAI_ACTION_FOR_VEHICLE(Car,LandVehicle);
    KICKAI_ACTION_FOR_VEHICLE(Tank,LandVehicle);
    KICKAI_ACTION_FOR_VEHICLE(Helicopter,Air);
    KICKAI_ACTION_FOR_VEHICLE(Plane,Air);
    KICKAI_ACTION_FOR_VEHICLE(Ship_F,Ship);
};
