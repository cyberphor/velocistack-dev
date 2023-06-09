# Dockerfile metadata
FROM alpine:3.18 as BUILDER
LABEL version="Velociraptor v0.6.7"
LABEL description="Velociraptor server in a Docker container"
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install tools needed to download Velociraptor and Cyber Chef
RUN apk add jq rsync unzip

# Create directories for Velociraptor & Cyber Chef binaries
RUN mkdir -p \
      /opt/cyberchef/ \
      /opt/velociraptor/binaries/linux/ \
      /opt/velociraptor/binaries/mac/ \
      /opt/velociraptor/binaries/windows/

# Download the latest release of Cyber Chef
RUN RELEASE=$(wget -qO - "https://api.github.com/repos/gchq/CyberChef/releases/latest") &&\
    LATEST=$(echo $RELEASE | jq -r 'limit(1 ; ( .assets[].browser_download_url))') &&\
    wget -q "$LATEST" -O /tmp/cyberchef.zip &&\
    unzip -o /tmp/cyberchef.zip -d /opt/cyberchef/ &&\
    rm -f /tmp/cyberchef.zip &&\
    mv /opt/cyberchef/CyberChef_*.html /opt/cyberchef/index.html 

# Download the latest releases of Velociraptor
RUN RELEASES=$(wget -qO - "https://api.github.com/repos/velocidex/velociraptor/releases/latest") &&\
    NIX=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("linux-amd64") )))') &&\
    MAC=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("darwin-amd64") )))') &&\
    EXE=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.exe") )))') &&\
    MSI=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.msi") )))') &&\
    wget -q "$NIX" -O /opt/velociraptor/binaries/linux/velociraptor &&\
    wget -q "$MAC" -O /opt/velociraptor/binaries/mac/velociraptor &&\
    wget -q "$EXE" -O /opt/velociraptor/binaries/windows/velociraptor.exe  &&\
    wget -q "$MSI" -O /opt/velociraptor/binaries/windows/velociraptor.msi &&\
    cp /opt/velociraptor/binaries/linux/velociraptor /opt/velociraptor/velociraptor &&\
    chmod +x /opt/velociraptor/velociraptor

# Copy Velociraptor configuration files
COPY custom/ /opt/velociraptor/artifact_definitions/
COPY entrypoint.sh /opt/velociraptor/entrypoint.sh

# Copy Cyber Chef and Velociraptor files to another image
FROM ubuntu:20.04
COPY --from=BUILDER /opt/cyberchef/ /opt/cyberchef/
COPY --from=BUILDER /opt/velociraptor/ /opt/velociraptor/

# Run Cyber Chef and Velociraptor
ENV PATH="/opt/velociraptor:$PATH"
WORKDIR /opt/velociraptor/
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "velociraptor", "--config", "server.config.yaml", "frontend", "-v" ]
