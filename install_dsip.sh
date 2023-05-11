#!/bin/sh

cd
clear

echo "IF9fX18gICAgICAgICAgICAgICAgIF9fX18gICBfX19fXyAgICBfX19fXyBfX19fICAgX19fX18gCnwgIF8gXCAgICAgICAgICAgICAgIHwgIF8gXCAvIF9fX198ICAvIF9fX198ICBfIFwgLyBfX19ffAp8IHxfKSB8IF9fIF8gX19fICBfX198IHxfKSB8IChfX18gICB8IChfX18gfCB8XykgfCB8ICAgICAKfCAgXyA8IC8gX2AgLyBfX3wvIF8gXCAgXyA8IFxfX18gXCAgIFxfX18gXHwgIF8gPHwgfCAgICAgCnwgfF8pIHwgKF98IFxfXyBcICBfXy8gfF8pIHxfX19fKSB8ICBfX19fKSB8IHxfKSB8IHxfX19fIAp8X19fXy8gXF9fLF98X19fL1xfX198X19fXy98X19fX18vICB8X19fX18vfF9fX18vIFxfX19fX3w=" \
| base64  -d \
| { echo -e "\e[1;49;36m"; cat; echo -e "\e[39;49;00m"; }
echo 
echo

yum -y install net-tools
yum -y install git
yum -y install python3
python3 -m pip install --upgrade pip setuptools

#cd /opt/
#wget https://github.com/yuriasa/dsiprouter_v0.643/raw/main/dsiprouter_v0643.tgz
#tar -xzvf dsiprouter_v0643.tgz
#rm -rf dsiprouter_v0643.tgz

cd /opt/
git clone https://github.com/yuriasa/dsip.git
mv /opt/dsip /opt/dsiprouter
cd /opt/dsiprouter
./dsiprouter.sh install -all

mysql -e "UPDATE mysql.user SET Password = PASSWORD('Basebs2022') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

mysql -u root -pBasebs2022 <<EOF
use mysql;
SET PASSWORD FOR 'kamailio'@'localhost' = PASSWORD('Basebs2022');
FLUSH PRIVILEGES;
exit;
EOF

vi /etc/dsiprouter/gui/settings.py +63d +wq
vi -e /etc/dsiprouter/gui/settings.py +63 << END
i
KAM_DB_PASS = 'Basebs2022'
.
wq
END

export ROOT_DB_PASS=Basebs2022
export KAM_DB_PASS=Basebs2022
python3 /etc/dsiprouter/gui/settings.py

cd /opt/dsiprouter/
./dsiprouter.sh generatekamconfig
./dsiprouter.sh configurekam
./dsiprouter.sh setcredentials -dc admin:admin

service kamailio restart
service kamailio status
service dsiprouter restart
service dsiprouter status
