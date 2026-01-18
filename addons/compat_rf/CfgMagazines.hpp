//["8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_Flare_white","8Rnd_82mm_Mo_Flare_white_illumination","8Rnd_82mm_Mo_Smoke_white","8Rnd_82mm_Mo_guided","8Rnd_82mm_Mo_LG"]
#define DEFMAG(name,pictureName) \
    class name; \
    class GVAR(name): name { \
        count = 8; \
        scope = 2; \
        scopeCurator = 2; \
        model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d"; \
        picture = pictureName; \
        type = 256; \
        mass = 50; \
    }

class CfgMagazines {
    DEFMAG(8Rnd_60mm_Mo_shells_RF,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_he_ca.paa");
    DEFMAG(8Rnd_82mm_Mo_Flare_white,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_illum_ca.paa");
    DEFMAG(8Rnd_82mm_Mo_Flare_white_illumination,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_illum_ca.paa");
    DEFMAG(8Rnd_82mm_Mo_Smoke_white,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_smk_white_ca.paa");
    DEFMAG(8Rnd_82mm_Mo_guided,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_he_ca.paa");
    DEFMAG(8Rnd_82mm_Mo_LG,"\z\ace\addons\mk6mortar\UI\w_l16_ammo_he_ca.paa");
};
