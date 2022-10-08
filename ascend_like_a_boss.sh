#!/bin/bash

# Should we ascend at the end of the loop or not?
ascend=1

# How many iterations to do for the main loop before ascending.
iterations=90

# During certain actions you need a bit of delay or the GPS acceleration
# is a little slow. Time in seconds
menu_delay=0.05

# To slow down or speed up the overall process use a delay after each click.
# Time in milliseconds
sword_click_delay=1
buy_click_delay=5
ascend_click_delay=200


# Open the ascend menu and click it. Sometimes the click doens't register so
# the delays are added to help give them time.
#
ascend () {
  xdotool key 3
  xdotool mousemove 1700 300 click --delay $ascend_click_delay 1
  xdotool mousemove 1700 800 click --delay $ascend_click_delay 1
}


# Do a series of vertical clicks to catch any fireflies that might be passing by.
# Also triggers the hookshot and shuriken.
#
clicks_and_powers () {
  xdotool key q
  xdotool key w
  for y in {350..650..25}
  do
    xdotool mousemove 900 $y click --delay $sword_click_delay 1
  done
}


# Buy all available propertie.
# 
buy_properties () {
  xdotool key 1
  sleep $menu_delay
  xdotool mousemove 1785 1050 click --delay $buy_click_delay 1
}



# Buy all upgrades
#
buy_upgrades () {
  xdotool key 2 
  sleep $menu_delay
  xdotool mousemove 1750 300 click --delay $buy_click_delay 1
  # Enable when you get to level 11 consistantly.
  xdotool mousemove 1750 350 click --delay $buy_click_delay 1
  # Enable when you get to level 12 consistantly.
  #xdotool mousemove 1750 565 click --delay $buy_click_delay 1
}


# Search for fireflies on the screen. Click everywhere.
#
click_everywhere () {
  xdotool type "~"
  xdotool key q &
  xdotool key w &
  for i in {0..1900..100}
  do
    for j in {350..650..40}
    do
      xdotool mousemove $i $j click --delay $sword_click_delay 1
    done
  done
  xdotool type "~"
  sleep 0.5
}

# Buy all the available upgrades.
# Sometimes the "Buy All" button can shift positions so this will click each spot
# where I've seen it appear. Seems reliable enough.
#
main () {

  for ((i = 0 ; i < iterations ; i++)); do
    clicks_and_powers  
    buy_properties
    buy_upgrades
    echo "$i/$iterations"
  done

  click_everywhere

  if [[ $ascend -eq 1 ]]; then
    ascend
  fi
}

main
