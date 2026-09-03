#!/bin/bash
# Скачивает и распаковывает 1С-Битрикс, если каталога bitrix ещё нет.

if [[ -d "$APP_PATH/bitrix" ]]; then
  log success "Битрикс уже есть в $APP_PATH — скачивать не нужно"
else
  log info "Скачиваю Битрикс ($BUILD_BITRIX_VERSION), это может занять несколько минут…"
  wget -q --show-progress -O "/tmp/$BUILD_BITRIX_VERSION.zip" "https://www.1c-bitrix.ru/download/${BUILD_BITRIX_VERSION}.zip"
  unzip -qo "/tmp/$BUILD_BITRIX_VERSION.zip" -d "$APP_PATH"
  rm -f "/tmp/$BUILD_BITRIX_VERSION.zip"
  log success "Дистрибутив распакован в $APP_PATH"
fi
