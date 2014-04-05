
Download Retrosheet database: http://www.baseballheatmaps.com/retrosheet-database-download/

echo CREATE DATABASE retrosheet |  mysql -u root ; cat compressed/retrosheet.sql | mysql -u root retrosheet
for foo in 20*_retrosheet.sql ; do echo "  === $foo" ; echo CREATE DATABASE `basename $foo .sql` |  mysql -u root ; cat $foo | mysql -u root `basename $foo .sql` ; done
for foo in 19*}s_retrosheet.sql ; do echo "  === $foo" ; echo cat $foo mysql -u root ; done

