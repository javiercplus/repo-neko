#!/bin/bash
# Script de compilación local para paquetes Neko en Void Linux
# Ejecutar como root o mediante sudo.

set -e

# ==========================================
# CONFIGURACIÓN LOCAL (Reemplaza estos datos)
# ==========================================
PRIVKEY_PATH="/ruta/a/tu/privkey.pem"
SFTP_USER="tu_usuario"
SFTP_PASS="tu_contraseña"
# ==========================================

echo "Actualizando sistema e instalando dependencias..."
xbps-install -Syu xbps
xbps-install -Suyd
xbps-install -y nodejs ca-certificates ntp git base-devel xtools sudo rsync openssh sshpass

echo "Configurando usuario y grupo de compilación..."
groupadd -f xbuilder
if ! id "builder" &>/dev/null; then
    useradd -m -s /bin/bash -G xbuilder builder
fi
echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder

echo "Preparando el entorno de void-packages en /tmp/void-packages..."
rm -rf /tmp/void-packages
git clone --depth 1 https://github.com/void-linux/void-packages.git /tmp/void-packages
cd /tmp/void-packages

echo "Clonando plantillas de paquetes..."
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

echo "#nothing" >> common/build-style/none.sh
chown -R builder:builder /tmp/void-packages

echo "Iniciando proceso de compilación con xbps-src..."
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

echo "Firmando paquetes y generando el índice del repositorio..."
cd /tmp/void-packages/hostdir/binpkgs

# Firmar paquetes
xbps-rindex --sign-pkg --privkey "$PRIVKEY_PATH" *.xbps
# Generar índice
xbps-rindex -a *.xbps
# Firmar índice
xbps-rindex --sign --signedby "javierc" --privkey "$PRIVKEY_PATH" .

echo "Desplegando repositorio a SourceForge..."
export SSHPASS="$SFTP_PASS"
sshpass -e rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" . ${SFTP_USER}@frs.sourceforge.net:/home/frs/project/neko-void/repo/

echo "Proceso completado con éxito. Los paquetes están disponibles localmente en /tmp/void-packages/hostdir/binpkgs/"
