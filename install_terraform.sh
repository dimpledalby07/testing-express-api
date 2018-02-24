#!/bin/bash -x
wget "https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip"
unzip terraform_0.11.3_linux_amd64.zip -d /opt/terraform
mv /opt/terraform/terraform /usr/bin/terraform