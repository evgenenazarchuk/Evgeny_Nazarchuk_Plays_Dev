FROM alpine:latest
LABEL maintainer="e.nazarchuk"
RUN apk update && apk upgrade && apk add nginx && apk add --upgrade nginx-mod-http-image-filter
#RUN apk add --update python3 py3-pip
#RUN apk add certbot
RUN mkdir -p /opt/nginx/image
COPY image/ ./opt/nginx/image
COPY music/ ./opt/nginx   
COPY index.html ./opt/nginx     
COPY default.conf ./etc/nginx/http.d/default.conf
#RUN pip install certbot-nginx
#ADD ./certbot.sh .
#RUN chmod +x certbot.sh
#RUN ./certbot.sh
COPY letsencrypt/ ./opt/nginx/letsencrypt
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"] 

