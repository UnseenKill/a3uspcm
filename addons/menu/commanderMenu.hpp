class ButtonBase;
class ScrtRscControlsGroup;
class ScrtRscControlsGroupNoScrollbarsMain;
class TextBase;
class TextBaseMT;

#define POS_GRID_X(position) POS_GRID_OX(0,position)
#define POS_GRID_Y(position) POS_GRID_OY(0,position)
#define POS_GRID_OX(offset,position) QUOTE(offset + (position * pixelGridNoUIScale * pixelW))
#define POS_GRID_OY(offset,position) QUOTE(offset + (position * pixelGridNoUIScale * pixelH))

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

                class GVAR(section0): ScrtRscControlsGroupNoScrollbarsMain {
                    idc = 61198202;
                    x = POS_GRID_X(1);
                    y = POS_GRID_Y(2);
                    w = POS_GRID_X(22);
                    h = POS_GRID_Y(10);

                    class Controls {
                        class GVAR(button1): ButtonBase {
                            idc = 61198203;
                            text = "Hello, world!";
                            x = POS_GRID_X(0);
                            y = POS_GRID_Y(0);
                            w = POS_GRID_X(12);
                            h = POS_GRID_Y(1.5);

                            sizeEx = "((pixelH * (pixelGridNoUIScale) * 2) * 1.25) * 0.25";
                            shadow = 2;
                            action = "diag_log 'FOOBAR!'";
                        };
                    };
                };
            };
        };
    };
};
