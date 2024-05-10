up:
	docker compose up -d
	docker compose exec app bash -c "rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"

down:
	docker compose down

exec:
	docker compose exec app bash

.PHONY: up down
