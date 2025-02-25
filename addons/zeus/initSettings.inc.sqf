private _category = localize ELSTRING(main,Title);

[
    QGVAR(moduleMSE_useAI), "CHECKBOX",
    [LSTRING(Settings_moduleMSE_useAI_DisplayName), LSTRING(Settings_moduleMSE_useAI_Tooltip)],
    _category,
    false,
    1,
    {},
    false // Needs mission restart
] call CBA_fnc_addSetting;
