{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "update-models";
  runtimeInputs = [ pkgs.jq ];
  text = ''
    if [[ $# -ne 2 ]]; then
      echo "usage: update-models <release> <dest>" >&2
      exit 1
    fi

    release=$1
    dest=$2
    new_meta=$release/metadata.json
    old_meta=$dest/metadata.json

    if [[ ! -f "$new_meta" ]]; then
      echo "error: $new_meta not found" >&2
      exit 1
    fi

    mkdir -p "$dest"

    # Index old metadata by name -> sourceHash for fast lookup
    declare -A old_hashes
    if [[ -f "$old_meta" ]]; then
      while IFS=$'\t' read -r name hash; do
        old_hashes[$name]=$hash
      done < <(jq -r '.[] | [.name, .sourceHash] | @tsv' "$old_meta")
    fi

    updated=0
    skipped=0

    while IFS=$'\t' read -r name hash; do
      if [[ "''${old_hashes[$name]:-}" == "$hash" ]]; then
        echo "skip $name (source unchanged)"
        skipped=$((skipped + 1))
      else
        echo "copy $name (source changed)"
        for ext in 3mf glb; do
          src=$release/models/$name.$ext
          [[ -f "$src" ]] && cp "$src" "$dest/$name.$ext"
        done
        updated=$((updated + 1))
      fi
    done < <(jq -r '.[] | [.name, .sourceHash] | @tsv' "$new_meta")

    cp "$new_meta" "$old_meta"
    echo "done: $updated updated, $skipped skipped"
  '';
}
