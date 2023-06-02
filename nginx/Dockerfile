# Dockerfile metadata
FROM nginx:latest
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Nginx configuration files
WORKDIR /etc/nginx/
COPY . .

# Create and restrict certificates
RUN openssl req -x509 -nodes -days 365 -subj /CN="velocistack" -keyout "/etc/nginx/nginx.key" -out "/etc/nginx/nginx.crt"