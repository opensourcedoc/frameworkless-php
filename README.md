# Frameworkless PHP

A "no framework" approach to PHP web development.

## System Requirements

### Back End

* Production
  * A major GNU/Linux distribution is recommended
  * PHP 7.3 or above
* Development
  * [Composer](https://getcomposer.org/)

### Front End

* Production
  * A [modern browser](https://browsehappy.com/) like Chrome or Firefox
* Development
  * Node.js 16.x or above
  * [Gulp](https://gulpjs.com/)
  * [Sass](https://sass-lang.com/)
  * [Autoprefixer](https://github.com/postcss/autoprefixer)
  * [stylelint](https://stylelint.io/)
  * [Babel](https://babeljs.io/)
  * [Flow](https://flow.org/en/)
  * [ESLint](https://eslint.org/)

### Install CLI Tools on Windows

```
> choco install php --version=7.4.23
> choco install composer
> choco install nodejs
> choco install rsync
> choco install sed
```

## Usage

Clone the repo locally:

```
$ git clone https://github.com/cwchentw/frameworkless-php.git myapp
$ cd myapp
```

Run your web app locally:

```
$ ./tools/bin/serve localhost:3000
```

To deploy your app to a PaaS, invoke this command:

```
$ ./tools/bin/publish
```

This command exposes all external files to *public* directory.

To deploy your app to an IaaS, invoke this command:

```
$ sudo ./tools/bin/sync-to /path/to/www
```

The root directory of your app is located in *www* directory.

## Copyright

Copyright (c) 2021 Michelle Chen. Licensed under MIT
