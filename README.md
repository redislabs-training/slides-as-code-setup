# Wrapper script for slides-as-code

This is a wrapper script over a dockerized version of the [slides-as-code](github.com/redislabs-training/slides-as-code) project.

## Requirements
The only requirement is to have Docker installed on your computer. Refer to the [Docker installation page](https://docs.docker.com/install/) for instructions on how to do it.

## Getting started

1. Clone the repo
    ```bash
    git clone git@github.com:redislabs-training/slides-as-code-setup.git
    ```

2. CD into the folder and run the setup script that will set some configuration variables for you and pull the Docker image
    ```bash
    cd slides-as-code-setup
    ./setup.sh
    ```

3. Initialise your presentation
    ```bash
    ./rls-docker init
    ```
4. You're ready to start working on your slides by editing the `presentation.md` file. To see your results in a browser run the following command:
    ```bash
    ./rls-docker serve
    ```
 

## Usage
### Quick Reference
```
init        - Creates a default presentation.md file 
              you can use as a starting point
serve       - Serves the slidedeck in a browser
export      - Exports the slidedeck as a standalone html 
              file (no dependencies)
pdf         - Exports the slidedeck as a pdf
```
### Initialise a presentation
After you clone the repo you need to initialise a presentation from the default template by running

```
./rls-docker.sh init
``` 

### Serve your presentation
You can edit the `presentation.md` with your changes and see the result in the browser. 

```
./rls-docker serve
```

This command will start a webserver and will watch the `presentation.md` file for your changes. Every time you save the file your browser tab will refresh and you will see your latest changes.

### Export to a standalone html file

Running the bellow command will create a `dist` directory in which you will see a single `html` file with all your assets and images inlined. Since it's a simple and standalone html file it can run on any platform, in any browser, giving you all the usual [Remark](https://github.com/gnab/remark) functions, like [presentation mode](https://github.com/gnab/remark/wiki/Presentation-mode), separate window (to put on another screen) and so on.

```
./rls-docker export
```

### Export to a pdf file
To Do