params [
    ["_title", "Stats Tracking", [""]],
    ["_message", "", [""]],
    ["_success", false, [false]]
];

private _prefix = ["ERROR", "OK"] select _success;
private _text = format ["[GRP9 Stats] %1 - %2: %3", _prefix, _title, _message];

systemChat _text;
hint _text;

diag_log format ["[grp9_mod] Client tracking feedback shown. success=%1 title=%2 message=%3", _success, _title, _message];
