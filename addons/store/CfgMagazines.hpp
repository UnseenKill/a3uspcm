#define DEFMAG(magazineClass,magazinePrice) \
    class magazineClass: CA_Magazine { \
        GVAR(fallbackSellPrice) = magazinePrice; \
    }

class CfgMagazines {
    class CA_Magazine;

    DEFMAG(20Rnd_650x39_Cased_Mag_F,50);
    DEFMAG(20Rnd_762x51_Mag,50);
    DEFMAG(30Rnd_545x39_Mag_F,50);
    DEFMAG(30Rnd_556x45_Stanag,50);
    DEFMAG(30Rnd_580x42_Mag_F,75);
    DEFMAG(30Rnd_65x39_caseless_mag,50);
    DEFMAG(30Rnd_762x39_Mag_F,50);
    DEFMAG(30Rnd_9x21_Mag,40);
    DEFMAG(50Rnd_570x28_SMG_03,60);
    DEFMAG(HandGrenade,80);
};
