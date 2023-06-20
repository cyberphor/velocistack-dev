# Dockerfile metadata
FROM intelowlproject/intelowl_nginx:v4.0.0
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Copy Nginx configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY errors.conf /etc/nginx/conf.d/errors.conf
COPY locations.conf /etc/nginx/conf.d/locations.conf