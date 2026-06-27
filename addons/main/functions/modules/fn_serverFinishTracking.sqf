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
    "[grp9_mod] Server finish tracking requested. logic_net_id=%1 requester_owner=%2",
    _logicNetId,
    _requesterOwner
];

if (missionNamespace getVariable ["grp9_mod_finishRequestInProgress", false]) exitWith {
    private _message = "Finish request is already being processed.";
    diag_log format ["[grp9_mod] Server finish tracking skipped: %1", _message];
    ["Finish Tracking", _message, true] call _notify;
    true
};

if !(missionNamespace getVariable ["grp9_stats_operationActive", false]) exitWith {
    private _lastFinishAt = missionNamespace getVariable ["grp9_mod_lastFinishCompletedAt", -9999];

    if ((diag_tickTime - _lastFinishAt) < 5) exitWith {
        private _message = "Finish request was already handled.";
        diag_log format ["[grp9_mod] Server finish tracking skipped: %1", _message];
        ["Finish Tracking", _message, true] call _notify;
        true
    };

    private _message = "No recording is currently active.";
    diag_log format ["[grp9_mod] Server finish tracking skipped: %1", _message];
    ["Finish Tracking", _message, false] call _notify;
    false
};

if (isNil "grp9_stats_fnc_finishOperation") exitWith {
    private _message = "grp9_stats_fnc_finishOperation is not available. Load @grp9_stats.";
    diag_log format ["[grp9_mod] Server finish tracking failed: %1", _message];
    ["Finish Tracking", _message, false] call _notify;
};

missionNamespace setVariable ["grp9_mod_finishRequestInProgress", true];
private _result = [] call grp9_stats_fnc_finishOperation;
missionNamespace setVariable ["grp9_mod_finishRequestInProgress", false];
diag_log format ["[grp9_mod] Server finish tracking result: %1", _result];

private _success = false;
private _message = "Backend did not confirm finish.";

if (_result isEqualType "") then {
    private _parsed = fromJSON _result;
    if (_parsed isEqualType createHashMap) then {
        private _status = _parsed getOrDefault ["status", ""];
        private _operationId = _parsed getOrDefault ["operation_id", ""];
        _success = _status isEqualTo "finished";
        _message = if (_success) then {
            missionNamespace setVariable ["grp9_mod_lastFinishCompletedAt", diag_tickTime];
            format ["Recording finished. operation_id=%1", _operationId]
        } else {
            private _error = _parsed getOrDefault ["error", "unknown_error"];
            private _detail = _parsed getOrDefault ["message", _result];
            private _preview = _parsed getOrDefault ["body_preview", ""];
            private _length = _parsed getOrDefault ["body_length", -1];
            if (_preview isEqualTo "") then {
                format ["Finish failed. %1: %2", _error, _detail]
            } else {
                format ["Finish failed. %1: %2 length=%3 preview=%4", _error, _detail, _length, _preview]
            }
        };
    } else {
        _message = format ["Finish returned non-object JSON: %1", _result select [0, 240]];
    };
} else {
    _message = format ["Finish returned unexpected result: %1", _result];
};

["Finish Tracking", _message, _success] call _notify;

_result
