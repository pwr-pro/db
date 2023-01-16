#!/usr/bin/env python3

from pathlib import PurePath
from os.path import exists
from sys import exit
from psycopg2 import connect


from config import config



tables_sql = PurePath(__file__).parents[1] / "sql" / "tables.sql"

if not exists(tables_sql):
    print(f"error file {tables_sql} doesn't exist")
    exit(1)

with open(tables_sql) as sql_file:
    sql_statements = sql_file.read()
    conn = connect(**config("postgres"))
    with conn.cursor() as crsr:
        print("Database Connection Established.")
        crsr.execute(sql_statements)
    conn.commit();
    print("Writing Tables to Database.")
    print("Database Connection Closed.")
