class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(PermanentMarker): CBA_MiscItem {
        scope = 2;
        author = "$STR_A3USPCM_Author";
        displayName = CSTRING(PermanentMarker);
        descriptionShort = CSTRING(PermanentMarkerDesc);
        picture = QPATHTOEF(assets,ui\icon-permanent-marker.paa);
        model = "\A3\Structures_F\Items\Stationery\PenRed_F.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 2;
        };
    };
};
