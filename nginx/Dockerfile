# Dockerfile metadata
FROM nginx:latest
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Nginx configuration files
WORKDIR /etc/nginx/
COPY . .

# Create and restrict certificates
RUN mkdir ssl/ &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj /CN="velocistack" -keyout "ssl/nginx.key" -out "ssl/nginx.crt" &&\
    chmod -R 600 /etc/nginx/ssl/