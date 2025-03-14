#include "\z\a3uspcm\addons\main\ui_define.hpp"
#include "RscDefine.hpp"

// Replace attributes:
//  Search: (^\s*(?:sizeEx|[xywh])) = ([^;]+)
//  Replace: $1 = QUOTE($2)
// Text:
//  Search: (^\s*(?:text|tooltip)\s*=\s*)[$]STR_A3_([^;]+)
//  Replace: $1CSTRING($2)

/* #Ryhulu
$[
	1.063,
	["RscA3USPCMGarrisonManagerDialog",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],2,1,1],
	[-1000,"StaticBackground",[1,"",["0.15 * safezoneW + safezoneX","0.16 * safezoneH + safezoneY","0.7 * safezoneW","0.68 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.8],[-1,-1,-1,-1],"","-1"],[]],
	[-1001,"StaticTitle",[1,"Title",["0.15 * safezoneW + safezoneX","0.116 * safezoneH + safezoneY","0.7 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.8,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[-1600,"BtnClose",[1,"X",["0.8325 * safezoneW + safezoneX","0.128 * safezoneH + safezoneY","0.0125 * safezoneW","0.02 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"CheckShowBLUFOR",[1,"",["0.1625 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show locations of BLUFOR faction (usually NATO)","-1"],[]],
	[1002,"StaticLabelBLUFOR",[1,"BLUFOR",["0.1875 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"CheckShowOPFOR",[1,"",["0.25 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show locations of OPFOR faction (usually CSAT)","-1"],[]],
	[1003,"StaticLabelOPFOR",[1,"OPFOR",["0.275 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2802,"CheckShowINDEP",[1,"",["0.325 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show locations of INDEP faction (usually: you)","-1"],[]],
	[1004,"StaticLabelINDEP",[1,"INDEP",["0.35 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2803,"CheckShowBases",[1,"",["0.425 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show military bases/airports","-1"],[]],
	[1005,"StaticLabelBases",[1,"Bases",["0.45 * safezoneW + safezoneX","0.776 * safezoneH + safezoneY","0.0625 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2804,"CheckShowOutposts",[1,"",["0.5125 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show outposts","-1"],[]],
	[1006,"StaticLabelOutposts",[1,"Outposts",["0.5375 * safezoneW + safezoneX","0.776 * safezoneH + safezoneY","0.0625 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2805,"CheckShowResources",[1,"",["0.6025 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show resources","-1"],[]],
	[1007,"StaticLabelResources",[1,"Resources",["0.625 * safezoneW + safezoneX","0.776 * safezoneH + safezoneY","0.0625 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2806,"CheckShowTowns",[1,"",["0.695 * safezoneW + safezoneX","0.788 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Show towns/villages","-1"],[]],
	[1008,"StaticLabelTowns",[1,"Towns/villages",["0.7175 * safezoneW + safezoneX","0.776 * safezoneH + safezoneY","0.0625 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"ListOverview",[1,"",["0.1625 * safezoneW + safezoneX","0.18 * safezoneH + safezoneY","0.675 * safezoneW","0.6 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["type = CT_LISTNBOX;","drawSideArrows = false;","idcLeft = -1;","idcRight = -1;","tooltipPerColumn = true;"]],
	[1601,"BtnLocate",[1,"Locate...",["0.7125 * safezoneW + safezoneX","0.86 * safezoneH + safezoneY","0.05 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"BtnRecruit",[1,"Recruit",["0.775 * safezoneW + safezoneX","0.86 * safezoneH + safezoneY","0.075 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[0,0.6,0,1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class GVAR(dialog) {
    idd = 6119820;
    onLoad = QUOTE(call FUNC(onMenuOpen));
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(menuDisplay),nil)]);

    class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by goreSplatter, v1.063, #Ryhulu)
		////////////////////////////////////////////////////////

		class StaticBackground: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICBACKGROUND;
			x = QUOTE(0.15 * safezoneW + safezoneX);
			y = QUOTE(0.16 * safezoneH + safezoneY);
			w = QUOTE(0.7 * safezoneW);
			h = QUOTE(0.68 * safezoneH);
			colorBackground[] = {0,0,0,0.8};
		};
		class StaticTitle: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICTITLE;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticTitle);
			x = QUOTE(0.15 * safezoneW + safezoneX);
			y = QUOTE(0.116 * safezoneH + safezoneY);
			w = QUOTE(0.7 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.8,0,1};
		};
		class BtnClose: RscButton
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_BTNCLOSE;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_BtnClose);
			x = QUOTE(0.8325 * safezoneW + safezoneX);
			y = QUOTE(0.128 * safezoneH + safezoneY);
			w = QUOTE(0.0125 * safezoneW);
			h = QUOTE(0.02 * safezoneH);
		};
		class CheckShowBLUFOR: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBLUFOR;
			x = QUOTE(0.1625 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowBLUFOR_tooltip);
		};
		class StaticLabelBLUFOR: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELBLUFOR;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelBLUFOR);
			x = QUOTE(0.1875 * safezoneW + safezoneX);
			y = QUOTE(0.78 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class CheckShowOPFOR: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOPFOR;
			x = QUOTE(0.25 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowOPFOR_tooltip);
		};
		class StaticLabelOPFOR: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELOPFOR;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelOPFOR);
			x = QUOTE(0.275 * safezoneW + safezoneX);
			y = QUOTE(0.78 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class CheckShowINDEP: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWINDEP;
			x = QUOTE(0.325 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowINDEP_tooltip);
		};
		class StaticLabelINDEP: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELINDEP;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelINDEP);
			x = QUOTE(0.35 * safezoneW + safezoneX);
			y = QUOTE(0.78 * safezoneH + safezoneY);
			w = QUOTE(0.04125 * safezoneW);
			h = QUOTE(0.055 * safezoneH);
		};
		class CheckShowBases: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWBASES;
			x = QUOTE(0.425 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowBases_tooltip);
		};
		class StaticLabelBases: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELBASES;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelBases);
			x = QUOTE(0.45 * safezoneW + safezoneX);
			y = QUOTE(0.776 * safezoneH + safezoneY);
			w = QUOTE(0.0625 * safezoneW);
			h = QUOTE(0.06 * safezoneH);
		};
		class CheckShowOutposts: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWOUTPOSTS;
			x = QUOTE(0.5125 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowOutposts_tooltip);
		};
		class StaticLabelOutposts: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELOUTPOSTS;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelOutposts);
			x = QUOTE(0.5375 * safezoneW + safezoneX);
			y = QUOTE(0.776 * safezoneH + safezoneY);
			w = QUOTE(0.0625 * safezoneW);
			h = QUOTE(0.06 * safezoneH);
		};
		class CheckShowResources: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWRESOURCES;
			x = QUOTE(0.6025 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowResources_tooltip);
		};
		class StaticLabelResources: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELRESOURCES;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelResources);
			x = QUOTE(0.625 * safezoneW + safezoneX);
			y = QUOTE(0.776 * safezoneH + safezoneY);
			w = QUOTE(0.0625 * safezoneW);
			h = QUOTE(0.06 * safezoneH);
		};
		class CheckShowTowns: RscCheckbox
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_CHECKSHOWTOWNS;
			x = QUOTE(0.695 * safezoneW + safezoneX);
			y = QUOTE(0.788 * safezoneH + safezoneY);
			w = QUOTE(0.025 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			tooltip = CSTRING(RscA3USPCMGarrisonManagerDialog_CheckShowTowns_tooltip);
		};
		class StaticLabelTowns: RscText
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_STATICLABELTOWNS;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_StaticLabelTowns);
			x = QUOTE(0.7175 * safezoneW + safezoneX);
			y = QUOTE(0.776 * safezoneH + safezoneY);
			w = QUOTE(0.0625 * safezoneW);
			h = QUOTE(0.06 * safezoneH);
		};
		class ListOverview: RscListbox
		{
			type = CT_LISTNBOX;
			drawSideArrows = false;
			idcLeft = -1;
			idcRight = -1;
			tooltipPerColumn = true;

			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_LISTOVERVIEW;
			x = QUOTE(0.1625 * safezoneW + safezoneX);
			y = QUOTE(0.18 * safezoneH + safezoneY);
			w = QUOTE(0.675 * safezoneW);
			h = QUOTE(0.6 * safezoneH);
		};
		class BtnLocate: RscButton
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_BTNLOCATE;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_BtnLocate);
			x = QUOTE(0.7125 * safezoneW + safezoneX);
			y = QUOTE(0.86 * safezoneH + safezoneY);
			w = QUOTE(0.05 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
		};
		class BtnRecruit: RscButton
		{
			idc = IDC_RSCA3USPCMGARRISONMANAGERDIALOG_BTNRECRUIT;
			text = CSTRING(RscA3USPCMGarrisonManagerDialog_BtnRecruit);
			x = QUOTE(0.775 * safezoneW + safezoneX);
			y = QUOTE(0.86 * safezoneH + safezoneY);
			w = QUOTE(0.075 * safezoneW);
			h = QUOTE(0.04 * safezoneH);
			colorBackground[] = {0,0.6,0,1};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
    };
};
