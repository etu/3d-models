{ pkgs, ... }:
pkgs.writers.writePython3Bin "strip-timestamps" { } ''
  import struct
  import json
  import zipfile
  import io
  import sys
  import re


  def fix_3mf(path):
      with zipfile.ZipFile(path) as zin:
          buf = io.BytesIO()
          with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as zout:
              for item in zin.infolist():
                  item.date_time = (1980, 1, 1, 0, 0, 0)
                  data = zin.read(item.filename)
                  if item.filename.endswith((".xml", ".model", ".rels")):
                      data = re.sub(
                          rb'<metadata name="(Creation|Modification)Date">[^<]*</metadata>[\n\r]*',
                          b"",
                          data,
                      )
                  zout.writestr(item, data)
      with open(path, "wb") as f:
          f.write(buf.getvalue())


  def fix_glb(path):
      with open(path, "rb") as f:
          data = f.read()
      if data[:4] != b"glTF":
          return
      magic, version, _ = struct.unpack("<III", data[:12])
      chunk_len, chunk_type = struct.unpack("<II", data[12:20])
      j = json.loads(data[20 : 20 + chunk_len])
      j.setdefault("asset", {}).pop("generator", None)
      json_bytes = json.dumps(j, separators=(",", ":"), sort_keys=True).encode()
      pad = (4 - len(json_bytes) % 4) % 4
      json_bytes += b" " * pad
      rest = data[20 + chunk_len :]
      new_total = 12 + 8 + len(json_bytes) + len(rest)
      with open(path, "wb") as f:
          f.write(struct.pack("<III", magic, version, new_total))
          f.write(struct.pack("<II", len(json_bytes), chunk_type))
          f.write(json_bytes)
          f.write(rest)


  fix_3mf(sys.argv[1])
  fix_glb(sys.argv[2])
''
