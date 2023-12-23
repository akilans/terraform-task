#!/bin/bash
apt update
apt install apache2 -y
echo "Hello from - $(hostname)" > /var/www/html/index.html