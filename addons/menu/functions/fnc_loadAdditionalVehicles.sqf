#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_menu_fnc_loadAdditionalVehicles

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
TRACE_1(QFUNC(loadAdditionalVehicles),_this);

if isNil(QGVAR(AdditionalVehicles)) then {
    INFO("loading additional vehicles");

    [QGVAR(AdditionalVehicles)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalVehicles)) || { !(GVAR(AdditionalVehicles) isEqualType []) }) then {
        INFO("No saved additional Vehicles found, initializing empty array");
        GVAR(AdditionalVehicles) = [];
    } else {
        INFO("Loading additional Vehicles from saved data");
    };
};

([GVAR(additionalVehiclesClassList)] call FUNCMAIN(utilParseAdditionalsList)) apply {
    _x params["_className","_price"];

    private _key = [_className] call FUNCMAIN(utilGetVehicleTemplateKey);

    GVAR(AdditionalVehicles) pushBackUnique[_className, _price, _key];
};

GVAR(AdditionalVehicles) apply {
    _x params[["_className","",[""]],["_price",0,[0]],["_type","",[""]]];

    TRACE_3(QFUNC(loadAdditionalVehicles),_className,_price,_type);

    server setVariable[_className, _price, true];
};

publicVariable QGVAR(AdditionalVehicles);

nil;
