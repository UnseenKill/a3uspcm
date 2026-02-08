class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(PackedBeacon): CBA_MiscItem {
        scope = 2;
        author = "$STR_A3USPCM_Author";
        displayName = CSTRING(PackedBeacon);
        descriptionShort = CSTRING(PackedBeaconDesc);
        picture = QPATHTOEF(assets,ui\icon-dsb-packed.paa);
        model = "\A3\Structures_F_Heli\Items\Luggage\PlasticCase_01_small_F.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 85;
        };
    };
};
