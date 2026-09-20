class CfgVehicles {
    class Items_base_F;

    class ace_advanced_throwing_pickUpHelper: Items_base_F {
        class ACE_Actions {
            class ace_advanced_throwing_pickUp {
                condition = QUOTE(!isNil { (_this select 0) getVariable QQUOTE(ace_advanced_throwing_throwable) getVariable QUOTE(QEGVAR(menu,intelMarker)) } && {[ARR_2(_player,true)] call FUNC(canPrepare)});
            };

            class GVAR(intelFound) {
                condition = QUOTE(!isNil { (_this select 0) getVariable QQUOTE(ace_advanced_throwing_throwable) getVariable QUOTE(QEGVAR(menu,intelMarker)) });
                displayName = ECSTRING(menu,Miscellaneous_FindIntelCleanupActionText);
                distance = 1.8;
                exceptions[] = {"isNotSwimming"};
                icon = "\a3\ui_f\data\igui\cfg\simpletasks\types\search_ca.paa";
                statement = QUOTE([(_this select 0) getVariable QQUOTE(ace_advanced_throwing_throwable) getVariable QUOTE(QEGVAR(menu,intelMarker))] call EFUNC(menu,intelCleanupMarker));
            };
        };
    };
};
