#include "\z\a3uspcm\addons\main\ui_define.hpp"

FORWARD(RscButton);
FORWARD(RscFrame);
FORWARD(RscLine);
FORWARD(RscPicture);
FORWARD(RscText);

#define PROFILE_COLOR(profileKey,defaultR,defaultG,defaultB,defaultA) \
    QUOTE(profileNamespace getVariable[ARR_2('DOUBLES(profileKey,R)',defaultR)]), \
    QUOTE(profileNamespace getVariable[ARR_2('DOUBLES(profileKey,G)',defaultG)]), \
    QUOTE(profileNamespace getVariable[ARR_2('DOUBLES(profileKey,B)',defaultB)]), \
    defaultA

#define PROFILE_BCG(alpha) PROFILE_COLOR(GUI_BCG_RGB,0.13,0.54,0.21,alpha)

#define DEFAULT_FONT font = "PuristaMedium"
#define TABLET_SCREEN_WIDTH (safeZoneW * 0.5125 + pixelW * 10)
#define TABLET_CLIENTAREA_HEIGHT (UI_GRID_H * 22)
#define TABLET_CLIENTAREA_WIDTH (TABLET_SCREEN_WIDTH - pixelW * 64)
#define UI_ASPECT ((safezoneW / safezoneH) min 1.2)
#define UI_GRID_H_20 ((UI_ASPECT / 1.2) / 20)
#define UI_GRID_H ((UI_ASPECT / 1.2) / 25)
#define UI_GRID_W (UI_ASPECT / 40)

class GVAR(RscButton) {
    type = CT_BUTTON;
    style = QUOTE(ST_CENTER);
    sizeEx = QUOTE((UI_GRID_H * 1));
    idc = -1;
    x = 0;
    y = 0;
    w = 0.095589;
    h = 0.039216;
    access = 0;
    borderSize = 0;
    colorBackground[] = { PROFILE_BCG(0.5) };
    colorBackgroundActive[] = { PROFILE_BCG(1)};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBorder[] = {0,0,0,1};
    colorDisabled[] = {1,1,1,0.25};
    colorFocused[] = {0,0,0,1};
    colorShadow[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    default = 0;
    deletable = 0;
    fade = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    offsetX = 0;
    offsetY = 0;
    shadow = 2;
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    text = "";
    url = "";

    DEFAULT_FONT;
};

class GVAR(RscButtonTab): GVAR(RscButton) {
    h = QUOTE(UI_GRID_H * 1.5);
    style = QUOTE(ST_UPPERCASE + ST_CENTER);
    colorBackground[] = {0.2,0.2,0.2,0.5};
    colorBackgroundActive[] = {0.2,0.2,0.2,1};
};

class GVAR(RscControlsGroup) {
    type = CT_CONTROLS_GROUP;
    style = QUOTE(ST_MULTI);
    idc = -1;
    x = 0;
    y = 0;
    w = 1;
    h = 1;
    deletable = 0;
    fade = 0;
    shadow = 0;

    class Controls {};

    class HScrollbar {
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        color[] = {
            "(profileNamespace getVariable['GUI_BCG_RGB_R',0.13])",
            "(profileNamespace getVariable['GUI_BCG_RGB_G',0.54])",
            "(profileNamespace getVariable['GUI_BCG_RGB_B',0.21])",
            1
        };
        height = 0.028;
    };

    class VScrollbar: HScrollbar {
        autoScrollEnabled = 1;
        width = 0.021;
    };
};

class GVAR(RscFrame): RscFrame {
    sizeEx = QUOTE(safeZoneH * 0.02);
    DEFAULT_FONT;
};

class GVAR(RscText): RscText {
    DEFAULT_FONT;
};

class GVAR(ConfigTablet) {
    idd = 6119823;
    onLoad = QUOTE(call FUNC(onTabletOpen));

    class Controls {
        class FocusStealer: RscButton { w = 0; };

