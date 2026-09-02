#!/bin/bash

alert_message "warning" "Проверка на то что Bitrix установлен"

BITRIX_EDITIONS=(
  "start_encode"
  "standard_encode"
  "small_business_encode"
  "business_encode"
)

BITRIX_EDITION_NAMES=(
  "Старт"
  "Стандарт"
  "Малый бизнес"
  "Бизнес"
)

select_bitrix_edition() {
  if [[ ! -t 0 || ! -t 1 ]]; then
    alert_message "error" "Нужна интерактивная консоль для выбора версии БУС. Запустите без -d: docker compose up"
    exit 1
  fi

  echo
  alert_message "info" "Выберите версию 1C-Bitrix: Управление сайтом"
  echo

  local i
  for i in "${!BITRIX_EDITIONS[@]}"; do
    printf "    %d) %s  [%s]\n" "$((i + 1))" "${BITRIX_EDITION_NAMES[$i]}" "${BITRIX_EDITIONS[$i]}"
  done
  echo

  local choice
  while true; do
    read -r -p "Номер версии: " choice || true
    if [[ "$choice" =~ ^[1-4]$ ]]; then
      BITRIX_EDITION="${BITRIX_EDITIONS[$((choice - 1))]}"
      break
    fi
    echo "Введите число от 1 до 4"
  done
}

if [ ! -d "$APP_PATH/bitrix" ]
then
  select_bitrix_edition

  alert_message "info" "Установка Bitrix версии $BITRIX_EDITION"

  # Загрузить и распаковать BITRIX CMS
  wget -P /tmp "https://www.1c-bitrix.ru/download/${BITRIX_EDITION}.zip"
  unzip "/tmp/${BITRIX_EDITION}.zip" -d "$APP_PATH"
  rm -rf "/tmp/${BITRIX_EDITION}.zip"

  # Установить полные права на все папки и файлы
  cd "$APP_PATH" && chmod -R 777 .
fi

alert_message "success" "Bitrix успешно установлен"
