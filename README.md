# Wrapper script for slides-as-code

This is a wrapper script over a dockerized version of the [slides-as-code](https://github.com/redislabs-training/slides-as-code-setup) project. We wrote a detailed post on [how to use it](https://redislabs.atlassian.net/wiki/spaces/TE/blog/2020/02/04/1001652723/How+to+set+up+Slides+as+Code+with+Docker).

## Requirements
The only requirement is to have Docker installed on your computer. Refer to the [Docker installation page](https://docs.docker.com/install/) for instructions on how to do it.

## Installation

> Note: This script assumes you have Docker installed on your computer. 

Choose a location to install the script (a good option would be `$HOME/opt`) then clone the repo and run the setup script.

```
cd $HOME/opt
git clone git@github.com:redislabs-training/slides-as-code-setup.git
cd slides-as-code-setup
./setup.sh
```
 
The setup script will pull a docker image and you'll be asked to input your Github username and an access token with `read:packages` permissions. This data will be stored in a `config.sh` file in your installation folder.

## Getting started
To create a new slide deck `cd` into a folder and run 
```
/path/to/rls.sh init
```
This will scaffold all the necessary files and create a `presentation.md` file. Now you can view the presentation in a browser by running

```
/path/to/rls.sh serve
```

Start editing your new presentation and look at the changes show up in the browser in real time. 




## Usage



### Quick Reference
```
./rls.sh init                       - Creates a default presentation.md file you can use as a starting point
./rls.sh serve [-p {PORT_NUMBER}]   - Serves the slidedeck in a browser
./rls.sh export                     - Exports the slidedeck as a standalone html file (no dependencies)
./rls.sh pdf                        - Exports the slidedeck as a pdf
```

### Initialise a presentation

#### Starting a new presentation
Create a folder for your presentation and run the init script:

```
mkdir {FOLDER_NAME}
cd {FOLDER_NAME}
/path/to/rls.sh init
```

This will set up a new presentation for you and create a `package.info` file, storing the version of the docker image needed to run it.  
A `.gitignore` file will be created for you as well, ignoring all template files, making sure you don't inflate your repository size unnecessarily. 

#### Setting up an existing presentation
Since template files are not meant to be committed in the repository, there has to be a way to "hydrate" your presentation after cloning so it works properly.
  
When a team member (or your future self) clones your presentation all they have to do (assuming they have slides-as-code installed) is run `/path/to/rls.sh init` and the template files will be puled, along with the correct version of the docker image (defined in the `package.info file). 

#### Updating a presentation (new template files)
To update to the latest version run `/path/to/rls.sh update`. 
This command will overwrite all template files and images, but will leave out your images and any custom styles you created in `template/custom.scss`.

To update to a specific version update the `package.info` file and run `/path/to/rls.sh init`. 

### Serve your presentation
You can edit the `presentation.md` with your changes and see the result in the browser. 

```
/path/to/rls.sh serve
```

This command will start a webserver listening on the default port `4100` and will watch the `presentation.md` file for your changes. Every time you save the file your browser tab will refresh and you will see your latest changes. 
If you want to run the server on a different port use the argument `-p {PORT_NUMBER}` like so:

```
/path/to/rls.sh serve -p {PORT_NUMBER}
```


### Export to a standalone html file

Running the bellow command will create a `dist` directory in which you will see a single `.html` file with all your assets and images inlined. Since it's a simple and standalone html file it can run on any platform, in any browser, giving you all the usual [Remark](https://github.com/gnab/remark) functions, like [presentation mode](https://github.com/gnab/remark/wiki/Presentation-mode), separate window (to put on another screen) and so on.

```
/path/to/rls.sh export
```

### Export to a pdf file

Running the bellow command will create a `pdf` directory in which you can find your pdf file. 

```
/path/to/rls.sh pdf
```

If you have multiple build steps on one slide you can instruct the exporter to put all of them in a single slide by using the `--handouts` or `-h` option: 
```
/path/to/rls.sh pdf --handouts
```


### Format
Slides are written in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), along with some useful **Remark.js** specific additions.
See the [Remark.js wiki](https://github.com/gnab/remark/wiki) for the specific syntax and helpers.


## Styling

The tool comes with its own set of predefined styles.

### Slide types

The RedisLabs style guide defines 4 main slide types: cover slide, separator slide, closing (ending) slide and an inner (content) slide.

- For the cover slide use the class `.cover`
- For the separator slides use the class `.separator`
- For the closing slide use the class `.end`

You can see an example usage of these styles in the presentation template created on `rls.sh init`.

### Grid system
You can use a "bootstrap-like" grid system to organise your slide in columns. Every horizontal row is divided in 12 columns. One column is represented by the class `.col-1`, two columns by `.col-2` and so on.

For example, to divide your slide in two columns, you'd use the following code:

```
.col-6[
  I will be shown on the left
]
.col-6[
  I will be shown on the right
]
```

If you want to have more than one row, you can use the `.row` class to group the different columns:

```
// First row with 2 columns
.row[
  .col-6[
    I will be shown on the left
  ]
  .col-6[
    I will be shown on the right
  ]
]

//Second row with 3 columns
.row[
  .col-3[
    I will be shown on the left
  ]
  .col-3[
    I will be shown in the middle
  ]  
  .col-3[
    I will be shown on the right
  ]
]
```

### Responsive images
To make an image responsive, just wrap it in a `.responsive` class:

```
.responsive[
  ![img/path](Image description)
]
```


### Positioning and Text
There are many predefined styles for positioning and text, please refer to the `main.scss` stylesheet in the `template` folder to see them all.

### Customize style

Just edit the `template/style.scss` file and make changes according to your needs.
The base theme already provides some helpful additions.

The stylesheet is written in [Sass](http://sass-lang.com), but you can use plain CSS instead if you feel like it, as long as you don't change the file extension.



## Presenting

We recommend exporting your presentation to a standalone html file with the `/path/to/rls.sh export` command and presenting from it. That way even if the internet connection happens to fail, your presentation will still work properly.

You can press `C` to create a separate tab that you can show on the projector screen. Then go back to the original slide and click `P` to show your presenter notes on your computer's screen. Use the arrows to navigate back and forward through the slides.  

There are a few more interesting options you can explore. Press `?` to see a menu listing all of them.