#!/bin/bash

echo "*/1 * * * * /usr/local/bin/php -f ${APP_PATH}/bitrix/php_interface/cron_events.php" >> /tmp/cron_env_file
(env; cat /tmp/cron_env_file) > /tmp/cron_env_file-update && mv /tmp/cron_env_file-update /tmp/cron_env_file
dos2unix /tmp/cron_env_file
crontab -r
crontab /tmp/cron_env_file
rm -rf /tmp/cron_env_file
