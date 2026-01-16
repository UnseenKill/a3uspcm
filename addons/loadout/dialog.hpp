#include "\z\a3uspcm\addons\main\ui_define.hpp"
#include "RscDefine.hpp"

// Replace attributes:
//  Search: (^\s*(?:sizeEx|[xywh])) = ([^;]+)
//  Replace: $1 = QUOTE($2)
// Text:
//  Search: (^\s*(?:text|tooltip)\s*=\s*)[$]STR_A3_([^;]+)
//  Replace: $1CSTRING($2)

/* #Luxiwu
$[
	1.063,
	["RscA3USPCMLoadoutManagerDialog",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],2,1,1],
	[-1000,"StaticBackground",[1,"",["0.3 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.4 * safezoneW","0.4 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[-1001,"StaticTitle",[1,"Title",["0.3 * safezoneW + safezoneX","0.24 * safezoneH + safezoneY","0.4 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[0,0.8,0,1],[-1,-1,-1,-1],"","-1"],["moving = 1;"]],
	[-1600,"BtnClose",[1,"X",["0.6825 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.0125 * safezoneW","0.02 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListLoadouts",[1,"",["0.3125 * safezoneW + safezoneX","0.3 * safezoneH + safezoneY","0.275 * safezoneW","0.36 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["type = CT_LISTNBOX;","idcLeft = -1;","idcRight = -1;","drawSideArrows = false;"]],
	[1601,"BtnSave",[1,"Save",["0.6 * safezoneW + safezoneX","0.38 * safezoneH + safezoneY","0.0875 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"Save current loadout","-1"],[]],
	[1602,"BtnRename",[1,"Rename",["0.6 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.0875 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"Rename current loadout","-1"],[]],
	[1603,"BtnOverwrite",[1,"Overwrite",["0.6 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0875 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"Overwrite current loadout","-1"],[]],
	[1604,"BtnDelete",[1,"Delete",["0.6 * safezoneW + safezoneX","0.62 * safezoneH + safezoneY","0.0875 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0.6,0,0,1],[-1,-1,-1,-1],"Save current loadout","-1"],[]],
	[1605,"BtnApply",[1,"Apply",["0.6 * safezoneW + safezoneX","0.3 * safezoneH + safezoneY","0.0875 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"Apply current loadout","-1"],[]]
]
*/
class GVAR(Dialog) {
    idd = 6119823;
    onLoad = QUOTE(call FUNC(onDialogOpen));
    onUnload = QUOTE(uiNamespace setVariable[ARR_2(QQGVAR(menuDisplay),nil)]);
	movingEnable = 1;

    class Controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by goreSplatter, v1.063, #Luxiwu)
		////////////////////////////////////////////////////////

		class StaticBackground: RscText
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_STATICBACKGROUND;
			x = QUOTE(0.3 * safezoneW + safezoneX);
			y = QUOTE(0.28 * safezoneH + safezoneY);
			w = QUOTE(0.4 * safezoneW);
			h = QUOTE(0.4 * safezoneH);
			colorBackground[] = {0,0,0,0.8};
		};
		class StaticTitle: RscText
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_STATICTITLE;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_StaticTitle);
			x = QUOTE(0.3 * safezoneW + safezoneX);
			y = QUOTE(0.24 * safezoneH + safezoneY);
			w = QUOTE(0.4 * safezoneW);
			h = QUOTE(0.032 * safezoneH);
			colorBackground[] = {0,0.8,0,1};
			moving = 1;
		};
		class BtnClose: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNCLOSE;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnClose);
			x = QUOTE(0.6825 * safezoneW + safezoneX);
			y = QUOTE(0.248 * safezoneH + safezoneY);
			w = QUOTE(0.0125 * safezoneW);
			h = QUOTE(0.02 * safezoneH);
		};
		class ListLoadouts: RscListbox
		{
			type = CT_LISTNBOX;
			idcLeft = -1;
			idcRight = -1;
			drawSideArrows = false;

			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_LISTLOADOUTS;
			x = QUOTE(0.3125 * safezoneW + safezoneX);
			y = QUOTE(0.3 * safezoneH + safezoneY);
			w = QUOTE(0.275 * safezoneW);
			h = QUOTE(0.36 * safezoneH);
		};
		class BtnSave: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNSAVE;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnSave);
			x = QUOTE(0.6 * safezoneW + safezoneX);
			y = QUOTE(0.38 * safezoneH + safezoneY);
			w = QUOTE(0.0875 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
			tooltip = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnSave_tooltip);
		};
		class BtnRename: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNRENAME;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnRename);
			x = QUOTE(0.6 * safezoneW + safezoneX);
			y = QUOTE(0.44 * safezoneH + safezoneY);
			w = QUOTE(0.0875 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
			tooltip = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnRename_tooltip);
		};
		class BtnOverwrite: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNOVERWRITE;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnOverwrite);
			x = QUOTE(0.6 * safezoneW + safezoneX);
			y = QUOTE(0.5 * safezoneH + safezoneY);
			w = QUOTE(0.0875 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
			tooltip = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnOverwrite_tooltip);
		};
		class BtnDelete: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNDELETE;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnDelete);
			x = QUOTE(0.6 * safezoneW + safezoneX);
			y = QUOTE(0.62 * safezoneH + safezoneY);
			w = QUOTE(0.0875 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0.6,0,0,1};
			tooltip = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnDelete_tooltip);
		};
		class BtnApply: RscButton
		{
			idc = IDC_RSCA3USPCMLOADOUTMANAGERDIALOG_BTNAPPLY;
			text = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnApply);
			x = QUOTE(0.6 * safezoneW + safezoneX);
			y = QUOTE(0.3 * safezoneH + safezoneY);
			w = QUOTE(0.0875 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
			tooltip = CSTRING(RscA3USPCMLoadoutManagerDialog_BtnApply_tooltip);
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
    };
};
