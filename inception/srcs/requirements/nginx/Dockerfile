FROM alpine:3.17

RUN	apk update && apk upgrade && apk add --no-cache nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN	mkdir -p /etc/nginx/ssl && cd /etc/nginx/ssl && \
	openssl req -x509 \
		-nodes \
		-subj "/C=IT/L=Rome/O=42Roma/OU=student/CN=$USERNAME.42.fr" \
		-out nginx.crt \
		-keyout nginx.key \
	&& chmod +r nginx.crt nginx.key

RUN	mkdir -p /run/nginx

WORKDIR /var/www/html

ENTRYPOINT ["nginx" , "-g" , "daemon off;"]
