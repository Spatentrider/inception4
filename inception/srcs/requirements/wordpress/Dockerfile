FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache \
		php81 \
		php81-fpm\
		php81-mysqli\
		php81-opcache\
		php81-curl\
		php81-mbstring\
		php81-intl\
		php81-xml\
		php81-zip\
		php81-openssl\
		php81-phar\
		mariadb-client \
		fcgi \
		curl \
		wget

RUN adduser -S nginx && addgroup -S nginx


COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp


RUN	mkdir -p /var/log/php-fpm && \
	touch /var/log/php-fpm/error.log && \
	touch /var/log/php-fpm/access.log && \
	chown -R nginx:nginx /var/log/php-fpm && \
	chmod -R 777 /var/log/php-fpm

COPY ./tools/configure.sh /tmp/configure.sh
RUN	chmod +x /tmp/configure.sh

EXPOSE 9000

ENTRYPOINT ["sh", "/tmp/configure.sh"]

# Set the default command for the container to run PHP-FPM with specific options
# CMD ["php-fpm81", "--nodaemonize"]
