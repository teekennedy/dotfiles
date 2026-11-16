# Shell environment

- The host is macOS, but many projects run inside a devenv/Nix shell (check
  for `DEVENV_ROOT` or `IN_NIX_SHELL` in the environment, or `which sed`
  resolving to `/nix/store/...`). In that shell the core utilities (`sed`,
  `awk`, `ls`, `grep`, `find`, `xargs`, `date`, `stat`, `tar`, etc.) are the
  GNU versions, not the BSD ones macOS ships.
