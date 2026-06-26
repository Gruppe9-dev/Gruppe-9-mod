# Gruppe 9 Mod

HEMTT-built Arma 3 mod for Gruppe 9 server utilities.

## Features

- Eden/Zeus module to start stats tracking.
- Eden/Zeus module to finish stats tracking.
- Main menu controls with a direct connect button for the Gruppe 9 server.

The tracking modules call functions from `@grp9_stats`, so load the stats mod when you want tracking integration.

## Server Connect Configuration

Edit `addons/main/config.cpp` before building:

```cpp
class CfgGrp9Mod
{
    serverAddress = "127.0.0.1";
    serverPort = 2302;
    serverPassword = "";
};
```

Set `serverAddress` to the public IP or DNS name of the server.

## Build

```powershell
hemtt check
hemtt build
```

Output:

```text
.hemttout/build/addons/grp9_mod_main.pbo
```

## Launch Shape

```text
-mod=@grp9_mod;@grp9_stats
-serverMod=@grp9_stats_server
```
