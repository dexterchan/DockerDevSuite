#!/bin/sh
sudo mkdir -p /opt/oracle/
ORACLE_CLIENT_VERSION=instantclient_21_5

# setup for cx_oracle
cd /opt/oracle/
sudo yum install -y unzip
sudo curl -o oracleclient.zip "https://download.oracle.com/otn_software/linux/instantclient/215000/instantclient-basic-linux.x64-21.5.0.0.0dbru.zip"
# Note: odbc driver also requires the download of basic client!!!
sudo curl -o oracleodbc.zip "https://download.oracle.com/otn_software/linux/instantclient/215000/instantclient-odbc-linux.x64-21.5.0.0.0dbru.zip"
sudo unzip oracleclient.zip
sudo unzip oracleodbc.zip 
sudo yum install -y libaio

sudo sh -c "echo /opt/oracle/${ORACLE_CLIENT_VERSION} > \
      /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig

echo export LD_LIBRARY_PATH=/opt/oracle/${ORACLE_CLIENT_VERSION}:$LD_LIBRARY_PATH >> ~/.bashrc
echo export PATH=/opt/oracle/${ORACLE_CLIENT_VERSION}:$PATH  >> ~/.bashrc
sudo yum install  python3-pip  -y
python3 -m pip  install --user cx_oracle



# In Redhat , install unixodbc with yum
sudo yum install unixODBC unixODBC-devel

#Installing the unixODBC with library build in case of repository not supporting unixODBC
# # reference https://github.com/mkleehammer/pyodbc/wiki/Install
# # reference https://github.com/mkleehammer/pyodbc/wiki/Connecting-to-Oracle-from-RHEL-or-Centos
# # sudo yum group install "Development Tools" -y
# sudo yum install gcc-c++ -y
# cd /tmp
# wget ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.4.tar.gz
# tar -xf unixODBC-2.3.4.tar.gz
# cd unixODBC-2.3.4/
# ./configure -sysconfdir=/etc 1> conf_std.log 2> conf_err.log
# make 1> mk_std.log 2> make_err.log
# sudo make install 1> mki_std.log 2> mki_err.log
# echo export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH >> ~/.bashrc
# echo export PATH=/usr/local/lib:$PATH >> ~/.bashrc

cd /opt/oracle/${ORACLE_CLIENT_VERSION} 
#reference https://github.com/mkleehammer/pyodbc/wiki/Connecting-to-Oracle-from-RHEL-or-Centos
echo Populate Oracle ODBC driver configuration into /etc/odbcinst.ini 
sudo sh odbc_update_ini.sh /
echo config file is in /etc/odbcinst.ini

#pyodbc requires build tools
#sudo yum group install "Development Tools" -y
sudo yum install gcc-c++ -y
sudo yum install  python3-pip python3-devel -y
python3 -m pip  install --user pyodbc