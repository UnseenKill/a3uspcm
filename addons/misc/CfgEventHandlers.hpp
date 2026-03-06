class Extended_InitPost_EventHandlers {
    class A3AU_RebHelipad_base_F {
        class ADDON {
            serverInit = QUOTE([ARR_3(FUNC(augmentHelipad),_this,5)] call CBA_fnc_execAfterNFrames);
        };
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_SCRIPT(XEH_preInitClient));
    };
};
