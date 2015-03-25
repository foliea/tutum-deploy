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

## Templates

### Configuration files directory

You need to run this image with a volume container with some configuration files
organized like this:

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
