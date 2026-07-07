#! /bin/bash
user(){
 # Crear el grupo xbuilder y un usuario 'builder' asociado a él
          groupadd -f xbuilder
          useradd -m -s /bin/bash -G xbuilder builder
          
          # Permitir que el usuario builder use sudo sin contraseña para las tareas de xbps-src
          echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder
       
}

clone(){
git clone --depth 1 https://github.com/void-linux/void-packages.git /tmp/void-packages
cd /tmp/void-packages
echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
git clone --depth 1 https://codeberg.org/Neko-Void/protonup-qtvoid.git
cp -rfv protonup-qtvoid/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/spicetify-void.git
cp -rfv spicetify-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/STEAM-ALT-VOID.git
cp -rfv STEAM-ALT-VOID/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/faugus-launcher-void.git
cp -rfv faugus-launcher-void/* srcpkgs/

git clone --depth 1 https://codeberg.org/Neko-Void/portproton-void.git
cp -rfv portproton-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/Windscribe-void.git
cp -rfv Windscribe-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/ZerotierOne-Void-Linux.git
cp -rfv ZerotierOne-Void-Linux/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/Neko-Void/heroic-games.git srcpkgs/heroic-games
          
git clone --depth 1 https://codeberg.org/Neko-Void/brave-bin.git srcpkgs/brave-bin
          
git clone --depth 1 https://codeberg.org/Neko-Void/linux-neko-rolling.git srcpkgs/linux-neko-rolling
          
git clone --depth 1 https://codeberg.org/Neko-Void/linux-neko-rt.git srcpkgs/linux-neko-rt
          
git clone --depth 1 https://codeberg.org/Neko-Void/linux-neko-zen.git srcpkgs/linux-neko-zen

git clone --depth 1 https://codeberg.org/Neko-Void/zig-nk.git srcpkgs/zig-nk

git clone --depth 1 https://codeberg.org/javiercplus/linux-cachy-void.git srcpkgs/linux-cachy-void

git clone --depth 1 https://github.com/javiercplus/ly-xbps.git srcpkgs/ly

git clone --depth 1 https://codeberg.org/Neko-Void/waterfox.git srcpkgs/waterfox
          
git clone --depth 1 https://codeberg.org/Neko-Void/vesktop.git srcpkgs/vesktop

git clone --depth 1 https://gitlab.com/neko-voidlinux/kitty-free.git srcpkgs/kitty-free

git clone --depth 1 https://codeberg.org/javiercplus/kyoz.git srcpkgs/kyoz

git clone --depth 1 https://github.com/javiercplus/sfwbar.git srcpkgs/sfwbar

git clone --depth 1 https://github.com/javiercplus/noctalia.git srcpkgs/noctalia

git clone --depth 1 https://codeberg.org/javiercplus/Kasha-Installer.git srcpkgs/kasha-installer
#BUILDSTyLE NONE
echo "#nnothing" >> common/build-style/none.sh
# Cambiar la propiedad al usuario builder
chown -R builder:builder /tmp/void-packages
}

build(){
          su - builder -c "cd /tmp/void-packages && ./xbps-src binary-bootstrap"
          su - builder -c "cd /tmp/void-packages && ./xbps-src  pkg heroic-games"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg protonup-qt"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg steam-nk"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg spicetify"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg faugus-launcher"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg portproton"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg windscribe-desktop"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg zerotierone"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg brave-bin"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg linux-neko-rolling"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg linux-neko-rt"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg linux-neko-zen"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg waterfox"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg vesktop"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg kyoz"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg sfwbar"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg noctalia"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg kitty-free"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg kasha-installer"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg linux-cachy-void"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg zig-nk"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg ly"
}

case "$@" in 
       user|user)
       echo "config user"
       user
       ;;
       build|build)
       echo "building pkgs"
       build
       ;;
       clone|clone)
       clone
       ;;
esac
