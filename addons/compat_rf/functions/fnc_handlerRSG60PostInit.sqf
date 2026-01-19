#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_compat_rf_fnc_handlerRSG60PostInit

Description:
    PostInit function for RF RSG-60 compatibility

Parameters:
    0: _vehicle - RSG60 mortar <OBJECT>

Optional:

Returns:
    Nothing

Environment:
    Client, Unscheduled

Author:
    UnseenKill/gor3Splatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(handlerRSG60PostInit),_this);

if !assert(params[
    ["_vehicle", nil, [objNull]]
]) exitWith {};

getArray(configOf _vehicle >> QGVAR(magazines)) apply {
    _x params["_fakeMagazine","_realMagazine"];
    private _config = configFile >> "CfgMagazines" >> _fakeMagazine;

    _vehicle addAction[
        format[localize "STR_ACE_CSW_loadX", getText(_config >> "displayName")],
        { call FUNC(rsg60ReloadUserAction) },
        [_fakeMagazine, _realMagazine, getNumber(_config >> "count"), getText(_config >> "displayName"), getNumber(configOf _vehicle >> "ace_csw" >> "ammoLoadTime")],
        1.5,
        false,
        true,
        "",
        format[QUOTE((_target isEqualTo objectParent _this) && { magazinesAmmoCargo backpackContainer _this findIf { _x select 0 isEqualTo QQUOTE(%1) } != -1 }), _fakeMagazine],
        5
    ];
};

_vehicle addAction[
    LLSTRING(RSG60_DumpAllAmmo),
    { call FUNC(rsg60DumpAllAmmo) },
    [],
    1.45,
    false,
    true,
    "",
    QUOTE((_target isEqualTo objectParent _this) && { magazines _target isNotEqualTo [] }),
    5
];

nil;
