## Velocistack
### Requirements
* Operating System: Ubuntu 20.04 or Windows 11
* Container Software: Docker and Docker Compose

### Installation
**Step 1.** Download Velocistack.
```
git clone https://github.com/weslambert/velocistack &&\
cd velocistack
```

**Step 2.** Run the installer script.
```
`sudo ./install_velocistack`
```

**Troubleshooting**  
If you experience an error with `cadvisor` and `/var/lib/docker`, try replacing the volume with `/var/snap/docker/common/var-lib-docker/` (for Docker installs that have occurred via `snap`).

### Getting Started
Login to Velociraptor and/or other included apps using the information below.
| Working  | App          | Port | URL                                       |
| -------- | ------------ | ---- | ----------------------------------------- |
| &check;  | Velociraptor | 8889 | https://localhost:8889/                   |
|          | Cyberchef    | ---- | https://localhost/cyberchef               |
| &check;  | Nginx        | 443  |                                           |
| &check;  | Intel Owl    | 9001 | https://localhost/intelowl/               |
| &check;  | IRIS         | 9000 | https://localhost/iris/                   |
| &check;  | Kibana       | 5601 | https://localhost:5601/                   |
|          | Prometheus   | 9090 | https://localhost/velocistack/prometheus/ |
|          | Grafana      | 3000 | https://localhost:3000/                   |

### Authentication
Velocistack proxies authentication for all services except for Intel Owl and IRIS. 
| App          | Username      | Password   |
| ------------ | ------------- | ---------- |
| Velociraptor | admin         | admin      |
| IRIS         | administrator | admin      |
| Intel Owl    | See below.    | See below. |

### Container Relationships
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

### FAQs
**What is Velocistack?** 
Velocistack is a free and open solution for streamlined host-based forensics and investigation.
- Collect forensic artifacts
- Post-process collections
- Visualize collections or hunt results
- Create cases for investigation
- Enrich results with additional context

**Why was Velocistack created?**  
To allow individuals to quickly spin up a local, integrated environment for analysis and investigation of forensic artifacts collected by Velociraptor, using popular free and open tools.

**Who should use Velocistack?**
- Analysts
- Incident Responders
- Students
- Anyone!

### Screenshots
**Landing Page**  
![image](https://user-images.githubusercontent.com/16829864/190757428-51012a52-13d5-429e-837f-3215a64598a8.png)

**Cyber Chef**  
![image](https://user-images.githubusercontent.com/16829864/191644980-52b65fa7-6940-40fa-8d3d-966602aa66f1.png)

**Cyber Chef Support in Velociraptor**
![image](https://user-images.githubusercontent.com/16829864/191645908-ed16ee29-1604-4cb9-9eba-72d1fd544fbd.png)

**IntelOwl**  
![image](https://user-images.githubusercontent.com/16829864/191645176-08ddbe91-b82e-439b-80a4-babc132cc588.png)

**IRIS**  
![image](https://user-images.githubusercontent.com/16829864/191645234-762f709d-1a6e-4c77-967f-175d71cef830.png)

**Kibana**
![image](https://user-images.githubusercontent.com/16829864/191645828-0a29ae0b-209b-48fc-a949-75e108c50b5c.png)

**Grafana**  
![image](https://user-images.githubusercontent.com/16829864/191645061-e0bd7597-5d2a-4bb5-b26c-6ec3bd5c41e1.png)