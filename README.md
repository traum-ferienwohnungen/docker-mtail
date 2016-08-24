docker image to run mtail (in kubernetes)
========================================

Place your own mtail progs in `progs` directory and rebuild to add them to the image or mount them as volume/configMap.

mtail - extract whitebox monitoring data from application logs for collection into a timeseries database
========================================================================================================

See the mtail repo at https://github.com/google/mtail

mtail is a tool for extracting metrics from application logs to be exported into a timeseries database or timeseries calculator for alerting and dashboarding.

It aims to fill a niche between applications that do not export their own internal state, and existing monitoring systems, without patching those applications or rewriting the same framework for custom extraction glue code.

The extraction is controlled by mtail programs which define patterns and actions:

    # simple line counter
    counter line_count
    /$/ {
      line_count++
    }

Metrics are exported for scraping by a collector as JSON or Prometheus format over HTTP, or can be periodically sent to a collectd, StatsD, or Graphite collector socket.

See [the Wiki](https://github.com/google/mtail/wiki/Home) for more details.


kubernetes
==========

The following podspec (example) may be used, logs can be shared via `emptyDir` volume.

```yaml
- name: mtail
  image: FIXME/mtail:latest
  command:
      - /bin/mtail
      - -logtostderr
      - -progs
      - /progs/linecount.mtail
      - -logs
      - /logs/query.log
  ports:
  - containerPort: 3903
  volumeMounts:
  - mountPath: /logs
    name: logs
```
