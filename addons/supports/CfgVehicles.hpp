#define VEHICLE_SUPPORT_ACTIONS(vehClass,vehParent) \
    class vehClass : vehParent { \
        class ACE_Actions { \
            class ACE_MainActions { \
                class GVAR(SupportsMenu) { \
                    displayName = CSTRING(MenuSupports); \
                    condition = QUOTE(call FUNC(canUseSupportsMenu)); \
\
                    class GVAR(SupportMenuAssignSupportRole) { \
                        displayName = CSTRING(MenuSupportsAssignRole); \
                        condition = QUOTE(call FUNC(canUseAssignSupportRoleMenu)); \
\
                        class GVAR(SupportMenuAssignArtillery) { \
                            displayName = CSTRING(MenuSupportsAssignAsArtillery); \
                            condition = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_ARTILLERY))] call FUNC(canAssignSupport)); \
                            statement = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_ARTILLERY))] call FUNC(assignSupportRoleToVehicle)); \
                        }; \
\
                        class GVAR(SupportMenuAssignCASPlane) { \
                            displayName = CSTRING(MenuSupportsAssignAsCASPlane); \
                            condition = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_CAS_PLANE))] call FUNC(canAssignSupport)); \
                            statement = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_CAS_PLANE))] call FUNC(assignSupportRoleToVehicle)); \
                        }; \
\
                        class GVAR(SupportMenuAssignCASHelicopter) { \
                            displayName = CSTRING(MenuSupportsAssignAsCASHelicopter); \
                            condition = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_CAS_HELICOPTER))] call FUNC(canAssignSupport)); \
                            statement = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_CAS_HELICOPTER))] call FUNC(assignSupportRoleToVehicle)); \
                        }; \
\
                        class GVAR(SupportMenuAssignTransport) { \
                            displayName = CSTRING(MenuSupportsAssignAsTransport); \
                            condition = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_TRANSPORT))] call FUNC(canAssignSupport)); \
                            statement = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_TRANSPORT))] call FUNC(assignSupportRoleToVehicle)); \
                        }; \
                    }; \
\
                    class GVAR(SupportMenuRevokeSupportRole) { \
                        displayName = CSTRING(MenuSupportsRevokeRole); \
                        condition = QUOTE(call FUNC(canRevokeSupportRole)); \
                        statement = QUOTE(call FUNC(revokeSupportRoleFromVehicle)); \
                    }; \
                }; \
            }; \
        }; \
    }

