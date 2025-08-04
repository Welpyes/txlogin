#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
ORANGE="\e[38;5;208m"
RESET="\e[0m"

hide_cursor() { echo -ne "\e[?25l"; }
show_cursor() { echo -ne "\e[?25h"; }

log_line() {
  local msg="$1"
  local rand=$((RANDOM % 100))

  if [ $rand -lt 2 ]; then
    echo -e "[ ${RED}FAILED${RESET} ] $msg"
  elif [ $rand -lt 5 ]; then
    echo -e "[ ${ORANGE}SKIPPED${RESET} ] $msg"
  else
    echo -e "[ ${GREEN}OK${RESET} ] $msg"
  fi
}

# Sleep helpers
sleep_fixed() {
  sleep "$1"
}
sleep_random() {
  awk -v min="$1" -v max="$2" 'BEGIN {
    srand(); printf "%.2f\n", min + rand() * (max - min)
  }'
}

clear
hide_cursor
echo -e "\e[1mWelcome to Debian GNU/Linux (Termux Edition)\e[0m"
sleep 0.4
echo

# === Heavy Boot Tasks === (~2s total)
heavy_sleep=0.05
heavy_items=(
  "Mounting /data..."
  "Loading kernel modules..."
  "Checking filesystem integrity (/data)..."
  "Starting Termux base environment..."
  "Initializing pseudo TTYs..."
  "Starting package manager (apt)..."
  "Mounting /dev/shm..."
  "Applying sysctl configs..."
  "Restoring SELinux contexts (skipped)..."
  "Creating volatile filesystems..."
  "Mounting /vendor (emulated)..."
  "Probing block devices..."
  "Initializing loopback interfaces..."
  "Parsing $PREFIX/etc/fstab (Termux override)..."
  "Starting early user-space processes..."
)

for item in "${heavy_items[@]}"; do
  sleep_fixed "$heavy_sleep"
  log_line "$item"
done

# === Light Boot Tasks === (~3-4s total)
light_sleep=0.009
light_items=(
  "Started Termux:API bridge."
  "Started clipboard monitor."
  "Started termux-services daemon."
  "Started SSH daemon."
  "Started local syslog stub."
  "Started cron job manager."
  "Mounted /proc/sys/fs/binfmt_misc."
  "Started Termux Bluetooth support."
  "Started tmux auto-session recovery."
  "Started battery monitor."
  "Started volume key watcher."
  "Started system time sync."
  "Started bspwm session."
  "Mounted tmpfs on $TMPDIR."
  "Started local DNS forwarder."
  "Started keyring agent."
  "Started SSH key monitor."
  "Started theme daemon."
  "Started update notifier."
  "Started login display (txdm)."
  "Started x11 session forwarding."
  "Started virtual framebuffer (XVFB)."
  "Started zsh profile loader."
  "Started bashrc processor."
  "Mounted SD card (fuse)."
  "Started PulseAudio bridge."
  "Started XDG autostart hooks."
  "Started OpenGL stub."
  "Started D-Bus system."
  "Started Notification dispatcher."
  "Started MOTD display manager."
  "Started Login manager."
  "Started system hooks ($PREFIX/etc/profile.d)."
  "Started Android property importer."
  "Started graphics abstraction layer."
  "Started $PREFIX/bin/termux-reload-settings."
  "Started user-defined hooks."
  "Started storage cleaner."
  "Started X11 root window painter."
  "Started GTK settings loader."
  "Started keyboard layout loader."
  "Started FontConfig manager."
  "Started accessibility bus."
  "Started device monitor daemon."
  "Started SD card permission fixer."
  "Started termux-setup-storage monitor."
  "Started virtual net device (tun0)."
  "Started user session manager."
  "Started localization sync."
  "Started Termux system tray emulation."
  "Started package cache manager."
  "Started input event rebinder."
  "Started user environment sync."
  "Started external drive automounter."
  "Started ~/.termux/boot hooks."
  "Started pkg channel resolver."
  "Started dpkg status refresher."
)

for item in "${light_items[@]}"; do
  sleep_fixed "$light_sleep"
  log_line "$item"
done

# === Final ===
echo
sleep 0.5
echo -e "\e[32mTermux GNU/Linux on Android tty1\e[0m"
sleep 0.4
echo
show_cursor
