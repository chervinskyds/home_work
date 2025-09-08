# HW26 — EFK with Node.js (Monitoring-2 app, patched logger)

## Run
cd hw26-efk-from-repo
docker compose up -d --build
curl http://localhost:10000/
curl http://localhost:10000/error

## Kibana
Open http://localhost:5601 → Stack Management → Data Views → create `js-app-*` → Discover.

## Deliverables
- node-app/Dockerfile
- docker-compose.yml
- fluentd/fluent.conf, elasticsearch.yml, kibana.yml
- screenshots: docker compose ps; hitting endpoints; Kibana Discover with logs.
