# Naive Obstacle Avoider

A basic ROS2-based obstacle avoidance system using shell scripts and a Python interface node. This project demonstrates how to control a mobile robot using LiDAR scan data, odometry, and IMU readings in a simple and naive way — moving forward when the path is clear and turning when obstacles are detected.

---

## 🧭 Project Structure

```text
naive_obstacle_avoider/
├── obstacle_avoider.bash        # Main obstacle avoidance logic (Bash)
├── robot_functions.bash         # Utility functions to interact with ROS2 parameters
├── robot_statistics.bash        # Real-time printout of odometry and IMU data
└── robot_interface.py           # ROS2 node interfacing with robot sensors and commands

## ✨ Features

- **Naive Obstacle Avoidance**: Moves forward when the path is clear, and turns when obstacles are detected using LiDAR.
- **Lightweight Bash Logic**: Core control logic is written in portable, readable shell scripts.
- **Live Telemetry Viewer**: View real-time odometry, orientation, and IMU data using `robot_statistics.bash`.
- **Compatible with Simulated and Real Robots**: Works with platforms like TurtleBot3 (Gazebo or real).
- **No Build Required**: Just clone, make scripts executable, and run — no compilation needed.

⚙️ Requirements
ROS 2 (Tested on Humble, should work on other recent distributions)

A working ROS 2 environment with topics:

/scan (publishing sensor_msgs/msg/LaserScan)

/odom (publishing nav_msgs/msg/Odometry)

/imu (publishing sensor_msgs/msg/Imu)

/cmd_vel (subscribing to geometry_msgs/msg/Twist)

🚀 How to Run
1. Clone the Repository
    git clone https://github.com/your-username/naive_obstacle_avoider.git
    cd naive_obstacle_avoider

2. Make Bash Scripts Executable
    chmod +x *.bash

3. Source ROS 2 Environment
    source /opt/ros/humble/setup.bash

4. Run the Robot Interface node
    python3 robot_interface.py

5. Run the Obstacle Avoider (Source ROS2 again in a new terminal)
    ./obstacle_avoider.bash


📦 Notes
This is a naive avoidance strategy: if the path ahead is clear, the robot moves forward; otherwise, it turns based on available side space.

All control logic is driven by parameter setting and reading using ros2 param.

🧪 Tested With
ROS 2 Humble (Ubuntu 22.04)
TurtleBot3 simulation in Gazebo
Real TurtleBot3 


