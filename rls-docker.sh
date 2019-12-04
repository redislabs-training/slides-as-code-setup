#!/usr/bin/env bash
source config.sh
source colours.sh

if [ "$1" == "" ]
then
    printf "${HIGHLIGHT2}"
    printf "Use one of the following arguments:\n"
    printf "\t${HIGHLIGHT2}init${HIGHLIGHT1}        - Creates a default ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} file you can use as a starting point\n"
    printf "\t${HIGHLIGHT2}serve${HIGHLIGHT1}       - Serves the slidedeck in a browser\n"
    printf "\t${HIGHLIGHT2}export${HIGHLIGHT1}      - Exports the slidedeck as a standalone html file (no dependencies)\n"
    printf "\t${HIGHLIGHT2}pdf${HIGHLIGHT1}         - Exports the slidedeck as a pdf\n"
    printf "${NC}"
    exit
fi


case "$1" in
"init")
    docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 init &>/dev/null
    printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Have fun!${NC}\n\n"
    ;;
"serve")
    # open http://localhost:${PORT_NUMBER}
    (sleep 2 && open http://localhost:${PORT_NUMBER}/presentation.html) & docker run --rm --init -p ${PORT_NUMBER}:${PORT_NUMBER} -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 serve -s -p ${PORT_NUMBER}
    ;;
"export")
    docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/rl-slides-as-code:1.0.0 export --l false
    ;;
"pdf")
    printf "TODO"
    ;;
esac