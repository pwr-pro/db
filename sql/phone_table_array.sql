/*
TODO: cpu and gpu brands as tables
TODO: network band table
TODO: Sensors bool-s
*/
create table "camera" (
    "id" serial primary key,
    "mp" int4,
    "f" float4,
    "flash" bool,
    "resolution" int
);

create table "brand" (
                         "id" serial primary key,
                         "name" varchar(16)
);
create table "cpu" (
  "id" serial primary key,
  "name" varchar(12),
  "frequency" float4,
  unique ("frequency", "name")
);
create table "gpu" (
  "id" serial primary key,
  "name" varchar(64)
);
create table "chipset" (
                           id serial primary key,
                           name varchar(23) unique
);
create table "color" (
  "id" serial primary key,
  "name" varchar(64)
);
create table "sim" (
                       "id" serial primary key,
                       "type" varchar(16)
);

create table "network" (
    "id" serial primary key,
    "symbol" varchar(16)-- 2G 4G etc
);


create table "phone"
(
    "id"                serial PRIMARY KEY,
    "model"             varchar(64) NOT NULL,
    "brand_id"          int references brand (id),
    "release"           date,
    "height"            float4,
    "width"             float4,
    "thickness"         float4,
    "resolution"        varchar(12), -- 1024x720
    "ppi"               int,
    "color_id"          varchar(32),
    "chipset_id"        int references chipset (id),
    "gpu_id"            int references gpu (id),
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
                             "phone_id" int references phone(id) on delete cascade,
                             "cpu_id" int references cpu(id) on delete cascade,
                             primary key (phone_id, cpu_id)
);
create table "phone-network" (
                                 "phone_id" int references phone(id) on delete cascade,
                                 "network_id" int references network(id) on delete cascade,
                                 primary key (phone_id, network_id)
);
create table "phone-sim" (
    phone_id int references phone(id) on delete cascade,
    sim_id int references sim(id) on delete cascade,
    primary key (phone_id, sim_id)
);
create table "phone-camera" (
                                            phone_id int references phone(id) on delete cascade,
                                            camera_id int references camera(id) on delete cascade,
                                            primary key (phone_id, camera_id)
);
