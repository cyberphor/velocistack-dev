# Dockerfile metadata
FROM python:3.9
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install tools needed to download IRIS
RUN apt-get update &&\
    apt-get install -y p7zip-full pgp postgresql-client unzip wget

# Make directories for IRIS
RUN mkdir -p \
      /opt/iris/certificates/ \ 
      /opt/iris/user_templates/ \
      /opt/iris/server_data/backup/ \
      /opt/iris/server_data/updates/ \
      /opt/iris/server_data/datastore/ \
      /opt/iris/server_data/custom_assets/

# Download IRIS
RUN wget -qO /tmp/iris.zip https://github.com/dfir-iris/iris-web/archive/refs/tags/v2.2.2.zip &&\
    unzip /tmp/iris.zip -d /tmp/ &&\
    mv /tmp/iris-web-2.2.2/source/* /opt/iris/ &&\
    rm -rf /tmp/iris.zip

# Install IRIS
WORKDIR /opt/iris/
COPY entrypoint.sh entrypoint.sh
COPY wait-for-iriswebapp.sh wait-for-iriswebapp.sh
RUN python -m venv /opt/iris/ &&\
    python -m pip install -r requirements.txt &&\
    chmod +x dependencies/evtxdump_binaries/linux/x64/fd &&\
    chmod +x dependencies/evtxdump_binaries/linux/x64/evtx_dump
ENV PATH="/opt/iris:$PATH"

# Run IRIS
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "wait-for-iriswebapp.sh" ]