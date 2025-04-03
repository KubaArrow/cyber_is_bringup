Cześć! Można to zrobić na Raspberry Pi 3B z Ubuntu 20.04 i ROS Noetic za pomocą prostego skryptu startowego i wykorzystania mechanizmu `systemd` lub `rc.local`. Poniżej pokażę Ci obie metody – sugeruję użyć `systemd`, bo jest bardziej niezawodna.

---

## 🔧 **Metoda 1: `systemd` (zalecana)**

### 1. **Utwórz skrypt startowy**

Stwórz plik np. `ros_start.sh`:

```bash
sudo nano /home/ubuntu/ros_start.sh
```

Wklej poniższy kod:

```bash
#!/bin/bash
source /opt/ros/noetic/setup.bash
source /home/ubuntu/catkin_ws/devel/setup.bash

# Uruchom roscore w tle
roscore &
sleep 5  # poczekaj aż roscore się w pełni uruchomi

# Uruchom rosbridge_websocket
roslaunch rosbridge_server rosbridge_websocket.launch
```

Zamień ścieżkę do `catkin_ws`, jeśli masz inną. Nadaj plikowi uprawnienia:

```bash
chmod +x /home/ubuntu/ros_start.sh
```

---

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
