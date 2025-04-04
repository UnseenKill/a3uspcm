class ACE_Medical_Injuries {
    class damageTypes {
        class GVAR(neckSnap) {
            thresholds[] = {{20, 1}};
            selectionSpecific = 1;

            class Crush {
                weighting[] = {{1, 1}};
            };
        };
    };
};
