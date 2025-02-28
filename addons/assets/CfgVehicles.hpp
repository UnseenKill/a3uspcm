class CfgVehicles {
    class RuggedTerminal_01_communications_F;

    class GVAR(DespawnSuppressionBeacon) : RuggedTerminal_01_communications_F {
        displayName = CSTRING(SuppressionBeacon_DisplayName);

        ace_cargo_size = 2;
        ace_cargo_canLoad = 1;
        ace_cargo_noRename = 1;
        ace_cargo_blockUnloadCarry = 1;
    };
};
