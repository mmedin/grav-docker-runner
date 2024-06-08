# grav-docker-runner

A container to run Grav CMS avoiding local installation of Apache, PHP and other dependencies.

Pushed to Docker Hub: https://hub.docker.com/r/mmedin/grav-runner

## Intro

This image is intended to help with testing [Grav CMS](https://getgrav.org), a modern, crazy fast, ridiculously easy and amazingly powerful flat-file CMS.

The idea is that, by using this image, you can avoid the local installation of Apache, PHP, other tools and all the libraries needed to run Grav.

## Some of the components included

- Apache 2.x
- PHP 8.x
- git
- rsync
- zip
- libzip-dev
- libpng-dev
- libjpeg-dev
- zlib1g-dev
- php > gd
- php > opcache

## Usage example

According to the [official Grav documentation](https://learn.getgrav.org/17/basics/installation), one of the installation alternatives is based on cloning the official repository:

```bash
git clone -b master https://github.com/getgrav/grav.git
```

From this point on, you would be required to have the prerequisites installed (Apache, PHP, etc). This is where our image comes into play. We run the container so that we can use all the environment that comes inside it, but operating on the copy of Grav that we have in a local directory after the previous step:

```bash
cd grav
docker run -d --rm -v $(pwd):/var/www/html -p 80:80 --name grav mmedin/grav-runner:latest
```

> [!NOTE]
> What we just did? We launched a container and we mapped `-v` the current folder `$(pwd)` with the web server root folder inside the container. We also exposed the internal container port `-p` 80 to the host (our computer) and we gave the resultant container a name `--name`.

We now have a webserver with PHP interpreter running on our app, but before accessing the web user interface we have to finish preparing it. So we connect to the bash console of our brand new container:

```bash
docker exec -it grav bash
```

> [!TIP]
> Always give your containers a name with the `--name` parameter in the `docker run` command. It eases the subsequent mentions in the following commands, like above with the "grav" name.

Once inside the container's bash console, we can run the command suggested in the documentation to install plugins, themes and dependencies:

```bash
bin/grav install
```

Now we can access http://localhost to start using Grav.
