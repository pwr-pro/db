create table "user"
(
    "id"       serial primary key,
    "email"    varchar(128) unique not null ,
    "password" varchar(128) not null ,
    "is_admin" bool default false
);
create table "brand_subscription"
(
    "user_id"  int references "user" (id) on delete cascade ,
    "brand_id" int references "brand" (id) on delete cascade ,
    primary key (user_id, brand_id)
);
create table "phone_subscription"
(
    "user_id"  int references "user" (id) on delete cascade,
    "phone_id" int references "phone" (id) on delete cascade,
    primary key (user_id, phone_id)
);
create table "comment"
(
    "id"                serial primary key,
    "content"           varchar not null,
    "score"             int default 0, -- TODO: calculate with a trigger
    "user_id"           int references "user"(id) not null ,
    "phone_id"          int references phones.public.phone (id) not null
);

create table "user-vote" (
    user_id int references "user"(id) not null,
    comment_id int references comment(id) not null,
    primary key (user_id, comment_id)
);
-- TODO: Error if null!!!
-- find user id by email
create function user_by_email(searched_mail varchar(128))
    returns int
    language plpgsql
  as
$$
declare user_id int;
begin
    select id
    into user_id
    from "user"
    where "user".email = searched_mail;
    return user_id;
end;
$$;

-- find user id by email
create function phone_by_model(searched_name varchar(128))
    returns int
    language plpgsql
as
$$
declare phone_id int;
begin
    select id
    into phone_id
    from phone
    where phone.model = searched_name;
    return phone_id;
end;
$$;

-- User Registration
insert into "user" ("email", "password")
values ('test1@example.com', 'dupa8');


-- Commenting
insert into "comment" (content, user_id, phone_id)
values ('Nie polecam !!!',
        (select id from "user" where email = 'test1@example.com'),
        (select id from "phone" where model = 'Mi 9 Pro')
);

-- Reacting to a comment
insert into "user-vote" (user_id, comment_id)
values ((select id from "user" where email = 'test1@example.com'),true);

-- Brand/Phone Subscription
insert into phone_subscription (user_id, phone_id)
values (user_by_email('test1@example.com'),phone_by_model('Mi 9 Pro'));
values (user_by_email('test1@example.com'),phone_by_model('S22'));

-- Phones Query
select model, "name" as brand_name from phone
join brand b on b.id = phone.brand_id;

-- Comments Query
select email, model, "content" as "comment" from "comment"
left join phone p on comment.phone_id = p.id
left join "user" on comment.user_id = "user".id