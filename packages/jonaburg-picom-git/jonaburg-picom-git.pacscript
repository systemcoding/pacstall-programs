name="jonaburg-picom-git"
pkgname="jonaburg-picom"
url="https://github.com/jonaburg/picom.git"
license="MIT,MPL-2.0"
depends="libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson curl"
description="A compositor, which is a fork of Sandmark's picom branch, including Blackcapcoder's animation, and tryone's dual_kawase blur with rounded corners"
maintainer="Ruturajn <nanotiruturaj@gmail.com>"
breaks="compton picom"

pkgver() {
  git ls-remote "${url}" master | cut -f1 | cut -c1-8
}
version="$(pkgver)"

prepare() {
  git submodule update --init --recursive
  meson --buildtype=release . build
  meson configure build
}

build() {
  ninja -C build
}

install() {
  sudo DESTDIR="${STOWDIR}/${name}" ninja -C build install
}
