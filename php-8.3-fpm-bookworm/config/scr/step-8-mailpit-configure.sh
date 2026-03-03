#!/bin/bash

if [ "$MAILPIT_ENABLED" = "1" ]; then
  # Проверить и установить значения по умолчанию (если переменная не заполнена)
  if [ -z "$MAILPIT_HOST" ]; then
      MAILPIT_HOST="mailpit:1025"
  fi

  alert_message "info" "Mailpit включен с хостом: ${MAILPIT_HOST}"

  echo "" >> /usr/local/etc/php/conf.d/php.ini
  echo "[mail]" >> /usr/local/etc/php/conf.d/php.ini
  echo "sendmail_path = \"/usr/local/bin/mailpit sendmail --smtp-addr ${MAILPIT_HOST}\"" >> /usr/local/etc/php/conf.d/php.ini
else
    alert_message "warning" "Mailpit выключен"
fi
