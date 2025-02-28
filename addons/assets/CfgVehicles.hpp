class CfgVehicles {
    class ThingX;

    class GVAR(DespawnSuppressionBeacon) : ThingX {
        displayName = CSTRING(SuppressionBeacon_DisplayName);
        model = "\a3\Props_F_Decade\Objectives\RuggedTerminal_01_communications_F.p3d";
        scope = 2;
        scopeCurator = 2;

        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;
        ace_cargo_noRename = 1;
        ace_cargo_blockUnloadCarry = 1;
        ace_dragging_canDrag = 1;
        ace_dragging_ignoreWeight = 1;
        ace_dragging_canCarry = 1;
        ace_dragging_ignoreWeightCarry = 1;
    };
};
