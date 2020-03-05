#!/usr/bin/env bash
RLS_DIR=`dirname $0`
source $RLS_DIR/functions.sh
source $RLS_DIR/colours.sh


printf "${HIGHLIGHT1}Let's get you started:${NC}\n"
echo "======================"


printf "${HIGHLIGHT1}What's your Github username?${NC}\n"
printf "${HIGHLIGHT2}>>>${NC}"
read GITHUB_USERNAME


printf "${HIGHLIGHT1}What's your Github token (needs 'read:packages' permissions )?${NC}\n"
printf "Check this link if you don't have one: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line\n"
printf "${HIGHLIGHT2}>>>${NC}"
read GITHUB_TOKEN


get_latest_version
DEFAULT_DOCKER_VERSION=$LATEST_DOCKER_VERSION

# Write the configuration details (github username, token and latest version)
# to a the `config.sh` file
write_config_file


printf "${HIGHLIGHT1}Pulling docker image${NC}\n"
printf "${GRAY}\n"

docker_login

if docker_pull; then
    echo "=============="
    printf "${SUCCESS}Success! Now you can ${HIGHLIGHT2}initialise${SUCCESS} your presentation by running ${HIGHLIGHT2}./rls.sh init${SUCCESS} ${NC}\n\n"
else
    echo "=============="
    printf "${ERROR}Those credentials don't look right! We weren't able to log you in.${NC}\n\n"
fi

docker_logout

printf "${NC}"