#!/bin/bash -x
cd terraform
ls -lthr
/opt/terraform/terraform init
/opt/terraform/terraform plan
/opt/terraform/terraform apply -auto-approve