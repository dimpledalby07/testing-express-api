#!/bin/bash -x
cd /opt/terraform
ls -lthr
./terraform plan
./terraform apply