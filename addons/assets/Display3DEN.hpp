class ctrlMenu;
class Display3DEN {
	class ContextMenu: ctrlMenu {
		class Items {
			items[] += { "A3USPCM_AddonMenu" };

			class A3USPCM_AddonMenu {
				text = "A3USPCM Addon";
				value = 0;
				items[] = {
					"A3USPCM_ExecModuleSQF"
				};
			};

			class A3USPCM_ExecModuleSQF {
				text = "Exec module.sqf";
				action = "_this execVM '3den.sqf'";
				condition = "true";
			};
		};
	};
};
