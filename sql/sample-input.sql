insert into brand ("name") values ('Samsung');

insert into chipset ("name") values ('Exynos 2200');

insert into cpu ("name") values ('Octa-core (1x2.8 GHz Cortex-X2 & 3x2.50 GHz Cortex-A710 & 4x1.8 GHz Cortex-A510) ');
insert into gpu ("name") values ('Xclipse 920');

insert into phone (model, brand_id, release, height, width, thickness, resolution,
                   ppi, cpu_id,chipset_id, gpu_id,
                   memory_card_dedicated,
                   internal_memory, ram, wifi,sim,  connector,
                   audio_jack, bluetooth_version,
                   gps, nfc, radio, battery_capacity, battery_removable, image_url)
values ('Galaxy S22 Ultra 5G',
        (select brand_id from brand where "name" = 'Samsung'),
        date'2022-02-25', 163.3 /*mm*/, 77.9, 8.9, '1440 x 3088',
                         '500',
        (select cpu_id from cpu where "name" = 'Octa-core (1x2.8 GHz Cortex-X2 & 3x2.50 GHz Cortex-A710 & 4x1.8 GHz Cortex-A510)'),
        (select chipset_id from chipset where "name" = 'Exynos 2200'),
        (select gpu_id from gpu where "name" = 'Xclipse 920'), false,
           '{128,256, 512, 1024}', '{8, 12}', 'Wi-Fi 802.11 a/b/g/n/ac/6e','Nano-SIM and eSIM or Dual SIM (2 Nano-SIMs and eSIM, dual stand-by)', 'USB Type-C 3.2, OTG',
                          false, 5.2,
                         true, true, false, 5000, false, 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s22-ultra-5g.jpg');

insert into camera (mp, f)
VALUES (108, 1.8);
insert into camera (mp, f)
VALUES (10, 4.9);
insert into camera (mp, f)
VALUES (10, 2.4);
insert into camera (mp, f)
VALUES (12, 2.2);


insert into "phone-camera" (phone_id, camera_id)
values (
        (select phone_id from phone where phone.model = 'Galaxy S22 Ultra 5G'),
       (select camera_id from camera where camera.mp = 108 and camera.f = '1.8')
       );
insert into "phone-camera" (phone_id, camera_id)
values (
           (select phone_id from phone where phone.model = 'Galaxy S22 Ultra 5G'),
           (select camera_id from camera where camera.mp = 10 and camera.f = '4.9')
       );
insert into "phone-camera" (phone_id, camera_id)
values (
           (select phone_id from phone where phone.model = 'Galaxy S22 Ultra 5G'),
           (select camera_id from camera where camera.mp = 10 and camera.f = '2.4')
       );
insert into "phone-camera" (phone_id, camera_id)
values (
           (select phone_id from phone where phone.model = 'Galaxy S22 Ultra 5G'),
           (select camera_id from camera where camera.mp = 12 and camera.f = '2.2')
       );

select p.model, c.mp, c.f from "phone-camera"
left join phone p on p.phone_id = "phone-camera".phone_id
left join camera c on "phone-camera".camera_id = c.camera_id