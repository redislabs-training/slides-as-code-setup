#!/usr/bin/env bash

DEFAULT_DOCKER_VERSION="1.1.2"


# Colours definition
HIGHLIGHT1='\033[0;34m'
HIGHLIGHT2='\033[0;33m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo "#!/usr/bin/env bash" > config.sh
echo "DEFAULT_DOCKER_VERSION=\"${DEFAULT_DOCKER_VERSION}\"" >> config.sh

printf "${HIGHLIGHT1}Let's get you started:${NC}\n"
echo "======================"

printf "${HIGHLIGHT1}What's your Github username?${NC}\n"
printf "${HIGHLIGHT2}>>>${NC}"
read GITHUB_USERNAME
echo "GITHUB_USERNAME=\"${GITHUB_USERNAME}\"" >> config.sh

printf "${HIGHLIGHT1}What's your Github token (needs 'read:packages' permissions )?${NC}\n"
printf "Check this link if you don't have one: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line\n"
printf "${HIGHLIGHT2}>>>${NC}"
read GITHUB_TOKEN
echo "GITHUB_TOKEN=\"${GITHUB_TOKEN}\"" >> config.sh

printf "${HIGHLIGHT1}Pulling docker image${NC}\n"
printf "${GRAY}\n"

docker login docker.pkg.github.com -u ${GITHUB_USERNAME} -p ${GITHUB_TOKEN} &> /dev/null

if docker pull docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DEFAULT_DOCKER_VERSION}; then
    echo "=============="
    printf "${SUCCESS}Success! Now you can ${HIGHLIGHT2}initialise${SUCCESS} your presentation by running ${HIGHLIGHT2}./rls.sh init${SUCCESS} ${NC}\n\n"
else
    echo "=============="
    printf "${ERROR}Those credentials don't look right! We weren't able to log you in.${NC}\n\n"
fi

docker logout docker.pkg.github.com &> /dev/null

printf "${NC}"