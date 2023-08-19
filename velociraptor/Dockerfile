# Dockerfile metadata
FROM debian:stable-slim
LABEL version="Velociraptor v0.6.7"
LABEL description="Velociraptor server in a Docker container"
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install tools needed to download Velociraptor and Cyber Chef
RUN apt-get update &&\
    apt-get install -y wget jq unzip

# Create directories for Velociraptor & Cyber Chef binaries
RUN mkdir -p \
      /opt/velociraptor/binaries/linux/ \
      /opt/velociraptor/binaries/mac/ \
      /opt/velociraptor/binaries/windows/ 

# Update the environment path
ENV PATH="/opt/velociraptor:$PATH"

# Download the latest releases of Velociraptor
RUN wget -qO  /opt/velociraptor/releases.json "https://api.github.com/repos/velocidex/velociraptor/releases/latest" &&\
    NIX=$(cat /opt/velociraptor/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("linux-amd64") )))') &&\
    MAC=$(cat /opt/velociraptor/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("darwin-amd64") )))') &&\
    EXE=$(cat /opt/velociraptor/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.exe") )))') &&\
    MSI=$(cat /opt/velociraptor/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.msi") )))') &&\
    wget -qO  /opt/velociraptor/binaries/linux/velociraptor "$NIX" &&\
    wget -qO  /opt/velociraptor/binaries/mac/velociraptor "$MAC" &&\
    wget -qO  /opt/velociraptor/binaries/windows/velociraptor.exe "$EXE" &&\
    wget -qO  /opt/velociraptor/binaries/windows/velociraptor.msi "$MSI" &&\
    cp /opt/velociraptor/binaries/linux/velociraptor /opt/velociraptor/velociraptor &&\
    chmod +x /opt/velociraptor/velociraptor &&\
    rm -f /tmp/velociraptor_releases.json

# Copy Velociraptor configuration files
COPY entrypoint.sh /opt/velociraptor/entrypoint.sh
COPY custom/ /opt/velociraptor/artifact_definitions/
COPY server.config.json /opt/velociraptor/server.config.json

# Run Cyber Chef and Velociraptor
WORKDIR /opt/velociraptor/
ENTRYPOINT [ "/opt/velociraptor/entrypoint.sh" ]
CMD [ "velociraptor", "frontend", "--config", "server.config.yaml", "-v" ]