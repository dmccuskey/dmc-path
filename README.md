# dmc-path

Take file paths and `require` strings apart and build them back, in a Solar2D (formerly Corona SDK) app.

dmc-path is [lua-path](https://github.com/dmccuskey/lua-path) packaged like the other DMC Solar2D libraries:

```lua
local Path = require 'dmc_corona.dmc_path'

local info = Path.parse( 'lib/dmc_ui/theme.lua' )
-- info.path = { 'lib', 'dmc_ui' }, info.name = 'theme', info.ext = 'lua'

print( Path.buildRequire( info ) ) -- lib.dmc_ui.theme
print( Path.buildPath( info ) )    -- lib/dmc_ui/theme.lua
```

## Features

- `parse()`: a path's folders, file name, name and extension, and whether it's absolute; a `require` string too, with separator `.`
- `buildPath()` and `buildRequire()`: a file path or a `require` string from those parts
- `getPath()`: a file's path inside a parsed folder
- `/` and `\` paths: the separator is guessed from the path and kept when it's built again
- Pure Lua, no plugins needed; MIT licensed

It works on strings only: it never looks at the file system. See [Known Issues](#known-issues).

## Quick Start

The following code will get you up and running in about 5 minutes in the Solar2D Simulator on macOS or Windows. It turns a file path into a `require` string and back, and places a file inside a folder.

Prerequisites: the [Solar2D](https://solar2d.com/) Simulator and a copy of this repository (`git clone https://github.com/dmccuskey/dmc-path.git`, or download the ZIP from GitHub).

### 1. Copy the Library into Your Project

Copy these from this repository into the root of your project folder:

```text
dmc_corona_boot.lua     loader for the DMC libraries
dmc_corona.cfg          configuration
dmc_corona/             dmc-path and the modules it needs
```

**Going further:** keep the libraries in a subfolder, or combine several DMC libraries ([dmc-corona-boot Configuration](https://github.com/dmccuskey/dmc-corona-boot/blob/master/docs/configuration.md)).

### 2. Take Paths Apart and Build Them

Create `main.lua` in the project folder:

```lua
local Path = require 'dmc_corona.dmc_path'

-- a file path: its parts, and the require string for it
local info = Path.parse( 'lib/dmc_ui/theme.lua' )
print( info.name, info.ext, #info.path )
print( Path.buildRequire( info ) )

-- a require string (separator '.') back to a file path
local mod = Path.parse( 'lib.dmc_ui.theme', '.' )
print( Path.buildPath( mod ) .. '.lua' )

-- a file inside a folder
local images = Path.parse( 'assets/images/' )
print( images:getPath( 'ship.png' ) )
```

Open the project in the Simulator. The screen stays black; the console shows:

```text
theme	lua	2
lib.dmc_ui.theme
lib/dmc_ui/theme.lua
assets/images/ship.png
```

If the console shows `module 'dmc_corona.dmc_path' not found` instead, `dmc_corona/` is missing from the root of the project folder.

`parse()` returns a table: `path` (the folders, a list), `filename`, `name`, `ext`, `isAbs`, `sep` (the separator it used), `original`, and `dir`, an empty list that `buildPath()` and `buildRequire()` put before `path`. A path from `getPath()` can go to `system.pathForFile()` like any other file name.

**Going further:** every function and field ([lua-path README](https://github.com/dmccuskey/lua-path#readme)).

To update, copy `dmc_corona_boot.lua` and `dmc_corona/` again from the newer version. Keep your own `dmc_corona.cfg` if you have changed it.

## Documentation

`require 'dmc_corona.dmc_path'` returns a copy of lua-path's module with `VERSION` added, so lua-path's [README](https://github.com/dmccuskey/lua-path#readme) applies as written. [CHANGELOG](CHANGELOG.md) lists the changes.

## Configuration

dmc-path has no settings: `dmc_corona.cfg` needs no section for it, only the `[DMC_CORONA]` section that tells the loader where the libraries are. See [dmc-corona-boot Configuration](https://github.com/dmccuskey/dmc-corona-boot/blob/master/docs/configuration.md).

## Known Issues

They are lua-path's, in its [Known Issues](https://github.com/dmccuskey/lua-path#known-issues): any dot in the last part makes it a file (`app/v1.2` is a file named `v1`), `buildRequire()` of an absolute path or one with `..` isn't a valid `require` string, and Windows drive letters aren't recognized as absolute.

## Development

Only `dmc_corona/dmc_path.lua` is written in this repository. It loads the DMC boot loader and returns a copy of lua-path's module from `lib.dmc_lua.lua_path`. Everything else in `dmc_corona/` and `dmc_corona_boot.lua` is a generated copy; fix it in its own repository, then rebuild:

| file | owner |
|---|---|
| every file in `dmc_corona/lib/dmc_lua/` | [DMC-Lua-Library](https://github.com/dmccuskey/DMC-Lua-Library), which copies them from the `lua-*` repositories ([lua-path](https://github.com/dmccuskey/lua-path), ...) |
| `dmc_corona_boot.lua` | [dmc-corona-boot](https://github.com/dmccuskey/dmc-corona-boot) |

The copies are made by Snakemake from sibling checkouts of the repositories above (`../DMC-Lua-Library`, `../dmc-corona-boot`, `../DMC-Corona-Library` for the shared rules). From this repository's root folder:

```sh
snakemake --cores 1 build_all
```

The unit tests check the wrapper and that lua-path's behavior comes through it; lua-path's own tests are in its `spec/`. They run under plain Lua 5.1 with dkjson, with stand-ins for the Solar2D globals the boot loader uses. From the repository's root folder:

```sh
tests/run_unit.sh
```

```text
-- Starting suite "dmc_path_spec", 7 test(s)
  .......
---- Testing finished, with 18 assertion(s) ----
  7 passed, 0 failed, 0 error(s), 0 skipped.
```

`LUA=/path/to/lua5.1 tests/run_unit.sh` picks the interpreter.

## License

dmc-path is released under the [MIT License](LICENSE).
