class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_postInitClient));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_InitPost_EventHandlers {
    class ReammoBox_F {
        class ADDON {
            clientInit = QUOTE(ADDON && { call FUNC(addVanillaSellInteraction) });
        };
    };
};