        class ScreenBlack: GVAR(RscText) {
            x = QUOTE(safeZoneX + safeZoneW * 0.25 - pixelW * 4);
            y = QUOTE(safeZoneY + safeZoneH * 0.2);
            w = QUOTE(TABLET_SCREEN_WIDTH);
            h = QUOTE(safeZoneH * 0.6);
            colorBackground[] = {0,0,0,1};
        };

        class ScreenConsole: GVAR(RscText) {
            x = QUOTE(safeZoneX + safeZoneW * 0.25 - pixelW * 4);
            y = QUOTE(safeZoneY + safeZoneH * 0.2);
            w = QUOTE(TABLET_SCREEN_WIDTH);
            h = QUOTE(safeZoneH * 0.6);
            colorBackground[] = {0,0.8,0,0.1};
        };

        class Main: GVAR(RscControlsGroup) {
            x = QUOTE(safeZoneX + safeZoneW * 0.25 - pixelW * 4);
            y = QUOTE(safeZoneY + safeZoneH * 0.2);
            w = QUOTE(TABLET_SCREEN_WIDTH);
            h = QUOTE(safeZoneH * 0.6);

            class Controls {
                class Title: GVAR(RscText) {
                    caption = CSTRING(Tablet_Caption_Text);
                    text = __EVAL(formatText["%1 - %2", QPREFIX, LLSTRING(Tablet_Caption_Text)]);
                    x = QUOTE(pixelW * 32);
                    w = QUOTE(TABLET_SCREEN_WIDTH - pixelW * 64);
                    h = QUOTE(UI_GRID_H_20 * 2);
                    sizeEx = QUOTE(safeZoneH * 0.04);
                };

                class Separator: RscLine {
                    x = QUOTE(pixelW * 16);
                    y = QUOTE(UI_GRID_H_20 * 2 - pixelH * 4);
                    w = QUOTE(TABLET_SCREEN_WIDTH - pixelW * 32);
                };

                class TabButtons: GVAR(RscControlsGroup) {
                    x = QUOTE(pixelW * 32);
                    y = QUOTE(UI_GRID_H_20 * 2);
                    w = QUOTE(TABLET_SCREEN_WIDTH - pixelW * 64);
                    h = QUOTE(UI_GRID_H * 2);

                    class Controls {
                        class BtnTabOverview: GVAR(RscButtonTab) {
                            idc = IDC_BTN_TAB_OVERVIEW;
                            x = QUOTE((TABLET_SCREEN_WIDTH - pixelW * 64) / 2 - UI_GRID_W * 11.5);
                            y = QUOTE(pixelH * 4);
                            w = QUOTE(UI_GRID_W * 7);
                            text = CSTRING(Tablet_BtnTab_Overview_Text);
                        };

                        class BtnTabTargets: BtnTabOverview {
                            idc = IDC_BTN_TAB_TARGETS;
                            x = QUOTE((TABLET_SCREEN_WIDTH - pixelW * 64) / 2 - UI_GRID_W * 3.5);
                            text = CSTRING(Tablet_BtnTab_Targets_Text);
                        };

                        class BtnTabConfig: BtnTabOverview {
                            idc = IDC_BTN_TAB_CONFIGURATION;
                            x = QUOTE((TABLET_SCREEN_WIDTH - pixelW * 64) / 2 + UI_GRID_W * 4.5);
                            text = CSTRING(Tablet_BtnTab_Configuration_Text);
                        };
                    };
                };

                class Main: GVAR(RscControlsGroup) {
                    x = QUOTE(pixelW * 32);
                    y = QUOTE(UI_GRID_H_20 * 2 + pixelH * 32);
                    w = QUOTE(TABLET_SCREEN_WIDTH - pixelW * 64);
                    h = QUOTE(safeZoneH * 0.6 - UI_GRID_H_20 * 2 - pixelH * 64);

                    class Controls {
                        class TabhostOverview: GVAR(RscControlsGroup) {
                            x = QUOTE(UI_GRID_W);
                            y = QUOTE(UI_GRID_H);
                            w = QUOTE(TABLET_CLIENTAREA_WIDTH - UI_GRID_W * 2);
                            h = QUOTE(TABLET_CLIENTAREA_HEIGHT);

