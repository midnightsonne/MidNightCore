#!/usr/bin/env bash

clear && SRC="/opt/MidNightCore/plugins" && PLUGINS=("${@}")

source "${SRC}/common_variables.sh"
source "${SRC}/common_functions.sh"
source "${SRC}/common_checks.sh"

[[ ${PLUGINS[*]} =~ "1" ]] && source "${SRC}/func_debug_print.sh"
[[ ${PLUGINS[*]} =~ "2" ]] && source "${SRC}/func_progress_bar.sh"
[[ ${PLUGINS[*]} =~ "3" ]] && source "${SRC}/func_screen_resize.sh"
[[ ${PLUGINS[*]} =~ "4" ]] && source "${SRC}/func_screen_resolution.sh"
[[ ${PLUGINS[*]} =~ "5" ]] && source "${SRC}/pack_networks.sh"
