#define DEFMAG(name,roundsCount,pictureName) \
    class name; \
    class GVAR(name): name { \
        count = roundsCount; \
        displayName = CSTRING(DOUBLES(CSW,name)); \
        scope = 2; \
        scopeCurator = 2; \
        model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d"; \
        picture = QUOTE(\z\ace\addons\mk6mortar\UI\pictureName.paa); \
        type = 256; \
        mass = 50; \
    }
#define DEFMAG_SELL(magazineClass,magazinePrice) \
    class GVAR(magazineClass): CA_Magazine { \
        EGVAR(store,fallbackSellPrice) = magazinePrice; \
    }

class CfgMagazines {
    class CA_Magazine;

    DEFMAG(2Rnd_60mm_Mo_Flare_white_RF,2,w_l16_ammo_illum_ca);
    DEFMAG(2Rnd_60mm_Mo_Smoke_white_RF,2,w_l16_ammo_smk_white_ca);
    DEFMAG(4Rnd_60mm_Mo_Flare_white_RF,4,w_l16_ammo_illum_ca);
    DEFMAG(4Rnd_60mm_Mo_LG_RF,4,w_l16_ammo_he_ca);
    DEFMAG(4Rnd_60mm_Mo_guided_RF,4,w_l16_ammo_he_ca);
    DEFMAG(4Rnd_60mm_Mo_Smoke_white_RF,4,w_l16_ammo_smk_white_ca);
    DEFMAG(4Rnd_60mm_Mo_shells_RF,4,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_shells_RF,8,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_LG_RF,8,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_guided_RF,8,w_l16_ammo_he_ca);

    DEFMAG_SELL(10Rnd_127x55_Mag_RF,100);
    DEFMAG_SELL(20Rnd_556x45_AP_Stanag_RF,50);
    DEFMAG_SELL(65Rnd_9x19_Mag_RF,60);
};
