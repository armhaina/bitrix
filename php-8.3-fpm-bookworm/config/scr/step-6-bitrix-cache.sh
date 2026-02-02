#!/bin/bash

alert_message "info" "Очистить кэш"

rm -rf $APP_PATH/bitrix/cache $APP_PATH/bitrix/managed_cache $APP_PATH/bitrix/stack_cache
