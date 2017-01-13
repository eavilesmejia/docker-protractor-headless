#!/bin/bash
export DISPLAY=:0
xvfb-run -a --server-args='-screen 0 1280x1024x24' protractor $@

