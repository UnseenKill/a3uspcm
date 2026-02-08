class CfgCommunicationMenu {
    class GVAR(CommunicationMenu) {
        text = CSTRING(Menu_Title);
        submenu = QUOTE(#USER:GVAR(topLevelMenu));
        expression = "";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "";
        // Leader and not alone or totally alone (so that running ops can still be cancelled)
        enable = "(IsLeader * (1 - IsAlone)) + (IsAlone)";
    };
};
