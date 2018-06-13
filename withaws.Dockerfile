FROM node:8.11.1-slim

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    xvfb \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    git \
    libasound2 \
  && rm -rf /var/cache/apt
RUN apt-get install -y python-pip
RUN apt-get install -y python-dev
RUN pip install awscli

# Cypress version
ENV CYPRESS_VERSION 2.1.0

# Hackstalling cypress in a non-application folder place
RUN mkdir /cypress/
RUN echo "{}" > /cypress/package.json
RUN cd /cypress &&  CYPRESS_INSTALL_BINARY=${CYPRESS_VERSION} npm install cypress@${CYPRESS_VERSION}
ENV PATH="/cypress/node_modules/.bin:${PATH}"
ENV CYPRESS_SKIP_BINARY_INSTALL="TRUE"

# Echo out some cypress status and verify
RUN cypress version
RUN cypress verify