class CfgMagazines {
    class CA_Magazine;
    class O_R_IR_Grenade;

    class GVAR(40mm_EMP) : CA_Magazine {
        scope = 2;
        displayName = CSTRING(Mag_40mm_EMP_DisplayName);
        displayNameShort = CSTRING(Mag_40mm_EMP_DisplayName);
        descriptionShort = CSTRING(Mag_40mm_EMP_DescriptionShort);

        ammo = QGVAR(Ammo40mm_EMP);
        count = 1;
        initSpeed = 80;
        mass = 4;
        nameSound = "";
        picture = "\A3\Weapons_f\Data\ui\gear_UGL_slug_CA.paa";
        type = 16;
        modelSpecial = "\a3\Weapons_F\MagazineProxies\mag_40x36_HE_1rnd.p3d";
        modelSpecialIsProxy = 1;
        deleteIfEmpty = 0;
    };

    class GVAR(Grenade_EMP) : O_R_IR_Grenade {
        scope = 2;
        displayName = CSTRING(Mag_Grenade_EMP_DisplayName);
        displayNameShort = CSTRING(Mag_Grenade_EMP_DisplayName);
        descriptionShort = CSTRING(Mag_Grenade_EMP_DescriptionShort);
        mass = 6;
        ammo = QGVAR(Ammo40mm_EMP);
    };
};
