# tutum-deploy
[![foliea/tutum-deploy](http://dockeri.co/image/foliea/tutum-deploy)](https://registry.hub.docker.com/u/foliea/tutum-deploy/)

This repository contains `Dockerfile` of `tutum-deploy` for docker's automated build
published to the public docker hub registry.

Create, update and deploy a stack on [tutum](https://www.tutum.co/).

This image renders a stack configuration file from a given
[mustache](https://mustache.github.io/) template and a YAML file corresponding
to the environment build to deploy.

## Base Docker Image

* [Ruby](https://registry.hub.docker.com/u/library/ruby/)

## Sources

* [GitHub](https://github.com/foliea/tutum-deploy)

## Installation

1. Install [docker](http://www.docker.com).

2. Download [automated build](https://registry.hub.docker.com/u/foliea/tutum-deploy)
from public [docker hub registry](https://registry.hub.docker.com/):

    `docker pull foliea/tutum-deploy`

## Usage

### Configuration files directory

You need to run this image with a volume container with some configuration files
organized like this:

```
/config
|
 -- /vars
|   |
|    - /myproject
|      |
|       -- staging.yml
|      |
|       -- production.yml
|
 -- /templates
    |
     -- myproject.yml
```

### Template specifications

In this case we are building a project called `myproject` in `staging`.

1. Template

`/config/templates/myproject.yml`:

```
redis:
  image: redis:{{config.redis.version}}
  expose:
    - '6379'
  volumes:
    - '/redis:/data'
  tags:
    - {{config.project}}
    - {{config.build_env}}
```

2. Vars file

```
redis:
  version: 2.8.9
```

3. Built configuration file:

```
redis:
  image: redis:2.8.9
  expose:
    - '6379'
  volumes:
    - '/redis:/data'
  tags:
    - myproject
    - staging
```

> N.B. For convenience, project and build environment variables are
available as configuration variables. You don't need to add them in
any of your vars files.

### Deploy

Run a container with your config directory mounted as a volume:

    docker run -e TUTUM_USER=user \
           -e TUTUM_APIKEY=apikey \
           -e BUILD_ENV=staging \
           -e PROJECT=myproject \
           -v $(pwd)/config:/config \
           -t foliea/tutum-deploy

### Environment variables

* `TUTUM_USER`: Tutum username.
* `TUTUM_APIKEY`: Tutum API key.
* `BUILD_ENV`: Build environment, should match your vars file.
* `PROJECT: Project name, should match both your template file name and
your vars directory.
* `STACK`: Optional stack name (default: `$PROJECT-$BUILD_ENV`)
