{...}: {
  home-manager.users.me = {
    mcp-hub,
    mcp-server-git,
    pkgs,
    ...
  }: {
    home.packages = [
      mcp-hub.packages."${pkgs.system}".mcp-hub
      mcp-server-git.packages."${pkgs.system}".mcp-server-git
      (pkgs.writeShellApplication
        {
          name = "filesystem-mcp-server";
          runtimeInputs = [
            pkgs.nodejs
          ];
          text = ''
            npx -y @modelcontextprotocol/server-filesystem "$HOME/projects"
          '';
        })
    ];
  };
  homebrew.enable = true;
  homebrew.casks = ["dagger/tap/container-use"];
}
