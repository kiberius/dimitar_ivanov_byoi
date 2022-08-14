#! /bin/bash
yum update -y
aws s3 cp s3://tfstate-bucket-dimitarivanov-sandbox/asg-key.pem ~/app-key/asg-key.pem