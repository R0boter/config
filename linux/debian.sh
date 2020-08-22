#!/bin/sh

echo  "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" > /etc/apt/sources.list
echo  "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" >> /etc/apt/sources.list
echo  "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list
echo  "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list
echo  "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list
echo  "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list
echo  "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >> /etc/apt/sources
echo  "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list

echo "----------------Update Sources--------------"

apt-get update
apt-get dist-upgrade -y

echo "---------------Install Base Program-----------------"

apt-get install plank git curl wget gcc g++ make fonts-powerline lightdm-gtk-greeter-settings python3-pip clang fcitx fcitx-sunpinyin -y

echo "---------------Install vim--------------------"

apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common -y

apt-get install liblua5.1-0-dev luajit libluajit-5.1 python3-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev -y

git clone https://github.com/vim/vim

cd ./vim/src

./configure --enable-multibyte --enable-perlinterp=dynamic --enable-rubyinterp=dynamic --with-ruby-command=/usr/bin/ruby --enable-python3interp --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu --enable-luainterp --with-luajit --enable-cscope --enable-gui=auto --with-features=huge --with-x --enable-fontset --enable-largefile --disable-netbeans --with-compiledby="Leon" --enable-fail-if-missing

make install

pip3 install jedi

echo "--------------------------Beautify------------------------------"

git clone https://github.com/R0boter/MyProsionResources.git

cd MyProsionResources

mkdir /usr/share/fonts/source

mv ./fonts/* /usr/share/fonts/source/

mv ./theme/* /usr/share/themes/

mv ./icons/* /usr/share/icons/

mv ./vim /home/leon/.vim

mv ./fcitx/* /usr/share/fcitx/skin/

mv ./java/* /usr/share/java/

echo "----------------------------------------------install tools---------------------------------------------"
apt-get install nmap sqlmap postgresql nikto dirb wireshare ettercap-text-only dnsutils 
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall


echo "# set java environment" > /etc/profile.d/java8.sh
echo "export JAVA_HOME=/usr/share/java/jdk1.8.0_212" >> /etc/profile.d/java8.sh
echo "export JRE_HOME=\${JAVA_HOME}/jre" >> /etc/profile.d/java8.sh
echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >> /etc/profile.d/java8.sh
echo "export PATH=\${JAVA_HOME}/bin:\$PATH" >> /etc/profile.d/java8.sh

chown -R leon:leon /home/leon/.vim/

su leon <<EOF
cd /home/leon/.vim/pack/plugin/start
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/Yggdroot/indentLine.git
git clone https://github.com/maralla/completor.vim.git
git clone https://github.com/rakr/vim-one.git
git clone https://github.com/arcticicestudio/nord-vim.git
git clone https://github.com/plasticboy/vim-markdown.git
git clone https://github.com/godlygeek/tabular.git
git clone https://github.com/dhruvasagar/vim-table-mode.git
EOF

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/" /etc/default/grub

update-grub

/usr/sbin/usermod -g sudo leon

rm /home/leon/.vim/pack/plugin/start/test

rm /home/leon/.vim/pack/plugin/opt/test

/usr/sbin/reboot











