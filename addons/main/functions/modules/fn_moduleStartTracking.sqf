params ["_logic", "_units", "_activated"];

if (!isServer) exitWith {};
if (!_activated) exitWith {};

if (isNil "grp9_stats_fnc_startOperation") exitWith {
    diag_log "[grp9_mod] Start tracking module failed: grp9_stats_fnc_startOperation is not available. Load @grp9_stats.";
};

diag_log "[grp9_mod] Start tracking module activated.";
[] call grp9_stats_fnc_startOperation;
