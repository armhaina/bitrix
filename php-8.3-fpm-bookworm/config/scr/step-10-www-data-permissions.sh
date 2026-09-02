#!/bin/bash

alert_message "info" "Назначение владельца www-data для $APP_PATH"

mkdir -p "$APP_PATH"

if ! chown -R www-data:www-data "$APP_PATH"; then
  alert_message "warning" "Не удалось сменить владельца $APP_PATH на www-data"
fi

# Новые файлы в каталогах наследуют группу www-data
find "$APP_PATH" -type d -exec chmod g+s {} + 2>/dev/null || true

# ACL: www-data может читать/писать текущие и все новые файлы проекта
if command -v setfacl >/dev/null 2>&1 && setfacl -m u:www-data:rwx "$APP_PATH" 2>/dev/null; then
  setfacl -R -m u:www-data:rwX,g:www-data:rwX "$APP_PATH" 2>/dev/null || true
  find "$APP_PATH" -type d -exec setfacl -d -m u:www-data:rwx,g:www-data:rwx {} + 2>/dev/null || true
  alert_message "success" "Владелец www-data и ACL по умолчанию установлены"
else
  alert_message "success" "Владелец www-data установлен"
fi
