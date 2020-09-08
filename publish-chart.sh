#!/bin/bash
# upgrade installed helm by using localy 
# "make helm" and  "helm upgrade"
exec 5>&1
SEPARATOR="--------------------------------------------------------------------------------"
version=$(git tag --sort=-committerdate | head -n 1)
version=${version:1}
echo "$SEPARATOR" 
echo "1. Create helm version $version"
REGEXP="Successfully packaged chart.*:[[:space:]](dist/(.*)-$version.tgz)"
result=$(make helm VERSION=$version | tee >(cat - >&5) | tail -1)
[[ $result =~ $REGEXP ]] 
chart="${BASH_REMATCH[1]}"
release="${BASH_REMATCH[2]}"
echo "$SEPARATOR" 
if [ -n "$chart" ]; then 
    echo "2. Starting upgrade deployment with $chart"
    helm upgrade $release $chart 
else
    echo "2. Creating chart is failed so helm is not upgraded: ${result}"
fi
