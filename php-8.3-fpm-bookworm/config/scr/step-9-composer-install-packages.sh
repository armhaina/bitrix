#!/bin/bash

if [ -f "$APP_PATH/composer.json" ]; then
  alert_message "info" "Установка пакетов composer.json"

  composer install
fi
