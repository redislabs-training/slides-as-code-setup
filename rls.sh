#!/usr/bin/env bash

RLS_EXEC=$0
RLS_DIR=`dirname $0`
source $RLS_DIR/config.sh
source package.info

# Colours definition
HIGHLIGHT1='\033[0;34m'
HIGHLIGHT2='\033[0;33m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color


if [ "$DOCKER_VERSION" == "" ]; then
    DOCKER_VERSION=${DEFAULT_DOCKER_VERSION}
fi
PORT_NUMBER="4101"

printf "Using docker image version ${SUCCESS} ${DOCKER_VERSION} ${NC}\n\n"

CMD_LOGIN="docker login docker.pkg.github.com -u ${GITHUB_USERNAME} -p ${GITHUB_TOKEN}"
CMD_INIT="docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} init"
CMD_SERVE="docker run --rm --init -p ${PORT_NUMBER}:${PORT_NUMBER} -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} serve -s -p ${PORT_NUMBER}"
CMD_EXPORT="docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} export --l false"
CMD_PDF="docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} pdf"



case "$1" in
"init")
    if ( eval ${CMD_INIT} ) || ( eval ${CMD_LOGIN} && eval ${CMD_INIT} ); then
        printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Serve it by running ./rls.sh serve and Have fun!${NC}\n\n"

#        Set the docker version this presentation uses
        echo "#!/usr/bin/env bash" > package.info
        echo "DOCKER_VERSION=\"${DOCKER_VERSION}\"" >> package.info

    else
        printf "${ERROR}Something went wrong. Did you run the setup script?${NC}\n\n"
    fi
    ;;
"serve")
    #CONTINUE HERE  ---->
    sleep 4 && open http://localhost:${PORT_NUMBER}/presentation.html &
    eval ${CMD_SERVE}  ||  ( eval ${CMD_LOGIN} && eval ${CMD_SERVE} )
    ;;
"export")
    if eval ${CMD_EXPORT}; then
        printf "${HIGHLIGHT1}You presentation was exported in the ${HIGHLIGHT2}dist${HIGHLIGHT1} folder${NC}\n\n"
    else
        printf "${ERROR}Something went wrong.${NC}\n\n"
    fi
    
    ;;
"pdf")
#    eval ${CMD_PDF};
    printf "The PDF export feature is currently WIP with Docker."
    ;;
*) 
    printf "${HIGHLIGHT2}"
    printf "\nUse one of the following arguments:\n"
    printf "\t${HIGHLIGHT2}init${HIGHLIGHT1}        - Creates a default ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} file you can use as a starting point\n"
    printf "\t${HIGHLIGHT2}serve${HIGHLIGHT1}       - Serves the slide deck in a browser\n"
    printf "\t${HIGHLIGHT2}export${HIGHLIGHT1}      - Exports the slide deck as a standalone html file (no dependencies)\n"
    printf "\t${HIGHLIGHT2}pdf${HIGHLIGHT1}         - Exports the slide deck as a pdf\n"
    printf "${NC}"
    ;;
esac
