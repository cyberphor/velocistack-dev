## Velocistack

Velocistack is a free and open source solution for streamlined host-based forensics and investigation.
* Collect forensic artifacts
* Post-process collections
* Visualize collections or hunt results
* Create cases for investigation
* Enrich results with additional context

### Installation
**Step 1.** Download Velocistack.
```
git clone https://github.com/weslambert/velocistack &&\
cd velocistack/velocistack
```

**Step 2.** Run Docker Compose.
```
docker compose --profile velocistack up
```

**Step 3.** Login to Velociraptor and/or other apps using the information below.
| App          | Working  | URL                                                   |
| ------------ | -------- | ----------------------------------------------------- |
| Velociraptor | &check;  | https://localhost/velocistack/                        |
| Cyberchef    |          | https://localhost/velocistack/cyberchef/              |
| Intel Owl    | &check;  | https://localhost/velocistack/intelowl/               |
| IRIS         | &check;  | https://localhost/velocistack/iris/                   |
| Kibana       | &check;  | https://localhost/velocistack/kibana/                 |
| Prometheus   |          | https://localhost/velocistack/prometheus/             |
| Grafana      |          | https://localhost/velocistack/grafana/                |