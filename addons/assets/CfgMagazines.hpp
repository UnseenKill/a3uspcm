class CfgMagazines {
    class CA_Magazine;
    class O_R_IR_Grenade;

    class GVAR(40mm_EMP): CA_Magazine {
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

    class GVAR(DecryptKeyBase): CA_Magazine {
        scope = 0;
        count = 0;
        mass = 0;
    };

    class GVAR(DecryptKeySingleBase): GVAR(DecryptKeyBase) {
        model = "\A3\Structures_F\Items\Documents\File2_F.p3d";
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Intel_File2_F.jpg";
        picture = QPATHTOF(ui\DecryptKeysSingle.paa);
        count = 1;
        mass = 0.25;
    };

    class GVAR(DecryptKeySingle_B): GVAR(DecryptKeySingleBase) {
        scope = 2;
        displayName = CSTRING(Mag_DecryptKeySingle_B_DisplayName);
        displayNameShort = CSTRING(Mag_DecryptKeySingle_B_DisplayName);
        descriptionShort = CSTRING(Mag_DecryptKeySingle_B_DescriptionShort);
        side = 1; // BLUFOR
    };

    class GVAR(DecryptKeySingle_O): GVAR(DecryptKeySingleBase) {
        scope = 2;
        displayName = CSTRING(Mag_DecryptKeySingle_O_DisplayName);
        displayNameShort = CSTRING(Mag_DecryptKeySingle_O_DisplayName);
        descriptionShort = CSTRING(Mag_DecryptKeySingle_O_DescriptionShort);
        side = 0; // OPFOR
    };

    class GVAR(DecryptKeyPackBase): GVAR(DecryptKeyBase) {
        model = "\A3\Structures_F\Items\Documents\File1_F.p3d";
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Intel_File1_F.jpg";
        picture = QPATHTOF(ui\DecryptKeysPack.paa);
        count = 8;
        mass = 2;
    };

    class GVAR(DecryptKeyPack_B): GVAR(DecryptKeyPackBase) {
        scope = 2;
        displayName = CSTRING(Mag_DecryptKeyPack_B_DisplayName);
        displayNameShort = CSTRING(Mag_DecryptKeyPack_B_DisplayName);
        descriptionShort = CSTRING(Mag_DecryptKeyPack_B_DescriptionShort);
        side = 1; // BLUFOR
    };

    class GVAR(DecryptKeyPack_O): GVAR(DecryptKeyPackBase) {
        scope = 2;
        displayName = CSTRING(Mag_DecryptKeyPack_O_DisplayName);
        displayNameShort = CSTRING(Mag_DecryptKeyPack_O_DisplayName);
        descriptionShort = CSTRING(Mag_DecryptKeyPack_O_DescriptionShort);
        side = 0; // OPFOR
    };

    class GVAR(Grenade_EMP): O_R_IR_Grenade {
        scope = 2;
        displayName = CSTRING(Mag_Grenade_EMP_DisplayName);
        displayNameShort = CSTRING(Mag_Grenade_EMP_DisplayName);
        descriptionShort = CSTRING(Mag_Grenade_EMP_DescriptionShort);
        mass = 6;
        ammo = QGVAR(Ammo40mm_EMP);
    };
};
