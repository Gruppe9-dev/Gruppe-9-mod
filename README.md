# Gruppe 9 Mod

HEMTT-built Arma 3 mod for Gruppe 9 server utilities.

## Features

- Placeable Gruppe 9 banner using a vanilla Arma 3 placeholder texture.
- Gruppe 9 map marker using the mod logo.
- Eden/Zeus module to start stats tracking.
- Eden/Zeus module to finish stats tracking.
- Eden/Zeus module to show current headless-client AI distribution.
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

## Banner Texture

The placeable banners are defined as `grp9_mod_flag` and `grp9_mod_flag2` in
`addons/main/config.cpp`. They inherit from `Banner_01_F` and use the custom
`grp9_flag.paa` and `grp9_flag2.paa` textures.

## Map Marker

The map marker is defined as `grp9_mod_marker` in `addons/main/config.cpp`.
It uses `z\grp9_mod\addons\main\data\grp9_logo_ca.paa` as its icon and is grouped under the `Gruppe 9` marker class.

## Headless Client Status Module

The Zeus/Eden module is defined as `grp9_mod_moduleHeadlessStatus`.
It reports connected headless clients and counts AI-only groups by their current `groupOwner`.
The result is sent only to the client owner that placed the module.

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
