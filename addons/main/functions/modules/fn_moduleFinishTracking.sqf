params ["_logic", "_units", "_activated"];

if (!isServer) exitWith {};
if (!_activated) exitWith {};

if (isNil "grp9_stats_fnc_finishOperation") exitWith {
    diag_log "[grp9_mod] Finish tracking module failed: grp9_stats_fnc_finishOperation is not available. Load @grp9_stats.";
};

diag_log "[grp9_mod] Finish tracking module activated.";
[] call grp9_stats_fnc_finishOperation;
