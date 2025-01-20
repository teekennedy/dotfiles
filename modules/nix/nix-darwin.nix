{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    devenv
    alejandra
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = ["tkennedy"];

  nix.distributedBuilds = true;
  nix.linux-builder = {
    enable = true;
    systems = ["x86_64-linux"];
  };
  nix.buildMachines = [
    {
      hostName = "borg-1";
      system = "x86_64-linux";
      sshUser = "root";
    }
  ];

  nix.optimise.automatic = true;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  programs.direnv.nix-direnv.enable = true;
}
