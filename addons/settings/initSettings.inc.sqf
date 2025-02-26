private _category = localize ELSTRING(main,Title);

[
    QEGVAR(zeus,moduleMSE_useAI), "CHECKBOX",
    [ELSTRING(zeus,Settings_moduleMSE_useAI_DisplayName), ELSTRING(zeus,Settings_moduleMSE_useAI_Tooltip)],
    _category,
    false,
    1,
    {},
    false // Needs mission restart
] call CBA_fnc_addSetting;
