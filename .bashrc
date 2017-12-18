###############################################################################
# Environment constants #######################################################
#-----------------------------------------------------------------------------#
export EDITOR=/usr/bin/vim

###############################################################################
# Aliases #####################################################################
#-----------------------------------------------------------------------------#
alias chrome='(chromium-browser --incognito &); exit'
alias fire='(firefox --private &); exit'
alias make='make --warn-undefined-variables'

###############################################################################
# Shell options ###############################################################
#-----------------------------------------------------------------------------#
# History verification
shopt -s histverify
# Vi mode
set -o vi

###############################################################################
# Functions ###################################################################
#-----------------------------------------------------------------------------#
function gpg-dir {
  local no_trailing_slash=${1%/}
  gpg-zip -c -o "${no_trailing_slash}.zip.gpg" "${no_trailing_slash}"
}
function set-window-title {
  echo -ne "\e]0;${1}\a"
}
function write-hardware-info {
  local FILE="${HOME}/tmp/hardware_info.html"
  sudo lshw -html > ${FILE}
  echo "Hardware information has been written to the file "'"'"${FILE}"'"'"."
}
