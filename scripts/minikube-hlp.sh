#!/usr/bin/env sh

function podman-start(){
    if [ "$1" = "update" ] && [ $(podman machine list -q) ]; then
        podman machine rm --force
        podman machine init --cpus 4 --disk-size 20 --memory 2048
    fi
    podman machine start
}

function podman-stop(){
    podman machine stop
}

function minikube-start-podman(){
    if [ "$1" = "update" ]; then 
        host_status=$(minikube status -f='{{.Host}}')
        [ "$host_status" = "Running" ] && minikube delete
        minikube config set rootless true
    fi
    minikube start --driver=podman --container-runtime=containerd
}

function minikube-start(){
    if [ "$1" = "update" ]; then 
        host_status=$(minikube status -f='{{.Host}}')
        [ "$host_status" = "Running" ] && minikube delete
        minikube config unset rootless
        minikube config unset driver 
        minikube config unset container-runtime 
    fi
    minikube start
}

function minikube-stop(){
    host_status=$(minikube status -f='{{.Host}}')
    [ "$host_status" = "Running" ] && minikube delete
}

