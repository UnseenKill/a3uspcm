class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_postInitClient));
    };
};

class Extended_InitPost_EventHandlers {
    class EGVAR(assets,DespawnSuppressionBeacon) {
        class ADDON {
            serverInit = QUOTE(call FUNC(handlerBeaconPostInit));
        };
    };

    class GVAR(I_UAV_01_F) {
        class ADDON {
            clientInit = QUOTE(call FUNC(handlerUAVPostInit));
        };
    };

    class CAManBase {
        class ADDON {
            clientInit = QUOTE(call FUNC(handlerPlayerRespawn));
        };
    };
};

class Extended_Respawn_EventHandlers {
    class CAManBase {
        class ADDON {
            clientRespawn = QUOTE(call FUNC(handlerPlayerRespawn));
        };
    };
};
