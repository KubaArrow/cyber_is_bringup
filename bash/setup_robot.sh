#!/bin/bash
source /home/pi/.bashrc

# Uruchom roscore w tle
roscore &
sleep 5  # poczekaj aż roscore się w pełni uruchomi

# Uruchom rosbridge_websocket
roslaunch cyber_is_bringup is_bringup.launch
