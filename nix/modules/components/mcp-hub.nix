{
  mcp-hub,
  mcp-server-git,
  pkgs,
  ...
}: {
  home.packages = [
    mcp-hub.packages."${pkgs.system}".mcp-hub
    mcp-server-git.packages."${pkgs.system}".mcp-server-git
  ];
}
