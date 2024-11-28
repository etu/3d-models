[![Check](https://github.com/etu/3d-models/actions/workflows/check.yml/badge.svg)](https://github.com/etu/3d-models/actions/workflows/check.yml)

# 3D models I've made as a Nix Flake

You can list all tho models in this flake by running
`nix flake show github:etu/3d-models`. Then they can be built for more
useful formats (3mf and STL) by running
`nix build github:etu/3d-modules#<name>`.

Most of my models are OpenSCAD and the source for them is stored in
`models/` but I've also started to build some FreeCAD models which
lives in `freecad-models/`.
