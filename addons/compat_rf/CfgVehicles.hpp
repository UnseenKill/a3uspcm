#define DEFVEH(declaredClass,baseClass) \
    class declaredClass: baseClass { \
        class ACE_CSW: ACE_CSW { \
            disassembleWeapon = QGVAR(declaredClass##_carry); \
        }; \
    }

class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class CommandoMortar_base_RF;
    class Helicopter_Base_H;

    class B_CommandoMortar_RF: CommandoMortar_base_RF {
        GVAR(magazines)[] = {
            {QGVAR(2Rnd_60mm_Mo_Flare_white_RF), QUOTE(2Rnd_60mm_Mo_Flare_white_RF)},
            {QGVAR(2Rnd_60mm_Mo_Smoke_white_RF), QUOTE(2Rnd_60mm_Mo_Smoke_white_RF)},
            {QGVAR(4Rnd_60mm_Mo_LG_RF), QUOTE(4Rnd_60mm_Mo_LG_RF)},
            {QGVAR(4Rnd_60mm_Mo_guided_RF), QUOTE(4Rnd_60mm_Mo_guided_RF)},
            {QGVAR(4Rnd_60mm_Mo_Flare_white_RF), QUOTE(4Rnd_60mm_Mo_Flare_white_RF)},
            {QGVAR(4Rnd_60mm_Mo_Smoke_white_RF), QUOTE(4Rnd_60mm_Mo_Smoke_white_RF)},
            {QGVAR(4Rnd_60mm_Mo_shells_RF), QUOTE(4Rnd_60mm_Mo_shells_RF)},
            {QGVAR(8Rnd_60mm_Mo_shells_RF), QUOTE(8Rnd_60mm_Mo_shells_RF)},
            {QGVAR(8Rnd_60mm_Mo_LG_RF), QUOTE(8Rnd_60mm_Mo_LG_RF)},
            {QGVAR(8Rnd_60mm_Mo_guided_RF), QUOTE(8Rnd_60mm_Mo_guided_RF)}
        };

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

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };

    DEFVEH(B_G_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(I_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(I_E_CommandoMortar_RF,I_CommandoMortar_RF);
    DEFVEH(I_G_CommandoMortar_RF,I_CommandoMortar_RF);
    DEFVEH(O_CommandoMortar_RF,B_CommandoMortar_RF);
    DEFVEH(O_G_CommandoMortar_RF,O_CommandoMortar_RF);

    class Heli_EC_01_base_RF: Helicopter_Base_H {
        slingLoadMaxCargoMass = 20000;
    };
};
