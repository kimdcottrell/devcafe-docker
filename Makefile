#!make
sinclude .env

.PHONY: help

.DEFAULT_GOAL := help

shell: ## WordPress: Start a shell as www-data
	docker-compose exec --user www-data wordpress bash -l

root-shell: ## WordPress: Start a shell as root
	docker-compose exec wordpress bash

mysql: ## Database: Start a mysql console as ${DB_USER} in ${DB_NAME}
	docker-compose exec database mysql -u${DB_USER} -p${DB_PASS} -h${WORDPRESS_DB_HOST} ${DB_NAME}

root-mysql: ## Database: Start a mysql console as root
	docker-compose exec database mysql -uroot -p${DB_ROOT_PASS} -h${WORDPRESS_DB_HOST}

build: ## Docker: Build or rebuild services
	docker-compose build

up: ## Docker: Builds (or fetch from cache), (re)creates, starts, and attaches to containers for a service.
	docker-compose up -d

down: ## Docker: Stop and remove containers, networks, images, and volumes
	docker-compose down

start: ## Docker: Start services
	docker-compose start

stop: ## Docker: Stop services
	docker-compose stop

restart: down build up ## Docker: make down, make build, and make up

status: ## Docker: Status of all containers and networks
	docker ps -a
	docker network ls

coffee: ## Make: Get your terminal caffeinated
	echo $$'\342\230\225\012'

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Make: Helper Team 6 comin' in hot
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

