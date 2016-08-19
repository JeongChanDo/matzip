CREATE database matzip;

use matzip;
drop table matzip;
create table matzip(
  no int primary key,
  upso_code varchar(10),
  upso_name varchar(20),
  upso_addr varchar(50),
  upso_tel varchar(15),
  uptae_name varchar(10));

INSERT INTO matzip VALUES(001, 'mat001', '알쭈', '서울특별시 구로구 고척동 52번지 199호 (고척길14)지상1층', '02-2066-8129', '치킨');
INSERT INTO matzip VALUES(002, 'mat002', 'e-어도참치 구로구청점', '서울특별시 구로구 구로동 86번지 5호', '011-557-1174', '한식');
INSERT INTO matzip VALUES(003, 'mat003', '무궁화대구탕', '서울특별시 구로구 구로동 735번지 8호', '02-865-7361', '한식');
INSERT INTO matzip VALUES(004, 'mat004', '시나브로', '서울특별시 구로구 구로동 685번지 212호 -103', '010-3169-5059', '분식');
INSERT INTO matzip VALUES(005, 'mat005', '천하제일왕족발', '서울특별시 구로구 고척동 76번지 38호 원메디타운 2층 제201호', '010-3169-5057', '한식');
INSERT INTO matzip VALUES(006, 'mat006', '땡큐맘치킨', '서울특별시 구로구 개봉동 357번지 13호 비동', '010-1621-4735', '치킨');
INSERT INTO matzip VALUES(007, 'mat007', '야심식당', '서울특별시 구로구 개봉동 279번지 5호 (버들길26)지상1층', '010-6379-9486', '한식');
INSERT INTO matzip VALUES(008, 'mat008', '엘에이(LA)북창동순두부신도림점','서울특별시 구로구 신도림동 337번지 (경인로264)대우푸르지오214/229호', '010-0000-0000', '한식');
INSERT INTO matzip VALUES(009, 'mat009', '남광호프', '서울특별시 구로구 구로동 738번지 65호', '02-869-1258', '호프');
INSERT INTO matzip VALUES(010, 'mat010', '서브웨이', '서울특별시 구로구 구로동 811번지 코오롱싸이언스밸리 109호', '02-850-2508', '기타');
INSERT INTO matzip VALUES(011, 'mat011', '파티오(PATIO)', '서울특별시 구로구 구로동 544번지', '010-3369-3485', 'duddirtlr');
INSERT INTO matzip VALUES(012, 'mat012', '동북반점', '서울특별시 구로구 가리봉동 124번지 4호  1층','02-1234-5678', '중식');
INSERT INTO matzip VALUES(013, 'mat013', '로타리호프', '서울특별시 구로구 개봉동 278번지 21호','02-1234-5678','호프');
INSERT INTO matzip VALUES(014, 'mat014', '맛나 칼국수', '서울특별시 구로구 구로동 738번지 37호', '02-1234-5678', '한식');
INSERT INTO matzip VALUES(015, 'mat015', 'Siesta coffee(씨에스타)', '서울특별시 구로구 구로동 212번지 16호 벽산디지털밸리 101호 일부', '02-868-3553', '까페');
INSERT INTO matzip VALUES(016, 'mat016', '홍스 쭈꾸미',	'서울특별시 구로구 구로동 31번지 3호 (은행나무길 8) 2층','016-644-5065', '한식');
INSERT INTO matzip VALUES(017, 'mat017', '마초짬뽕', '서울특별시 구로구 구로동 104번지 1층', '010-3072-3511', '중식');
INSERT INTO matzip VALUES(018, 'mat018', 'e-어도참치 구로구청점', '서울특별시 구로구 구로동 86번지 5호', '011-557-1174', '한식');
INSERT INTO matzip VALUES(019, 'mat019', '길림양꼬치', '서울특별시 구로구 구로동 313번지 80호 1층', '010-9120-7511', '중식');
INSERT INTO matzip VALUES(020, 'mat020', '족발집', '서울특별시 구로구 오류동 42번지 6호 지상1층 1호', '02-2066-3939', '한식');

commit;
select * from matzip;



