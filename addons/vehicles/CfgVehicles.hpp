#define RESUPPLY_ACTION_FOR_CLASS(className,parentClass) \
    class className : parentClass {\
        class ACE_Actions {\
            class ACE_MainActions {\
                class GVAR(AirVehicleResupply) {\
                    displayName = CSTRING(AirVehicleResupply_Action_DisplayName);\
                    condition = QUOTE(call FUNC(canAirVehicleResupply));\
                    statement = QUOTE(call FUNC(doAirVehicleResupply));\
                    icon = "\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa";\
                };\
            };\
        };\
    }

class CfgVehicles {
    class Air;

    RESUPPLY_ACTION_FOR_CLASS(Helicopter,Air);
    RESUPPLY_ACTION_FOR_CLASS(Plane,Air);
};
