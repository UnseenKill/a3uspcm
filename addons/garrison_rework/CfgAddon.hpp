class RscDisplayEmpty;

class GVAR(RscDisplayEmpty): RscDisplayEmpty {
    onLoad = QUOTE([ARR_2(QUOTE(CBA_EVENT_DIALOG_LOADED),_this)] call CBA_fnc_localEvent);
    onUnload = QUOTE([ARR_2(QUOTE(CBA_EVENT_DIALOG_UNLOADED),_this)] call CBA_fnc_localEvent);
};

class GVAR(Config) {
    class Dialog {
        idcBase = 1000;

        className = QUOTE(RscControlsGroupNoVScrollbars);
        ignoreMap[] = {"Caption","Separator"};

        x = QUOTE(safeZoneX);
        y = QUOTE(safeZoneY + 3 * safeZoneH / 5);
        w = QUOTE(safeZoneW);
        h = QUOTE(2 * safeZoneH / 5);

        colorBackground[] = {0.15,0.15,0.15,0.95};
        fade = 1;

        font = "PuristaMedium";
        fontSize = QUOTE(1 * UI_GRID_H - 4 * pixelH);

        onBuiltEvent = CBA_EVENT_DIALOG_BUILT;

        class Controls {
            class MainTitle {
                w = "100%";
                h = QUOTE(1.25 * UI_GRID_H);
                fontSize = QUOTE(1.25 * UI_GRID_H - 4 * pixelH);
                text = CSTRING(Dialog_MainTitle);
            };

            class ButtonClose {
                x = QUOTE(safeZoneW - 1 * UI_GRID_W - 8 * pixelW);
                y = QUOTE(8 * pixelH);
                w = QUOTE(1 * UI_GRID_W);
                h = QUOTE(1 * UI_GRID_H);
                className = QUOTE(RscButton);
                text = "X";
                onButtonClickEvent = CBA_EVENT_DIALOG_BTNCLOSE_CLICK;
            };

            class Separator {
                y = QUOTE(1.5 * UI_GRID_H);
                w = "100%";
                h = 0;
                className = QUOTE(RscLine);
            };

            class AGM {
                y = QUOTE(1.5 * UI_GRID_H + 4 * pixelH);
                spacing[] = {QUOTE(4 * pixelW), QUOTE(4 * pixelH)};

                class Controls {
                #define COLUMN_OFFSETS columns[] = {0, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95}
                #define UNIT_ABBREVIATION(Name) CSTRING(TRIPLES(Dialog_UnitType,Name,Abbreviated))
                #define UNIT_DISPLAYNAME(Name) CSTRING(TRIPLES(Dialog_UnitType,Name,DisplayName))
                    class LeftPanel {
                        w = QUOTE(20 * UI_GRID_W);

                        class Controls {
                            yesHemttThoseStringsAreUsed[] = {
                                CSTRING(Dialog_ListHeader_Column_Name_DisplayName),
                                CSTRING(Dialog_ListHeader_Column_Current_DisplayName),
                                CSTRING(Dialog_ListHeader_Column_Capacity_DisplayName),
                                UNIT_ABBREVIATION(SquadLdr),
                                UNIT_ABBREVIATION(Medic),
                                UNIT_ABBREVIATION(Marksman),
                                UNIT_ABBREVIATION(Rifleman),
                                UNIT_ABBREVIATION(Grenadier),
                                UNIT_ABBREVIATION(Autorifleman),
                                UNIT_ABBREVIATION(AT),
                                UNIT_ABBREVIATION(AASpecialist),
                                UNIT_ABBREVIATION(ATSpecialist),
                                UNIT_ABBREVIATION(Crew),
                                UNIT_ABBREVIATION(Sapper),
                                UNIT_ABBREVIATION(Engineer)
                            };
                            class ListLocationsHeader {
                                fontSize = "80%";
                                w = "100%";
                                h = QUOTE(1 * UI_GRID_H);
                                className = QGVAR(RscListNBoxHeader);
                                enabled = 0;
                                COLUMN_OFFSETS;
                                items[] = {{
                                    CSTRING(Dialog_ListHeader_Column_Name_DisplayName),
                                    CSTRING(Dialog_ListHeader_Column_Current_DisplayName),
                                    CSTRING(Dialog_ListHeader_Column_Capacity_DisplayName),
                                    UNIT_ABBREVIATION(SquadLdr),
                                    UNIT_ABBREVIATION(Medic),
                                    UNIT_ABBREVIATION(Marksman),
                                    UNIT_ABBREVIATION(Rifleman),
                                    UNIT_ABBREVIATION(Grenadier),
                                    UNIT_ABBREVIATION(Autorifleman),
                                    UNIT_ABBREVIATION(AT),
                                    UNIT_ABBREVIATION(AASpecialist),
                                    UNIT_ABBREVIATION(ATSpecialist),
                                    UNIT_ABBREVIATION(Crew),
                                    UNIT_ABBREVIATION(Sapper),
                                    UNIT_ABBREVIATION(Engineer)
                                }};
                            };

