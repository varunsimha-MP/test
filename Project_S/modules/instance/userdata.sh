#!/bin/bash

# Update packages
apt update

apt upgrade -y

# Install Apache and mod_ssl
yum install -y apache2

# Start and enable Apache
systemctl start apache2
systemctl enable apache2

# Restart Apache
systemctl restart apache2