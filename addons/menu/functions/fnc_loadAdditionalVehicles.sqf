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

if (GVAR(AdditionalVehicles) isEqualTo false) then {
    INFO("loading additional vehicles");

    [QGVAR(AdditionalVehicles)] call A3A_fnc_getStatVariable;
    
    if ((isNil QGVAR(AdditionalVehicles)) || !(GVAR(AdditionalVehicles) isEqualType [])) then {
        INFO("No saved additional Vehicles found, initializing empty array");
        GVAR(AdditionalVehicles) = [];
    } else {
        private _typeMap = createHashMapFromArray[
            ["vehiclesLightArmed", "TANK"],
            ["vehiclesCivCar", "UNARMEDCAR"],
            ["vehiclesCivHeli", "HELI"],
            ["vehiclesCivPlane", "PLANE"],
            ["vehiclesCivBoat", "BOAT"],
            ["vehiclesPlane", "PLANE"],
            ["vehiclesBoat", "BOAT"]
        ];

        INFO("Loading additional Vehicles from saved data");

        GVAR(AdditionalVehicles) apply {
            _x params[["_className","",[""]],["_price",0,[0]],["_type","",[""]]];

            TRACE_3(QFUNC(loadAdditionalVehicles),_className,_price,_type);

            A3A_faction_reb get _type pushBackUnique _className;

            if (A3U_blackMarketStock findIf { _x select 0 isEqualTo _className } isNotEqualTo -1) then {
                WARNING_2("%1(%2): black market config found; not adding to BM",QFUNC(loadAdditionalVehicles),_className);
            } else {
                A3U_blackMarketStock pushBack [
                    _className, // classname
                    _price, // price
                    _typeMap get _type, // type
                    {true} // condition
                ];
            };
        };
    };
};

nil;
