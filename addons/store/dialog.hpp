#include "\z\a3uspcm\addons\main\ui_define.hpp"
#include "RscDefine.hpp"

// Replace attributes:
//  Search: (^\s*(?:sizeEx|[xywh])) = ([^;]+)
//  Replace: $1 = QUOTE($2)
// Text:
//  Search: (^\s*(?:text|tooltip)\s*=\s*)[$]STR_A3_([^;]+)
//  Replace: $1CSTRING($2)

/* #Vyzogo
$[
	1.063,
	["RscA3USPCMStoreSellDialog",[[0,0,1,1],0.025,0.04,"GUI_GRID"],2,1,1],
	[-1000,"StaticTitle",[1,"A3USPCM Faster Loot Selling",["0.3 * safezoneW + safezoneX","0.2342 * safezoneH + safezoneY","0.376406 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[0,0.8,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[-1001,"StaticBackground",[1,"",["0.3 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.4 * safezoneW","0.5 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[-1602,"BtnClose",[1,"X",["0.679438 * safezoneW + safezoneX","0.2338 * safezoneH + safezoneY","0.020625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"DropFilterSelect",[1,"",["0.308186 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.2475 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListContainerContent",[1,"",["0.308186 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.2475 * safezoneW","0.44 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["type = CT_LISTNBOX;","drawSideArrows = true;","idcLeft = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXLEFTARROW;","idcRight = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXRIGHTARROW;","tooltipPerColumn = true;"]],
	[1600,"BtnListboxLeftArrow",[1,"<<",["0.298906 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"BtnListboxRightArrow",[1,">>",["0.345312 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"",[1,"",["0.556719 * safezoneW + safezoneX","0.731 * safezoneH + safezoneY","0.020625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"LabelShowUnsellable",[1,"Show unsellable items",["0.577344 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.118594 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"LabelAmount",[1,"Amount:",["0.579403 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0464063 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"EditAmount",[1,"",["0.630971 * safezoneW + safezoneX","0.5506 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"BtnSell",[1,"Sell",["0.580438 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0979687 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[0,0.8,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"PictureSellItem",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.644375 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.04125 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1800,"FrameItemInfo",[1,"Item name goes here",["0.561875 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.134062 * safezoneW","0.352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["sizeEx = 0.03;"]],
	[1004,"LabelItemInfoCount",[1,"Amount in container:",["0.567031 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.0876563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"LabelItemSalePrice",[1,"Item sale price:",["0.567031 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.0876563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"TextItemCount",[1,"0",["0.644375 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.04125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["style = ST_RIGHT;"]],
	[1007,"TextItemPrice",[1,"0",["0.644375 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.04125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["style = ST_RIGHT;"]],
	[1008,"LabelTotalSale",[1,"Total sale:",["0.567031 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.0876563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"TextTotalSale",[1,"0",["0.644375 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.04125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["style = ST_RIGHT;"]]
]
*/
class GVAR(sellDialog) {
    idd = 6119821;
    onLoad = QUOTE(call FUNC(onMenuOpen));
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(menuDisplay),nil)]);

    class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by goreSplatter, v1.063, #Vyzogo)
		////////////////////////////////////////////////////////

		class StaticTitle: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_STATICTITLE;
			text = CSTRING(RscA3USPCMStoreSellDialog_StaticTitle);
			x = QUOTE(0.3 * safezoneW + safezoneX);
			y = QUOTE(0.2342 * safezoneH + safezoneY);
			w = QUOTE(0.376406 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
			colorBackground[] = {0,0.8,0,1};
		};
		class StaticBackground: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_STATICBACKGROUND;
			x = QUOTE(0.3 * safezoneW + safezoneX);
			y = QUOTE(0.28 * safezoneH + safezoneY);
			w = QUOTE(0.4 * safezoneW);
			h = QUOTE(0.5 * safezoneH);
			colorBackground[] = {0,0,0,0.8};
		};
		class BtnClose: RscButton
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_BTNCLOSE;
			text = CSTRING(RscA3USPCMStoreSellDialog_BtnClose);
			x = QUOTE(0.679438 * safezoneW + safezoneX);
			y = QUOTE(0.2338 * safezoneH + safezoneY);
			w = QUOTE(0.020625 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class DropFilterSelect: RscCombo
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_DROPFILTERSELECT;
			x = QUOTE(0.308186 * safezoneW + safezoneX);
			y = QUOTE(0.291 * safezoneH + safezoneY);
			w = QUOTE(0.2475 * safezoneW);
			h = QUOTE(0.022 * safezoneH);
		};
		class ListContainerContent: RscListbox
		{
			type = CT_LISTNBOX;
			drawSideArrows = true;
			idcLeft = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXLEFTARROW;
			idcRight = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXRIGHTARROW;
			tooltipPerColumn = true;

			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LISTCONTAINERCONTENT;
			x = QUOTE(0.308186 * safezoneW + safezoneX);
			y = QUOTE(0.324 * safezoneH + safezoneY);
			w = QUOTE(0.2475 * safezoneW);
			h = QUOTE(0.44 * safezoneH);
		};
		class BtnListboxLeftArrow: RscButton
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXLEFTARROW;
			text = CSTRING(RscA3USPCMStoreSellDialog_BtnListboxLeftArrow);
			x = QUOTE(0.298906 * safezoneW + safezoneX);
			y = QUOTE(0.808 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class BtnListboxRightArrow: RscButton
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_BTNLISTBOXRIGHTARROW;
			text = CSTRING(RscA3USPCMStoreSellDialog_BtnListboxRightArrow);
			x = QUOTE(0.345312 * safezoneW + safezoneX);
			y = QUOTE(0.808 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class RscCheckbox_2800: RscCheckbox
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_RSCCHECKBOX_2800;
			x = QUOTE(0.556719 * safezoneW + safezoneX);
			y = QUOTE(0.731 * safezoneH + safezoneY);
			w = QUOTE(0.020625 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class LabelShowUnsellable: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LABELSHOWUNSELLABLE;
			text = CSTRING(RscA3USPCMStoreSellDialog_LabelShowUnsellable);
			x = QUOTE(0.577344 * safezoneW + safezoneX);
			y = QUOTE(0.72 * safezoneH + safezoneY);
			w = QUOTE(0.118594 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class LabelAmount: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LABELAMOUNT;
			text = CSTRING(RscA3USPCMStoreSellDialog_LabelAmount);
			x = QUOTE(0.579403 * safezoneW + safezoneX);
			y = QUOTE(0.544 * safezoneH + safezoneY);
			w = QUOTE(0.0464063 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class EditAmount: RscEdit
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_EDITAMOUNT;
			x = QUOTE(0.630971 * safezoneW + safezoneX);
			y = QUOTE(0.5506 * safezoneH + safezoneY);
			w = QUOTE(0.0464063 * safezoneW);
			h = QUOTE(0.022 * safezoneH);
			colorBackground[] = {0,0,0,0};
		};
		class BtnSell: RscButton
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_BTNSELL;
			text = CSTRING(RscA3USPCMStoreSellDialog_BtnSell);
			x = QUOTE(0.580438 * safezoneW + safezoneX);
			y = QUOTE(0.588 * safezoneH + safezoneY);
			w = QUOTE(0.0979687 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
			colorBackground[] = {0,0.8,0,1};
		};
		class PictureSellItem: RscPicture
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_PICTURESELLITEM;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = QUOTE(0.644375 * safezoneW + safezoneX);
			y = QUOTE(0.313 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.077 * safezoneH);
		};
		class FrameItemInfo: RscFrame
		{
			sizeEx = QUOTE(0.03);

			idc = IDC_RSCA3USPCMSTORESELLDIALOG_FRAMEITEMINFO;
			text = CSTRING(RscA3USPCMStoreSellDialog_FrameItemInfo);
			x = QUOTE(0.561875 * safezoneW + safezoneX);
			y = QUOTE(0.291 * safezoneH + safezoneY);
			w = QUOTE(0.134062 * safezoneW);
			h = QUOTE(0.352 * safezoneH);
		};
		class LabelItemInfoCount: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LABELITEMINFOCOUNT;
			text = CSTRING(RscA3USPCMStoreSellDialog_LabelItemInfoCount);
			x = QUOTE(0.567031 * safezoneW + safezoneX);
			y = QUOTE(0.401 * safezoneH + safezoneY);
			w = QUOTE(0.0876563 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class LabelItemSalePrice: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LABELITEMSALEPRICE;
			text = CSTRING(RscA3USPCMStoreSellDialog_LabelItemSalePrice);
			x = QUOTE(0.567031 * safezoneW + safezoneX);
			y = QUOTE(0.434 * safezoneH + safezoneY);
			w = QUOTE(0.0876563 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class TextItemCount: RscText
		{
			style = ST_RIGHT;

			idc = IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMCOUNT;
			text = CSTRING(RscA3USPCMStoreSellDialog_TextItemCount);
			x = QUOTE(0.644375 * safezoneW + safezoneX);
			y = QUOTE(0.401 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class TextItemPrice: RscText
		{
			style = ST_RIGHT;

			idc = IDC_RSCA3USPCMSTORESELLDIALOG_TEXTITEMPRICE;
			text = CSTRING(RscA3USPCMStoreSellDialog_TextItemPrice);
			x = QUOTE(0.644375 * safezoneW + safezoneX);
			y = QUOTE(0.434 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class LabelTotalSale: RscText
		{
			idc = IDC_RSCA3USPCMSTORESELLDIALOG_LABELTOTALSALE;
			text = CSTRING(RscA3USPCMStoreSellDialog_LabelTotalSale);
			x = QUOTE(0.567031 * safezoneW + safezoneX);
			y = QUOTE(0.467 * safezoneH + safezoneY);
			w = QUOTE(0.0876563 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		class TextTotalSale: RscText
		{
			style = ST_RIGHT;

			idc = IDC_RSCA3USPCMSTORESELLDIALOG_TEXTTOTALSALE;
			text = CSTRING(RscA3USPCMStoreSellDialog_TextTotalSale);
			x = QUOTE(0.644375 * safezoneW + safezoneX);
			y = QUOTE(0.467 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.033 * safezoneH);
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
    };
};
