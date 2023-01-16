#!/usr/bin/env python3

from config import config
from subprocess import run
from pathlib import PurePath

cfg = config(section="postgres")

cmd = f"""
podman run -d \\
       --name TelefonyDB-1 \\
        -e POSTGRES_USER={cfg['user']} \\
        -e POSTGRES_PASSWORD={cfg['password']} \\
        -e POSTGRES_DB={cfg['database']} \\
        -p {cfg['port']}:5432 \\
        -v {PurePath(__file__).parents[1]}/pgdata:/var/lib/postgresql/data:rw,Z \\
    postgres:12-alpine
"""
print(cmd)

run(['sh', '-c', cmd])
