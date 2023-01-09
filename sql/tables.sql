create table "user"
(
    user_id  serial primary key,
    "email"    varchar(128) unique not null ,
    "password" varchar(128) not null ,
    "is_admin" bool default false
);
create table "brand_subscription"
(
    "user_id"  int references "user" (user_id) on delete cascade ,
    "brand_id" int references "brand" (brand_id) on delete cascade ,
    primary key (user_id, brand_id)
);
create table "phone_subscription"
(
    "user_id"  int references "user" (user_id) on delete cascade,
    "phone_id" int references "phone" (phone_id) on delete cascade,
    primary key (user_id, phone_id)
);
create table "comment"
(
    comment_id        serial primary key,
    "content"           varchar not null,
    "score"             int default 0, -- TODO: calculate with a trigger
    "user_id"           int references "user"(user_id) not null,
    "phone_id"          int references phone (phone_id) not null
);

create table "user-vote" (
    user_id int references "user"(user_id) not null,
    comment_id int references comment(comment_id) not null,
    primary key (user_id, comment_id)
);





create table "camera" (
    "camera_id" serial primary key,
    "mp" int4,
    "f" float4,
    "flash" bool,
    "resolution" int
);

create table "brand" (
                         "brand_id" serial primary key,
                         "name" varchar(16)
);
create table "cpu" (
  "cpu_id" serial primary key,
  "name" varchar(12),
  "frequency" float4,
  unique ("frequency", "name")
);
create table "gpu" (
  "gpu_id" serial primary key,
  "name" varchar(64)
);
create table "chipset" (
                           chipset_id serial primary key,
                           "name" varchar(23) unique
);
create table "color" (
  "color_id" serial primary key,
  "name" varchar(64)
);
create table "sim" (
                       "sim_id" serial primary key,
                       "type" varchar(16)
);

create table "network" (
    "network_id" serial primary key,
    "symbol" varchar(16)-- 2G 4G etc
);


create table "phone"
(
    phone_id          serial PRIMARY KEY,
    "model"             varchar(64) NOT NULL,
    "brand_id"          int references brand (brand_id),
    "release"           date,
    "height"            float4,
    "width"             float4,
    "thickness"         float4,
    "resolution"        varchar(12), -- 1024x720
    "ppi"               int,
    "color_id"          varchar(32),
    "chipset_id"        int references chipset (chipset_id),
    "gpu_id"            int references gpu (gpu_id),
    "memory_card_max_gb"   int,
    "memory_card_dedicated" bool,
    "internal memory"   int4[],
    "ram"               int4[],
    "wifi"              varchar(16)[],

    "connector"         varchar(32),
    "loud_speakers"     bool,
    "audio_jack"        bool,
    "bluetooth_version" float4,
    "gps"               bool,
    "nfc"               bool,
    "radio"             bool,
    "battery_capacity"  int,
    "battery_removable" int,
    "image_url"         varchar(128) -- check length of urls
);

create table "phone-cpu" (
    -- 1 phone multiple cpus (each core separate cpu)
                             "phone_id" int references phone(phone_id) on delete cascade,
                             "cpu_id" int references cpu(cpu_id) on delete cascade,
                             primary key (phone_id, cpu_id)
);
create table "phone-network" (
                                 "phone_id" int references phone(phone_id) on delete cascade,
                                 "network_id" int references network(network_id) on delete cascade,
                                 primary key (phone_id, network_id)
);
create table "phone-sim" (
    phone_id int references phone(phone_id) on delete cascade,
    sim_id int references sim(sim_id) on delete cascade,
    primary key (phone_id, sim_id)
);
create table "phone-camera" (
                                            phone_id int references phone(phone_id) on delete cascade,
                                            camera_id int references camera(camera_id) on delete cascade,
                                            primary key (phone_id, camera_id)
);