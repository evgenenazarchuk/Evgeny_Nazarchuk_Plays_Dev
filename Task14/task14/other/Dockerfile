FROM alpine:latest
LABEL maintainer="e.nazarchuk"
RUN apk update && apk upgrade && apk add nginx && apk add --upgrade nginx-mod-http-image-filter
RUN mkdir -p /opt/nginx/image
#RUN mkdir /opt/nginx
COPY image/ ./opt/nginx/image
COPY music/ ./opt/nginx   
COPY index.html ./opt/nginx     
#RUN echo "<h1>Hello nginx task1</h1>" > /opt/www/index.html
COPY default.conf ./etc/nginx/http.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
