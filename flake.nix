{
  description = "Realtime Vulkan ray tracing";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    carla = { url = "github:CTU-IIG/carla-simulator.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, carla,... }: let
    lib = {
      inherit (flake-utils.lib) defaultSystems eachSystem;
    };
    supportedSystems = [ "x86_64-linux" ];
  in lib.eachSystem supportedSystems (system: let

    pkgs = import nixpkgs {
        inherit system;
        overlays = [
           carla.overlays."0.9.14" 
        ];
      };
  in {
    
devShell = pkgs.mkShell rec {
  hardeningDisable = [
    "fortify"
  ];
  nativeBuildInputs = [
    
    #cargoPlay 
    
  ]; 

  buildInputs = with pkgs; [
    carla-bin
    scenic
  ];


  shellHook = ''
  '';
};

  });
}
