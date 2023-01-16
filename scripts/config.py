from configparser import ConfigParser
from pathlib import PurePath

root_dir = PurePath(__file__).parents[1]


def config(section: str, field: str | None = None, config_file: PurePath = root_dir / "config.ini"):
    parser = ConfigParser()
    parser.read(config_file)
    options = {}
    if parser.has_section(section):
        params = parser.items(section)
        for p in params:
            options[p[0]] = p[1]
    else:
        raise Exception(f"Section{section} is not found in {config_file} file.")

    if not field:
        return options
    else:
        return options['field']
