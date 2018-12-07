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
alias mypy="mypy --config-file $HOME/.mypy"

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
function preview-markdown {
  local file_name=${1}
  local stem=$(basename -s .md ${file_name})
  pandoc -s -f markdown_github -t html -o ${stem}.html ${file_name}
}
function set-window-title {
  echo -ne "\e]0;${1}\a"
}
function write-hardware-info {
  local FILE="${HOME}/tmp/hardware_info.html"
  sudo lshw -html > ${FILE}
  echo "Hardware information has been written to the file "'"'"${FILE}"'"'"."
}
function notify-me {
  local message="${1:-Hello!}"
  spd-say "$message"
  zenity --info --text "$message" 2>/dev/null
}
