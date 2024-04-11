# Frameworkless PHP

A "no framework" approach to PHP web development.

## System Requirements

### Back End

* Production
  * A major GNU/Linux distribution is recommended
  * [PHP](https://www.php.net/) 8.1 or above
* Development
  * [Composer](https://getcomposer.org/)

### Front End

* Production
  * A [modern browser](https://browsehappy.com/) like Chrome or Firefox
* Development
  * [Node.js](https://nodejs.org/) 18.x or above
  * [Gulp](https://gulpjs.com/)
  * [Sass](https://sass-lang.com/)
  * [Autoprefixer](https://github.com/postcss/autoprefixer)
  * [stylelint](https://stylelint.io/)
  * [Babel](https://babeljs.io/)
  * [Flow](https://flow.org/en/)
  * [ESLint](https://eslint.org/)

### Install CLI Tools on Windows

```shell
> choco install php --version=8.1.21
> choco install composer
> choco install nodejs --version=18.16.1
> choco install rsync
> choco install sed
```

## Usage

Clone the repo locally:

```shell
$ git clone https://github.com/cwchentw/frameworkless-php.git myapp
$ cd myapp
```

Run your web app locally:

```shell
$ ./tools/bin/serve localhost:5000
```

To deploy your app to a PaaS, invoke this command:

```shell
$ ./tools/bin/publish
```

This command exposes all external files to *public* directory.

To deploy your app to an IaaS, invoke this command:

```shell
$ sudo ./tools/bin/sync-to /path/to/www
```

The root directory of your app is located in *www* directory.

## Copyright

Copyright (c) 2021-2023 OpenTechTutorials. Licensed under MIT
