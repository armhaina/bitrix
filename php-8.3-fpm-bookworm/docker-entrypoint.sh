#!/usr/bin/env bash
# Готовит окружение 1С-Битрикс и запускает Nginx + PHP-FPM.
set -e

source /tmp/scr/1-text-decoration.sh
log info "Готовлю контейнер 1С-Битрикс…"

source /tmp/scr/2-variables-declaring.sh
source /tmp/scr/3-composer-install.sh
source /tmp/scr/4-variables-change.sh
source /tmp/scr/5-nginx-conf-def-disable.sh
source /tmp/scr/6-bitrix-install.sh
source /tmp/scr/7-bitrix-cache.sh
source /tmp/scr/8-cron-configure.sh
source /tmp/scr/9-mailpit-configure.sh
source /tmp/scr/10-composer-install-packages.sh
source /tmp/scr/11-final-supervisor-run.sh
