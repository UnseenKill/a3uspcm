class Extended_InitPost_EventHandlers {
    class A3AU_RebHelipad_base_F {
        class ADDON {
            serverInit = QUOTE(call FUNC(augmentHelipad));
        };
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitClient));
    };
};
