DB_DOCKER_CONTAINER=coffee_db
BINARY_NAME=crsdcoffeeapi

postgres:
	docker run --name ${DB_DOCKER_CONTAINER} -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

run:
	go run cmd/server/main.go