/*
TODO: cpu and gpu brands as tables
TODO: network band table
TODO: Sensors bool-s
*/
create table "bluetooth_features" (
    "id" serial primary key,
    "name" varchar(48) unique
);
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

create table "memory_card" (
                               "id" serial primary key,
                               "dedicated_slot" bool,
                               "max_storage" int
);
create table "network" (
    "id" serial primary key,
    "symbol" varchar(16)-- 2G 4G etc
);
create table "connector" (
                             "id" serial primary key,
                             "name" varchar(24) unique
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
    "color_id"          int[] references color (id), -- lazy solution
    "chipset_id"        int references chipset (id),
    "gpu_id"            int references gpu (id),
    "memory_card_id"    int references memory_card (id),
    "internal memory"   int4[],
    "ram"               int4[],
    "wifi"              varchar(16)[],

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
create table "phone-connector" (
                                   "phone_id" int references phone(id) on delete cascade,
                                   "connector_id" int references connector(id) on delete cascade,
                                   primary key (phone_id, connector_id)

);
create table "phone-sim" (
    phone_id int references phone(id) on delete cascade,
    sim_id int references sim(id) on delete cascade,
    primary key (phone_id, sim_id)
);
create table "phone-bluetooth_features" (
                                            phone_id int references phone(id) on delete cascade,
                                            bluetooth_features_id int references bluetooth_features(id) on delete cascade,
                                            primary key (phone_id, bluetooth_features_id)
);
create table "phone-camera" (
                                            phone_id int references phone(id) on delete cascade,
                                            camera_id int references camera(id) on delete cascade,
                                            primary key (phone_id, camera_id)
);
