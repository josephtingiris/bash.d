# etc/profile.d/zzz-bash.d.sh

# see https://github.com/josephtingiris/bash.d/blob/main/README.md

[ ${0} == ${BASH_SOURCE} ] && printf "\n${BASH_SOURCE} | ERROR | this code is not meant to be executed (instead, 'source ${BASH_SOURCE}')\n\n" && exit 1

[ -r ~/.bash.d.env ] && source ~/.bash.d.env # configure (predictable?)
[ "${BASH_D_SOURCE_ORDER}" == "reset" ] && unset BASH_D_SOURCE

# first, valid BASH_D_SOURCE always wins; always export to let the last win
[ ! -f "${BASH_D_SOURCE}" ] && unset BASH_D_SOURCE
[ -z "${BASH_D_SOURCE}" ] && export BASH_D_SOURCE=${BASH_SOURCE}

#echo "BASH_D_SOURCE = ${BASH_D_SOURCE}, BASH_SOURCE = ${BASH_SOURCE}"

[ "${BASH_D_SOURCE}" != "${BASH_SOURCE}" ] && return # prevent dupes & loops

BASH_D_DIRS=("/etc/bash.d")
[ ${#HOME} -gt 0 ] && [ "${HOME}" != "/" ] && [ -d "${HOME}/etc/bash.d" ] && BASH_D_DIRS+=("${HOME}/etc/bash.d")

for BASH_D_DIR in "${BASH_D_DIRS[@]}"; do
  SHELL=/bin/bash
  for BASH_D_DIR_SH in "${BASH_D_DIR}"/*.sh ; do
    [ "${BASH_D_DIR_SH}" == "${BASH_SOURCE}" ] && continue
    [ "${BASH_D_DIR_SH}" == "${BASH_D_SOURCE}" ] && continue
    if [ -r "${BASH_D_DIR_SH}" ]; then
      #echo "source ${BASH_D_DIR_SH}"
      source "${BASH_D_DIR_SH}"
    fi
  done
  unset -v BASH_D_DIR_SH
done
