FROM mysql:5.6.34

COPY config/my.cnf /etc/mysql/conf.d/my.cnf

# timezoneを変更
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
