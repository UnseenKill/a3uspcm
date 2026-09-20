class CfgMapContextMenu {
    class Location {
        class ContextBase;

        class A3A_ultimate_dynamic_hover_menu_Garrison: ContextBase {
            title = "$STR_A3A_garrison_header";
            tooltipDisabled = "$STR_A3U_CONTEXT_GARRISON_REQUIREMENTS";
            statement = QUOTE(call FUNCMAIN(recruitLaunchAGM));
        };
    };
};
