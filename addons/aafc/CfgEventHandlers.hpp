class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
        serverInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitServer));
    };
};
