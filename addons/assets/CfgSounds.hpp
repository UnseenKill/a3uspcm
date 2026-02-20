class CfgSounds {
    sounds[] = {};

    // Sampled from https://pixabay.com/sound-effects/film-special-effects-04-alarms-amp-beeps-scanning-for-hostiles-b-343791/
    class GVAR(AafcContact) {
        name = "A/A FC contact alarm";
        sound[] = {QPATHTOF(sound\aafc-contact-343791.ogg), 1, 1, 50};
        titles[] = {};
    };

    // From https://pixabay.com/sound-effects/alarm-clock-90867/
    class GVAR(AlarmClock) {
        name = "Digital alarm clock";
        sound[] = {QPATHTOF(sound\alarm-clock-90867.ogg), 1, 1, 50};
        titles[] = {};
    };

    // From https://pixabay.com/sound-effects/radio-wave-101552/
    class GVAR(RadioWave) {
        name = "Despawn Suppression Beacon Ping";
        sound[] = {QPATHTOF(sound\radio-wave.ogg), 1, 1, 50};
        titles[] = {};
    };

    // From https://pixabay.com/sound-effects/cash-register-purchase-87313/
    class GVAR(Sell) {
        name = "Weapons Dealer Sell Sound";
        sound[] = {QPATHTOF(sound\cash-register-purchase-87313.ogg), 1, 1, 5};
        titles[] = {};
    };

    // From https://pixabay.com/sound-effects/squish-107555/
    class GVAR(Squash0) {
        name = "Snake Squashed Sound";
        sound[] = {QPATHTOF(sound\tomato-squishwet-103934.ogg), 1, 1, 5};
        titles[] = {};
    };

    // From https://pixabay.com/sound-effects/goopy-slime-30-229642/
    class GVAR(Squash1) {
        name = "Snake Squashed Sound";
        sound[] = {QPATHTOF(sound\goopy-slime-30-229642.ogg), 1, 1, 5};
        titles[] = {};
    };

    // Sampled from https://soundbuttonsw.com/meep-meep-sound-buttons/
    class EGVAR(vehicles,MeepMeep) {
        name = "Classic Road Runner Meep Meep";
        sound[] = {QPATHTOF(sound\roadrunner-meep-meep.ogg), 1, 1, 200};
        titles[] = {};
    };

    // Arma built-in
    class EGVAR(vehicles,TruckHorn) {
        name = "Arma Truck Horn";
        sound[] = {"A3\Sounds_F\weapons\horns\MRAP_02_horn_1.wss", 1, 1, 200};
        titles[] = {};
    };
};
