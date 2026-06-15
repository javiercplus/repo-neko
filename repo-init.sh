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
          su - builder -c "cd /tmp/void-packages && ./xbps-src -r https://repo-de.voidlinux.org/current/ binary-bootstrap"
          su - builder -c "cd /tmp/void-packages && ./xbps-src -r https://repo-de.voidlinux.org/current/ pkg heroic-games"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ protonup-qt"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ steam-nk"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ spicetify"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ faugus-launcher"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ portproton"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ windscribe-desktop"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ zerotierone"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ brave-bin"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ linux-neko-rolling"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ linux-neko-rt"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ linux-neko-zen"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ waterfox"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ vesktop"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ kyoz"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ sfwbar"
          su - builder -c "cd /tmp/void-packages && ./xbps-src pkg -r https://repo-de.voidlinux.org/current/ noctalia"
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
