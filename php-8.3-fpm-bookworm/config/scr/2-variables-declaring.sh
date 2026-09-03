#!/bin/bash
# Читает и проверяет переменные окружения контейнера.
# Без APP_PATH и SERVER_NAME Nginx не узнает, куда класть сайт и какой домен слушать.

require() {
  [[ -n "${!1}" ]] || { log error "Не задана переменная $1 — укажите её в .env"; exit 1; }
}

require APP_PATH
require SERVER_NAME

BUILD_BITRIX_VERSION=${BUILD_BITRIX_VERSION:-start_encode}
case $BUILD_BITRIX_VERSION in
  start_encode|standard_encode|small_business_encode|business_encode) ;;
  *)
    log error "BUILD_BITRIX_VERSION=$BUILD_BITRIX_VERSION неизвестна. Допустимо: start_encode, standard_encode, small_business_encode, business_encode"
    exit 1
    ;;
esac

log info "Сайт: $APP_PATH  ·  домен: $SERVER_NAME  ·  редакция: $BUILD_BITRIX_VERSION"
cd "$APP_PATH"
