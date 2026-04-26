{
  description = "etu/3d-models";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      systems = [ "x86_64-linux" ];
      bp = inputs.blueprint { inherit inputs systems; };
      modelPackagesPerSystem = builtins.listToAttrs (
        map (system: {
          name = system;
          value = (import ./models.nix { pkgs = inputs.nixpkgs.legacyPackages.${system}; }).modelPackages;
        }) systems
      );
    in
    bp
    // {
      packages = builtins.mapAttrs (
        system: pkgs: pkgs // (modelPackagesPerSystem.${system} or { })
      ) bp.packages;
    };
}
