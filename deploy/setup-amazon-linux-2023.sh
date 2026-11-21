#!/bin/bash
# Run on an Amazon Linux 2023 EC2 instance.
# Review commands before running. This installs Java 21 and Apache HTTP Server.
set -euo pipefail

sudo dnf update -y
sudo dnf install -y java-21-amazon-corretto-headless httpd mod_proxy_html

sudo systemctl enable httpd
sudo systemctl start httpd

echo "Java and Apache installation completed."
echo "Next: copy the JAR, systemd service, and Apache config using README instructions."
