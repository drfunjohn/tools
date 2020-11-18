#!/usr/bin/env sh
echo "Please add credential of dev AWS environment (where registry is placed) by run command
aws configure
or define
AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
# AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... \
aws ecr get-login-password \
              --region us-east-1 \
          | docker login \
              --username AWS \
              --password-stdin 989481965862.dkr.ecr.us-east-1.amazonaws.com
cat ~/.docker/config.json | grep ecr
