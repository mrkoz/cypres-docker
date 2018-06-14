FROM misterkoz/node8.11-cypress2.1.0

RUN apt-get install -y python-pip python-dev \
  && pip install awscli \
  && rm -rf /var/cache/apt
