include .env

up:
	docker compose up -d --build --remove-orphans

stop:
	docker compose stop

down:
	docker compose down -v



cache-clear:
	docker compose exec -it application bash -c "rm -rf bitrix/cache && rm -rf bitrix/managed_cache && rm -rf bitrix/stack_cache"



migrations-create:
	docker compose exec -it application bash -c 'php bin/migrate add &&  chmod -R 777 local/php_interface/migrations'

migrations-up:
	docker compose exec -it application php bin/migrate up

migrations-down:
	docker compose exec -it application php bin/migrate down

migrations-down-version: ## Пример: make migrations-down-version VERSION=Version20260303232408
	docker compose exec -it application php bin/migrate down $(VERSION)



phpstan:
	docker compose exec -it application php vendor/bin/phpstan analyse

phpcs:
	docker compose exec -it application php vendor/bin/php-cs-fixer fix --allow-risky=yes

phpcs-dry:
	docker compose exec -it application php vendor/bin/php-cs-fixer fix --allow-risky=yes --dry-run || true

rector:
	docker compose exec -it application php vendor/bin/rector process

rector-dry:
	docker compose exec -it application php vendor/bin/rector process --dry-run || true


.PHONY: test-init
