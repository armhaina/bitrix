#!/bin/bash
# Сбрасывает файловый кэш Битрикса (cache, managed_cache, stack_cache).
# Чтобы подтянуть свежие настройки из БД, например после записи strong_update_check.

log info "Очищаю файловый кэш Битрикса…"
rm -rf "$APP_PATH/bitrix/"{cache,managed_cache,stack_cache}
log success "Файловый кэш очищен"
