FROM node:slim
MAINTAINER Edgard Aviles "edgard.aviles@ooqia.com"
ENV UPDATED_AT 2016-12-14
WORKDIR /tmp
RUN apt-get update && apt-get install -y xvfb wget net-tools && \
    npm install -g protractor mocha jasmine && \
    mkdir /protractor
ADD protractor.sh /protractor.sh
RUN chmod +x /protractor.sh
# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]
