class CfgPatches {
    class grp9_mod_main {
        name = "Gruppe 9 Mod";
        author = "Gruppe 9";
        requiredVersion = 2.18;
        requiredAddons[] = {"A3_Modules_F"};
        units[] = {
            "grp9_mod_moduleStartTracking",
            "grp9_mod_moduleFinishTracking"
        };
        weapons[] = {};
    };
};

class CfgGrp9Mod {
    serverAddress = "127.0.0.1";
    serverPort = 2302;
    serverPassword = "";
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class grp9_modules: NO_CATEGORY {
        displayName = "Gruppe 9";
        priority = 2;
        side = 7;
    };
};

class CfgFunctions {
    class grp9_mod {
        class main_menu {
            file = "z\grp9_mod\addons\main\functions\main_menu";
            class addMainMenuControls {};
            class connectServer {};
            class initMainMenu {
                postInit = 1;
            };
        };
        class modules {
            file = "z\grp9_mod\addons\main\functions\modules";
            class moduleStartTracking {};
            class moduleFinishTracking {};
        };
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ModuleDescription;
    };

    class grp9_mod_moduleStartTracking: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Start Stats Tracking";
        category = "grp9_modules";
        function = "grp9_mod_fnc_moduleStartTracking";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 1;
        curatorCanAttach = 0;
        icon = "\a3\Modules_F_Curator\Data\iconModule_ca.paa";

        class ModuleDescription: ModuleDescription {
            description = "Starts Gruppe 9 stats tracking by calling grp9_stats_fnc_startOperation on the server.";
        };
    };

    class grp9_mod_moduleFinishTracking: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Finish Stats Tracking";
        category = "grp9_modules";
        function = "grp9_mod_fnc_moduleFinishTracking";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 1;
        curatorCanAttach = 0;
        icon = "\a3\Modules_F_Curator\Data\iconModule_ca.paa";

        class ModuleDescription: ModuleDescription {
            description = "Finishes Gruppe 9 stats tracking by calling grp9_stats_fnc_finishOperation on the server.";
        };
    };
};
