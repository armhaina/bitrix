#!/bin/bash

APP_PATH=$(printenv APP_PATH)
SERVER_NAME=$(printenv SERVER_NAME)
CRON_ENABLED=$(printenv CRON_ENABLED)
MAILPIT_ENABLED=$(printenv MAILPIT_ENABLED)
MAILPIT_HOST=$(printenv MAILPIT_HOST)

if [ -z "$APP_PATH" ]; then
  alert_message "error" "Переменная APP_PATH не установлена"
  exit 1
fi

if [ -z "$SERVER_NAME" ]; then
  alert_message "error" "Переменная SERVER_NAME не установлена"
  exit 1
fi
