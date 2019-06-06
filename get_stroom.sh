#!/usr/bin/env bash

# Exit the script on any error
set -e

#Shell Colour constants for use in 'echo -e'
#RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
#LGREY='\e[37m'
#DGREY='\e[90m'
NC='\033[0m' # No Colour

main() {
    # stack_version will be hard coded by TravisCI at build time
    local -r stack_name="stroom_core"
    local -r stack_tag="stroom_core-v6.0-beta.21"
    local -r stack_version="v6.0-beta.21"
    local -r install_dir="./${stack_name}/${stack_tag}"
    local -r url="https://github.com/gchq/stroom-resources/releases/download/${stack_tag}/${stack_tag}.tar.gz"

    if [ "$(find . -name "stroom_*" | wc -l)" -gt 0 ] || [ -d ./volumes ]; then
        echo -e "${YELLOW}WARNING${GREEN}: It looks like you already have an existing stack installed.${NC}"
        echo -e "${GREEN}If you proceed, your configuration will be replaced/updated but data will be left as is.${NC}"
        echo -e "${GREEN}If the existing stack is running, you should stop it first${NC}"
        echo
    fi

    echo
    echo -e "${GREEN}This script will download the Stroom stack ${BLUE}${stack_version}${NC}"
    echo -e "${GREEN}into the current directory.${NC}"

    echo
    read -rsp $'Press "y" to continue, any other key to cancel.\n' -n1 keyPressed

    if [ "${keyPressed}" = 'y' ] || [ "${keyPressed}" = 'Y' ]; then
        echo
    else
        echo
        echo "Exiting"
        exit 0
    fi

    echo
    echo -e "${GREEN}Downloading and unpacking stack ${BLUE}${url}${NC}"

    # Download the stack archive file and extract it
    curl --silent --location "${url}" | tar xz 

    echo
    echo -e "${GREEN}Start Stroom using ${BLUE}start.sh${GREEN} in ${BLUE}${install_dir}${NC}"
    echo -e "${GREEN}or read the ${BLUE}README.md${GREEN} file.${NC}"
    echo
}

main 
