class CfgWeapons {
	class GrenadeLauncher;

	class Throw : GrenadeLauncher {
		muzzles[] += { QGVAR(EMPGrenadeMuzzle) };

		class ThrowMuzzle;

		class GVAR(EMPGrenadeMuzzle) : ThrowMuzzle {
			displayName = "Lights out, motherfucker.";
			magazines[] = { QGVAR(Grenade_EMP) };
		};
	};
};
