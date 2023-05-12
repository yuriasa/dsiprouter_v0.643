
#!/bin/sh
# CentOS 7 install
echo "*****************************************************************"
echo "*           Welcome to Script build PBX_System        		*"
echo "*                Generate by KietCT                        	*"
echo "*	 ____                 ____ ____    ____  ______  __	*"
echo "*	| __ )  __ _ ___  ___| __ ) ___|  |  _ \| __ ) \/ /	*"
echo "*	|  _ \ / _,  / __|/ _ \  _ \___ \  | |_) |  _ \\  /	*"
echo "*	| |_) | (_| \__ \  __/ |_) |__) | |  __/| |_) /  \	*"	 
echo "*	|____/ \__,_|___/\___|____/____/  |_|   |____/_/\_\	*"	 
echo "*****************************************************************"
echo
echo
echo Press 1 for asterisk 13?
echo Press 2 for asterisk 16?
echo Do you want setup Asterisk version 13 or 16?
while :
do
  read asterisk
  case $asterisk in
	1)
		echo "Your choose asterisk version: 13"
		echo "Starting install Asterisk version 13!"
		yum -y update
yum -y groupinstall core base "Development Tools"
yum install -y perl kernel-headers epel-release telnet open-vm-tools dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel libedit libedit-devel svn git epel-release audiofile-devel psmisc sox uuid-devel
echo '[irontec]
name=Irontec RPMs repository
baseurl=http://packages.irontec.com/centos/$releasever/$basearch/' > /etc/yum.repos.d/irontec.repo
rpm --import http://packages.irontec.com/public.key
yum install sngrep -y
yum install ntp -y 
yum install -y chrony 
systemctl restart chronyd 
systemctl restart ntpd 
systemctl enable ntpd
systemctl enable chronyd 
ntpdate -q vn.pool.ntp.org 
timedatectl
mkdir ~/build && cd ~/build
wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz --no-check-certificate
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
tar xvfz dahdi-linux-complete-current.tar.gz
tar xvfz libpri-current.tar.gz
cd ~/build/dahdi-linux-complete-*
make all
make install-config
cd ~/build/libpri-*
make && make install
cd ~/build/
wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.10.tar.gz
tar xvfz jansson.tar.gz
cd ~/build/jansson-2.10
autoreconf  -i
./configure --libdir=/usr/lib64
make && make install
cd ~/build
wget https://github.com/pjsip/pjproject/archive/2.10.tar.gz
tar -xzvf 2.10.tar.gz
cd ~/build/pjproject-2.10
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep
make && sudo make install && sudo ldconfig
ldconfig -p | grep pj
cd ~/build
wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-13.38.3.tar.gz
tar xvfz asterisk-13.38.3.tar.gz
cd ~/build/asterisk-13.*
./configure --libdir=/usr/lib64
contrib/scripts/install_prereq install
sudo ./contrib/scripts/get_mp3_source.sh
./configure --libdir=/usr/lib64 --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable res_config_mysql menuselect.makeopts
menuselect/menuselect --enable app_mysql menuselect.makeopts
menuselect/menuselect --enable cdr_mysql menuselect.makeopts
menuselect/menuselect --enable app_skel menuselect.makeopts
menuselect/menuselect --enable app_ivrdemo menuselect.makeopts
menuselect/menuselect --enable app_saycounted menuselect.makeopts
menuselect/menuselect --enable app_statsd menuselect.makeopts
menuselect/menuselect --enable app_fax menuselect.makeopts
menuselect/menuselect --enable app_macro menuselect.makeopts
menuselect/menuselect --enable codec_opus menuselect.makeopts
menuselect/menuselect --enable codec_g729a menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-WAV menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ULAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ALAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-G729 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-G722 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SLN16 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SIREN7 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SIREN14 menuselect.makeopts
make && make install
make samples
make config
ldconfig
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
chown asterisk. /var/run/asterisk
chown -R asterisk. /etc/asterisk
chown -R asterisk. /var/{lib,log,spool}/asterisk
chown -R asterisk. /usr/lib64/asterisk
mkdir /var/www/
mkdir /var/www/html
chown -R asterisk. /var/www/
sed -i 's/;runuser/runuser/' /etc/asterisk/asterisk.conf
sed -i 's/;rungroup/rungroup/' /etc/asterisk/asterisk.conf
sed -i 's/;hideconnect/hideconnect/' /etc/asterisk/asterisk.conf
yum -y install lynx tftp-server ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git crontabs cronie cronie-anacron wget vim uuid-devel sqlite-devel net-tools gnutls-devel unixODBC mysql-connector-odbc
yum -y install mariadb-server mariadb-client
systemctl enable --now mariadb
systemctl start mariadb


curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
yum install nodejs -y
node -v

yum -y install httpd mod_ssl
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
rm -f /var/www/html/index.html
systemctl restart httpd.service
sudo systemctl enable httpd
service firewalld stop
chkconfig firewalld off
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install php56w php56w-pdo php56w-mysql php56w-mbstring php56w-pear php56w-process php56w-xml php56w-opcache php56w-ldap php56w-intl php56w-soap -y
sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php.ini
cd ~/build
wget --no-check-certificate https://downloads.mariadb.com/enterprise/r8ex-kwwe/connectors/odbc/connector-odbc-2.0.9/mariadb-connector-odbc-2.0.9-beta-linux-x86_64.tar.gz
tar zxvf mariadb-connector-odbc-2.0.9-beta-linux-x86_64.tar.gz
mv mariadb-connector-odbc-2.0.9-beta-linux-x86_64/lib/libmaodbc.so /usr/lib64/
chown root:root /usr/lib64/libmaodbc.so
sed -i s/libmyodbc5/libmaodbc/ /etc/odbcinst.ini
ln -s /usr/lib64/libodbcinst.so.2 /usr/lib64/libodbcinst.so.1
ldd /usr/lib64/libmaodbc.so
cd ~/build
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz
tar xfz freepbx-15.0-latest.tgz
cd ~/build/freepbx
./start_asterisk start
./install -n
sudo fwconsole ma disablerepo commercial
sudo fwconsole ma enablerepo unsupported extended
sudo fwconsole ma installall
sudo fwconsole ma delete firewall sysadmin
fwconsole chown
fwconsole reload
service httpd restart
echo
my_primary_ip=$(ip route get 8.8.8.8 | head -1 | grep -Po '(\d+\.){3}\d+' | tail -n1)
echo "     Congratulations! Freepbx15 has been installed!"
echo
echo "     * Access Freepbx15 UI:"
echo "         http://$my_primary_ip"
echo "     * Access Secure Freepbx15 UI:"
echo "         https://$my_primary_ip"
echo "*------------------------------------------*"
echo "* NOTE: Please save the above information. *"
echo "* REBOOT YOUR SERVER TO COMPLETE INSTALL.  *"
echo "*------------------------------------------*"
		break
		;;
	2)
		echo "Your choose asterisk version: 16"
		echo "Starting install Asterisk version 16!"
		yum -y update
