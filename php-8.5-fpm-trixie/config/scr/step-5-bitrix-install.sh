#!/bin/bash

alert_message "warning" "Проверка на то что Bitrix установлен"

if [ ! -d $APP_PATH/bitrix ]
then
  alert_message "info" "Установка Bitrix версии $BITRIX_VERSION"

  # Загрузить и распаковать BITRIX CMS
  wget -P /tmp https://www.1c-bitrix.ru/download/$BITRIX_VERSION.zip
  unzip /tmp/$BITRIX_VERSION.zip -d $APP_PATH
  rm -rf /tmp/$BITRIX_VERSION.zip

  # Установить полные права на все папки и файлы
  cd $APP_PATH && chmod -R 777 .
fi

alert_message "success" "Bitrix успешно установлен"
