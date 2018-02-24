#!/bin/bash -x
ls -lthr
/opt/terraform/terraform init
/opt/terraform/terraform plan
/opt/terraform/terraform apply -auto-approve