yum -y groupinstall core base "Development Tools"
yum install -y epel-release telnet open-vm-tools dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel libedit libedit-devel svn git epel-release audiofile-devel psmisc sox uuid-devel
echo '[irontec]
name=Irontec RPMs repository
baseurl=http://packages.irontec.com/centos/$releasever/$basearch/' > /etc/yum.repos.d/irontec.repo
rpm --import http://packages.irontec.com/public.key
yum install sngrep -y
yum install ntp -y 
yum install -y chrony 
systemctl enable ntpd
systemctl enable chronyd 
systemctl restart chronyd 
systemctl restart ntpd 
ntpdate -q vn.pool.ntp.org 
timedatectl
mkdir ~/build && cd ~/build
wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz --no-check-certificate
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
tar xvfz dahdi-linux-complete-current.tar.gz
tar xvfz libpri-current.tar.gz
cd ~/build/dahdi-linux-complete-*
make all
make install-config
cd ~/build/libpri-*
make && make install
cd ~/build/
wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.10.tar.gz
tar xvfz jansson.tar.gz
cd ~/build/jansson-2.10
autoreconf  -i
./configure --libdir=/usr/lib64
make && make install
cd ~/build
wget https://github.com/pjsip/pjproject/archive/2.10.tar.gz
tar -xzvf 2.10.tar.gz
cd ~/build/pjproject-2.10
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep
make && sudo make install && sudo ldconfig
ldconfig -p | grep pj
cd ~/build
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar xvfz asterisk-16-current.tar.gz
cd ~/build/asterisk-16.*
./configure --libdir=/usr/lib64
contrib/scripts/install_prereq install
sudo ./contrib/scripts/get_mp3_source.sh
./configure --libdir=/usr/lib64 --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable res_config_mysql menuselect.makeopts
menuselect/menuselect --enable app_mysql menuselect.makeopts
menuselect/menuselect --enable cdr_mysql menuselect.makeopts
menuselect/menuselect --enable app_skel menuselect.makeopts
menuselect/menuselect --enable app_ivrdemo menuselect.makeopts
menuselect/menuselect --enable app_saycounted menuselect.makeopts
menuselect/menuselect --enable app_statsd menuselect.makeopts
menuselect/menuselect --enable app_fax menuselect.makeopts
menuselect/menuselect --enable app_macro menuselect.makeopts
menuselect/menuselect --enable codec_opus menuselect.makeopts
menuselect/menuselect --enable codec_g729a menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-WAV menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ULAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ALAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-G729 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-G722 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SLN16 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SIREN7 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SIREN14 menuselect.makeopts
make && make install
make samples
make config
ldconfig
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
chown asterisk. /var/run/asterisk
chown -R asterisk. /etc/asterisk
chown -R asterisk. /var/{lib,log,spool}/asterisk
chown -R asterisk. /usr/lib64/asterisk
mkdir /var/www/
mkdir /var/www/html
chown -R asterisk. /var/www/
sed -i 's/;runuser/runuser/' /etc/asterisk/asterisk.conf
sed -i 's/;rungroup/rungroup/' /etc/asterisk/asterisk.conf
sed -i 's/;hideconnect/hideconnect/' /etc/asterisk/asterisk.conf
yum -y install lynx tftp-server ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git crontabs cronie cronie-anacron wget vim uuid-devel sqlite-devel net-tools gnutls-devel unixODBC mysql-connector-odbc
yum -y install mariadb-server mariadb-client
systemctl enable --now mariadb
systemctl start mariadb

curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
yum install nodejs -y
node -v

yum -y install httpd mod_ssl
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
rm -f /var/www/html/index.html
systemctl restart httpd.service
sudo systemctl enable httpd
service firewalld stop
chkconfig firewalld off
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install php56w php56w-pdo php56w-mysql php56w-mbstring php56w-pear php56w-process php56w-xml php56w-opcache php56w-ldap php56w-intl php56w-soap -y
sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php.ini
cd ~/build
wget --no-check-certificate https://downloads.mariadb.com/enterprise/r8ex-kwwe/connectors/odbc/connector-odbc-2.0.9/mariadb-connector-odbc-2.0.9-beta-linux-x86_64.tar.gz
tar zxvf mariadb-connector-odbc-2.0.9-beta-linux-x86_64.tar.gz
mv mariadb-connector-odbc-2.0.9-beta-linux-x86_64/lib/libmaodbc.so /usr/lib64/
chown root:root /usr/lib64/libmaodbc.so
sed -i s/libmyodbc5/libmaodbc/ /etc/odbcinst.ini
ln -s /usr/lib64/libodbcinst.so.2 /usr/lib64/libodbcinst.so.1
ldd /usr/lib64/libmaodbc.so
cd ~/build
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz
tar xfz freepbx-15.0-latest.tgz
cd ~/build/freepbx
./start_asterisk start
./install -n
sudo fwconsole ma disablerepo commercial
sudo fwconsole ma enablerepo unsupported extended
sudo fwconsole ma installall
sudo fwconsole ma delete firewall sysadmin
fwconsole chown
fwconsole reload
service httpd restart
echo
my_primary_ip=$(ip route get 8.8.8.8 | head -1 | grep -Po '(\d+\.){3}\d+' | tail -n1)
echo "     Congratulations! Freepbx15 has been installed!"
echo
echo "     * Access Freepbx15 UI:"
echo "         http://$my_primary_ip"
echo "     * Access Secure Freepbx15 UI:"
echo "         https://$my_primary_ip"
echo "*------------------------------------------*"
echo "* NOTE: Please save the above information. *"
echo "* REBOOT YOUR SERVER TO COMPLETE INSTALL.  *"
echo "*------------------------------------------*"
		break
		;;
	*)
		echo "Sorry, Try again"
		;;
  esac
done

