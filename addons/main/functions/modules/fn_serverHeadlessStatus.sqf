params [
    ["_logicNetId", "", [""]],
    ["_requesterOwner", 0, [0]]
];

if (!isServer) exitWith {};

private _notify = {
    params ["_title", "_message", "_success"];

    if (_requesterOwner > 2) then {
        [_title, _message, _success] remoteExecCall ["grp9_mod_fnc_clientModuleFeedback", _requesterOwner];
    } else {
        if (hasInterface) then {
            [_title, _message, _success] call grp9_mod_fnc_clientModuleFeedback;
        };
    };
};

diag_log format [
    "[grp9_mod] Headless client status requested. logic_net_id=%1 requester_owner=%2",
    _logicNetId,
    _requesterOwner
];

private _headlessClients = (entities "HeadlessClient_F") select {!isNull _x};
{
    if !(_x in _headlessClients) then {
        _headlessClients pushBack _x;
    };
} forEach (allPlayers select {typeOf _x isEqualTo "HeadlessClient_F"});

private _ownerLabels = createHashMap;
{
    private _ownerId = owner _x;
    private _name = name _x;
    if (_name isEqualTo "") then {
        _name = vehicleVarName _x;
    };
    if (_name isEqualTo "") then {
        _name = format ["Headless Client %1", _forEachIndex + 1];
    };

    _ownerLabels set [str _ownerId, format ["%1 (owner %2)", _name, _ownerId]];
} forEach _headlessClients;

private _buckets = createHashMap;
private _ensureBucket = {
    params ["_ownerId"];

    private _key = str _ownerId;
    private _bucket = _buckets getOrDefault [_key, []];

    if (_bucket isEqualTo []) then {
        private _label = switch (true) do {
            case (_ownerId isEqualTo 2): {
                "Server (owner 2)"
            };
            case ((_ownerLabels getOrDefault [_key, ""]) isNotEqualTo ""): {
                _ownerLabels get _key
            };
            default {
                format ["Unknown owner %1", _ownerId]
            };
        };

        _bucket = [_ownerId, _label, 0, 0];
        _buckets set [_key, _bucket];
    };

    _bucket
};

[2] call _ensureBucket;
{
    [owner _x] call _ensureBucket;
} forEach _headlessClients;

private _aiGroupCount = 0;
private _aiUnitCount = 0;

{
    private _group = _x;
    private _groupUnits = units _group;
    private _aiUnits = _groupUnits select {alive _x && {!isPlayer _x}};
    private _hasPlayer = (_groupUnits findIf {isPlayer _x}) > -1;

    if (!_hasPlayer && {_aiUnits isNotEqualTo []}) then {
        private _ownerId = groupOwner _group;
        private _bucket = [_ownerId] call _ensureBucket;
        private _groupCount = (_bucket select 2) + 1;
        private _unitCount = (_bucket select 3) + count _aiUnits;

        _bucket set [2, _groupCount];
        _bucket set [3, _unitCount];
        _buckets set [str _ownerId, _bucket];

        _aiGroupCount = _aiGroupCount + 1;
        _aiUnitCount = _aiUnitCount + count _aiUnits;
    };
} forEach allGroups;

private _rows = [];
{
    _rows pushBack _y;
} forEach _buckets;

_rows sort true;

private _logLines = [
    format ["Headless clients connected: %1", count _headlessClients],
    format ["AI groups counted: %1 | AI units counted: %2", _aiGroupCount, _aiUnitCount]
];
private _hintLines = [
    format ["HCs: %1", count _headlessClients],
    format ["Total: %1g / %2u", _aiGroupCount, _aiUnitCount]
];

{
    _x params ["_ownerId", "_label", "_groupCount", "_unitCount"];

    private _hintLabel = switch (true) do {
        case (_ownerId isEqualTo 2): {
            "Server"
        };
        case ((_ownerLabels getOrDefault [str _ownerId, ""]) isNotEqualTo ""): {
            private _headlessLabel = _ownerLabels get str _ownerId;
            private _ownerSuffix = format [" (owner %1)", _ownerId];
            private _suffixIndex = _headlessLabel find _ownerSuffix;
            if (_suffixIndex > -1) then {
                _headlessLabel select [0, _suffixIndex]
            } else {
                _headlessLabel
            }
        };
        default {
            format ["owner %1", _ownerId]
        };
    };

    _logLines pushBack format ["%1: %2 groups / %3 AI units", _label, _groupCount, _unitCount];
    _hintLines pushBack format ["%1: %2g / %3u", _hintLabel, _groupCount, _unitCount];
} forEach _rows;

private _logMessage = _logLines joinString (toString [10]);
private _hintMessage = _hintLines joinString (toString [10]);
diag_log format ["[grp9_mod] Headless client status result: %1", _logMessage];

["Headless Client Status", _hintMessage, true] call _notify;

_logMessage
