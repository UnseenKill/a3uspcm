class CfgVehicles {
    class Man;
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
    };
};
