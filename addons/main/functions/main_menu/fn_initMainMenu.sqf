if (!hasInterface) exitWith {};

[] spawn {
    disableSerialization;

    waitUntil {
        uiSleep 0.25;
        !isNull findDisplay 0
    };

    private _display = findDisplay 0;
    [_display] call grp9_mod_fnc_addMainMenuControls;
};
