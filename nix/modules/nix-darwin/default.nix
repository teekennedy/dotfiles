{lib, ...}: {
  imports = [./nix-darwin.nix ./build-machines.nix ./home-manager.nix];
  options.myUsername = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "The username for the home-manager user.";
  };
}
