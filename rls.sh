#!/usr/bin/env bash
source config.sh

# Colours definition
HIGHLIGHT1='\033[0;34m'
HIGHLIGHT2='\033[0;33m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# if [ "$1" == "" ]
# then
#     printf "${HIGHLIGHT2}"
#     printf "Use one of the following arguments:\n"
#     printf "\t${HIGHLIGHT2}init${HIGHLIGHT1}        - Creates a default ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} file you can use as a starting point\n"
#     printf "\t${HIGHLIGHT2}serve${HIGHLIGHT1}       - Serves the slidedeck in a browser\n"
#     printf "\t${HIGHLIGHT2}export${HIGHLIGHT1}      - Exports the slidedeck as a standalone html file (no dependencies)\n"
#     printf "\t${HIGHLIGHT2}pdf${HIGHLIGHT1}         - Exports the slidedeck as a pdf\n"
#     printf "${NC}"
#     exit
# fi

case "$1" in
"init")
    if [ "$INSTALLATION_TYPE" = "npm" ]; then
    rls init
    printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Serve it by running ./rls.sh serve and Have fun!${NC}\n\n"
    exit
    fi

    if docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.4 init; then
        printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Serve it by running ./rls.sh serve and Have fun!${NC}\n\n"
    else
        printf "${ERROR}Something went wrong. Did you run the setup script?${NC}\n\n"
    fi
    ;;
"serve")
    if [ "$INSTALLATION_TYPE" = "npm" ]; then
    rls serve -p ${PORT_NUMBER}
    exit
    fi

    (sleep 2 && open http://localhost:${PORT_NUMBER}/presentation.html) & docker run --rm --init -p ${PORT_NUMBER}:${PORT_NUMBER} -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.4 serve -s -p ${PORT_NUMBER}
    ;;
"export")
    if [ "$INSTALLATION_TYPE" = "npm" ]; then
    rls export --l false
    exit
    fi


    if docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.4 export --l false; then
        printf "${HIGHLIGHT1}You presentation was exported in the ${HIGHLIGHT2}dist${HIGHLIGHT1} folder${NC}\n\n"
    else
        printf "${ERROR}Something went wrong.${NC}\n\n"
    fi
    
    ;;
"pdf")
    if [ "$INSTALLATION_TYPE" = "npm" ]; then
    rls pdf $2
    exit
    fi

    docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.4 pdf
    # printf "TODO"
    ;;
*) 
    printf "${HIGHLIGHT2}"
    printf "\nUse one of the following arguments:\n"
    printf "\t${HIGHLIGHT2}init${HIGHLIGHT1}        - Creates a default ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} file you can use as a starting point\n"
    printf "\t${HIGHLIGHT2}serve${HIGHLIGHT1}       - Serves the slidedeck in a browser\n"
    printf "\t${HIGHLIGHT2}export${HIGHLIGHT1}      - Exports the slidedeck as a standalone html file (no dependencies)\n"
    printf "\t${HIGHLIGHT2}pdf${HIGHLIGHT1}         - Exports the slidedeck as a pdf\n"
    printf "${NC}"
    ;;    
esac