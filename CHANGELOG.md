# Changelog

## 0.2.0 (2026-09-29)

### Changed

- The module is now lua-path's (0.2.0), from DMC-Lua-Library's `lib.dmc_lua.lua_path`: `require 'dmc_corona.dmc_path'` returns a copy of it, so the shared module is left as it is.
- `parse( s, '.' )` no longer marks every `require` string absolute (the separator was used as a pattern, so `.` matched any first character).
- `getPath()` puts the file inside the folders from `parse()`, instead of ignoring them.
- `buildPath()` keeps `\` for a path parsed with `\`, instead of always joining with `/`.
- `split()` treats the separator as plain text, so `%` or `]` works.
- Rebuilt with dmc-corona-boot 1.6.0 and the current DMC-Lua-Library.

### Added

- `VERSION` in the table the module returns.
- `dmc_corona.cfg`, so the boot loader finds `dmc_corona/lib/`.
- Unit tests: `tests/run_unit.sh`, plain Lua 5.1.

### Removed

- The configuration block copied from dmc-patch, with its copy of `extend()`, which set the global `_extend`.

## 0.1.0

- First release, in DMC-Corona-Library (2015); in its own repository since 2026-09-26.
