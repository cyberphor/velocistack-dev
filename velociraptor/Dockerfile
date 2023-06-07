FROM ubuntu:20.04
LABEL version="Velociraptor v0.6.7"
LABEL description="Velociraptor server in a Docker container"
LABEL maintainer="Wes Lambert, @therealwlambert"

RUN apt-get update && \
    apt-get install -y curl wget jq rsync unzip

# Create directories for Velociraptor & Cyber Chef binaries
RUN mkdir -p /opt/velociraptor/{linux,mac,windows} &&\
    mkdir -p /opt/cyberchef

# Download Velociraptor
RUN WINDOWS_EXE=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.exe") )))')  &&\
    WINDOWS_MSI=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.msi") )))') &&\
    LINUX_BIN=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("linux-amd64") )))') &&\
    MAC_BIN=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("darwin-amd64") )))') &&\
    wget -O /opt/velociraptor/linux/velociraptor "$LINUX_BIN" &&\
    wget -O /opt/velociraptor/mac/velociraptor_client "$MAC_BIN" &&\
    wget -O /opt/velociraptor/windows/velociraptor_client.exe "$WINDOWS_EXE" &&\
    wget -O /opt/velociraptor/windows/velociraptor_client.msi "$WINDOWS_MSI"

# Download Cyber Chef
RUN wget -O /tmp/cyberchef.zip https://github.com/gchq/CyberChef/releases/download/v9.32.3/CyberChef_v9.32.3.zip &&\
    unzip -o /tmp/cyberchef.zip -d /opt/cyberchef &&\
    mv /opt/cyberchef/cyberchef_v9.32.3.html /opt/cyberchef/index.html &&\
    rm -f /tmp/cyberchef.zip

# Clean up
RUN apt-get remove -y --purge curl wget jq && \
    apt-get clean

# Copy Velociraptor configuration files
WORKDIR /opt/velociraptor/
COPY custom/ /custom/
COPY entrypoint.sh entrypoint.sh

# Run Velociraptor
CMD [ "entrypoint.sh" ]
