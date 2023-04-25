#!/bin/sh
# CentOS 7 install

yum -y install python3
python3 -m pip install --upgrade pip setuptools

cd /opt/
wget https://github.com/yuriasa/dsiprouter_v0.643/raw/main/dsiprouter_v0643.tgz
tar -xzvf dsiprouter_v0643.tgz
rm -rf dsiprouter_v0643.tgz

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
