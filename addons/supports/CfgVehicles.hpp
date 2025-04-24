class CfgVehicles {
    class LandVehicle;

    class Car : LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(SupportsMenu) {
                    displayName = CSTRING(MenuSupports);
                    condition = QUOTE(call FUNC(canUseSupportsMenu));
                    
                    class GVAR(SupportMenuAssignSupportRole) {
                        displayName = CSTRING(MenuSupportsAssignRole);
                        condition = QUOTE(call FUNC(canUseAssignSupportRoleMenu));

                        class GVAR(SupportMenuAssignArtillery) {
                            displayName = CSTRING(MenuSupportsAssignAsArtillery);
                            condition = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_ARTILLERY))] call FUNC(canAssignSupport));
                            statement = QUOTE([ARR_3(_target,_player,QUOTE(SUPPORT_TYPE_ARTILLERY))] call FUNC(assignSupportRoleToVehicle));
                        };
                    };
                };
            };
        };
    };
};
