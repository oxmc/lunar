#!/bin/bash
#Script created by oxmc
#Made for Lunar-Client by gl91306

#install modprobe if not already installed
if ! command -v modprobe >/dev/null;then
  
  if [ -f /usr/bin/apt ];then
    sudo apt update
    sudo apt install -y modprobe || echo "Failed to install modprobe."
  else
    error "Failed to find any package manager to install modprobe."
  fi
fi

#Run modprobe fuse
sudo modprobe fuse

cd
#Download client
wget https://github.com/gl91306/lunar/raw/master/lunarclient-2.7.3c-aarch64.AppImage
if [ ! -d ~/lwjgl3arm64 ]; then
    mkdir ~/lwjgl3arm64
fi
if [ ! -f jdk-16.0.1+9-jre64.tar.gz ]; then
    wget https://github.com/gl91306/lunar/raw/master/jdk-16.0.1%2B9-jre64.gz
fi
if [ ! -f lwjgl3arm64.tar.gz ]; then
    wget https://github.com/mikehooper/Minecraft/raw/main/lwjgl3arm64.tar.gz
fi
if [ ! -d /opt/jdk ]; then
    sudo mkdir /opt/jdk
fi
sudo tar -zxf jdk-16.0.1+9-jre64.gz -C /opt/jdk
tar -zxf lwjgl3arm64.tar.gz -C ~/lwjgl3arm64
sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk-16.0.1+9-jre64/bin/java 0
sudo update-alternatives --set java /opt/jdk/jdk-16.0.1+9-jre64/bin/java
cd
cd lwjgl3arm64
wget https://github.com/gl91306/lunar/raw/master/libwebp-imageio64.so
cd
mkdir lunarassets
sudo apt-get install unzip
wget https://github.com/gl91306/lunar/raw/master/javafx-sdk-17-64.zip
unzip javafx-sdk-17-64.zip -d $HOME/lunarassets
cd
#Change perms of Launcher
sudo chmod +x $HOME/lunarclient-2.7.3c-aarch64.AppImage

#Run launcher
$HOME/lunarclient-2.7.3c-aarch64.AppImage
cd
rm -rf jdk-16.0.1+9-jre64.tar.gz
rm -rf javafx-sdk-17-64.zip
rm -rf lwjgl3arm64.tar.gz
cd

#Add icon
cd
cd lunarassets
wget https://github.com/gl91306/lunar/raw/master/lunarclient.png
cd

#Then make menu button & desktop icon
echo "Creating a desktop entry for Lunar-Client..."
echo "[Desktop Entry]
Name=Lunar Client
Comment=Lunar Client for Rpi made by PiKATchu on Discord.
Exec=$HOME/lunarclient-2.7.3c-aarch64.AppImage
Icon=$HOME/lunarassets/lunarclient.png
Categories=Game;
Type=Application
Terminal=false" > "$HOME/.local/share/applications/Lunar-Client.desktop"

echo "[Desktop Entry]
Name=Lunar Client
Comment=Lunar Client for Rpi made by PiKATchu on Discord.
Exec=$HOME/lunarclient-2.7.3c-aarch64.AppImage
Icon=$HOME/lunarassets/lunarclient.png
Categories=Game;
Type=Application
Terminal=false" > "$HOME/Desktop/Lunar Client"
