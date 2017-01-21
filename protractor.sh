#!/bin/bash
xvfb-run --server-num=${SERVER_NUM} --server-args='-screen 0 ${SCREEN_RES}' protractor $@

