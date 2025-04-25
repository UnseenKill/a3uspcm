class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_InitPost_EventHandlers {
    class GVAR(SupportTentBase) {
        class ADDON {
            serverInit = QUOTE(call FUNC(handlerSupportTentPostInit));
        };
    };
};
