include .env

up:
	docker compose up -d --build --remove-orphans

stop:
	docker compose stop

down:
	docker compose down -v



cache-clear:
	docker compose exec -it application bash -c "rm -rf bitrix/cache && rm -rf bitrix/managed_cache && rm -rf bitrix/stack_cache"



cron-up:
	docker compose exec -it application bash -c "/usr/local/bin/php -f ${APP_PATH}/bitrix/php_interface/cron_events.php"



migrations-create:
	docker compose exec -it application bash -c 'php bin/migrate add &&  chmod -R 777 local/php_interface/migrations'

migrations-up:
	docker compose exec -it application php bin/migrate up

migrations-down:
	docker compose exec -it application php bin/migrate down

migrations-down-version: ## Пример: make migrations-down-version VERSION=Version20260303232408
	docker compose exec -it application php bin/migrate down $(VERSION)

seed-mocks: ## Очистить инфоблоки и накатить моковые данные
	@output=$$(docker compose exec -T application php bin/seed-mocks); \
	echo "$$output"; \
	id=$$(printf '%s\n' "$$output" | sed -n 's/^ID текущего мероприятия: //p'); \
	if [ -n "$$id" ] && [ -f frontend/siberia/.env ] && [ -n "$$(docker compose --profile siberia ps -q --status running siberia)" ]; then \
		sed -i.bak -E "s/^VITE_EVENT_ID=.*/VITE_EVENT_ID=$$id/" frontend/siberia/.env && rm -f frontend/siberia/.env.bak; \
		echo "Обновлён frontend/siberia/.env VITE_EVENT_ID=$$id"; \
		docker compose --profile siberia up -d --force-recreate siberia; \
	fi



phpstan:
	docker compose exec -it application php vendor/bin/phpstan analyse

phpcs:
	docker compose exec -it application php vendor/bin/php-cs-fixer fix --allow-risky=yes

phpcs-dry:
	docker compose exec -it application php vendor/bin/php-cs-fixer fix --allow-risky=yes --dry-run || true

test: ## Запустить тесты Codeception
	docker compose exec -it application php vendor/bin/codecept run Api

rector:
	docker compose exec -it application php vendor/bin/rector process

rector-dry:
	docker compose exec -it application php vendor/bin/rector process --dry-run || true


.PHONY: test-init
