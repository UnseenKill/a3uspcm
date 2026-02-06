class CfgWeapons {
	class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;
	class GrenadeLauncher;

    class GVAR(DecryptKeyRefuse): CBA_MiscItem {
        scope = 2;
        displayName = CSTRING(Mag_DecryptKeyRefuse_DisplayName);
        displayNameShort = CSTRING(Mag_DecryptKeyRefuse_DisplayName);
        descriptionShort = CSTRING(Mag_DecryptKeyRefuse_DescriptionShort);
        model = "\a3\Weapons_F_Orange\Ammo\leaflet_05_f.p3d";
        editorPreview = "\A3\EditorPreviews_F_Orange\Data\CfgVehicles\Leaflet_05_F.jpg";
        picture = QPATHTOF(ui\DecryptKeysRefuse.paa);

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.26;
        };
    };

    class GVAR(DecryptKeyRefuseReread): GVAR(DecryptKeyRefuse) {};

	class Throw : GrenadeLauncher {
		muzzles[] += { QGVAR(EMPGrenadeMuzzle) };

		class ThrowMuzzle;

		class GVAR(EMPGrenadeMuzzle) : ThrowMuzzle {
			displayName = "Lights out, motherfucker.";
			magazines[] = { QGVAR(Grenade_EMP) };
		};
	};
};
