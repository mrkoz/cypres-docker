# Node and cypress in a docker container

## Why

Because it will speed up development/testing/deployment to be able to have the
cypres binary download outside the `npm -i` call.

In a local dev environment, the binary can be cached or installed globally 
(even though it's not recommended) but a global install is not feasible inside
a docker container for node >6

## How

Have a read of the [Dockerfile](Dockerfile) for the actual details.

Coming from a pretty stock node 8.11 image:

1. The gtk xvfb and other OS level dependancies are installed.
2. Cypress is installed non-globally to the `/cypress`
3. The `/cypress/node_modules/.bin` folder is added to `PATH`
4. An os level environment variable is set to stop the cypress binaries from being installed in node projects

## How to use

### 1. Using docker `FROM`

This is an example Dockerfile, the image has been pushed to `misterkoz/node8.11-cypress2.1.0`

```Dockerfile
FROM misterkoz/node8.11-cypress2.1.0

# Application directory
ENV ROOT /app
WORKDIR $ROOT

# Port
ENV PORT 9091
EXPOSE $PORT

# Copy over the Source files
COPY . ./

# install
RUN npm i

# Entrypoint stuff
ENTRYPOINT [ "npm", "run" ]
CMD ["start"]

```

### 2. Copy and paste this docker file into the start of yours

Self explanatory really.

## Todos

* finish example with some hellow world stuff
* add cypress tests
* automate cypress test in travis
* show off
* etc

## Licence

As per the [Licence file](licence.md)