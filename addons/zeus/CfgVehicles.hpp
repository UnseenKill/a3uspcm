class CfgFactionClasses {
	class GVAR(modules) {
		displayName = CSTRING(ModuleCategory);
        priority = 2;
		side = 7;
	};
};

class CfgVehicles {
	class Module_F;

	class GVAR(moduleBase) : Module_F {
		author = "goreSplatter";
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
	};

    class GVAR(moduleFindStaticEmplacements) : GVAR(moduleBase) {
        displayName = CSTRING(ModuleFSE_DisplayName);
        function = QFUNC(findStaticEmplacements);
        category = QGVAR(modules);
        isDisposable = 1;
        curatorCanAttach = 0;
    };

    class GVAR(moduleMountStaticEmplacements) : GVAR(moduleBase) {
        displayName = CSTRING(ModuleMSE_DisplayName);
        function = QFUNC(mountStaticEmplacements);
        category = QGVAR(modules);
        isDisposable = 1;
        curatorCanAttach = 0;
    };
};
