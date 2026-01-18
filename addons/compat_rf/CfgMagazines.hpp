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

class CfgMagazines {
    DEFMAG(4Rnd_60mm_Mo_Flare_white_RF,4,w_l16_ammo_illum_ca);
    DEFMAG(4Rnd_60mm_Mo_Smoke_white_RF,4,w_l16_ammo_smk_white_ca);
    DEFMAG(4Rnd_60mm_Mo_shells_RF,4,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_shells_RF,8,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_LG_RF,8,w_l16_ammo_he_ca);
    DEFMAG(8Rnd_60mm_Mo_guided_RF,8,w_l16_ammo_he_ca);
};
