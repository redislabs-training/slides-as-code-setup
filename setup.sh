#!/usr/bin/env bash

# Colours definition
HIGHLIGHT1='\033[0;34m'
HIGHLIGHT2='\033[0;33m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

printf "${HIGHLIGHT1}Let's get you started:${NC}\n"
echo "======================"

printf "${HIGHLIGHT1}What's your Github username?${NC}\n"
printf "${HIGHLIGHT1}>>>${NC}"
read GITHUB_USERNAME
echo "#!/usr/bin/env bash" > config.sh
echo "GITHUB_USERNAME=\"${GITHUB_USERNAME}\"" >> config.sh

printf "${HIGHLIGHT1}What's your Github token?${NC}\n"
printf "Check this link if you don't have one: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line\n"
printf "${HIGHLIGHT1}>>>${NC}"
read GITHUB_TOKEN
echo "GITHUB_TOKEN=\"${GITHUB_TOKEN}\"" >> config.sh

printf "${HIGHLIGHT1}What port should we serve your slidedeck on?${NC}\n"
echo "(Default is 4100)"
printf "${HIGHLIGHT1}>>>${NC}"
read PORT_NUMBER

if [ "$PORT_NUMBER" == "" ];
then
    PORT_NUMBER="4100"
fi
echo "PORT_NUMBER=\"${PORT_NUMBER}\"" >> config.sh

printf "${HIGHLIGHT1}Pulling docker image${NC}\n"
printf "${GRAY}\n"

docker login docker.pkg.github.com -u ${GITHUB_USERNAME} -p ${GITHUB_TOKEN} &> /dev/null

if docker pull docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.1; then
    ./rls-docker.sh init
    ./rls-docker.sh serve
    echo "=============="
    printf "${SUCCESS}Success! Now you can start editing the  ${HIGHLIGHT2}presentation.md${SUCCESS} file.${NC}\n\n"
else
    echo "=============="
    printf "${ERROR}Those credentials don't look right! We weren't able to log you in.${NC}\n\n"
fi

docker logout docker.pkg.github.com &> /dev/null

printf "${NC}"
