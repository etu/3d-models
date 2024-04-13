{
  description = "Flake with 3d models";

  inputs = {
    # Main nixpkgs channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Dependency used for several pakages
      # https://www.printables.com/model/439440
      elephantStand = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/439440/stls/3631985_8486b45f-085f-4228-af0c-b3e8f0a1a5a6/elephant_stand.stl";
        sha256 = "sha256:0d2rbydn83j4hlhlbf0b2h7jsynygd6ifb0xr5i42w0sxxjkx24j";
      };

      # https://www.printables.com/model/309327
      rockWallHoldKnob1 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689887_f1e9ae5b-1fa4-4726-ab11-fec3baabdb3d/rock-wall-hold-knob-1.stl";
        sha256 = "sha256:1zb4kfvr6hyzi2cx0dfzrpv9jsziyzwb7gyivak2b35adf78w0hc";
      };
      rockWallHoldKnob2 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689889_5391558d-0d32-4261-86cb-ae08737bcbc0/rock-wall-hold-knob-2.stl";
        sha256 = "sha256:0jc77vybz4hlp10cvys5s34cyj81dqac0gkgd55rhkwmdiazqc4v";
      };
      rockWallHoldKnob3 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689886_abd27929-895c-4d18-9104-3c4d82d0f7c6/rock-wall-hold-knob-3.stl";
        sha256 = "sha256:132lvq7k84cha7zaxlilgp57kzy11b2hz02r85bqhcbrp5vj0jy2";
      };
      rockWallHoldKnob4 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689890_36d796a3-97d9-4815-b6fd-e895557f20a5/rock-wall-hold-knob-4.stl";
        sha256 = "sha256:006kp3nsqa02rivsm2y7xwgpvrg1vbv6ffrpjrb3mc1x02yh8n9g";
      };
      rockWallHoldKnob5 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689888_4eee9b1b-f040-4182-8062-362e27d6bcd7/rock-wall-hold-knob-5.stl";
        sha256 = "sha256:1c8k307cacibiy9dax80knxz45acmp2miav4fxpkp1qkab6x2x8c";
      };
      rockWallHoldKnob6 = builtins.fetchurl {
        url = "https://files.printables.com/media/prints/309327/stls/2689891_5b761490-e751-4f2b-a0f8-696b98878f79/rock-wall-hold-knob-6.stl";
        sha256 = "sha256:0d3d1cifdfv927xhgw59y4vgajsrm2w7xwj3v294iyq15l5rcsi2";
      };

      # Helper function to build scad files to 3mf, stl and gbl files.
      mkOpenscad = args: (pkgs.stdenv.mkDerivation (let
        _2gltf2 = pkgs.fetchFromGitHub {
          repo = "2gltf2";
          owner = "ux3d";
          rev = "5f34c0c3ed7750d22d0d0649a4a6b4630d5be255";
          hash = "sha256-Hch+wiAX1VnV2w3xL8WLZjq4ojV9ml6lQDcsouWakTs=";
        };
      in
        args
        // {
          buildInputs = [
            pkgs.blender
            pkgs.openscad-unstable
          ];
          dontUnpack = true;
          patchPhase = ''
            runHook prePatch

            cp $src model.scad

            runHook postPatch
          '';
          buildPhase = ''
            runHook preBuild

            openscad -o model.3mf --export-format 3mf    model.scad
            openscad -o model.stl --export-format binstl model.scad
            blender -noaudio -b -P ${_2gltf2}/2gltf2.py -- model.stl

            runHook postBuild
          '';
          installPhase = ''
            runHook preInstall

            mkdir -p $out
            mv model.3mf model.stl model.glb $out

            runHook postInstall
          '';
          meta =
            {
              license = args.meta.license or pkgs.lib.licenses.cc-by-nc-sa-40;
            }
            // (args.meta or {});
        }));
    in {
      formatter = pkgs.alejandra;

      packages = {
        beadsCuteElephant = mkOpenscad {
          name = "beadsCuteElephant";
          src = ./models/beads/cute-elephant.scad;
          postPatch = ''
            sed -i 's#elephant_stand.stl#${elephantStand}#' model.scad
          '';
          meta.description = "Beads: Cute Elephant";
          meta.longDescription = ''
            This is a bead in the shape of a small and cute elephant.

            You can use it for whatever you use beads for.
          '';
          meta.homepage = "https://www.printables.com/model/712098";
        };
        beadsNixosLogo = mkOpenscad {
          name = "beadsNixosLogo";
          src = ./models/beads/nixos-logo.scad;
          meta.description = "Beads: NixOS Logo";
          meta.longDescription = ''
            This is a bead in the shape of a NixOS logo.

            You can use it for whatever you use beads for.
          '';
          meta.homepage = "https://www.printables.com/model/712021";
        };
        businessCardHolder = mkOpenscad {
          name = "businessCardHolder";
          src = ./models/business-card-holder.scad;
          meta.description = "Business Card Holder";
          meta.longDescription = ''
            This is a business card holder. The original Openscad model is
            very flexible and can be customized to fit your needs.
          '';
          meta.homepage = "https://www.printables.com/model/710837";
        };
        cabinetHook = mkOpenscad {
          name = "cabinetHook";
          src = ./models/cabinet-hook.scad;
          meta.description = "Cabinet Hook";
          meta.longDescription = "Hook for hanging stuff in one of my cabinets.";
        };
        garbageBinHook = mkOpenscad {
          name = "garbageBinHook";
          src = ./models/garbage-bin-hook.scad;
          meta.description = "Garbage Bin Hook";
          meta.longDescription = "Hook for hanging a garbage bin under my sink.";
        };
        keychainClimberHoldKnob1 = mkOpenscad {
          name = "keychainClimberHoldKnob1";
          src = ./models/keychains/keychain-climbing-hold-knob-1.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_1.stl#${rockWallHoldKnob1}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 1";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainClimberHoldKnob2 = mkOpenscad {
          name = "keychainClimberHoldKnob2";
          src = ./models/keychains/keychain-climbing-hold-knob-2.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_2.stl#${rockWallHoldKnob2}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 2";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainClimberHoldKnob3 = mkOpenscad {
          name = "keychainClimberHoldKnob3";
          src = ./models/keychains/keychain-climbing-hold-knob-3.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_3.stl#${rockWallHoldKnob3}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 3";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainClimberHoldKnob4 = mkOpenscad {
          name = "keychainClimberHoldKnob4";
          src = ./models/keychains/keychain-climbing-hold-knob-4.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_4.stl#${rockWallHoldKnob4}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 4";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainClimberHoldKnob5 = mkOpenscad {
          name = "keychainClimberHoldKnob5";
          src = ./models/keychains/keychain-climbing-hold-knob-5.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_5.stl#${rockWallHoldKnob5}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 5";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainClimberHoldKnob6 = mkOpenscad {
          name = "keychainClimberHoldKnob6";
          src = ./models/keychains/keychain-climbing-hold-knob-6.scad;
          postPatch = ''
            sed -i 's#Rock_wall_hold_knob_6.stl#${rockWallHoldKnob6}#' model.scad
          '';
          meta.description = "Keychain: Climber hold Knob 6";
          meta.longDescription = "Keyring in the shape of a climbing hold.";
          meta.homepage = "https://www.printables.com/model/842346";
        };
        keychainLabel = mkOpenscad {
          name = "keychainLabel";
          src = ./models/keychains/keychain-label.scad;
          meta.description = "Keyring with text";
        };
        lampTopCorner = mkOpenscad {
          name = "lampTopCorner";
          src = ./models/lamp-top-corner.scad;
          meta.description = "Lamp top corner";
          meta.longDescription = "Top corner for a lamp for a relative where the original part broke.";
        };
        logitechCameraHolder = mkOpenscad {
          name = "logitechCameraHolder";
          src = ./models/logitech-camera-holder.scad;
          meta.description = "Holder for a Logitech camera";
          meta.longDescription = "Holder for a Logitech camera where I've removed the original case..";
        };
        magnetsCuteElephant = mkOpenscad {
          name = "magnetsCuteElephant";
          src = ./models/magnets/cute-elephant-magnet.scad;
          postPatch = ''
            sed -i 's#elephant_stand.stl#${elephantStand}#' model.scad
          '';
          meta.description = "Magnet: Cute Elephant";
          meta.longDescription = "This is a magnet in the shape of a small and cute elephant.";
          meta.homepage = "https://www.printables.com/model/734325";
        };
        paperFoodGarbageBagHolder = mkOpenscad {
          name = "paperFoodGarbageBagHolder";
          src = ./models/paper-food-garbage-bag-holder.scad;
          meta.description = "Holder for a paper food garbage bags under the sink.";
        };
        ringToy = mkOpenscad {
          name = "ringToy";
          src = ./models/ring-toy.scad;
          meta.description = "Customizable ring toy";
          meta.homepage = "https://www.printables.com/model/711269";
        };
        roborockStopperForDryerStand = mkOpenscad {
          name = "roborockStopperForDryerStand";
          src = ./models/roborock-stopper-for-dryer-stand.scad;
          meta.description = "Roborock Stopper for Dryer Stand";
          meta.longDescription = "Stopper for a Roborock vacuum cleaner to prevent it from getting stuck on my dryer stand.";
        };
        routerHolder = mkOpenscad {
          name = "routerHolder";
          src = ./models/router-holder.scad;
          meta.description = "Holder for a router";
        };
        shoppingCartFakeCoin = mkOpenscad {
          name = "shoppingCartFakeCoin";
          src = ./models/shopping-cart-fake-coin.scad;
          meta.description = "Fake coin 10SEK";
          meta.longDescription = "Fake coin for shopping carts in the shape of 10SEK.";
          meta.homepage = "https://www.printables.com/model/711248";
        };
        sparvHooksNerfRifleWallHooks = mkOpenscad {
          name = "sparvHooksNerfRifleWallHooks";
          src = ./models/sparv-hooks/nerf-rifle-wall-hooks.scad;
          meta.description = "Sparv hooks: Nerf rifle hooks";
        };
        tableStabilizier = mkOpenscad {
          name = "tableStabilizier";
          src = ./models/table-stabilizier.scad;
          meta.description = "Stabilizer for a table";
        };
        toothbrushHolder = mkOpenscad {
          name = "toothbrushHolder";
          src = ./models/toothbrush-holder.scad;
          meta.description = "Toothbrush holder";
        };
        waterCo2MachineBottleStabilizer = mkOpenscad {
          name = "waterCo2MachineBottleStabilizer";
          src = ./models/water-co2-machine-bottle-stabilizer.scad;
          meta.description = "Stabilizer for a water CO2 machine bottle";
        };
        webcamLevler = mkOpenscad {
          name = "webcamLevler";
          src = ./models/webcam-levler.scad;
          meta.description = "Levler for a webcam";
        };
      };
    });
}
