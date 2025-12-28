#!/bin/sh
set -e

cat <<'EOF'
This script prepares a WSL (Ubuntu) environment for building OpenVPN.
Recommended: clone the repository inside WSL (not via /mnt/c) and run the build there.
EOF

sudo apt update
sudo apt install -y build-essential autoconf automake libssl-dev liblzo2-dev libpam0g-dev pkg-config libsystemd-dev fakeroot dpkg-dev debhelper git ca-certificates wget

echo
echo "If you haven't cloned the repo inside WSL, do so now. Example:"
echo "  git clone https://github.com/<your-fork>/openvpn-build.git"
echo "  cd openvpn-build"
echo

if [ -x ./release/full-release-build.sh ]; then
  echo "Found release/full-release-build.sh — running it now"
  ./release/full-release-build.sh
else
  echo "No release/full-release-build.sh found in current directory."
  echo "Either cd into the cloned repository or run the release build script manually."
fi
