#!/usr/bin/env bash

RLS_EXEC=$0
RLS_DIR=`dirname $0`
source $RLS_DIR/config.sh
source $RLS_DIR/functions.sh
source $RLS_DIR/colours.sh
source package.info

# If there is no version specified in package.info - use latest
if [[ $DOCKER_VERSION == "" ]]; then
    get_latest_version
    DOCKER_VERSION=${LATEST_DOCKER_VERSION}
fi

if [[ $2 = "-p" ]]; then
    PORT_NUMBER=${3}
else
    PORT_NUMBER="4100"
fi

printf "Using docker image version ${SUCCESS} ${DOCKER_VERSION} ${NC}\n\n"

docker_login

case "$1" in
"init")
    if rls_init ; then
        printf "${HIGHLIGHT1}You presentation ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} was initialised successfully. Serve it by running ./rls.sh serve and Have fun!${NC}\n\n"

        # Save the docker version this presentation uses in package.info
        echo "#!/usr/bin/env bash" > package.info
        echo "DOCKER_VERSION=\"${DOCKER_VERSION}\"" >> package.info

    else
        printf "${ERROR}Something went wrong. Did you run the setup script?${NC}\n\n"
    fi
    ;;
"serve")
    sleep 4 && open http://localhost:${PORT_NUMBER}/presentation.html & rls_serve
    ;;
"export")
    if rls_export ; then
        printf "${HIGHLIGHT1}You presentation was exported in the ${HIGHLIGHT2}dist${HIGHLIGHT1} folder${NC}\n\n"
    else
        printf "${ERROR}Something went wrong.${NC}\n\n"
    fi
    ;;
"pdf")
    [[ ! -d dist ]] && mkdir dist  # If directory "dist" doesn't exist - create it
    rls_export_sync_tmp # Export the html with all assets inlined, used as input for the pdf export
    rls_pdf
    rm "${PWD}/.tmp/presentation.html"

    printf "${HIGHLIGHT1}You presentation was exported in the ${HIGHLIGHT2}dist${HIGHLIGHT1} folder${NC}\n\n"
    ;;
"update")
    CURRENT_VERSION=$DOCKER_VERSION
    get_latest_version
    DOCKER_VERSION=${LATEST_DOCKER_VERSION}
    
    # Update package.info with the docker version this presentation is being updated to
    echo "#!/usr/bin/env bash" > package.info
    echo "DOCKER_VERSION=\"${LATEST_DOCKER_VERSION}\"" >> package.info
    printf "Updated to docker image version ${SUCCESS} ${LATEST_DOCKER_VERSION} ${NC}\n\n"

    # Update logos to the new template. Only needs to be done for pre 1.1.18 version when they were introduced.
    if [[ $CURRENT_VERSION < "1.1.18" ]]; then
        cp presentation.md presentation.md-bak
        sed -i '' 's/img\/logo\.jpg/img\/logo_dark_text\.png/g' presentation.md
        sed -i '' 's/img\/logo_dark_text.jpg/img\/logo_dark_text.png/g' presentation.md
        printf "Updated some logo images to match new slide template. Just in case it broke something, there is a backup: presentation.md-bak.\n\n"
    fi
    
    rls_init
    ;;    
*) 
    printf "${HIGHLIGHT2}"
    printf "\nUse one of the following arguments:\n"
    printf "\t${HIGHLIGHT2}init${HIGHLIGHT1}        - Creates a default ${HIGHLIGHT2}presentation.md${HIGHLIGHT1} file you can use as a starting point\n"
    printf "\t${HIGHLIGHT2}serve${HIGHLIGHT1}       - Serves the slide deck in a browser\n"
    printf "\t${HIGHLIGHT2}export${HIGHLIGHT1}      - Exports the slide deck as a standalone html file (no dependencies)\n"
    printf "\t${HIGHLIGHT2}pdf${HIGHLIGHT1}         - Exports the slide deck as a pdf\n"
    printf "\t${HIGHLIGHT2}update${HIGHLIGHT1}      - Updates an existing presentation to the latest version"
    printf "${NC}"
    ;;
esac