class Extended_InitPost_EventHandlers {
    class Helicopter_Base_H {
        class ADDON {
            clientInit = QUOTE(call FUNC(initSlingloadAdjust));
        };
    };
};

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
