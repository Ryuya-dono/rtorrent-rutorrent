FROM alpine:latest

RUN apk upgrade --no-cache && \
    apk add --no-cache tzdata curl mktorrent rtorrent nginx php7 php7-fpm php7-mbstring php7-json php7-session php7-bcmath php7-phar && \
    cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    echo "Europe/Moscow" >  /etc/timezone && \
    apk del tzdata && \
    rm -r -f /var/www/localhost/

COPY root /

RUN chmod -R 755 /usr/local/bin/ /etc/services.d/ && \
    mkdir -p /run/nginx/ /run/php-fpm/ /run/rtorrent/ /var/log/rutorrent/ /session/rtorrent/ /session/rutorrent/torrents/ /downloads/  && \
    chown -R nginx:nginx /run/nginx/ /run/php-fpm/ /run/rtorrent/ /var/log/php7/ /var/log/rutorrent/ /etc/nginx/ /etc/php7/ /etc/rtorrent/ /var/www/rutorrent/ /session/ /downloads/

EXPOSE 80 6881 50000

VOLUME ["/session/", "/downloads/"]

ENTRYPOINT ["/init"]
