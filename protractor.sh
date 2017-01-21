#!/bin/bash
xvfb-run -a --server-args='-noreset -screen 0 ${SCREEN_RES}' protractor $@

