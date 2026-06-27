class CfgPatches {
    class grp9_mod_main {
        name = "Gruppe 9 Mod";
        author = "Gruppe 9";
        requiredVersion = 2.18;
        requiredAddons[] = {"A3_Modules_F", "A3_Data_F_Enoch_Loadorder"};
        units[] = {
            "grp9_mod_moduleStartTracking",
            "grp9_mod_moduleFinishTracking"
        };
        weapons[] = {};
    };
};

class RscStandardDisplay;
class RscText;
class RscPicture;
class RscButton;
class RscPictureKeepAspect;
class RscActivePictureKeepAspect;
class RscControlsGroupNoHScrollbars;

class CfgGrp9Mod {
    serverAddress = "78.46.158.233";
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
            class connectServer {};
        };
        class modules {
            file = "z\grp9_mod\addons\main\functions\modules";
            class moduleStartTracking {};
            class moduleFinishTracking {};
        };
    };
};

class RscDisplayMain: RscStandardDisplay {
    text = "";
    enableDisplay = 0;
    delete Spotlight;
    onLoad = "['onLoad', _this, 'RscDisplayMain', 'init'] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";

    class ControlsBackground {
        class Picture: RscPicture {
            text = "";
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";
        };
        class LoadingPic: RscPicture {
            text = "";
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";
        };
        class grp9_mod_background: RscPicture {
            idc = 990000;
            text = "z\grp9_mod\addons\main\data\main_menu_background.jpg";
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";
        };
        class grp9_mod_vignette: RscText {
            idc = 990001;
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";
            colorBackground[] = {0, 0, 0, 0.18};
        };
    };

    class controls {
        class BackgroundBar: RscText {
            show = 0;
            colorBackground[] = {0, 0, 0, 0};
        };
        class BackgroundCenter: BackgroundBar {
            show = 0;
        };
        class BackgroundBarLeft: RscPicture {
            show = 0;
            text = "";
        };
        class BackgroundBarRight: BackgroundBarLeft {
            show = 0;
        };
        class Footer: RscText {
            show = 0;
            text = "";
            colorBackground[] = {0, 0, 0, 0};
        };
        class Logo: RscPictureKeepAspect {
            show = 1;
            text = "z\grp9_mod\addons\main\data\grp9_logo_ca.paa";
            tooltip = "";
            onButtonClick = "";
            x = "safeZoneX + (safeZoneW / 2) - 0.11";
            y = "safeZoneY - 0.035";
            w = 0.22;
            h = 0.33;
        };
        class LogoApex: Logo {
            show = 1;
            text = "z\grp9_mod\addons\main\data\grp9_logo_ca.paa";
        };
        delete Spotlight1;
        delete Spotlight2;
        delete Spotlight3;
        delete BackgroundSpotlightRight;
        delete BackgroundSpotlightLeft;
        delete BackgroundSpotlight;
        delete InfoMods;
        delete InfoDLCsOwned;
        delete InfoDLCs;
        delete InfoNews;
        delete InfoBranch;
        delete InfoVersion;
        delete AllMissions;
        delete ProofsOfConcept;
        class SpotlightPrev: RscActivePictureKeepAspect {
            show = 0;
            text = "";
            onload = "";
        };
        class SpotlightNext: SpotlightPrev {
            show = 0;
            onload = "";
        };
        class infomods: RscControlsGroupNoHScrollbars {
            show = 0;
            onload = "";
        };
        class infoDLCsOwned: infomods {
            show = 0;
            onload = "";
        };
        class infoDLCs: infoDLCsOwned {
            show = 0;
            onload = "";
        };
        class infoNews: infomods {
            show = 0;
            onload = "";
        };
        class infoVersion: infoNews {
            show = 0;
            onload = "";
        };
        delete ACE_news_apex;
        delete CAALogo;

        class grp9_mod_joinServer: RscButton {
            idc = 990012;
            text = "JOIN GRUPPE 9 SERVER";
            x = "safeZoneX + (safeZoneW / 2) - 0.24";
            y = "safeZoneY + (safeZoneH / 2) - 0.035";
            w = 0.48;
            h = 0.07;
            tooltip = "Connect to the configured Gruppe 9 Arma 3 server";
            action = "private _cfg = configFile >> 'CfgGrp9Mod'; connectToServer [getText (_cfg >> 'serverAddress'), getNumber (_cfg >> 'serverPort'), getText (_cfg >> 'serverPassword')];";
            font = "PuristaBold";
            style = 2;
            sizeEx = 0.034;
            colorText[] = {1, 1, 1, 1};
            colorDisabled[] = {1, 1, 1, 0.25};
            colorBackground[] = {0.07, 0.07, 0.06, 0.88};
            colorBackgroundActive[] = {0.36, 0.31, 0.18, 0.95};
            colorBackgroundDisabled[] = {0, 0, 0, 0.55};
            colorFocused[] = {0.36, 0.31, 0.18, 0.95};
            colorShadow[] = {0, 0, 0, 0.4};
            colorBorder[] = {0.92, 0.82, 0.58, 1};
            borderSize = 0.002;
            offsetX = 0;
            offsetY = 0;
            offsetPressedX = 0;
            offsetPressedY = 0;
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
        isTriggerActivated = 0;
        isDisposable = 1;
        curatorCanAttach = 0;
        icon = "z\grp9_mod\addons\main\data\module_start_tracking_ca.paa";
        portrait = "z\grp9_mod\addons\main\data\module_start_tracking_ca.paa";

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
        isTriggerActivated = 0;
        isDisposable = 1;
        curatorCanAttach = 0;
        icon = "z\grp9_mod\addons\main\data\module_finish_tracking_ca.paa";
        portrait = "z\grp9_mod\addons\main\data\module_finish_tracking_ca.paa";

        class ModuleDescription: ModuleDescription {
            description = "Finishes Gruppe 9 stats tracking by calling grp9_stats_fnc_finishOperation on the server.";
        };
    };
};
