# Dockerfile metadata
FROM ubuntu:20.04
LABEL version="Velociraptor v0.6.7"
LABEL description="Velociraptor server in a Docker container"
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install tools needed to download Velociraptor and Cyber Chef
RUN apt-get update &&\
    apt-get install -y jq rsync unzip

# Create directories for Velociraptor & Cyber Chef binaries
RUN mkdir -p /opt/velociraptor/ /opt/velociraptor/linux/ /opt/velociraptor/mac/ /opt/velociraptor/windows/ /opt/cyberchef/

# Download the latest releases of Velociraptor
RUN RELEASES=$(wget -qO - "https://api.github.com/repos/velocidex/velociraptor/releases/latest") &&\
    NIX=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("linux-amd64") )))') &&\
    MAC=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("darwin-amd64") )))') &&\
    EXE=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.exe") )))') &&\
    MSI=$(echo $RELEASES | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.msi") )))') &&\
    wget -q "$NIX" -O /opt/velociraptor/linux/velociraptor &&\
    wget -q "$MAC" -O /opt/velociraptor/mac/velociraptor_client &&\
    wget -q "$EXE" -O /opt/velociraptor/windows/velociraptor_client.exe  &&\
    wget -q "$MSI" -O /opt/velociraptor/windows/velociraptor_client.msi 

# Download the latest release of Cyber Chef
RUN RELEASE=$(wget -qO - "https://api.github.com/repos/gchq/CyberChef/releases/latest") &&\
    LATEST=$(echo $RELEASE | jq -r 'limit(1 ; ( .assets[].browser_download_url))') &&\
    wget -q "$LATEST" -O /tmp/cyberchef.zip &&\
    unzip -o /tmp/cyberchef.zip -d /opt/cyberchef &&\
    mv /opt/cyberchef/CyberChef_*.html /opt/cyberchef/index.html &&\
    rm -f /tmp/cyberchef.zip

# Copy Velociraptor configuration files
ENV PATH="/opt/velociraptor:$PATH"
WORKDIR /opt/velociraptor/
COPY custom/ $DATASTORE_LOCATION/artifact_definitions
COPY entrypoint.sh entrypoint.sh

# Move binaries into place
RUN cp /opt/velociraptor/linux/velociraptor . &&\
    chmod +x velociraptor &&\
    mkdir -p $CLIENT_DIR/linux &&\
    mkdir -p $CLIENT_DIR/mac &&\
    mkdir -p $CLIENT_DIR/windows &&\
    rsync -a /opt/velociraptor/linux/velociraptor $CLIENT_DIR/linux/velociraptor_client &&\
    rsync -a /opt/velociraptor/mac/velociraptor_client $CLIENT_DIR/mac/velociraptor_client &&\
    rsync -a /opt/velociraptor/windows/velociraptor_client* $CLIENT_DIR/windows/

# Remove tools used to download Velociraptor and Cyber Chef
RUN apt-get remove --purge -y jq rsync unzip &&\
    apt-get clean

# Run Velociraptor
ENTRYPOINT [ "/opt/velociraptor/entrypoint.sh" ]
CMD [ "velociraptor", "--config", "server.config.yaml", "frontend", "-v" ]
