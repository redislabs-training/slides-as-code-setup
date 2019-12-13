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
    if docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 init; then
        printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Have fun!${NC}\n\n"
    else
        printf "${ERROR}Something went wrong. Did you run the setup script?${NC}\n\n"
    fi
    ;;
"serve")
    (sleep 2 && open http://localhost:${PORT_NUMBER}/presentation.html) & docker run --rm --init -p ${PORT_NUMBER}:${PORT_NUMBER} -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 serve -s -p ${PORT_NUMBER}
    ;;
"export")
    if docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 export --l false; then
        printf "${HIGHLIGHT1}You presentation was exported in the ${HIGHLIGHT2}dist${HIGHLIGHT1} folder${NC}\n\n"
    else
        printf "${ERROR}Something went wrong.${NC}\n\n"
    fi
    
    ;;
"pdf")
    docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 pdf
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