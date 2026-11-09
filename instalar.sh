#!/bin/sh
# Agrega el repositorio de PlayLearn a apt (Ubuntu 22.04+ y Debian 12+).
# Después: sudo apt install playlearn. Las actualizaciones llegan con apt upgrade.
set -e
URL=https://novasofttechnologiescorp.github.io/playlearn-apt
[ "$(id -u)" = 0 ] || { echo "Corre este instalador con sudo." >&2; exit 1; }
install -d -m 0755 /etc/apt/keyrings
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL/playlearn.gpg" -o /etc/apt/keyrings/playlearn.gpg
else
  wget -qO /etc/apt/keyrings/playlearn.gpg "$URL/playlearn.gpg"
fi
chmod 0644 /etc/apt/keyrings/playlearn.gpg
cat > /etc/apt/sources.list.d/playlearn.sources <<SRC
Types: deb
URIs: $URL
Suites: stable
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/playlearn.gpg
SRC
apt-get update -o Dir::Etc::sourcelist=sources.list.d/playlearn.sources -o Dir::Etc::sourceparts=- -o APT::Get::List-Cleanup=0 >/dev/null
echo "Listo. Ahora: sudo apt install playlearn"
