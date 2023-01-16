#!/usr/bin/env python3
import json
import psycopg2
from sys import argv, exit

from config import config


def import_phones(path):
    conn = psycopg2.connect(**config("postgres"))
    """
    insert into 
    """

    phones = json.load(open(path))
    with conn.cursor() as cur:
        for p in phones:
            queries = [
                f"""insert into brand("name") values ('{p['brand']}') on conflict do nothing;""",
                f"""insert into chipset("name") values ('{p['chipset']}') on conflict do nothing """,
                f"""insert into cpu("name") values ('{p['cpu']}') on conflict do nothing """,
                f"""insert into gpu("name") values ('{p['gpu']}') on conflict do nothing  """,
                f"""insert into phone (model, brand_id, release, height, width, thickness, resolution,
                       ppi, cpu_id,chipset_id, gpu_id,
                       memory_card_dedicated,
                       internal_memory, ram, wifi,sim,  connector,
                       audio_jack, bluetooth_version,
                       gps, nfc, radio, battery_capacity, battery_removable, image_url)
                    values ('{p['model']}',
                    (select brand_id from brand where "name" = '{p['brand']}'),
                    date'{p['release']}', '{p['height']}', '{p['width']}', '{p['thickness']}', '{p['resolution']}', '{p['ppi']}',
                    (select cpu_id from cpu where "name" = '{p['cpu']}'),
                    (select chipset_id from chipset where "name" = '{p['chipset']}'),
                    (select gpu_id from gpu where "name" = '{p['gpu']}'), {p['memory_card_dedicated']},
                    array {str(p['internal_memory'])}, array {str(p['ram'])}, '{p['wifi']}','{p['sim']}', '{p['connector']}', {p['audio_jack']}, {p['bluetooth_version']},
                     {p['gps']}, {p['nfc']}, {p['radio']}, {p['battery_capacity']}, {p['battery_removable']}, '{p['image_url']}')
                     on conflict do nothing;""", ]
            for q in queries:
                print(q)
                cur.execute(q)
            for camera in p['camera']:
                cur.execute(
                    f"insert into camera (mp, f) values({camera['mp']},{camera['f']}) on conflict do nothing;")
                cur.execute(f"""
                insert into "phone-camera" (phone_id, camera_id) 
                values (
                  (select phone_id from phone where phone.model = '{p['model']}'),
                  (select camera_id from camera where camera.mp = '{camera['mp']}' and camera.f = '{camera['f']}')
                ) on conflict do nothing ;
                """)
            conn.commit()
    print("Closed connection to database.")


def main():
    if len(argv) < 2:
        print(r"Please provide valid `phones.json` file to import.")
        exit(1)
    else:
        for file in argv[1:]:
            import_phones(file)


if __name__ == "__main__":
    main()
