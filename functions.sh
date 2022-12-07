write_config_file() {
    echo "#!/usr/bin/env bash" > config.sh
    echo "GITHUB_USERNAME=\"${GITHUB_USERNAME}\"" >> config.sh
    echo "GITHUB_TOKEN=\"${GITHUB_TOKEN}\"" >> config.sh
    echo "DEFAULT_DOCKER_VERSION=\"${DEFAULT_DOCKER_VERSION}\"" >> config.sh

    printf "${HIGHLIGHT1}Configuration saved in config.sh ${NC}\n\n"
}

get_latest_version() {
    LATEST_DOCKER_VERSION=`curl -u ${GITHUB_USERNAME}:${GITHUB_TOKEN} https://raw.githubusercontent.com/redislabs-training/slides-as-code/master/version`
}

docker_login() {
    docker login docker.pkg.github.com -u ${GITHUB_USERNAME} -p ${GITHUB_TOKEN} &> /dev/null
}

docker_pull() {
    docker pull docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DEFAULT_DOCKER_VERSION}
}

docker_logout() {
    docker logout docker.pkg.github.com &> /dev/null
}

rls_init() {
    docker run --rm -d -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} init
}

rls_serve() {
    docker run --rm --init -p ${PORT_NUMBER}:${PORT_NUMBER} -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} serve /src -s -p ${PORT_NUMBER}
}

rls_export() {
    docker run --rm -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} export --l false
}

rls_export_sync_tmp() {
    docker run --rm -v $PWD:/src docker.pkg.github.com/redislabs-training/slides-as-code/slides-as-code:${DOCKER_VERSION} export --l false -o .tmp $2
}

rls_pdf() {
    docker run --rm -t -v $PWD:/slides ghcr.io/astefanutti/decktape:3.5 --page-load-timeout 60000 /slides/.tmp/presentation.html /slides/dist/presentation.pdf
}