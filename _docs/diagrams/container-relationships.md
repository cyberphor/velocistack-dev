# Container Relationships
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