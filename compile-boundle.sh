#!/usr/bin/env sh

# REQUIRE!!!: personal access credential to GIT repo in env variables
# ${AZURE_GIT_USERNAME}
# ${AZURE_GIT_PASSWORD}

# Compile image:
image=waf-on-envoy/offline-compiler:dev
compile_w_global_state="/opt/app_protect/bin/apcompile --nodefaults -g /tmp/globalsettings.json"

# GIT REPO
organization=${ORGANIZATION:-gmessalem}
projectname=${PROJECTNAME:-Matrix}
reponame=${REPONAME:-Matrix}
globalsettings=${GLOBALSETTINGS:-/test/globalstates/globalsettings.json}
globalsettings_name=$(basename ${globalsettings})

resource_file=$1
resource_type=$2 # policy, logging-profile
SET_RED='\033[0;31m'
SET_GREEN='\033[0;32m'
R_C='\033[0m' # No Color

function use() {
  echo "\n==================================================================="
  echo "Use:"
  echo "compile resource with predefined global settings file:"
  echo "    git:/test/globastates/globalsettings.json"
  echo
  echo "$(basename $0) <file.json> <type>"
  echo "Arguments:"
  echo "   - source_file.json:    path to policy or logging profile json file"
  echo "   - type:                type of resource: [policy|logging-profile]"
  echo "Result: file.tgz - boundle with the same name as source file"
  echo
  echo "example:"
  echo "   > $(basename $0) test/my-dir/simple-policy.json policy"
  echo "==================================================================="
}

use

# Compile image:
image=waf-on-envoy/offline-compiler:dev
compile_w_global_state="/opt/app_protect/bin/apcompile --nodefaults -g /tmp/globalsettings.json"

# Construct the download URL
url="https://dev.azure.com/$organization/$projectname/_apis/git/repositories/$reponame/items?path=${globalsettings}&download=true&api-version=5.0"
echo "\n==== Download Global Settings by next URL:"
echo "$url"
curl -u ${AZURE_GIT_USERNAME}:${AZURE_GIT_PASSWORD} "${url}" -o $(basename ${globalsettings})
echo "==================================================================="
cat ${globalsettings_name} | jq
echo "==================================================================="
if [ $? -ne 0 ]; then
  echo "\nDownload ${globalsettings} ${SET_RED}FAILED!${R_C}"
  exit 1
fi

cp ${resource_file} .
file_name=$(basename ${resource_file})
boundle_name=${file_name%.*}.tgz
boundle_path=${resource_file%/*}/${boundle_name}
echo "\n==== Compile ${resource_file}"
docker run --rm -v ${PWD}:/tmp ${image} ${compile_w_global_state} \
  --${resource_type} /tmp/${file_name} -o /tmp/${boundle_name}

if [ $? -ne 0 ]; then
  echo "\nCompile ${resource_type} ${resource_file} ${SET_RED}FAILED!${R_C}"
  exit 1
fi

echo
echo "\n==== Clean temp files"
rm ${globalsettings_name}
if [ "${resource_file%/*}" != "${PWD}" ]; then
  rm ${file_name}
fi
if [ -f ${boundle_name} ]; then
  mv ${boundle_name} ${boundle_path}
  echo "\n==== File ${boundle_path} created"
else
  echo "\nCreate file ${boundle_name} is ${SET_RED}FAILED!${R_C}"
  exit 1
fi
