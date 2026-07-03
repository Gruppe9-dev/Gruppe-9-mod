params [
    ["_title", "Gruppe 9 Module", [""]],
    ["_message", "", [""]],
    ["_success", false, [false]]
];

private _prefix = ["ERROR", "OK"] select _success;
private _chatText = format ["[GRP9] %1 - %2", _prefix, _title];
private _hintText = if (_message isEqualTo "") then {
    _chatText
} else {
    format ["%1\n%2", _chatText, _message]
};

systemChat _chatText;
hint _hintText;

diag_log format ["[grp9_mod] Client module feedback shown. success=%1 title=%2 message=%3", _success, _title, _message];
