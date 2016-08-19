
use matzip;
create table matzip_member(
 day timestamp not null,
 id varchar(30) primary key,
 password varchar(30) not null,
 nickname varchar(30) not null,
 phone varchar(20) not null,
 zip_code varchar(15) not null,
 address1 varchar(150) not null,
 address2 varchar(200) not null,
 photo varchar(1000) not null,
 grade varchar(15) not null
 );
insert into matzip_member value('2016-08-16 10:44:23.0','6666','6666','4444','01044446666','53567','대구시 남구 대명동 1123','1111','default.jpg','1');
select substr(day,1,10), id from matzip_member;


insert into matzip_member value('2016-08-16 10:44:23.0','6666','6666','4444','01044446666','53567','대구 남구 대명동 1123','1111','default.jpg','1');
insert into matzip_member value('2016-08-15 10:44:23.0','7777','7777','4444','01044446666','53567','대전 남구 대명동 1123','1111','default.jpg','1');
insert into matzip_member value('2016-08-14 10:44:23.0','8888','8888','4444','01044446666','53567','대전 남구 대명동 1123','1111','default.jpg','1');

select substr(day,1,10), id from matzip_member;


select substr(day,6) as day, count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 7;
select substr(day,6) as day, count(id) as num from (select substr(day,1,10) as day, id from matzip_member) c group by c.day order by day desc limit 30;
