#include "\z\a3uspcm\addons\main\ui_define.hpp"
#define UI_GRID_W (0.025 * safezoneW)
#define UI_GRID_H (0.025 * safezoneH)

class RscListNBox {
    class ListScrollBar;
};

FORWARD(RscButton);
FORWARD(RscText);
FORWARD(RscToolbox);

class GVAR(RscButton): RscButton {
    colorBackgroundActive[] = {
        QUOTE(profileNamespace getVariable[ARR_2(QQUOTE(GUI_BCG_RGB_R),0.13)]),
        QUOTE(profileNamespace getVariable[ARR_2(QQUOTE(GUI_BCG_RGB_G),0.54)]),
        QUOTE(profileNamespace getVariable[ARR_2(QQUOTE(GUI_BCG_RGB_B),0.21)]),
        0.5
    };
};

class GVAR(RscListNBox): RscListNBox {
    colorText[] = {0.75,0.75,0.75,1};

    class ListScrollBar: ListScrollBar {
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    };
};

class GVAR(RscListNBoxHeader): GVAR(RscListNBox) {
    colorText[] = {0.75,0.75,0.75,1};
    rows = 1;

    class ListScrollBar: ListScrollBar {
        arrowEmpty = "#(argb,8,8,3)color(0,0,0,0)";
        arrowFull = "#(argb,8,8,3)color(0,0,0,0)";
    };
};

class GVAR(RscText): RscText {
    colorText[] = {0.75,0.75,0.75,1};
};

class GVAR(RscTextMessage): GVAR(RscText) {
    style = ST_CENTER;
};

class GVAR(RscTextRightAlign): GVAR(RscText) {
    style = ST_RIGHT;
};

class GVAR(RscToolboxYesNo): RscToolbox {
    columns = 2;
    strings[] = {__EVAL(localize "str_lib_info_no"), __EVAL(localize "str_lib_info_yes")};
};
