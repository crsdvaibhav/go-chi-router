DSN="host=localhost port=5432 user=root password=secret dbname=coffeedb sslmode=disable timezone=UTC connect_timeout=5"
PORT=8080
DB_DOCKER_CONTAINER=coffee_db
BINARY_NAME=crsdcoffeeapi

postgres:
	docker run --name ${DB_DOCKER_CONTAINER} -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

# Start container
start-docker:
	docker start ${DB_DOCKER_CONTAINER}

# Stop all containers
stop-containers:
	chmod +x stop.sh && ./stop.sh

createdb:
	docker exec -t ${DB_DOCKER_CONTAINER} createdb --username=root --owner=root coffeedb

create_migrations:
	sqlx migrate add -r init

migrate-up:
	sqlx migrate run --database-url "postgres://root:secret@localhost:5432/coffeedb?sslmode=disable"

migrate-down:
	sqlx migrate revert --database-url "postgres://root:secret@localhost:5432/coffeedb?sslmode=disable"

build:
	@echo "Building api binary..."
	go build -o ${BINARY_NAME} cmd/server/*.go
	@echo "Binary built!"

run:
	go run cmd/server/main.go