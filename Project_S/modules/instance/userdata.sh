#!/bin/bash

# Update packages
yum update -y

# Install Apache and mod_ssl
yum install -y httpd mod_ssl

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Restart Apache
systemctl restart httpd
