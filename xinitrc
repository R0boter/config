#!/bin/bash

xrandr --output HDMI-A-0 --auto --left-of eDP
#自动连接wifi，如果不是使用wifi删除此句
#sudo wpa_supplicant -B -i wlp4s0 -c /etc/wpa_supplicant/wpa_supplicant.conf

# 设置随机壁纸
#while true; do
#	find ~/Pictures/Wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
#		shuf -n1 -z | xargs -0 habak -ms
#	sleep 15m
#done &
while true; do
  feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers
  sleep 1800
done &

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# 渲染器
picom &
# 网络连接托盘
nm-applet &
# 蓝牙托盘
blueberry-tray &
# 如果不能正常启动 fcitx5，在后面添加 sleep 2 即可
fcitx5 &
# 启动消息通知程序
dunst &
# 启动火焰截图
flameshot &
# dwm 用于修复 java 程序窗口 bug 的一个程序
wmname LG3D &

xrdb ~/.Xresources
# 设置状态栏显示
while true; do
  # 原本是按照网卡接口来计算流量，但必须先连接网络才生效，所以改为读取设备中所有接口的数值来计算流量，即使没连接网络脚本也可以正常运行

  # 获取上传下载的字节数
  RX=$(cat /proc/net/dev | awk '{print $2}' | grep '[0-9]')
  echo $RX
  old_RX=0
  for i in $RX; do
    old_RX=$(($old_RX + $i))
  done

  TX=$(cat /proc/net/dev | awk '{print $10}' | grep '[0-9]')
  old_TX=0
  for i in $TX; do
    old_TX=$(($old_TX + $i))
  done

  # old_RX=$(cat /proc/net/dev | sed -n '4p' | awk '{printf $2}')
  # old_TX=$(cat /proc/net/dev | sed -n '4p' | awk '{printf $10}')
  sleep 1

  # 获取上传下载的字节数
  RX=$(cat /proc/net/dev | awk '{print $2}' | grep '[0-9]')
  echo $RX
  new_RX=0
  for i in $RX; do
    new_RX=$(($new_RX + $i))
  done

  TX=$(cat /proc/net/dev | awk '{print $10}' | grep '[0-9]')
  new_TX=0
  for i in $TX; do
    new_TX=$(($new_TX + $i))
  done

  # new_RX=$(cat /proc/net/dev | sed -n '4p' | awk '{printf $2}')
  # new_TX=$(cat /proc/net/dev | sed -n '4p' | awk '{printf $10}')

  # 计算上传下载的字节数，并添加单位
  net_RX=$((($new_RX - $old_RX) / 1024))
  net_TX=$((($new_TX - $old_TX) / 1024))

  if [[ $net_RX -gt 1024 ]]; then
    net_RX=$(echo -e "\ue33a")" "$(($net_RX / 1024))"MB"
  else
    net_RX=$(echo -e "\ue33a")" "$net_RX"KB"
  fi

  if [[ $net_TX -gt 1024 ]]; then
    net_TX=$(echo -e "\ue33c")" "$(($net_TX / 1024))"MB"
  else
    net_TX=$(echo -e "\ue33c")" "$net_TX"KB"
  fi

  # 计算本地硬盘剩余容量f171
  HDD_free=$(echo -e "\ue703")" "$(df -h /dev/nvme0n1p2 | grep / | awk '{print $5}')

  # 计算 CPU 使用率
  CPU_use=$(echo -e "\ue234")" "$(top -bn1 | grep Cpu | awk '{print(100-$8)"%"}')

  # 计算内存使用率e20a
  MEM_use=$(echo -e "\ufa0e")$(free -m | sed -n '2p' | awk '{printf "%.2f%",$3/$2*100}')

  # 获取音量,实体机里用于判断是耳机还是外放
  cat /proc/asound/card1/codec\#0 | grep Pin-ctls | grep 0x40 >>/dev/null
  if [ $? -eq 0 ]; then
    VOL=$(echo -e "\uf028")" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{printf $5}')
  else
    VOL=$(echo -e "\ufcc3")" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{printf $5}')
  fi

  # 笔记本获取电池
  # BAT_status=$(cat /sys/class/power_supply/BAT0/status)
  # if [[ $BAT_status == D* ]]; then
  #   BAT=$(echo -e "\uf583")" "$(cat /sys/class/power_supply/BAT0/capacity)
  # else
  #   BAT=$(echo -e "\ufba3")" "$(cat /sys/class/power_supply/BAT0/capacity)
  # fi

  BAT_STA=$(acpi -i | sed -n '1p' | awk '{printf $3}')
  if [[ $BAT_STA == D* ]]; then
    BAT=$(echo -e "\uf583")$(acpi -i | sed -n '1p' | awk -F, '{printf $2}')" 剩余时间:"$(acpi -i | sed -n '1p' | awk '{printf $5}')
  else
    BAT=$(echo -e "\ufba3")$(acpi -i | sed -n '1p' | awk -F, '{printf $2}')
  fi

  # 时间日期
  DAY=$(echo -e "\ufb8c")" "$(date +"%m-%d %H:%M:%S ")

  # 系统已运行时间
  UPTIME=$(cat /proc/uptime | awk -F. '{day=$1/86400;hour=($1%86400)/3600;minute=($1%3600)/60;second=$1%60;printf("%d天%d时%d分%d秒\n",day,hour,minute,second)}')

  xsetroot -name "$UPTIME $net_RX $net_TX $CPU_use $MEM_use $HDD_free $VOL $BAT $DAY "
done &

exec slock &
exec dwm
