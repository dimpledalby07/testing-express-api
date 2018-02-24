#!/bin/bash -x
cd /opt/terraform
ls -lthr
./terraform init
./terraform plan
./terraform apply