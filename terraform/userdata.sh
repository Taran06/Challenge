#!/bin/bash
sudo yum install -y nginx
mkdir /etc/systemd/system/nginx.service.d
printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf
systemctl daemon-reload
systemctl restart nginx
systemctl status nginx
echo "<html>" > /usr/share/nginx/html/index.html
echo "<head>" >> /usr/share/nginx/html/index.html
echo "  <title>Hello World</title>" >> /usr/share/nginx/html/index.html
echo "</head>" > /usr/share/nginx/html/index.html
echo "<body>" > /usr/share/nginx/html/index.html
echo "  <h1>Hello World!</h1>" >> /usr/share/nginx/html/index.html
echo "</body>" >> /usr/share/nginx/html/index.html
echo "</html>" >> /usr/share/nginx/html/index.html
systemctl restart nginx
