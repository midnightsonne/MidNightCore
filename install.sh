#!/usr/bin/env bash

source "plugins/common_variables.sh" 2>/dev/null
source "plugins/func_progress_bar.sh" 2>/dev/null

case "${1}" in
  -[iI] | -[iI][nN][sS][tT][aA][lL][lL])
    if [ -d "/opt/MidNightCore/" ]; then
      progress_bar 33 100 " - REMOVING OLD FILES    " -c -t .1
      sudo rm -r "/opt/MidNightCore/"
    fi

    progress_bar 66 100 " - COPYING NEW FILES     " -c -t .1
    sudo cp -r "${PWD}" "/opt/MidNightCore/"

    progress_bar 99 100 " - GIVING PERMISSIONS    " -c -t .1
    sudo chown -R "${USERNAME}" "/opt/MidNightCore/"

    if [ -d "/opt/MidNightCore/" ]; then
      cd "/opt/MidNightCore/" && rm -r ".git/" ".gitignore" "install.sh"

      clear && echo -e "\n MidNightCore WAS INSTALLED \n"
    else
      clear && echo -e "\n MidNightCore COULDN'T BE INSTALLED \n"
    fi
    ;;
  -[uU] | -[uU][nN][iI][nN][sS][tT][aA][lL][lL])
    if [ -d "/opt/MidNightCore/" ]; then
      progress_bar 50 100 " - UNINSTALLING MidNightCore " -c -t .1
      sudo rm -r "/opt/MidNightCore/"

      clear && echo -e "\n MidNightCore WAS UNINSTALLED \n"
    else
      clear && echo -e "\n MidNightCore IS NOT INSTALLED \n"
    fi
    ;;
  *)
    clear && echo -e "\n \"${1}\" IS NOT RECOGNIZED AS AN INTERNAL COMMAND \n\n TRY \"sudo bash install.sh -i (OR -u)\" \n"
    ;;
esac 2>/dev/null && exit
