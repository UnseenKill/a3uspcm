class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_postInitClient));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitClient));
        serverInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitServer));
    };
};
