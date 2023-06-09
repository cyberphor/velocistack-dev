# Dockerfile metadata
FROM intelowlproject/intelowl_nginx:v4.0.0
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Install OpenSSL
RUN apk add openssl 

# Create and restrict SSL certificates
RUN mkdir /etc/nginx/ssl &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj /CN="velocistack" \
      -keyout "/etc/nginx/ssl/nginx.key" \
      -out "/etc/nginx/ssl/nginx.crt" &&\
    chmod -R 640 /etc/nginx/ssl/

# Copy Nginx configuration files
WORKDIR /etc/nginx/
COPY . .