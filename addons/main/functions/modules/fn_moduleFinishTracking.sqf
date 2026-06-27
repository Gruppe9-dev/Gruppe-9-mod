params [
    ["_logic", objNull, [objNull]],
    ["_units", [], [[]]],
    ["_activated", true, [true]]
];

if (!isServer) exitWith {};

if (!_activated) exitWith {
    diag_log "[grp9_mod] Finish tracking module ignored because it was not activated.";
    if (!isNull _logic) then {
        deleteVehicle _logic;
    };
};

private _logicNetId = if (isNull _logic) then {""} else {netId _logic};
private _requesterOwner = if (isNull _logic) then {0} else {owner _logic};
diag_log format [
    "[grp9_mod] Finish tracking module activated. isServer=%1 logic_net_id=%2 requester_owner=%3",
    isServer,
    _logicNetId,
    _requesterOwner
];

[_logicNetId, _requesterOwner] call grp9_mod_fnc_serverFinishTracking;

if (!isNull _logic) then {
    deleteVehicle _logic;
};
