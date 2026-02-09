// Macros ----------------------------------------------------------------------
#define DEFAULT_FONT font = "PuristaMedium"
#define TABLET_SCREEN_WIDTH (safeZoneW * 0.5125 + pixelW * 10)
#define TABLET_CLIENTAREA_HEIGHT (UI_GRID_H * 22)
#define TABLET_CLIENTAREA_WIDTH (TABLET_SCREEN_WIDTH - pixelW * 64)
#define UI_ASPECT ((safeZoneW / safeZoneH) min 1.2)
#define UI_GRID_H_20 ((UI_ASPECT / 1.2) / 20)
#define UI_GRID_H ((UI_ASPECT / 1.2) / 25)
#define UI_GRID_W (UI_ASPECT / 40)

// Control IDs -----------------------------------------------------------------
#define IDC_BTN_STEAL_THIS_FOCUS    821610
#define IDC_BTN_TAB_OVERVIEW        821611
#define IDC_BTN_TAB_TARGETS         821612
#define IDC_BTN_TAB_CONFIGURATION   821613

#define IDC_TABHOST_OVERVIEW        821620
#define IDC_OVERVIEW_BTN_FIREATWILL 821621
#define IDC_OVERVIEW_BTN_CIWSONLY   821622
#define IDC_OVERVIEW_BTN_SRSAM      821623
#define IDC_OVERVIEW_BTN_LRSAM      821624
#define IDC_OVERVIEW_BTN_HOLDFIRE   821625
#define IDC_OVERVIEW_HOSTCTL_GROUPS 821626

#define IDC_TABHOST_TARGETS         821640

#define IDC_TABHOST_CONFIGURATION   821660
