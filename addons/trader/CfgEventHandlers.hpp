class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
        serverInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitServer));
    };
};

class Extended_InitPost_EventHandlers {
    class EGVAR(assets,RemoteTraderPhoneBooth) {
        class ADDON {
            clientInit = QUOTE(call FUNC(addVanillaRemoteTraderInteraction));
        };
    };

    class EGVAR(assets,RemoteTraderTerminal) {
        class ADDON {
            clientInit = QUOTE(call FUNC(addVanillaRemoteTraderInteraction));
        };
    };
};
