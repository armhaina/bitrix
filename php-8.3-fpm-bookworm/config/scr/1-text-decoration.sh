#!/bin/bash
# Цветные статус-строки на всю ширину терминала.
# Чтобы в docker logs сразу было видно этап, предупреждение и ошибку.

log() {
  local type=$1; shift
  local cols=${COLUMNS:-$(tput cols 2>/dev/null || echo 80)}
  local -A color=([error]='97;41' [warning]='30;43' [info]='97;44' [success]='97;42')
  local -A tag=([error]='ОШИБКА' [warning]='ВНИМАНИЕ' [info]='…' [success]='ГОТОВО')
  printf "\033[%sm%-*s\033[0m\n" "${color[$type]:-30;47}" "$cols" " [${tag[$type]:-}] $*"
}
