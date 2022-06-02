#!/bin/bash
echo "prepare paravision db"
docker pull paravision/postgres:12.11
docker run -d --name pvdb -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=identity paravision/postgres:12.11
docker run --rm --link pvdb --entrypoint /migrate paravision/identity:v4.0.0 -source file://migrations --database $POSTGRES_URI up
echo "v4 migration complete"
