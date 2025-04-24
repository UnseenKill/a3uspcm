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

class CfgVehicles {
    class Air;
    class LandVehicle;
    class Ship;

    VEHICLE_SUPPORT_ACTIONS(Car,LandVehicle);
    VEHICLE_SUPPORT_ACTIONS(Tank,LandVehicle);
    VEHICLE_SUPPORT_ACTIONS(Helicopter,Air);
    VEHICLE_SUPPORT_ACTIONS(Plane,Air);
    VEHICLE_SUPPORT_ACTIONS(Ship_F,Ship);
};
