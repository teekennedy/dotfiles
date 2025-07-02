{pkgs, ...}: {
  # https://devenv.sh/packages/
  packages = [pkgs.stow];

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    # Nix code formatter
    alejandra = {
      enable = true;
      after = ["deadnix"];
    };
    # Removes nix dead code
    deadnix = {
      enable = true;
      args = ["--edit"];
    };
    # Shell script linter
    shellcheck.enable = true;
    # YAML linter
    yamllint.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
