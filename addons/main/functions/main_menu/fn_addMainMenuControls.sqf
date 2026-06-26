disableSerialization;
params ["_display"];

if (isNull _display) exitWith {};
if (!isNull (_display displayCtrl 990100)) exitWith {};

private _panelX = safeZoneX + safeZoneW - 0.43;
private _panelY = safeZoneY + safeZoneH - 0.28;
private _panelW = 0.36;

private _title = _display ctrlCreate ["RscStructuredText", 990100];
_title ctrlSetPosition [_panelX, _panelY, _panelW, 0.05];
_title ctrlSetBackgroundColor [0, 0, 0, 0.35];
_title ctrlSetStructuredText parseText "<t align='center' size='1.15' font='PuristaBold'>GRUPPE 9</t>";
_title ctrlCommit 0;

private _subtitle = _display ctrlCreate ["RscStructuredText", 990101];
_subtitle ctrlSetPosition [_panelX, _panelY + 0.052, _panelW, 0.045];
_subtitle ctrlSetBackgroundColor [0, 0, 0, 0.25];
_subtitle ctrlSetStructuredText parseText "<t align='center' size='0.82'>Arma 3 Community Server</t>";
_subtitle ctrlCommit 0;

private _join = _display ctrlCreate ["RscButton", 990102];
_join ctrlSetText "JOIN GRUPPE 9 SERVER";
_join ctrlSetPosition [_panelX, _panelY + 0.105, _panelW, 0.055];
_join ctrlSetTooltip "Connect to the configured Gruppe 9 Arma 3 server";
_join buttonSetAction "[] call grp9_mod_fnc_connectServer";
_join ctrlCommit 0;
