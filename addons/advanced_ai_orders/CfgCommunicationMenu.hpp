class CfgCommunicationMenu {
    class GVAR(CommunicationMenu) {
        text = CSTRING(Menu_Title);
        submenu = QUOTE(#USER:GVAR(topLevelMenu));
        expression = "";
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "";
        enable = "IsLeader * (1 - IsAlone)";
    };
};
