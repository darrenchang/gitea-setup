FROM nginx:1.27-alpine

COPY certs/openssl.cnf /tmp/openssl.cnf
RUN apk add --no-cache openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/server.key \
        -out /etc/nginx/ssl/server.crt \
        -config /tmp/openssl.cnf -extensions v3_req && \
    rm /tmp/openssl.cnf

COPY nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx_config.conf /etc/nginx/conf.d/gitea.conf
