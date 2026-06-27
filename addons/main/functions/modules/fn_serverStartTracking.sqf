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
    "[grp9_mod] Server start tracking requested. logic_net_id=%1 requester_owner=%2",
    _logicNetId,
    _requesterOwner
];

if (missionNamespace getVariable ["grp9_mod_startRequestInProgress", false]) exitWith {
    private _message = "Start request is already being processed.";
    diag_log format ["[grp9_mod] Server start tracking skipped: %1", _message];
    ["Start Tracking", _message, true] call _notify;
    true
};

if (missionNamespace getVariable ["grp9_stats_operationActive", false]) exitWith {
    private _operationId = missionNamespace getVariable ["grp9_stats_operationId", ""];
    private _lastStartAt = missionNamespace getVariable ["grp9_mod_lastStartCompletedAt", -9999];
    private _message = if ((diag_tickTime - _lastStartAt) < 5) then {
        format ["Start request was already handled. operation_id=%1", _operationId]
    } else {
        format ["Recording already active. operation_id=%1", _operationId]
    };
    diag_log format ["[grp9_mod] Server start tracking skipped: %1", _message];
    ["Start Tracking", _message, true] call _notify;
    true
};

if (isNil "grp9_stats_fnc_startOperation") exitWith {
    private _message = "grp9_stats_fnc_startOperation is not available. Load @grp9_stats.";
    diag_log format ["[grp9_mod] Server start tracking failed: %1", _message];
    ["Start Tracking", _message, false] call _notify;
};

missionNamespace setVariable ["grp9_mod_startRequestInProgress", true];
private _result = [] call grp9_stats_fnc_startOperation;
missionNamespace setVariable ["grp9_mod_startRequestInProgress", false];
diag_log format ["[grp9_mod] Server start tracking result: %1", _result];

private _success = false;
private _message = "Backend did not return an operation id.";

if (_result isEqualType "") then {
    private _parsed = fromJSON _result;
    if (_parsed isEqualType createHashMap) then {
        private _operationId = _parsed getOrDefault ["operation_id", ""];
        private _status = _parsed getOrDefault ["status", ""];
        _success = _operationId isNotEqualTo "";
        _message = if (_success) then {
            missionNamespace setVariable ["grp9_mod_lastStartCompletedAt", diag_tickTime];
            format ["Recording started. operation_id=%1 status=%2", _operationId, _status]
        } else {
            private _error = _parsed getOrDefault ["error", "unknown_error"];
            private _detail = _parsed getOrDefault ["message", _result];
            private _preview = _parsed getOrDefault ["body_preview", ""];
            private _length = _parsed getOrDefault ["body_length", -1];
            if (_preview isEqualTo "") then {
                format ["Start failed. %1: %2", _error, _detail]
            } else {
                format ["Start failed. %1: %2 length=%3 preview=%4", _error, _detail, _length, _preview]
            }
        };
    } else {
        _message = format ["Start returned non-object JSON: %1", _result select [0, 240]];
    };
} else {
    if (_result isEqualType false && {missionNamespace getVariable ["grp9_stats_operationActive", false]}) then {
        private _operationId = missionNamespace getVariable ["grp9_stats_operationId", ""];
        _success = true;
        _message = format ["Recording already active. operation_id=%1", _operationId];
    } else {
        _message = format ["Start returned unexpected result: %1", _result];
    };
};

["Start Tracking", _message, _success] call _notify;

_result
