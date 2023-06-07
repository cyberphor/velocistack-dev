# Dockerfile metadata
FROM alpine:3.18
LABEL version="Velociraptor v0.6.7"
LABEL description="Velociraptor server in a Docker container"
LABEL maintainer="Wes Lambert, @therealwlambert"

# Install tools needed to download Velociraptor and Cyber Chef
RUN apk add curl jq rsync unzip

# Create directories for Velociraptor & Cyber Chef binaries
RUN mkdir -p /opt/velociraptor/ /opt/velociraptor/linux /opt/velociraptor/mac /opt/velociraptor/windows /opt/cyberchef 

# Download Velociraptor
RUN WINDOWS_EXE=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.exe") )))')  &&\
    WINDOWS_MSI=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("windows-amd64.msi") )))') &&\
    LINUX_BIN=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("linux-amd64") )))') &&\
    MAC_BIN=$(curl -s https://api.github.com/repos/velocidex/velociraptor/releases/latest | jq -r 'limit(1 ; ( .assets[].browser_download_url | select ( contains("darwin-amd64") )))') &&\
    curl -s "$LINUX_BIN" --output /opt/velociraptor/linux/velociraptor &&\
    curl -s "$MAC_BIN" --output /opt/velociraptor/mac/velociraptor_client.elf  &&\
    curl -s "$WINDOWS_EXE" --output /opt/velociraptor/windows/velociraptor_client.exe  &&\
    curl -s "$WINDOWS_MSI" --output /opt/velociraptor/windows/velociraptor_client.msi 

# Download Cyber Chef
RUN wget -O /tmp/cyberchef.zip https://github.com/gchq/CyberChef/releases/download/v9.32.3/CyberChef_v9.32.3.zip &&\
    unzip -o /tmp/cyberchef.zip -d /opt/cyberchef &&\
    mv /opt/cyberchef/CyberChef_v9.32.3.html /opt/cyberchef/index.html &&\
    rm -f /tmp/cyberchef.zip

# Clean up
RUN apk del curl jq

# Copy Velociraptor configuration files
WORKDIR /opt/velociraptor/
COPY custom/ /custom/
COPY entrypoint.sh entrypoint.sh

# Run Velociraptor
CMD [ "/opt/velociraptor/entrypoint.sh" ]
