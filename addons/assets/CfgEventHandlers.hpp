class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitClient));
        serverInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitServer));
    };
};

class Extended_InitPost_EventHandlers {
    class GVAR(SignHelperBase) {
        class ADDON {
            clientInit = QUOTE(call FUNC(handlerSignHelperPostInit));
        };
    };
};
