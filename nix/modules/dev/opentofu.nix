{pkgs, ...}: {
  # The tofu CLI is used by neovim as a .tf/.tofu formatter, and mason has no package for it.
  environment.systemPackages = with pkgs; [
    opentofu
  ];
}
