#!/usr/bin/env python3

from config import config
from subprocess import run
cfg = config(section="postgres")

cmd = f"""
podman run -d \\
       --name forum-db \\
        -e POSTGRES_USER={cfg['user']} \\
        -e POSTGRES_PASSWORD={cfg['password']} \\
        -e POSTGRES_DB={cfg['database']} \\
        -p {cfg['port']}:5432 \\
        -v $PWD/pgdata:/var/lib/postgresql/data:rw,Z \\
    postgres:12-alpine
"""
print(cmd)

# run(['sh', '-c', cmd])
