
mkdir -p www.baseball-reference.com/data
wget http://www.baseball-reference.com/data/war_daily_bat.txt   -O www.baseball-reference.com/data/batting_war-`date +%Y%m%d`.csv
wget http://www.baseball-reference.com/data/war_daily_pitch.txt -O www.baseball-reference.com/data/pitching_war-`date +%Y%m%d`.csv

wget -x http://seanlahman.com/files/database/lahman-csv_2014-02-14.zip
wget -x http://seanlahman.com/files/database/lahman2012-sql.zip
wget -x http://seanlahman.com/files/database/readme2012.txt
wget -x http://seanlahman.com/files/database/2013-revisions.txt

wget -r -np http://examples.oreilly.com/9780596009427
ln -s examples.oreilly.com/9780596009427 examples.oreilly.com/baseball_hacks

for foo in 19{2,3,4,5,6,7,8,9}0 20{0,1}0 ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/events/${foo}seve.zip ; done
for foo in 19{1,2,3,4,5,6,7}0            ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/events/${foo}sbox.zip ; done
for foo in 19{1,2,3,4,5}0                ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/events/${foo}sdis.zip ; done
for foo in allas allpost                 ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/events/$foo.zip ; done
for foo in ws as wc dv lc                ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/gamelogs/gl$foo.zip  ; done

for foo in 1871_99 19{00_19,20_39,40_59,60_69,70_79,80_89,90_99] 20{00_09,10_13} ; do echo "  === $foo" ; wget -x http://www.retrosheet.org/gamelogs/gl$foo.zip  ; done

wget -x http://www.retrosheet.org/parkcode.txt
wget -x http://www.retrosheet.org/gamelogs/glfields.txt
wget -x http://www.hardballtimes.com/images/uploads/retrosheet.zip
wget -x http://www.hardballtimes.com/tht-live/building-a-retrosheet-database-the-short-form

wget -r ftp://ftp.baseballgraphs.com/winshares/
