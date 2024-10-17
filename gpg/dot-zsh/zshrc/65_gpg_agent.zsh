if command_exists gpgconf; then
  export GPG_TTY="$(tty)"
  gpgconf --launch gpg-agent
fi
