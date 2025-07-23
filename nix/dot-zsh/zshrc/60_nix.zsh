if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# home manager (with homeManager.useUserPackages = true)
if [ -e "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
fi

# Export SSL_CERT_FILE so nix-managed curl and openssl can pick it up
if [ -e "/etc/nix/macos-keychain.crt" ]; then
  export SSL_CERT_FILE="/etc/nix/macos-keychain.crt"
fi
