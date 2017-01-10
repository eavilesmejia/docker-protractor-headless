# Docker image of Protractor linked with selenium hub and selnium node

Protractor end to end testing for AngularJS



# Usage

## Step 0 - Download the docker images for Selenium Hub and Selenium Node

```
docker pull selenium/hub:latest
docker pull selenium/node-chrome:latest
```

## Step 1 - Download the docker protractor images

```
docker pull avilem/docker-protractor-headless
```

## Step 2 - Running the container

### Running the selenium container:
```
docker run -d -p 4444:4444 --name hub selenium/hub
docker run -d --link hub:hub --name node selenium/node-chrome
````

### Running the protractor container:

```
docker run --rm -it --privileged -v /dev/sh:/dev/shm -v "$(pwd)":/protractor --link hub:hub --link node:node avilem/docker-protractor-headless $@
````

This will run protractor in your current directory, so you should run it in your tests root directory. It is useful to create a script, for example /usr/local/bin/protractor.sh such as this:

```
#!/bin/bash

docker run --rm -it --privileged -v /dev/shm:/dev/shm -v "$(pwd)":/protractor --link hub:hub --link node:node avilem/docker-protractor-headless $@
```

The script will allow you to run dockerised protractor like so:

```
protractor.sh [protractor options]
```

## protractor conf.js

```
exports.config = {
  ...
  seleniumAddress: 'http://hub:4444/wd/hub',
  ...
};
```

## Why mapping `/dev/shm`?

Docker has hardcoded value of 64MB for `/dev/shm`. Because of that you can encounter an error [session deleted becasue of page crash](https://bugs.chromium.org/p/chromedriver/issues/detail?id=1097) on memory intensive pages. The easiest way to mitigate that problem is share `/dev/shm` with the host.

This needs to be done till `docker build` [gets the option `--shm-size`](https://github.com/docker/docker/issues/2606).

## Why `--privileged`?

Chrome uses sandboxing, therefore if you try and run Chrome within a non-privileged container you will receive the following message:

"Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted".

The [`--privileged`](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) flag gives the container almost the same privileges to the host machine resources as other processes running outside the container, which is required for the sandboxing to run smoothly.



