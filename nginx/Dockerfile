# Dockerfile metadata
FROM intelowlproject/intelowl_nginx:v4.0.0
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Nginx configuration files
WORKDIR /etc/nginx/
COPY . .

# Create and restrict certificates
RUN apk add openssl &&\
    mkdir ssl/ &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj /CN="velocistack" -keyout "ssl/private.key" -out "ssl/public.key" &&\
    chmod -R 600 /etc/nginx/ssl/