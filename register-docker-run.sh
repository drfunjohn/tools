#!/usr/bin/env sh

gitlab-runner register \
--non-interactive \
--registration-token $TOKEN \
--url https://gitswarm.f5net.com/ \
--tag-list "docker-runner" \
--tls-ca-file /Users/sherbakov/Downloads/SE3CIPICA01.F5Net.com_F5_F5NET_Issuing_CA.crt \
--executor docker \
--env GIT_SSL_NO_VERIFY=true \
--docker-image alpine:latest \
--docker-volumes /etc/hosts:/etc/hosts \
--docker-volumes /var/run/docker.sock:/var/run/docker.sock \
--docker-volumes /Users/sherbakov/Downloads/SE3CIPICA01.F5Net.com_F5_F5NET_Issuing_CA.crt:/etc/gitlab-runner/certs/ca.crt
