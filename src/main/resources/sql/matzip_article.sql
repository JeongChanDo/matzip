create table matzip_article(
  time timestamp not null default now(),
  board_no int not null,
  article_no int auto_increment primary key,
  title varchar(50) not null,
  content varchar(20000) not null,
  writer varchar(30) not null,
  nickname varchar(30) not null,
  view int not null default 0,
  good int not null default 0,
  photo varchar(500),
  seq int not null default 0,
  comment int not null default 0
);