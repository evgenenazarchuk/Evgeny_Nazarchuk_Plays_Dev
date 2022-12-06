#!/bin/sh
certbot run -n --nginx --agree-tos -d nginxsrvdocker.duckdns.org  -m  e.nazarchuk96@gmail.com  --redirect
