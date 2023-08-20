# Dockerfile metadata
FROM python:3.9
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install tools needed to download Cyber Chef
RUN apt-get update &&\
    apt-get install -y wget unzip

# Create a directory for Cyber Chef
RUN mkdir /opt/cyberchef/ 

# Download the latest release of Cyber Chef
RUN wget -qO /opt/cyberchef/releases.json "https://api.github.com/repos/gchq/CyberChef/releases/latest" &&\
    LATEST=$(cat /opt/cyberchef/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url))') &&\
    wget -qO /tmp/cyberchef.zip "$LATEST" &&\
    unzip /tmp/cyberchef.zip -d /opt/cyberchef/ &&\
    mv /opt/cyberchef/CyberChef_*.html /opt/cyberchef/index.html &&\
    rm -f /opt/cyberchef/releases.json /tmp/cyberchef.zip 

# Run Cyber Chef and Velociraptor
WORKDIR /opt/cyberchef/
CMD [ "python", "-m", "http.server", "8443" ]