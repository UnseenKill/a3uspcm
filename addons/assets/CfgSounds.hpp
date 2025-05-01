class CfgSounds {
	sounds[] = {};

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
};