                            class ListLocations {
                                fontSize = "80%";
                                y = QUOTE(1 * UI_GRID_H);
                                w = "100%";
                                h = QUOTE(2 * safeZoneH / 5 - 2.5 * UI_GRID_H - 8 * pixelH);
                                className = QGVAR(RscListNBox);
                                COLUMN_OFFSETS;

                                onLBDblClickEvent = CBA_EVENT_DIALOG_LOCATION_DBLCLICK;
                                onLBSelChangedEvent = CBA_EVENT_DIALOG_LOCATION_SELECTED;

                                class Properties {
                                    GVAR(columnsOrder)[] = {
                                        QUOTE(unitSL),
                                        QUOTE(unitMedic),
                                        QUOTE(unitSniper),
                                        QUOTE(unitRifle),
                                        QUOTE(unitGL),
                                        QUOTE(unitMG),
                                        QUOTE(unitLAT),
                                        QUOTE(unitAA),
                                        QUOTE(unitAT),
                                        QUOTE(unitCrew),
                                        QUOTE(unitExp),
                                        QUOTE(unitEng)
                                    };
                                };
                            };
                        };
                    };

                    class CenterPanel {
                        x = QUOTE(20 * UI_GRID_W);
                        w = QUOTE(10 * UI_GRID_W);

                        class Controls {
                            class BtnRecruit {
                                className = QGVAR(RscButton);
                                text = CSTRING(Dialog_BtnRecruit_DisplayName);
                                tooltip = CSTRING(Dialog_BtnRecruit_Tooltip);
                                x = QUOTE(5 * UI_GRID_W);
                                y = QUOTE(11.5 * UI_GRID_H);
                                w = QUOTE(5 * UI_GRID_W - 4 * pixelW);
                                h = QUOTE(1.5 * UI_GRID_H);
                                onButtonClickEvent = CBA_EVENT_DIALOG_BTNRECRUIT_CLICK;
                            };

                            class RecruitList {
                                h = QUOTE(11.5 * UI_GRID_H);
                                backgroundControlClass = QGVAR(RscTextMessage);
                                colorBackground[] = {0,0,0,0};

#define RECRUIT_ROW(Offset,Name,UnitType) \
                                    class DOUBLES(Label,Name) { \
                                        className = QGVAR(RscText); \
                                        y = QUOTE((Offset) * 0.8 * UI_GRID_H); \
                                        w = QUOTE(2.5 * UI_GRID_W); \
                                        h = QUOTE(0.8 * UI_GRID_H); \
                                        text = UNIT_DISPLAYNAME(Name); \
                                        fontSize = "80%"; \
                                    }; \
                                    class DOUBLES(PriceTag,Name) { \
                                        className = QGVAR(RscTextRightAlign); \
                                        x = QUOTE(2.5 * UI_GRID_W); \
                                        y = QUOTE((Offset) * 0.8 * UI_GRID_H); \
                                        w = QUOTE(1.5 * UI_GRID_W); \
                                        h = QUOTE(0.8 * UI_GRID_H); \
                                        fontSize = "80%"; \
                                        \
                                        class Properties { \
                                            GVAR(unitType) = QUOTE(UnitType); \
                                        }; \
                                    }; \
                                    class DOUBLES(Slider,Name) { \
                                        y = QUOTE((Offset) * 0.8 * UI_GRID_H); \
                                        x = QUOTE(4 * UI_GRID_W); \
                                        w = QUOTE(5 * UI_GRID_W); \
                                        h = QUOTE(0.8 * UI_GRID_H); \
                                        className = QUOTE(RscXSliderH); \
                                        \
                                        class Properties { \
                                            GVAR(isSlider) = 1; \
                                            GVAR(unitName) = QUOTE(Name); \
                                            GVAR(unitType) = QUOTE(UnitType); \
                                        }; \
                                        \
                                        onSliderPosChangedEvent = CBA_EVENT_DIALOG_UNITTYPE_SLIDER_CHANGED; \
                                    }; \
                                    class DOUBLES(Counter,Name) { \
                                        className = QGVAR(RscTextRightAlign); \
                                        y = QUOTE((Offset) * 0.8 * UI_GRID_H); \
                                        x = QUOTE(9 * UI_GRID_W); \
                                        w = QUOTE(1 * UI_GRID_W - 8 * pixelW); \
                                        h = QUOTE(0.8 * UI_GRID_H); \
                                        text = "0"; \
                                        fontSize = "80%"; \
                                    }

