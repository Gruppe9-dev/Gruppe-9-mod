private _cfg = configFile >> "CfgGrp9Mod";
private _address = getText (_cfg >> "serverAddress");
private _port = getNumber (_cfg >> "serverPort");
private _password = getText (_cfg >> "serverPassword");

if (_address isEqualTo "") exitWith {
    systemChat "Gruppe 9 server address is not configured.";
};

if (_port <= 0) exitWith {
    systemChat "Gruppe 9 server port is not configured.";
};

diag_log format ["[grp9_mod] Connecting to Gruppe 9 server %1:%2.", _address, _port];
connectToServer [_address, _port, _password];
