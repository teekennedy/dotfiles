{...}: {
  imports = [
    ./nix-darwin.nix
    ./build-machines.nix
    ./home-manager.nix
    ./homebrew-ssh.nix
  ];
}
