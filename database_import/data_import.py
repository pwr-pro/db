import csv
import psycopg2

conn = psycopg2.connect("dbname=phones user=user password=pass host=127.0.0.1")
cur = conn.cursor()
cur.execute("select * from phones.public.phone")
print(cur.fetchall())
# Separate Tables
# bluetooth_features
# camera -> mp, f, flash tf, resolution
# brand -> name
# cpu -> name, frequency
# gpu -> name
# chipset -> name
# color -> name
# sim -> type string
# memory card -> dedicated slot (bool), max storage
# network (5G etc) varchar
# connector (type-c) etc
#
# phone:
#   model
#   release: date
#   height: cm
#   width
#   thickness
#   resolution
#   ppi
#   internal memory
#   ram: []int
#   wifi: []varchar (802.11ax)
#   loud_speaker:bool
#   audio_jack
#   bluetooth_version
#   gps
#   nfc
#   radio
#   battery_capacity
#   battery_removable
#   image_url
#

# brand[0], model[1], network_technology[2], 2G_bands[3], 3G_bands[4], 4G_bands[5], network_speed[6], GPRS[7], EDGE[8], announced[9], status[10],
# dimentions[11], weight_g[12], weight_oz[13], SIM[14], display_type[15], display_resolution[16], display_size[17], OS[18], CPU[19], Chipset[20], GPU[21],
# memory_card[22], internal_memory[23], RAM[24], primary_camera[25], secondary_camera[26], loud_speaker[27], audio_jack[28], WLAN[29], bluetooth[30],
# GPS[31], NFC[32], radio[33], USB[34], sensors[35], battery[36], colors[37], approx_price_EUR[38], img_url[39]
#with open('initial-dataset.csv') as csvfile:
#    r = csv.reader(csvfile, delimiter=',')
#    arr = []
#    for l in r:
#        arr.append(l[3])
        #if l[0] not in brands:
        #    brands.append(l[0])

