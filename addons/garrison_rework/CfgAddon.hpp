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
                onButtonClick = "ctrlParent(_this select 0) closeDisplay 0";
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
                #define COLUMN_OFFSETS columns[] = {0, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95}
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
                            };
                        };
                    };

                    class CenterPanel {
                        x = QUOTE(20 * UI_GRID_W);
                        w = QUOTE(10 * UI_GRID_W);

                        class Controls {
                            class RecruitList {
                                h = QUOTE(2 * safeZoneH / 5 - 3.5 * UI_GRID_H - 8 * pixelH);

#define RECRUIT_ROW(Offset,Name) \
                                    class DOUBLES(Label,Name) { \
                                        y = QUOTE((Offset) * UI_GRID_H); \
                                        w = QUOTE(4 * UI_GRID_W); \
                                        h = QUOTE(1 * UI_GRID_H); \
                                        text = UNIT_DISPLAYNAME(Name); \
                                    }; \
                                    class DOUBLES(Slider,Name) { \
                                        y = QUOTE((Offset) * UI_GRID_H); \
                                        x = QUOTE(4 * UI_GRID_W); \
                                        w = QUOTE(5 * UI_GRID_W); \
                                        h = QUOTE(1 * UI_GRID_H); \
                                        className = QUOTE(RscXSliderH); \
                                    }; \
                                    class DOUBLES(Counter,Name) { \
                                        y = QUOTE((Offset) * UI_GRID_H); \
                                        x = QUOTE(9 * UI_GRID_W); \
                                        w = QUOTE(1 * UI_GRID_W - 8 * pixelW); \
                                        h = QUOTE(1 * UI_GRID_H); \
                                        text = "0"; \
                                    }

                                class Controls {
                                    RECRUIT_ROW(0,SquadLdr);
                                    RECRUIT_ROW(1,Medic);
                                    RECRUIT_ROW(2,Marksman);
                                    RECRUIT_ROW(3,Rifleman);
                                    RECRUIT_ROW(4,Grenadier);
                                    RECRUIT_ROW(5,Autorifleman);
                                    RECRUIT_ROW(6,AT);
                                    RECRUIT_ROW(7,AASpecialist);
                                    RECRUIT_ROW(8,ATSpecialist);
                                    RECRUIT_ROW(9,Crew);
                                    RECRUIT_ROW(10,Sapper);
                                    RECRUIT_ROW(11,Engineer);
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
                            };

                            class LabelShowOutposts: LabelShowBases {
                                y = QUOTE(2 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowOutposts_DisplayName);
                            };

                            class ChecksShowOutposts: ChecksShowBases {
                                y = QUOTE(2 * UI_GRID_H);
                            };

                            class LabelShowResources: LabelShowBases {
                                y = QUOTE(3 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowResources_DisplayName);
                            };

                            class ChecksShowResources: ChecksShowBases {
                                y = QUOTE(3 * UI_GRID_H);
                            };

                            class LabelShowTowns: LabelShowBases {
                                y = QUOTE(4 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_ShowTowns_DisplayName);
                            };

                            class ChecksShowTowns: ChecksShowBases {
                                y = QUOTE(4 * UI_GRID_H);
                            };

                            class LabelHideFull: LabelShowBases {
                                y = QUOTE(5 * UI_GRID_H);
                                text = CSTRING(Dialog_Filters_Check_HideFull_DisplayName);
                            };

                            class ChecksHideFull: ChecksShowBases {
                                y = QUOTE(5 * UI_GRID_H);
                            };

#ifdef __A3_DEBUG__
                            class ADTMagicWordEdit {
                                w = "100%";
                                className = QUOTE(RscEdit);
                                y = QUOTE(2 * safeZoneH / 5 - 3.5 * UI_GRID_H - 8 * pixelH);
                                h = QUOTE(1 * UI_GRID_H);
                            };
#endif
                        };
                    };
                };
            };
        };
    };
};
