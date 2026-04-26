{ pkgs, ... }:
let
  modelPackages = (import ../models.nix { inherit pkgs; }).modelPackages;
in
pkgs.runCommand "allModels" { } ''
  ${builtins.concatStringsSep "\n" (
    map (pkgName: ''
      mkdir -p $out/${pkgName}
      ln -s ${modelPackages.${pkgName}}/* $out/${pkgName}/
    '') (builtins.attrNames modelPackages)
  )}
''
