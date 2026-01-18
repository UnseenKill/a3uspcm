class CfgVehicles {
    class CommandoMortar_base_RF;

    class B_CommandoMortar_RF: CommandoMortar_base_RF {
        class ACE_CSW {
            enabled = 1;
            proxyWeapon = QGVAR(mortar_60mm_RF_proxy);
            magazineLocation = "_target selectionPosition 'otochlaven'";
            disassembleWeapon = QGVAR(mortar_60mm_RF_carry);
            disassembleTurret = QUOTE(TRIPLES(ace,csw,mortarBaseplate));
            ammoLoadTime = 6;
            ammoUnloadTime = 4;
            desiredAmmo = 24;
        };
    };
};
