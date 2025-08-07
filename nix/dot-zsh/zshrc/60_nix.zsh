if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# home manager (with homeManager.useUserPackages = true)
if [ -e "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
  # Surprisingly, sourcing hm-session-vars.sh doesn't include the path
  bin_dir="/etc/profiles/per-user/$USER/bin"
  if [ -d "$bin_dir" ]; then
    # Add the bin directory to PATH if it's not already there
    case ":$PATH:" in
    *":$bin_dir:"*) echo "bin dir $bin_dir already in PATH" ;;
    *)
      echo "adding $bin_dir to PATH"
      export PATH="$bin_dir:$PATH"
      ;;
    esac
  fi
fi

# Export SSL_CERT_FILE so nix-managed curl and openssl can pick it up
if [ -e "/etc/nix/macos-keychain.crt" ]; then
  export SSL_CERT_FILE="/etc/nix/macos-keychain.crt"
fi
