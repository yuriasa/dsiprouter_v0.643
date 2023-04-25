#!/bin/sh

cd /tmp
wget https://raw.githubusercontent.com/yuriasa/dsiprouter_v0.643/main/install_dsip.sh | sh
chmod +x /tmp/install_dsip.sh
sh /tmp/install_dsip.sh
