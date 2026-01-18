#define DEFGRP(name) \
    class GVAR(name) { \
        GVAR(name) = 1; \
        name = 1; \
    }

class ACE_CSW_Groups {
    DEFGRP(8Rnd_60mm_Mo_shells_RF);
    DEFGRP(8Rnd_60mm_Mo_Flare_white);
    DEFGRP(8Rnd_60mm_Mo_Flare_white_illumination);
    DEFGRP(8Rnd_60mm_Mo_Smoke_white);
    DEFGRP(8Rnd_60mm_Mo_guided);
    DEFGRP(8Rnd_60mm_Mo_LG);
};
