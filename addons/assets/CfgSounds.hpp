class CfgSounds {
	sounds[] = {};

	// From https://pixabay.com/sound-effects/cash-register-purchase-87313/
	class GVAR(Sell) {
		name = "Weapons Dealer Sell Sound";
		sound[] = {QPATHTOF(sound\cash-register-purchase-87313.ogg), 1, 1, 5};
		titles[] = {};
	};

    // From https://pixabay.com/sound-effects/radio-wave-101552/
	class GVAR(RadioWave) {
		name = "Despawn Suppression Beacon Ping";
		sound[] = {QPATHTOF(sound\radio-wave.ogg), 1, 1, 50};
		titles[] = {};
	};
};
