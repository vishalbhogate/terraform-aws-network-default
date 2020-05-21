#!/bin/sh
echo "running terraform format"
terraform fmt

echo "running terraform initilization"
terraform init

echo "running terraform validate"
terraform validate


