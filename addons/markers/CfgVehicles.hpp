class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class GVAR(EraseMarkers) {
                displayName = CSTRING(EraseMarkers);
                condition = QUOTE(call FUNC(canEraseMarkers));
                statement = QUOTE(call FUNC(eraseMarkers));
                icon = QPATHTOEF(assets,ui\loadout-discard.paa);
                exceptions[] = {"isNotDragging", "notOnMap", "isNotInside", "isNotSitting"};
                showDisabled = 0;
                priority = 15;
            };

            class GVAR(DrawSpawnRadius): GVAR(EraseMarkers) {
                displayName = CSTRING(DrawSpawnRadius);
                condition = QUOTE((customWaypointPosition isNotEqualTo []) && {call FUNC(canEraseMarkers)});
                statement = QUOTE(call FUNC(drawSpawnRadius));
                icon = "";
            };
        };
    };
};
