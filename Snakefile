# dmc-path

try:
	if not gSTARTED: print( gSTARTED )
except:
	MODULE = "dmc-path"
	include: "../DMC-Corona-Library/snakemake/Snakefile"

module_config = {
	"name": "dmc-path",
	"module": {
		"dir": "dmc_corona",
		"files": [
			"dmc_path.lua"
		],
		"requires": [
			"dmc-corona-boot",
			"DMC-Lua-Library"
		]
	},
	"tests": {
		"files": [],
		"requires": []
	}
}

register( "dmc-path", module_config )

