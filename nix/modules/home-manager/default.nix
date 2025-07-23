{pkgs, ...}: {
  imports = [./alacritty.nix];
  # The state version is required and should stay at the version you originally installed.
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    curl
    btop
    tree
    jq
    ripgrep
    fd
    bat
    alejandra
  ];
}
