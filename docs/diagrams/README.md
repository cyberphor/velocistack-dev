## Contents
* [Container Relationships](#container-relationships)
* [Profiles](#profiles)
  * [Velocistack](#velocistack)
  * [Intelowl](#intelowl)
  * [Iris](#iris)
  * [Elastic](#Elastic)
  * [Velociraptor](#velociraptor)
  * [Cyber Chef](#cyber-chef)
  * [Prometheus](#prometheus)
  * [Grafana](#grafana)
  * [Zinc](#zinc)

## Container Relationships
```mermaid
flowchart TD
    velociraptor --> cyber_chef
    velociraptor --> kibana 
        kibana --> elasticsearch
    velociraptor --> zinc
    velociraptor --> nginx 
        nginx --> intel_owl
            intel_owl --> rabbitmq --> postgres
        nginx --> iris
            iris --> postgres
    velociraptor --> prometheus
        prometheus --> cadvisor
    velociraptor --> grafana
```

## Profiles
### Velocistack
```mermaid
flowchart TD
  postgres --> rabbitmq --> intelowl --> nginx
  postgres --> iris --> nginx
  postgres --> celery-beat
  postgres --> celery-worker
  elasticsearch --> kibana
  velociraptor
  cyber-chef 
  prometheus
  grafana
  zinc
```

### Intelowl
```mermaid
flowchart TD
  postgres --> rabbitmq --> intelowl --> nginx
```

### Iris
```mermaid
flowchart TD
  postgres --> iris --> nginx
```

### Elastic
```mermaid
flowchart TD
  elasticsearch --> kibana
```

### Velociraptor
```mermaid
flowchart TD
  velociraptor
```

### Cyber Chef
```mermaid
flowchart TD
  cyber-chef
```

### Velociraptor
```mermaid
flowchart TD
  prometheus
```

### Grafana
```mermaid
flowchart TD
  grafana
```

### zinc
```mermaid
flowchart TD
  zinc
```