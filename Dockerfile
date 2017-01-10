FROM node:slim
MAINTAINER Edgard Aviles "edgard.aviles@ooqia.com"
ENV UPDATED_AT 2016-12-14
WORKDIR /tmp
RUN apt-get update -qqy  && apt-get install -qqy python-software-properties && \  
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update -qqy && apt-get install -qqy oracle-java8-installer 
RUN apt-get install -qqy xvfb wget net-tools && \
    npm install -g protractor mocha jasmine && \
    webdriver-manager update && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb && \
    mkdir /protractor
ADD protractor.sh /protractor.sh
RUN chmod +x /protractor.sh
# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]
