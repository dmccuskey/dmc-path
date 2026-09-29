--====================================================================--
-- tests/dmc_path_spec.lua
--
-- Unit tests for dmc-path, using Luna Test.
-- Run with tests/run_unit.sh
--
-- lua-path has the full specs; these check the wrapper, and that
-- lua-path's fixes come through it
--====================================================================--


module(..., package.seeall)



--====================================================================--
--== Setup


local Path, LuaPath

function suite_setup()
	Path = require 'dmc_corona.dmc_path'
	LuaPath = require 'lib.dmc_lua.lua_path'
end



--====================================================================--
--== Tests


function test_module()
	assert_equal( 'table', type( Path ) )
	assert_equal( 'string', type( Path.VERSION ) )
	assert_equal( 'function', type( Path.parse ) )
	assert_equal( 'function', type( Path.buildRequire ) )
	assert_equal( 'function', type( Path.buildPath ) )
end

function test_shared_module_untouched()
	assert_not_equal( LuaPath, Path )
	assert_nil( LuaPath.VERSION )
end

function test_no_global_extend()
	assert_nil( rawget( _G, '_extend' ) )
end

function test_quick_start()
	local info = Path.parse( 'lib/dmc_ui/theme.lua' )
	assert_equal( 'lib', info.path[1] )
	assert_equal( 'dmc_ui', info.path[2] )
	assert_equal( 'theme', info.name )
	assert_equal( 'lua', info.ext )
	assert_equal( 'lib.dmc_ui.theme', Path.buildRequire( info ) )
	assert_equal( 'lib/dmc_ui/theme.lua', Path.buildPath( info ) )
end

-- a '.' separator used to make every string absolute
function test_parse_require_string()
	local info = Path.parse( 'lib.dmc_ui.theme', '.' )
	assert_false( info.isAbs )
	assert_equal( 'lib.dmc_ui.theme', Path.buildRequire( info ) )
end

-- getPath() used to ignore the parsed folders
function test_get_path()
	assert_equal( '/a/b/c/d.lua', Path.parse( '/a/b/' ):getPath( 'c/d.lua' ) )
end

-- buildPath() used to always join with '/'
function test_build_path_separator()
	local info = Path.parse( 'lib\\ui\\a.png' )
	assert_equal( 'lib\\ui\\a.png', Path.buildPath( info ) )
end
