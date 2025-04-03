# Project Cyber IS
Package to bringup robot


### 1. **Connect with Raspberry**

```bash
ssh pi@192.168.18.101
```

```bash
cd catkin_ws/src
```

```bash
git clone https://github.com/KubaArrow/cyber_is_bringup.git
```

```bash
cd .. && catkin_make
```

```bash
sudo chmod +x /home/pi/catkin_ws/src/cyber_is_bringup/bash/setup_robot.sh
```

### 2. **Create service systemd**

```bash
sudo nano /etc/systemd/system/ros_start.service
```

Past content:

```ini
[Unit]
Description=ROS Start Service
After=network.target

[Service]
ExecStart=/home/pi/catkin_ws/src/cyber_is_bringup/bash/setup_robot.sh
Restart=on-failure
User=pi

[Install]
WantedBy=multi-user.target





```


---

### 3. **Start service**

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable ros_start.service
sudo systemctl start ros_start.service
```

Możesz sprawdzić status:

```bash
sudo systemctl status ros_start.service
```
