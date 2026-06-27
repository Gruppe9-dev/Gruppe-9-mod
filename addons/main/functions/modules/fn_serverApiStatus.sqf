params [
    ["_logicNetId", "", [""]],
    ["_requesterOwner", 0, [0]]
];

if (!isServer) exitWith {};

private _notify = {
    params ["_title", "_message", "_success"];

    if (_requesterOwner > 2) then {
        [_title, _message, _success] remoteExecCall ["grp9_mod_fnc_clientTrackingFeedback", _requesterOwner];
    } else {
        if (hasInterface) then {
            [_title, _message, _success] call grp9_mod_fnc_clientTrackingFeedback;
        };
    };
};

diag_log format [
    "[grp9_mod] Server API status requested. logic_net_id=%1 requester_owner=%2",
    _logicNetId,
    _requesterOwner
];

if (isNil "grp9_stats_server_fnc_callExtension") exitWith {
    private _message = "grp9_stats_server_fnc_callExtension is not available. Load @grp9_stats_server as serverMod.";
    diag_log format ["[grp9_mod] Server API status failed: %1", _message];
    ["API Status", _message, false] call _notify;
};

private _result = ["api_status", []] call grp9_stats_server_fnc_callExtension;
diag_log format ["[grp9_mod] Server API status result: %1", _result];

private _success = false;
private _message = "API status check failed.";

if (_result isEqualType "") then {
    private _parsed = fromJSON _result;
    if (_parsed isEqualType createHashMap) then {
        _success = _parsed getOrDefault ["ok", false];
        private _status = _parsed getOrDefault ["status", 0];
        if (_success) then {
            _message = format ["API reachable. HTTP status=%1", _status];
        } else {
            private _error = _parsed getOrDefault ["error", "unknown_error"];
            private _detail = _parsed getOrDefault ["message", _parsed getOrDefault ["body", _result]];
            _message = format ["API check failed. %1: %2", _error, _detail];
        };
    } else {
        _message = format ["API status returned non-object JSON: %1", _result select [0, 240]];
    };
} else {
    _message = format ["API status returned unexpected result: %1", _result];
};

["API Status", _message, _success] call _notify;

_result
