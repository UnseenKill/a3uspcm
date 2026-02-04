class Extended_InitPost_EventHandlers {
    class EGVAR(assets,RemoteTraderTerminal) {
        class ADDON {
            clientInit = QUOTE(ADDON && { call FUNC(addVanillaSellInteraction) });
        };
    };
};
