#include "RscDefine.hpp"

class brSpacer;
class ButtonBase;
class ProgressBase;
class ScrtRscControlsGroup;
class ScrtRscControlsGroupNoScrollbarsMain;
class SliderBase;
class TextBase;
class TextBaseMT;

#define POS_GRID_X(position) POS_GRID_OX(0,position)
#define POS_GRID_Y(position) POS_GRID_OY(0,position)
#define POS_GRID_OX(offset,position) QUOTE(offset + ((position) * pixelGridNoUIScale * pixelW))
#define POS_GRID_OY(offset,position) QUOTE(offset + ((position) * pixelGridNoUIScale * pixelH))
#define GLUE(A,B) A##B
#define CM_BTN(C) \
    class GLUE(button,C): ButtonBase {\
        idc = GLUE(IDC_CM_INJECT_HOTBUTTONS_BASE,C); \
        text = QUOTE(GLUE(button,C)); \
        x = POS_GRID_X(11.1 * (C mod 2)); \
        y = POS_GRID_Y(2 * floor(C / 2)); \
        w = POS_GRID_X(10.9); \
        h = POS_GRID_Y(1.75); \
        sizeEx = QUOTE(((pixelH * (pixelGridNoUIScale) * 2) * 1.25) * 0.475); \
        shadow = 2; \
        action = QUOTE(['GLUE(IDC_CM_INJECT_HOTBUTTONS_BASE,C)'] call FUNC(commanderMenuAction)); \
    }

class commanderMenu {
    class Controls {
        class ADDON: ScrtRscControlsGroup {
			idc = IDC_CM_INJECT_MAIN_CONTROL;
			x = QUOTE(-0.4 * safezoneW + safezoneX);
            y = POS_GRID_OY(safezoneY,12);
            w = POS_GRID_X(26);
            h = QUOTE(safezoneH - (12 * pixelGridNoUIScale * pixelH));
            onLoad = QUOTE(_this spawn FUNC(commanderMenuInit));

            class Controls {
				class GVAR(menuTitle): TextBase {
					idc = IDC_CM_INJECT_TITLE_CONTROL;
					text = ECSTRING(main,Title);
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(0);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(1.5);
				};

                class GVAR(menuHotButtons): ScrtRscControlsGroupNoScrollbarsMain {
                    idc = IDC_CM_INJECT_HOTBUTTONS_CONTROL;
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(2);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(8);

                    class Controls {
                        CM_BTN(0);
                        CM_BTN(1);
                        CM_BTN(2);
                        CM_BTN(3);
                        CM_BTN(4);
                        CM_BTN(5);
                        CM_BTN(6);
                        CM_BTN(7);
                    };
                };

                class GVAR(spacer0): brSpacer {
                    idc = IDC_CM_INJECT_SPACER_CONTROL;
                    y = POS_GRID_Y(10.5);
                };

                class GVAR(stopWatches0): ScrtRscControlsGroupNoScrollbarsMain {
                    idc = IDC_CM_INJECT_STOPWATCHES_CONTROL0;
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(11);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(7);
                    onLoad = QUOTE(_this spawn FUNC(commanderMenuStopWatchesInit));

                    class GVAR(Config) {
                        timerIndex = 0;
                    };

                    class Controls {
                        class GVAR(timerTitle): TextBase {
                            idc = IDC_CM_INJECT_STOPWATCHES_TITLE0;
                            text = CSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_TITLE);
                            x = POS_GRID_X(0);
                            y = POS_GRID_Y(0);
                            w = POS_GRID_X(22);
                            h = POS_GRID_Y(1.5);
                        };

                        class GVAR(timerText): TextBaseMT {
                            idc = IDC_CM_INJECT_STOPWATCHES_TEXT0;
                            text = CSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_STATUS);
                            x = POS_GRID_X(0);
                            y = POS_GRID_Y(2);
                            w = POS_GRID_X(22);
                            h = POS_GRID_Y(1.5);
                            colorText[] = {1,1,1,0.7};
                        };

                        class GVAR(timerProgressBar): ProgressBase {
                            idc = IDC_CM_INJECT_STOPWATCHES_PROGRESS0;
                            x = POS_GRID_X(0);
                            y = POS_GRID_Y(4);
                            w = POS_GRID_X(16);
                            h = POS_GRID_Y(1.5);
                        };

                        class GVAR(timerSlider): SliderBase {
                            idc = IDC_CM_INJECT_STOPWATCHES_SLIDER0;
                            x = POS_GRID_X(0);
                            y = POS_GRID_Y(4);
                            w = POS_GRID_X(16);
                            h = POS_GRID_Y(1.5);
                        };

                        class GVAR(timerButton): ButtonBase {
                            idc = IDC_CM_INJECT_STOPWATCHES_BUTTON0;
                            text = CSTRING(CMI_IDC_CM_INJECT_STOPWATCHES_START);
                            x = POS_GRID_X(16.5);
                            y = POS_GRID_Y(4);
                            w = POS_GRID_X(5.5);
                            h = POS_GRID_Y(1.5);
                            sizeEx = QUOTE(pixelH * pixelGridNoUIScale * 2.5 * 0.475);
                        };

                        class GVAR(spacer): brSpacer {
                            idc = -1;
                            y = POS_GRID_Y(6);
                        };
                    };
                };
            };
        };
    };
};
