#!/bin/bash

SCREEN_RES=${SCREEN_RES:-1280x1024x24}

# Start Xvfb
Xvfb :${SERVERNUM} -ac -noreset -screen 0 $SCREEN_RES -nolisten tcp &
xvfb_pid=$!
echo "Xvfb PID: " $xvfb_pid

export DISPLAY=:${SERVERNUM}

protractor $@ &
protractor_pid=$!
echo "protractor PID: " $protractor_pid

wait $protractor_pid

kill -9 $xvfb_pid
