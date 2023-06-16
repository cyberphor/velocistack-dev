# Dockerfile metadata
FROM python:3.9
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

RUN apt-get update &&\
    apt-get install -y p7zip-full pgp postgresql-client jq wget unzip

RUN mkdir -p \
      /opt/iris/certificates/ \ 
      /opt/iris/user_templats/ \
      /opt/iris/server_data/backup/ \
      /opt/iris/server_data/updates/ \
      /opt/iris/server_data/datastore/ \
      /opt/iris/server_data/custom_assets/

RUN wget -qO /opt/iris/releases.json "https://api.github.com/repos/dfir-iris/iris-web/releases/latest"
RUN LATEST=$(cat /opt/iris/releases.json | jq -r 'limit(1 ; ( .assets[].browser_download_url))')
RUN wget -O /tmp/iris.zip "$LATEST"
RUN unzip /tmp/iris.zip -d /opt/iris/
RUN rm -f /opt/iris/releases.json /tmp/iris.zip
RUN python -m venv /opt/iris/
RUN pip3 install -r requirements.txt

    #cp ./iris/source/dependencies /dependencies &&\
    #cp ./iris/source/requirements.txt / &&\
    #cp ./iris/docker/webApp/iris-entrypoint.sh . &&\
    #cp ./iris/docker/webApp/wait-for-iriswebapp.sh . &&\
    #cp ./iris/source .

# Add execution right to binaries needed by evtx2splunk for iris_evtx module
RUN chmod +x /iriswebapp/dependencies/evtxdump_binaries/linux/x64/fd &&\
    chmod +x /iriswebapp/dependencies/evtxdump_binaries/linux/x64/evtx_dump &&\
    chmod +x entrypoint.sh &&\
    chmod +x wait-for-iriswebapp.sh

ENV PATH="/opt/venv/bin:$PATH"
ENV IRIS_ADM_PASSWORD="MySuperFirstPasswordIWant"
WORKDIR /opt/iris/
ENTRYPOINT [ "entrypoint.sh" ]