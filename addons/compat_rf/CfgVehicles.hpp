#define DEFVEH(declaredClass,baseClass) \
    class declaredClass: baseClass { \
        class ACE_CSW: ACE_CSW { \
            disassembleWeapon = QGVAR(declaredClass##_carry); \
        }; \
    }

class CfgVehicles {
    class CommandoMortar_base_RF;

    class B_CommandoMortar_RF: CommandoMortar_base_RF {
        class ACE_CSW {
            enabled = 1;
            proxyWeapon = QGVAR(mortar_60mm_RF_proxy);
            magazineLocation = "_target selectionPosition 'otochlaven'";
            disassembleWeapon = QGVAR(B_CommandoMortar_RF_carry);
            disassembleTurret = QUOTE(TRIPLES(ace,csw,mortarBaseplate));
            ammoLoadTime = 6;
            ammoUnloadTime = 4;
            desiredAmmo = 24;
        };
    };

    DEFVEH(B_G_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(I_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(I_E_CommandoMortar_RF,I_CommandoMortar_RF);
    DEFVEH(I_G_CommandoMortar_RF,I_CommandoMortar_RF);
    DEFVEH(O_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(O_G_CommandoMortar_RF,O_CommandoMortar_RF);
};
