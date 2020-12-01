#!/bin/bash

# Copy the required files to relevant folders

set -e

mkdir -p bin config

mv ../../build_docker/programs/clickhouse* bin/
cp ../../programs/server/config.xml config/
cp ../../programs/server/users.xml config/
cp ../../docker/server/docker_related_config.xml config/
cp ../../debian/clickhouse.limits config/
cp ../../programs/client/clickhouse-client.xml config/
