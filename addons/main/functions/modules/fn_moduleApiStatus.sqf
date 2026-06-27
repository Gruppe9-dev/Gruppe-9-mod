params [
    ["_logic", objNull, [objNull]],
    ["_units", [], [[]]],
    ["_activated", true, [true]]
];

if (!_activated) exitWith {
    diag_log "[grp9_mod] API status module ignored because it was not activated.";
    if (!isNull _logic) then {
        deleteVehicle _logic;
    };
};

private _logicNetId = if (isNull _logic) then {""} else {netId _logic};
private _requesterOwner = if (hasInterface) then {clientOwner} else {0};
diag_log format [
    "[grp9_mod] API status module activated. isServer=%1 logic_net_id=%2 requester_owner=%3",
    isServer,
    _logicNetId,
    _requesterOwner
];

if (isServer) then {
    [_logicNetId, _requesterOwner] call grp9_mod_fnc_serverApiStatus;
} else {
    [_logicNetId, _requesterOwner] remoteExecCall ["grp9_mod_fnc_serverApiStatus", 2];
};

if (!isNull _logic) then {
    deleteVehicle _logic;
};
