{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    deadnix
    alejandra
  ];
}
