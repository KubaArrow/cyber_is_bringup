
```bash
sudo chmod +x /home/pi/catkin_ws/src/cyber_is_bringup/bash/setup_robot.sh
```

### 2. **Utwórz usługę systemd**

```bash
sudo nano /etc/systemd/system/ros_start.service
```

Wklej zawartość:

```ini
[Unit]
Description=ROS Start Service
After=network.target

[Service]
ExecStart=/home/ubuntu/ros_start.sh
Restart=on-failure
User=ubuntu
Environment=DISPLAY=:0
Environment=ROS_IP=127.0.0.1
Environment=ROS_MASTER_URI=http://localhost:11311

[Install]
WantedBy=multi-user.target
```

Zamień `User=ubuntu` na swoją nazwę użytkownika.

---

### 3. **Włącz usługę**

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
