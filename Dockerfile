FROM node:slim
MAINTAINER Edgard Aviles "edgard.aviles@ooqia.com"
ENV UPDATED_AT 2016-12-14
WORKDIR /tmp
RUN apt-get update && apt-get install -y xvfb wget net-tools openjdk-7-jre && \
    npm install -g protractor mocha jasmine && \
    webdriver-manager update --versions.chrome 2.27 && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb && \
    mkdir /protractor
ADD protractor.sh /protractor.sh
RUN chmod +x /protractor.sh
EXPOSE 4444
# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]
