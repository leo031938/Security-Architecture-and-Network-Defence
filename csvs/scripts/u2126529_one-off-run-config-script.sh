#Network create
docker network create --subnet=203.0.113.0/24 u2126529/csvs2023_n

cd ../builds/dbserver
#Insert database
docker exec -i u2126529_csvs2023-db_c mysql -uroot -pCorrectHorseBatteryStaple < sqlconfig/csvs23db.sql

#web:
cd ../webserver

#web SElinux:
sudo make -f /usr/share/selinux/devel/Makefile u2126529_web.pp
sudo semodule -i u2126529_web.pp
sudo semodule -l | grep u2126529_web

#db:
cd ../dbserver
#db SElinux:
sudo make -f /usr/share/selinux/devel/Makefile u2126529_db.pp
sudo semodule -i u2126529_db.pp
sudo semodule -l | grep u2126529_db

#db persistent
#Create volume for mysql
docker volume create mysql_volume

