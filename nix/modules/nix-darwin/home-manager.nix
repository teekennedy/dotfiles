{config, ...}: {
  users.users.tkennedy = {
    name = config.myUsername;
    home = "/Users/${config.myUsername}";
  };
  home-manager.users.tkennedy = {pkgs, ...}: {
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
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";
  };
}