                                class Controls {
                                    RECRUIT_ROW(0,SquadLdr,unitSL);
                                    RECRUIT_ROW(1,Medic,unitMedic);
                                    RECRUIT_ROW(2,Marksman,unitSniper);
                                    RECRUIT_ROW(3,Rifleman,unitRifle);
                                    RECRUIT_ROW(4,Grenadier,unitGL);
                                    RECRUIT_ROW(5,Autorifleman,unitMG);
                                    RECRUIT_ROW(6,AT,unitLAT);
                                    RECRUIT_ROW(7,AASpecialist,unitAA);
                                    RECRUIT_ROW(8,ATSpecialist,unitAT);
                                    RECRUIT_ROW(9,Crew,unitCrew);
                                    RECRUIT_ROW(10,Sapper,unitExp);
                                    RECRUIT_ROW(11,Engineer,unitEng);

                                    class Separator: Separator {
                                        y = QUOTE(10 * UI_GRID_H);
                                        h = 0;
                                        w = "100%";
                                    };

                                    class LabelTotal {
                                        className = QGVAR(RscText);
                                        y = QUOTE(10 * UI_GRID_H);
                                        w = QUOTE(2.5 * UI_GRID_W);
                                        h = QUOTE(1 * UI_GRID_H);
                                        text = CSTRING(Dialog_Recruitment_LabelTotal);
                                        fontSize = "80%";
                                    };

                                    class PriceTagTotal: LabelTotal {
                                        className = QGVAR(RscTextRightAlign);
                                        x = QUOTE(2.5 * UI_GRID_W);
                                        w = QUOTE(1.5 * UI_GRID_W);
                                        text = "";
                                    };

                                    class DeltaInfo: PriceTagTotal {
                                        x = QUOTE(9 * UI_GRID_W);
                                        w = QUOTE(1 * UI_GRID_W - 8 * pixelW);
                                        text = "";
                                    };
                                };
                            };
                        };
                    };

                    class RightPanel {
                        x = QUOTE(30 * UI_GRID_W);
                        w = QUOTE(10 * UI_GRID_W);

                        class Controls {
                            class CaptionFilters {
                                w = "100%";
                                h = QUOTE(1 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_SectionTitle);
                            };

                            class Separator: Separator {
                                y = QUOTE(1 * UI_GRID_H);
                            };

                            class LabelShowBases {
                                className = QGVAR(RscText);
                                y = QUOTE(1 * UI_GRID_H);
                                w = QUOTE(6 * UI_GRID_W);
                                h = QUOTE(1 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowBases_DisplayName);
                                fontSize = "80%";
                            };

                            class ChecksShowBases {
                                x = QUOTE(6 * UI_GRID_W);
                                y = QUOTE(1 * UI_GRID_H);
                                w = QUOTE(4 * UI_GRID_W - 4 * pixelW);
                                h = QUOTE(1 * UI_GRID_H);
                                className = QGVAR(RscToolboxYesNo);
                                fontSize = "80%";

                                class Properties {
                                    GVAR(filterType) = FILTER_BASES;
                                };

