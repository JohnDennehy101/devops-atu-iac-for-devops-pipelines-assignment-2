FROM nginx:alpine

LABEL maintainer="L00196611@atu.ie"

COPY ./site/index.html /usr/share/nginx/html/index.html

COPY ./run.sh /run.sh

ENV LISTEN_PORT=80

USER root

RUN chmod +x /run.sh \
 && chown -R nginx:nginx /usr/share/nginx/html \
 && mkdir -p /var/cache/nginx/client_temp \
 && chown -R nginx:nginx /var/cache/nginx

USER nginx

CMD ["/run.sh"]