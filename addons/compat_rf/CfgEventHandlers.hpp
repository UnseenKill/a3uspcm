class Extended_InitPost_EventHandlers {
    class B_CommandoMortar_RF {
        class ADDON {
            clientInit = QUOTE(call FUNC(handlerRSG60PostInit));
        };
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};
