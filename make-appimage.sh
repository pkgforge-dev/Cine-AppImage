#!/bin/sh
set -eu

# Setup
ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.diegopvlk.Cine.svg
export DESKTOP=/usr/share/applications/io.github.diegopvlk.Cine.desktop
export PATH_MAPPING='/usr/share/cine:${SHARUN_DIR}/share/cine'
export DEPLOY_PYTHON=1
export USE_HOST_DRIVERS_EXPERIMENTAL=1
export STARTUPWMCLASS=io.github.diegopvlk.Cine # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun \
    /usr/bin/cine \
    /usr/share/cine \
    /usr/lib/libgtk-4.so* \
    /usr/lib/libadwaita-1.so* \
    /usr/lib/libmpv.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
