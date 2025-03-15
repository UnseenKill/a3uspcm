class CfgAmmo {
    class O_IRStrobe;

    class GVAR(Ammo40mm_EMP) : O_IRStrobe {
        hit = 20;
        indirectHit = 20;
        indirectHitRange = 20;

        class Eventhandlers {
            fired = QUOTE(call FUNC(handle40mmFired));
        };
    };
};
