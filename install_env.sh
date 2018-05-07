#!/bin/bash

## Functions
_bold=$(tput bold)
_reset=$(tput sgr0)

_red=$(tput setaf 1)
_green=$(tput setaf 2)
_yellow=$(tput setaf 3)

function print_ok   { printf "${_bold}${_green}%s${_reset}\n" "$@"; }
function print_err  { printf "${_bold}${_red}%s${_reset}\n" "$@"; }
function print_warn { printf "${_bold}${_yellow}%s${_reset}\n" "$@"; }

## Linux Distribution and Version Check
print_ok "Installing environment for downloading \"blue-app-iota\" to the Ledger..."

if ! type "gawk" &> /dev/null; then
  print_err "ERROR: gawk is missing! If you're on Debian or Ubuntu, please run 'sudo apt install -y gawk'"
  exit 1
fi

linux_id=`gawk -F= '/^ID=/{print $2}' /etc/os-release`
linux_version_id=`gawk -F= '/^VERSION_ID=/{print $2}' /etc/os-release`
if [ ${linux_id} = 'debian' ];
then
    if [ ${linux_version_id} != '"9"' ];
    then
        print_err "ERROR: This script was tested under Debian 9 (stretch) only! Exiting..."
        exit 1
	fi
elif [ ${linux_id} = 'ubuntu' ];
then
    if [ ${linux_version_id} != '"16.04"' ] && [ ${linux_version_id} != '"16.10"' ] && [ ${linux_version_id} != '"17.04"' ] && [ ${linux_version_id} != '"17.10"' ] && [ ${linux_version_id} != '"18.04"' ];
    then
        print_err "ERROR: This script was tested under Ubuntu 16.04 till 18.04 only! Exiting..."
        exit 1
	fi
else
    print_err "ERROR: This script was created for Debian and Ubuntu only! Exiting..."
    exit 1
fi

## Variables
BLUE_APP_IOTA_PY_VIRT_ENV=`realpath .pyenv`

print_ok "Updating Packages..."
sudo apt update && sudo apt dist-upgrade -y

print_ok "Installing git, autoconf, autogen, libtool, libudev, libusb and Python3 virtual environment..."
sudo apt install -y pkg-config git autoconf autogen libtool libudev-dev libusb-1.0-0-dev python3-pip python3-venv

print_ok "Creating python virtual environment..."
python3 -m venv ${BLUE_APP_IOTA_PY_VIRT_ENV}
. ${BLUE_APP_IOTA_PY_VIRT_ENV}/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install wheel
#pip3 install ledgerblue    # This doesn't work at the moment => Better use the git repo!
SECP_BUNDLED_EXPERIMENTAL=1 pip3 --no-cache-dir install --no-binary secp256k1 secp256k1
pip3 install git+https://github.com/LedgerHQ/blue-loader-python.git

print_ok "Adding user to the \"plugdev\" group..."
sudo adduser $USER plugdev

print_ok "Installing udev rules for ledger nano S..."
# Additional Tags (if ledger is no recognized) => TAG+="uaccess", TAG+="udev-acl" OWNER="<UNIX username>"
sudo bash -c "echo 'SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"2b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"3b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"4b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1807\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1808\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2c97\", ATTRS{idProduct}==\"0000\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2c97\", ATTRS{idProduct}==\"0001\", MODE=\"0660\", GROUP=\"plugdev\"' >/etc/udev/rules.d/20-hw1.rules"
sudo udevadm trigger
sudo udevadm control --reload-rules

print_ok "...Installing environment for downloading \"blue-app-iota\" done!"
print_warn "Please restart to apply changes!"
