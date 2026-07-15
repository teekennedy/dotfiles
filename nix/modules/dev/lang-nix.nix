{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    nixd
    deadnix
    statix
  ];
}
