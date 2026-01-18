#define DEFGRP(name) \
    class GVAR(name) { \
        GVAR(name) = 1; \
        name = 1; \
    }

class ACE_CSW_Groups {
    DEFGRP(2Rnd_60mm_Mo_Flare_white_RF);
    DEFGRP(2Rnd_60mm_Mo_Smoke_white_RF);
    DEFGRP(4Rnd_60mm_Mo_LG_RF);
    DEFGRP(4Rnd_60mm_Mo_guided_RF);
    DEFGRP(4Rnd_60mm_Mo_Flare_white_RF);
    DEFGRP(4Rnd_60mm_Mo_Smoke_white_RF);
    DEFGRP(4Rnd_60mm_Mo_shells_RF);
    DEFGRP(8Rnd_60mm_Mo_shells_RF);
    DEFGRP(8Rnd_60mm_Mo_LG_RF);
    DEFGRP(8Rnd_60mm_Mo_guided_RF);
};
