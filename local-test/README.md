# abap-trace-tender
## start

```
docker-compose -f docker-compose-grafana-tempo.yml up
```

## utils

### Tempo

`curl -vX POST http://localhost:9411 -H 'Content-Type: application/json' -d @./grafana/trace-data/example-zipkin-trace.json`

## based on

### Tempo

https://grafana.com/docs/tempo/latest/guides/pushing-spans-with-http/