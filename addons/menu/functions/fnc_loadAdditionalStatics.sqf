#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadAdditionalStatics

Description:
    Load additional buyable static emplacements

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(loadAdditionalStatics),_this);

if isNil(QGVAR(AdditionalStatics)) then {
    INFO("loading additional static weapons");

    [QGVAR(AdditionalStatics)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalStatics)) || { !(GVAR(AdditionalStatics) isEqualType []) }) then {
        INFO("No saved additional statics found, initializing empty array");
        GVAR(AdditionalStatics) = [];
    } else {
        INFO("Loading additional statics from saved data");
    };
};

([GVAR(additionalStaticsClassList)] call FUNCMAIN(utilParseAdditionalsList)) apply {
    GVAR(AdditionalStatics) pushBackUnique _x;
};

GVAR(AdditionalStatics) apply {
    _x params[["_className","",[""]],["_price",0,[0]]];

    TRACE_2(QFUNC(loadAdditionalStatics),_className,_price);

    server setVariable[_className, _price, true];
};

publicVariable QGVAR(AdditionalStatics);

nil;
