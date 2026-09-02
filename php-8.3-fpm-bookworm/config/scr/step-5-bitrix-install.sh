#!/bin/bash

alert_message "warning" "Проверка на то что Bitrix установлен"

if [ ! -d "$APP_PATH/bitrix" ]
then
  alert_message "info" "Установка Bitrix версии $BITRIX_VERSION"

  # Загрузить и распаковать BITRIX CMS
  wget -P /tmp "https://www.1c-bitrix.ru/download/${BITRIX_VERSION}.zip"
  unzip "/tmp/${BITRIX_VERSION}.zip" -d "$APP_PATH"
  rm -rf "/tmp/${BITRIX_VERSION}.zip"

  chown -R www-data:www-data "$APP_PATH"

  DB_HOST=$(printenv DB_HOST)
  DB_USER=$(printenv DB_USER)
  DB_PASSWORD=$(printenv DB_PASSWORD)
  DB_DATABASE=$(printenv DB_DATABASE)

  if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_DATABASE" ]; then
    alert_message "warning" "DB_HOST/DB_USER/DB_DATABASE не заданы, strong_update_check не установлен"
  elif ! wait-for-it "${DB_HOST}:3306" -t 60; then
    alert_message "warning" "База данных недоступна, strong_update_check не установлен"
  else
    alert_message "info" "Запись main.strong_update_check=N в b_option"

    if php -d display_errors=0 <<'PHP'
<?php
$host = getenv('DB_HOST') ?: '';
$user = getenv('DB_USER') ?: '';
$password = getenv('DB_PASSWORD') ?: '';
$database = getenv('DB_DATABASE') ?: '';

try {
    $pdo = new PDO(
        sprintf('mysql:host=%s;dbname=%s;charset=utf8mb4', $host, $database),
        $user,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_TIMEOUT => 10,
        ]
    );
} catch (PDOException $e) {
    fwrite(STDERR, $e->getMessage() . PHP_EOL);
    exit(1);
}

$exists = $pdo->query("SHOW TABLES LIKE 'b_option'")->fetch(PDO::FETCH_NUM);
if (!$exists) {
    fwrite(STDERR, "Таблица b_option ещё не создана" . PHP_EOL);
    exit(2);
}

$pdo->exec(
    "UPDATE b_option SET VALUE = 'N' WHERE MODULE_ID = 'main' AND NAME = 'strong_update_check'"
);

$count = (int) $pdo->query(
    "SELECT COUNT(*) FROM b_option WHERE MODULE_ID = 'main' AND NAME = 'strong_update_check'"
)->fetchColumn();

if ($count === 0) {
    $pdo->exec(
        "INSERT INTO b_option (MODULE_ID, NAME, VALUE, SITE_ID)
         VALUES ('main', 'strong_update_check', 'N', '')"
    );
}
PHP
    then
      rm -rf "$APP_PATH/bitrix/managed_cache"/*/b_option "$APP_PATH/bitrix/cache"/*/b_option 2>/dev/null || true
      alert_message "success" "Опция strong_update_check=N записана в b_option"
    else
      alert_message "warning" "Не удалось записать strong_update_check (таблица b_option может ещё не существовать)"
    fi
  fi
fi

alert_message "success" "Bitrix успешно установлен"
