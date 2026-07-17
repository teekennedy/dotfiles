{pkgs, ...}: {
  imports = [./alacritty.nix];

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
