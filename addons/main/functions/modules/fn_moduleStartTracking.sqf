params [
    ["_logic", objNull, [objNull]],
    ["_units", [], [[]]],
    ["_activated", true, [true]]
];

if (!isServer) exitWith {
    if (!isNull _logic) then {
        deleteVehicle _logic;
    };
};

if (!_activated) exitWith {
    diag_log "[grp9_mod] Start tracking module ignored because it was not activated.";
    if (!isNull _logic) then {
        deleteVehicle _logic;
    };
};

if (isNil "grp9_stats_fnc_startOperation") exitWith {
    diag_log "[grp9_mod] Start tracking module failed: grp9_stats_fnc_startOperation is not available. Load @grp9_stats.";
    if (!isNull _logic) then {
        deleteVehicle _logic;
    };
};

diag_log "[grp9_mod] Start tracking module activated.";
private _result = [] call grp9_stats_fnc_startOperation;
diag_log format ["[grp9_mod] Start tracking module result: %1", _result];

if (!isNull _logic) then {
    deleteVehicle _logic;
};

_result
