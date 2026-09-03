#!/bin/bash
# Вешает поминутный запуск bitrix/php_interface/cron_events.php, если CRON_ENABLED=1.
# Без крона агенты Битрикса (почта, отложенные задания) в контейнере не выполняются.

if [[ ${CRON_ENABLED:-0} != 1 ]]; then
  log warning "Крон выключен — агенты Битрикса запускаться не будут"
else
  log info "Включаю агенты Битрикса: cron_events.php каждую минуту…"
  { env; echo "*/1 * * * * /usr/local/bin/php -f ${APP_PATH}/bitrix/php_interface/cron_events.php"; } | crontab -
  log success "Крон настроен"
fi
