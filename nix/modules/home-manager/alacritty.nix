{pkgs, ...}: {
  home.packages = with pkgs; [
    alacritty
    # Maple Mono NF CN (Ligature unhinted)
    maple-mono.NF-CN-unhinted
  ];
}
