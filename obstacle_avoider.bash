#! /usr/bin/bash

# include the functions library
source ./robot_functions.bash

# naive obstacle avoider

# this is an infinite while loop - use ctrl+c to break
echo "Running Naive Obstacle Avoider with Bash Script..."
echo "Press Ctrl+C to Terminate..."

# make sure that the robot is stopped initially
# set linear velocity to zero 
set_cmd_vel_linear 0.000
# set angular velocity to zero 
set_cmd_vel_angular 0.000

# set obstacle avoidance distance threshold
threshold=0.300
# main while loop for naive obstacle avoider
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
while :
do
  # get all the five scan ranges
  ll_range=$(get_scan_left_ray_range)
  echo "left range: $ll_range meters"

  fl_range=$(get_scan_front_left_ray_range)
  echo "front left range: $fl_range meters"

  ff_range=$(get_scan_front_ray_range)
  echo "front range: $ff_range meters"

  fr_range=$(get_scan_front_right_ray_range)
  echo "front right range: $fr_range meters"

  rr_range=$(get_scan_right_ray_range)
  echo "right range: $rr_range meters"

  # check if the three frontal scan ranges are less than threshold
  front_left_free=$(echo "$fl_range > $threshold" | bc -l)
  echo "front_left_free: $front_left_free"

  front_free=$(echo "$ff_range > $threshold" | bc -l)
  echo "front_free: $front_free"

  front_right_free=$(echo "$fr_range > $threshold" | bc -l)
  echo "front_right_free: $front_right_free"

  # provide conditions for 8 different cases of frontal scan ranges
  if [[ "$front_left_free" == "0" && "$front_free" == "0" && "$front_right_free" == "0" ]]; then
    if (( $(echo "$ll_range > $rr_range" | bc -l ) )); then
      echo "turning left..."
      set_cmd_vel_angular 0.31416
      sleep 0.5
      set_cmd_vel_angular 0.000
    else
      echo "turning right..."
      set_cmd_vel_angular -0.31416
      sleep 0.5
      set_cmd_vel_angular 0.000
    fi

  elif [[ "$front_left_free" == "0" && "$front_free" == "0" && "$front_right_free" != "0" ]]; then
    echo "turning right..."
    set_cmd_vel_angular -0.31416
    sleep 0.5
    set_cmd_vel_angular 0.000
  elif [[ "$front_left_free" == "0" && "$front_free" != "0" && "$front_right_free" == "0" ]]; then
    dist_to_move=$(echo "$ff_range - $threshold" | bc -l)
    time_to_move=$(echo "$dist_to_move / 0.100" | bc -l)
    time_to_move=$(echo "$time_to_move - 1.000" | bc -l)
    echo "moving forward..."
    set_cmd_vel_linear 0.100
    sleep $time_to_move
    set_cmd_vel_linear 0.000

  elif [[ "$front_left_free" == "0" && "$front_free" != "0" && "$front_right_free" != "0" ]]; then
    echo "turning right..."
    set_cmd_vel_angular -0.31416
    sleep 0.5
    set_cmd_vel_angular 0.000

  elif [[ "$front_left_free" != "0" && "$front_free" == "0" && "$front_right_free" == "0" ]]; then
    echo "turning left..."
    set_cmd_vel_angular 0.31416
    sleep 0.5
    set_cmd_vel_angular 0.000
  elif [[ "$front_left_free" != "0" && "$front_free" == "0" && "$front_right_free" != "0" ]]; then
    if (( $(echo "$ll_range > $rr_range" | bc -l ) )); then
      echo "turning left..."
      set_cmd_vel_angular 0.31416
      sleep 0.5
      set_cmd_vel_angular 0.000
    else
      echo "turning right..."
      set_cmd_vel_angular -0.31416
      sleep 0.5
      set_cmd_vel_angular 0.000
    fi

  elif [[ "$front_left_free" != "0" && "$front_free" != "0" && "$front_right_free" == "0" ]]; then
    echo "turning left..."
    set_cmd_vel_angular 0.31416
    sleep 0.5
    set_cmd_vel_angular 0.000

  else
    dist_to_move=$(echo "$ff_range - $threshold" | bc -l)
    time_to_move=$(echo "$dist_to_move / 0.100" | bc -l)
    time_to_move=$(echo "$time_to_move - 1.000" | bc -l)
    echo "moving forward..."
    set_cmd_vel_linear 0.100
    sleep $time_to_move
    set_cmd_vel_linear 0.000
  fi

  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
done

# End of Code
