{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    devenv
  ];
  programs.direnv.nix-direnv.enable = true;
}
