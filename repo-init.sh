#! /bin/bash
clone(){
git clone --depth 1 https://github.com/void-linux/void-packages.git /tmp/void-packages
cd /tmp/void-packages
          
git clone --depth 1 https://codeberg.org/javiercplus/protonup-qtvoid.git
cp -rfv protonup-qtvoid/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/spicetify-void.git
cp -rfv spicetify-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/STEAM-ALT-VOID.git
cp -rfv STEAM-ALT-VOID/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/faugus-launcher-void.git
cp -rfv faugus-launcher-void/* srcpkgs/

git clone --depth 1 https://codeberg.org/javiercplus/portproton-void.git
cp -rfv portproton-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/Windscribe-void.git
cp -rfv Windscribe-void/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/ZerotierOne-Void-Linux.git
cp -rfv ZerotierOne-Void-Linux/* srcpkgs/
          
git clone --depth 1 https://codeberg.org/javiercplus/heroic-games.git srcpkgs/heroic-games
          
git clone --depth 1 https://codeberg.org/javiercplus/brave-bin.git srcpkgs/brave-bin
          
git clone --depth 1 https://codeberg.org/javiercplus/linux-neko-rolling.git srcpkgs/linux-neko-rolling
          
git clone --depth 1 https://codeberg.org/javiercplus/linux-neko-rt.git srcpkgs/linux-neko-rt
          
git clone --depth 1 https://codeberg.org/javiercplus/linux-neko-zen.git srcpkgs/linux-neko-zen
          
git clone --depth 1 https://codeberg.org/javiercplus/waterfox.git srcpkgs/waterfox
          
git clone --depth 1 https://codeberg.org/javiercplus/vesktop.git srcpkgs/vesktop

git clone https://codeberg.org/javiercplus/kyoz.git srcpkgs/kyoz
git clone --depth 1 https://github.com/javiercplus/sfwbar.git srcpkgs/sfwbar
git clone --depth 1 https://github.com/javiercplus/noctalia.git srcpkgs/noctalia

#BUILDSTyLE NONE
echo "#nnothing" >> common/build-style/none.sh
# Cambiar la propiedad al usuario builder
chown -R builder:builder /tmp/void-packages
}

build(){
          su - builder -c "cd /tmp/void-packages && ./xbps-src binary-bootstrap"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg heroic-games"
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
}

