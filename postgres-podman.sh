#!/bin/sh

podman run -d \
	--name telefony-db \
	-e POSTGRES_USER=user \
	-e POSTGRES_PASSWORD=pass \
	-e POSTGRES_DB=phones \
	-p 5432:5432 \
	-v $PWD/pgdata:/var/lib/postgresql/data:rw,Z \
	postgres:12-alpine

