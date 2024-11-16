localFlake: {
  self,
  inputs,
  ...
}: {
  imports = [./nix-darwin.nix];
  perSystem = {
    lib,
    pkgs,
    system,
    inputs',
    ...
  }: {
    formatter = inputs.alejandra.defaultPackage.${system};
  };
}
