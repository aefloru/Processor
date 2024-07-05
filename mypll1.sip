set_global_assignment -entity "mypll1" -library "lib_mypll1" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "mypll1" -library "lib_mypll1" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "mypll1" -library "lib_mypll1" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_mypll1" -name SPD_FILE [file join $::quartus(sip_path) "mypll1.spd"]

set_global_assignment -library "lib_mypll1" -name MISC_FILE [file join $::quartus(sip_path) "mypll1_sim/mypll1.vo"]
