class ButtonBase;
class ScrtRscControlsGroup;
class ScrtRscControlsGroupNoScrollbarsMain;
class TextBase;
class TextBaseMT;

#define POS_GRID_X(position) POS_GRID_OX(0,position)
#define POS_GRID_Y(position) POS_GRID_OY(0,position)
#define POS_GRID_OX(offset,position) QUOTE(offset + ((position) * pixelGridNoUIScale * pixelW))
#define POS_GRID_OY(offset,position) QUOTE(offset + ((position) * pixelGridNoUIScale * pixelH))
#define GLUE(A,B) A##B
#define CM_BTN(C) \
    class GLUE(button,C): ButtonBase {\
        idc = GLUE(61198203,C); \
        text = QUOTE(GLUE(button,C)); \
        x = POS_GRID_X(10 * (C mod 2)); \
        y = POS_GRID_Y(2 * floor(C / 2)); \
        w = POS_GRID_X(9.75); \
        h = POS_GRID_Y(1.5); \
        sizeEx = QUOTE(((pixelH * (pixelGridNoUIScale) * 2) * 1.25) * 0.25); \
        shadow = 2; \
        action = QUOTE([GLUE(61198203,C)] call FUNC(commanderMenuAction)); \
    }

class commanderMenu {
    class Controls {
        class ADDON: ScrtRscControlsGroup {
			idc = 61198200;
			x = QUOTE(-0.4 * safezoneW + safezoneX);
            y = POS_GRID_OY(safezoneY,12);
            w = POS_GRID_X(26);
            h = QUOTE(safezoneH - (12 * pixelGridNoUIScale * pixelH));
            onLoad = QUOTE(call FUNC(commanderMenuInit));

            class Controls {
				class GVAR(menuTitle): TextBase {
					idc = 61198201;
					text = ECSTRING(main,Title);
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(0);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(1.5);
				};

                class GVAR(menuHotButtons): ScrtRscControlsGroupNoScrollbarsMain {
                    idc = 61198202;
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(2);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(10);

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
            };
        };
    };
};