                                onToolBoxSelChangedEvent = CBA_EVENT_DIALOG_FILTER_CHANGED;
                            };

                            class LabelShowOutposts: LabelShowBases {
                                y = QUOTE(2 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowOutposts_DisplayName);
                            };

                            class ChecksShowOutposts: ChecksShowBases {
                                y = QUOTE(2 * UI_GRID_H);

                                class Properties {
                                    GVAR(filterType) = FILTER_OUTPOSTS;
                                };
                            };

                            class LabelShowResources: LabelShowBases {
                                y = QUOTE(3 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowResources_DisplayName);
                            };

                            class ChecksShowResources: ChecksShowBases {
                                y = QUOTE(3 * UI_GRID_H);

                                class Properties {
                                    GVAR(filterType) = FILTER_RESOURCES;
                                };
                            };

                            class LabelShowTowns: LabelShowBases {
                                y = QUOTE(4 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowTowns_DisplayName);
                            };

                            class ChecksShowTowns: ChecksShowBases {
                                y = QUOTE(4 * UI_GRID_H);

                                class Properties {
                                    GVAR(filterType) = FILTER_TOWNS;
                                };
                            };

                            class LabelShowPosts: LabelShowBases {
                                y = QUOTE(5 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowPosts_DisplayName);
                            };

                            class ChecksShowPosts: ChecksShowBases {
                                y = QUOTE(5 * UI_GRID_H);

                                class Properties {
                                    GVAR(filterType) = FILTER_POSTS;
                                };
                            };

                            class LabelHideFull: LabelShowBases {
                                y = QUOTE(6 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_HideFull_DisplayName);
                            };

                            class ChecksHideFull: ChecksShowBases {
                                y = QUOTE(6 * UI_GRID_H);

                                class Properties {
                                    GVAR(filterType) = FILTER_AT_CAPACITY;
                                };
                            };

                            class OwnershipGroup {
                                y = QUOTE(8 * UI_GRID_H);
                                h = QUOTE(4 * UI_GRID_H);

                                class Controls {
                                    class LabelOwnerFilterRebels: LabelShowBases {
                                        y = 0;
                                        text = CSTRING(Dialog_Filters_Check_OwnerFilterRebels_DisplayName);
                                    };

                                    class ChecksOwnerFilterRebels: ChecksShowBases {
                                        y = 0;

                                        class Properties {
                                            GVAR(filterType) = FILTER_OWNER_REBELS;
                                            GVAR(label) = QUOTE(LabelOwnerFilterRebels);
                                        };
                                    };

                                    class LabelOwnerFilterOccupiers: LabelShowBases {
                                        y = QUOTE(1 * UI_GRID_H);
                                        text = CSTRING(Dialog_Filters_Check_OwnerFilterOccupiers_DisplayName);
                                    };

                                    class ChecksOwnerFilterOccupiers: ChecksShowBases {
                                        y = QUOTE(1 * UI_GRID_H);

                                        class Properties {
                                            GVAR(filterType) = FILTER_OWNER_OCCUPIERS;
                                            GVAR(label) = QUOTE(LabelOwnerFilterOccupiers);
                                        };
                                    };

                                    class LabelOwnerFilterInvaders: LabelShowBases {
                                        y = QUOTE(2 * UI_GRID_H);
                                        text = CSTRING(Dialog_Filters_Check_OwnerFilterInvaders_DisplayName);
                                    };

                                    class ChecksOwnerFilterInvaders: ChecksShowBases {
                                        y = QUOTE(2 * UI_GRID_H);

                                        class Properties {
                                            GVAR(filterType) = FILTER_OWNER_INVADERS;
                                            GVAR(label) = QUOTE(LabelOwnerFilterInvaders);
                                        };
                                    };
                                };
                            };

                            class ADTMagicWordEdit {
                                className = QUOTE(RscEdit);
                                x = QUOTE(6 * UI_GRID_W - 8 * pixelW);
                                y = 0;
                                w = QUOTE(4 * UI_GRID_W);
                                h = QUOTE(1 * UI_GRID_H);
                                colorBackground[] = {0.5,0,0,0.9};
                            };
                        };
                    };
                };
            };
        };
    };
};
