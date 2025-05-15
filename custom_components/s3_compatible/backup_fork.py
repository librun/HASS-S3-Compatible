from homeassistant.components.backup import (
    AgentBackup,
    suggested_filename,
)

def suggested_filenames_with_dir(dir: str, backup: AgentBackup) -> tuple[str, str]:
    """Return the suggested filenames for the backup and metadata files."""
    base_name = suggested_filename(backup).rsplit(".", 1)[0]
    if len(dir) > 0:
        base_name = dir + "/" + base_name

    return f"{base_name}.tar", f"{base_name}.metadata.json"
