create table "brand" (
    id serial primary key,
    "name" varchar(32) unique
);
create table "phone" (
    id serial primary key,
    model varchar(64),
    brand_id int references brand(id) unique
);
--/*
insert into brand ("name") values ('xiaomi');
insert into brand ("name") values ('samsung');
insert into brand ("name") values ('apple');

insert into phone (model, brand_id)
values ('S22',(select id from brand where "name" = 'samsung'));

insert into phone (model, brand_id)
values ('Mi 9 Pro',(select id from brand where "name" = 'xiaomi'));
--*/