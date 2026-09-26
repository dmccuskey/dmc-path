# dmc-path

Parse and build file paths and `require` strings in Corona SDK (Solar2D) projects.

```lua
local Path = require 'dmc_corona.dmc_path'

local info = Path.parse( 'lib/dmc_ui/theme.lua' )
-- info.path = { 'lib', 'dmc_ui' }, info.name = 'theme', info.ext = 'lua'

print( Path.buildRequire( info ) ) -- lib.dmc_ui.theme
print( Path.buildPath( info ) )    -- lib/dmc_ui/theme.lua
```

Part of [DMC-Corona-Library](https://github.com/dmccuskey/DMC-Corona-Library).

## License

MIT, see [LICENSE](LICENSE).
