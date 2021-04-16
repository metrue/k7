VUS ?= 1
ITERATIONS ?= 1
DB ?= 'myk6db'
INFLUXDB_IP := $(shell ipconfig getifaddr en0)

help:
	cat README.md
setup:
	docker-compose -f docker/docker-compose.yml up -d
	docker ps

teardown:
	docker-compose -f docker/docker-compose.yml down --remove-orphans

run:
	docker run -i loadimpact/k6 run --vus ${VUS} --iterations ${ITERATIONS} --out influxdb=http://${INFLUXDB_IP}:8086/${DB} - <scripts/load_test.js
