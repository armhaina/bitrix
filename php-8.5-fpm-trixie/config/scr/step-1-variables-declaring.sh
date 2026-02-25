#!/bin/bash

APP_PATH=$(printenv APP_PATH)
SERVER_NAME=$(printenv SERVER_NAME)
BITRIX_VERSION=$(printenv BITRIX_VERSION)

if [ -z "$APP_PATH" ]; then
  alert_message "error" "Переменная APP_PATH не установлена"
  exit 1
fi

if [ -z "$SERVER_NAME" ]; then
  alert_message "error" "Переменная SERVER_NAME не установлена"
  exit 1
fi

BITRIX_VERSIONS=("start_encode" "standard_encode" "small_business_encode" "business_encode", "bitrix24_shop_encode", "business_cluster_postgresql_encode")

if ! printf '%s\n' "${BITRIX_VERSIONS[@]}" | grep -qFx "$BITRIX_VERSION"; then
    BITRIX_VERSION="start_encode"
fi