// THIS FUCKING += OPERATOR. WHEN. DOES. IT. WORK.
#define SUPPORT_TENT_ATTACH_OBJECTS_BASE \
    {"Land_PortableDesk_01_black_F",{0.85791,0.200492,-0.764919},{{-1,1.56148e-06,0.000771823},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_DeskChair_01_black_F",{0.193848,0.962382,-0.988018},{{1,-1.11643e-06,-0.000771824},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_Laptop_03_black_F",{0.826172,0.94807,-0.154469},{{1,-1.11643e-06,-0.000771824},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_PortableCabinet_01_bookcase_sand_F",{-1.01123,1.09114,-0.790859},{{-0.5,0.866026,-0.000282695},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_Document_01_F",{0.814453,0.274359,-0.307304},{{0.866025,0.499999,-0.00105444},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_Notepad_F",{0.725098,-0.712944,-0.310806},{{0,1,-0.00077204},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_PenRed_F",{0.710938,-0.838918,-0.314308},{{-0.866025,0.500001,0.000282398},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_DataTerminal_01_F",{-1.14111,-3.00419,-1.28695},{{0,1,-0.00077204},{0.000771824,0.00077204,0.999999}},1}, \
    {"Land_PlasticCase_01_medium_olive_F",{-0.921875,-0.884279,-1.01468},{{-8.02678e-07,-1,0.000772041},{0.000771824,0.00077204,0.999999}},1} \

class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Air;
    class B_Deck_Crew_F;
    class Land_ConnectorTent_01_NATO_closed_F;
    class LandVehicle;
    class Ship;

    VEHICLE_SUPPORT_ACTIONS(Car,LandVehicle);
    VEHICLE_SUPPORT_ACTIONS(Tank,LandVehicle);
    VEHICLE_SUPPORT_ACTIONS(Helicopter,Air);
    VEHICLE_SUPPORT_ACTIONS(Plane,Air);
    VEHICLE_SUPPORT_ACTIONS(Ship_F,Ship);

    class GVAR(I_Deck_Crew_F) : B_Deck_Crew_F {
        faction = "IND_E_F";
    };

    class GVAR(SupportTentBase) : Land_ConnectorTent_01_NATO_closed_F {
        scope = 0;
        scopeCurator = 0;
        author = "$STR_A3USPCM_Author";
        authors[] = {"goreSplatter"};

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    class GVAR(SupportTentArtillery) : GVAR(SupportTentBase) {
        scope = 2;
        scopeCurator = 2;

        costMultiplier = 1.25;
        displayName = CSTRING(SupportTentArtilleryDisplayName);

        GVAR(supportType) = SUPPORT_TYPE_ARTILLERY;
        GVAR(attachObjects)[] = {
            SUPPORT_TENT_ATTACH_OBJECTS_BASE,
            {"Land_TentLamp_01_suspended_F",{-0.00830078,1.50576,1.02703},{{-1,1.19249e-08,0},{0,0,1}},0},
            {"MRL_Magazine_transport_RF",{2.4873,-3.57091,-0.875122},{{-0.707107,-0.707106,0.00109183},{0.00077204,0.00077204,0.999999}},1},
            {"I_crew_F",{-0.246094,0.105128,-1.20744},{{-8.74228e-08,-1,0},{0,0,1}},0}
        };
    };

    class GVAR(SupportTentCASHelicopter) : GVAR(SupportTentBase) {
        scope = 2;
        scopeCurator = 2;

        costMultiplier = 1.75;
        displayName = CSTRING(SupportTentCASHelicopterDisplayName);

        GVAR(supportType) = SUPPORT_TYPE_CAS_HELICOPTER;
        GVAR(attachObjects)[] = {
            SUPPORT_TENT_ATTACH_OBJECTS_BASE,
            {"Land_TentLamp_01_suspended_red_F",{-0.00830078,1.50576,1.02703},{{-1,1.19249e-08,0},{0,0,1}},0},
            {"Land_Missle_Trolley_02_F",{2.021,-3.26353,-0.564541},{{-0.866025,-0.499999,0.00105463},{0.00077204,0.00077204,0.999999}},1},
            {"I_helipilot_F",{-0.246094,0.105128,-1.20744},{{-8.74228e-08,-1,0},{0,0,1}},0}
        };
    };

    class GVAR(SupportTentCASPlane) : GVAR(SupportTentBase) {
        scope = 2;
        scopeCurator = 2;

        costMultiplier = 2;
        displayName = CSTRING(SupportTentCASPlaneDisplayName);

        GVAR(supportType) = SUPPORT_TYPE_CAS_PLANE;
        GVAR(attachObjects)[] = {
            SUPPORT_TENT_ATTACH_OBJECTS_BASE,
            {"Land_Bomb_Trolley_01_F",{2.15771,-3.29966,-0.563881},{{-0.851979,-0.523574,0.00106198},{0.00077204,0.00077204,0.999999}},1},
            {"Land_TentLamp_01_suspended_red_F",{-0.00830078,1.50576,1.02703},{{-1,1.19249e-08,0},{0,0,1}},0},
            {"I_pilot_F",{-0.246094,0.105128,-1.20744},{{-8.74228e-08,-1,0},{0,0,1}},0}
        };
    };

    class GVAR(SupportTentTransport) : GVAR(SupportTentBase) {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(SupportTentTransportDisplayName);

        GVAR(supportType) = SUPPORT_TYPE_TRANSPORT;
        GVAR(attachObjects)[] = {
            SUPPORT_TENT_ATTACH_OBJECTS_BASE,
            {"Land_TentLamp_01_suspended_F",{-0.00830078,1.50576,1.02703},{{-1,1.19249e-08,0},{0,0,1}},0},
            {"Land_Pallet_MilBoxes_F",{1.23633,-3.61195,-0.84774},{{0,1,-0.00077204},{0.00077204,0.00077204,0.999999}},1},
            {QGVAR(I_Deck_Crew_F),{-0.246094,0.105128,-1.20744},{{-8.74228e-08,-1,0},{0,0,1}},0}
        };
    };
};
