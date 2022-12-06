FROM alpine:latest
LABEL maintainer="e.nazarchuk"
RUN apk update && apk upgrade && apk add nginx && apk add --upgrade nginx-mod-http-image-filter
#RUN apk add --update python3 py3-pip
#RUN apk add certbot
#COPY default.conf ./etc/nginx/http.d/default.conf
#RUN pip install certbot-nginx
CMD ["nginx", "-g", "daemon off;"]