                            class Controls {
                                class FrameROE: GVAR(RscFrame) {
                                    x = QUOTE(pixelW * 1);
                                    w = QUOTE(TABLET_CLIENTAREA_WIDTH - UI_GRID_W * 2 - pixelW * 1);
                                    h = QUOTE(UI_GRID_H * 4);
                                    text = CSTRING(Tablet_TabhostOverview_FrameROE_Caption_Text);
                                };

                                class BtnFireAtWill: GVAR(RscButton) {
                                    idc = IDC_OVERVIEW_BTN_FIREATWILL;
                                    x = QUOTE(UI_GRID_W);
                                    y = QUOTE(UI_GRID_H * 1.5);
                                    w = QUOTE(UI_GRID_W * 7);
                                    h = QUOTE(UI_GRID_H * 2);
                                    text = CSTRING(Tablet_TabhostOverview_BtnFireAtWill_Text);
                                    tooltip = CSTRING(Tablet_TabhostOverview_BtnFireAtWill_Tooltip);
                                    colorText[] = {1,0,0,1};
                                };

                                class BtnFireCIWSOnly: GVAR(RscButton) {
                                    idc = IDC_OVERVIEW_BTN_CIWSONLY;
                                    x = QUOTE(UI_GRID_W * 9);
                                    y = QUOTE(UI_GRID_H * 1.5);
                                    w = QUOTE(UI_GRID_W * 6);
                                    h = QUOTE(UI_GRID_H * 2);
                                    text = CSTRING(Tablet_TabhostOverview_BtnFireCIWSOnly_Text);
                                    tooltip = CSTRING(Tablet_TabhostOverview_BtnFireCIWSOnly_Tooltip);
                                };

                                class BtnFireSRSAM: BtnFireCIWSOnly {
                                    idc = IDC_OVERVIEW_BTN_SRSAM;
                                    x = QUOTE(UI_GRID_W * 16);
                                    text = CSTRING(Tablet_TabhostOverview_BtnFireSRSAM_Text);
                                    tooltip = CSTRING(Tablet_TabhostOverview_BtnFireSRSAM_Tooltip);
                                };

                                class BtnFireLRSAM: BtnFireCIWSOnly {
                                    idc = IDC_OVERVIEW_BTN_LRSAM;
                                    x = QUOTE(UI_GRID_W * 23);
                                    text = CSTRING(Tablet_TabhostOverview_BtnFireLRSAM_Text);
                                    tooltip = CSTRING(Tablet_TabhostOverview_BtnFireLRSAM_Tooltip);
                                };

                                class BtnHoldFire: BtnFireCIWSOnly {
                                    idc = IDC_OVERVIEW_BTN_HOLDFIRE;
                                    x = QUOTE(UI_GRID_W * 30);
                                    text = CSTRING(Tablet_TabhostOverview_BtnHoldFire_Text);
                                    tooltip = CSTRING(Tablet_TabhostOverview_BtnHoldFire_Tooltip);
                                };

                                class FrameGroups: GVAR(RscFrame) {
                                    x = QUOTE(pixelW * 1);
                                    y = QUOTE(UI_GRID_H * 5);
                                    w = QUOTE(TABLET_CLIENTAREA_WIDTH - UI_GRID_W * 2 - pixelW * 1);
                                    h = QUOTE(UI_GRID_H * 16);
                                    text = "A/A Groups";
                                };
                            };
                        };
                    };
                };
            };
        };

        class TabletBackground: RscPicture {
            fade = 0;
            text = QPATHTOEF(assets,ui\aafc-tablet.paa);
            x = QUOTE(safeZoneX + safeZoneW * 0.1);
            y = QUOTE(safeZoneY + safeZoneH * 0.1);
            w = QUOTE(safeZoneW * 0.8);
            h = QUOTE(safeZoneH * 0.8);
        };
    };
};
