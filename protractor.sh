#!/bin/bash

export DISPLAY=:1.0
Xvfb :0 -ac -screen 0 1024x768x24 &
webdriver-manager start --detach 
protractor $@

