#!/bin/bash
set -e

# Ensure you've set up dev environment: https://nvidia-isaac-ros.github.io/getting_started/dev_env_setup.html
# Ensure you've set ISAAC's apt repo: https://nvidia-isaac-ros.github.io/getting_started/isaac_apt_repository.html
# Follow Jetson Setup for VPI: https://nvidia-isaac-ros.github.io/getting_started/hardware_setup/compute/jetson_vpi.html

## Following: https://docs.ros.org/en/humble/How-To-Guides/Building-a-Custom-Deb-Package.html

sudo apt install python3-bloom python3-rosdep fakeroot debhelper dh-python -y

git clone https://github.com/Sid220/isaac_ros_apriltag isaac_ros_apriltag && cd isaac_ros_apriltag

cp isaac.yaml /opt/ros/isaac.yaml

echo "yaml file:///opt/ros/isaac.yaml" | sudo tee -a /etc/ros/rosdep/sources.list.d/20-default.list

rosdep update

cd ./isaac_ros_apriltag

bloom-generate rosdebian

fakeroot debian/rules binary
