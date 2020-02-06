# Wrapper script for slides-as-code

This is a wrapper script over a dockerized version of the [slides-as-code](https://github.com/redislabs-training/slides-as-code-setup) project.

## Requirements
The only requirement is to have Docker installed on your computer. Refer to the [Docker installation page](https://docs.docker.com/install/) for instructions on how to do it.

## Getting started

Clone the repo and run the setup script.

```
git clone https://github.com/redislabs-training/slides-as-code-setup.git
cd slides-as-code-setup
./setup.sh
```
 

## Usage
### Quick Reference
```
./rls.sh init        - Creates a default presentation.md file 
              you can use as a starting point
./rls.sh serve       - Serves the slidedeck in a browser
./rls.sh export      - Exports the slidedeck as a standalone html 
              file (no dependencies)
./rls.sh pdf         - Exports the slidedeck as a pdf
```

### Initialise a presentation
After you clone the repo you need to set up a few configuration variables and initialise a presentation from the default template by running

```
./setup.sh
``` 

### Serve your presentation
You can edit the `presentation.md` with your changes and see the result in the browser. 

```
./rls.sh serve
```

This command will start a webserver and will watch the `presentation.md` file for your changes. Every time you save the file your browser tab will refresh and you will see your latest changes.

### Export to a standalone html file

Running the bellow command will create a `dist` directory in which you will see a single `html` file with all your assets and images inlined. Since it's a simple and standalone html file it can run on any platform, in any browser, giving you all the usual [Remark](https://github.com/gnab/remark) functions, like [presentation mode](https://github.com/gnab/remark/wiki/Presentation-mode), separate window (to put on another screen) and so on.

```
./rls.sh export
```

### Export to a pdf file
Running the bellow command will create a `pdf` directory in which you can find your pdf file. 

```
./rls.sh pdf
```

If you have multiple build steps on one slide you can instruct the exporter to put all of them in a single slide by using the `--handouts` option: 
```
./rls.sh pdf --handouts
```

>Note: Currently pdf export doesn't work with the Docker installation. It should be fixed soon.

### Format
Slides are written in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), along with some useful **Remark.js** specific additions.
See the [Remark.js wiki](https://github.com/gnab/remark/wiki) for the specific syntax and helpers.


## Styling

The tool comes with its own set of predefined styles.

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
There are many predefined styles for positioning and text, please refer to the stylesheets in the `template` folder to see them all.

### Customize style

Just edit the `template/style.scss` file and make changes according to your needs.
The base theme already provides some helpful additions.

The stylesheet is written in [Sass](http://sass-lang.com), but you can use plain CSS instead if you feel like it, as long as you don't change the file extension.