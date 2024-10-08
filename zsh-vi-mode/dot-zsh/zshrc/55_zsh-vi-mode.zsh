# Load zsh-vi-mode
# https://github.com/jeffreytse/zsh-vi-mode

if  command_exists brew && [ -f "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]; then
  # Use vim-sandwich style surround keybinds
  export ZVM_VI_SURROUND_BINDKEY="s-prefix"
  source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

  # Restore keybindings of other plugins after zsh-vi-mode finishes initializing
  function zsh_vi_mode_after_init() {
    [ -f ~/.zsh/zshrc/55_atuin.zsh ] && source ~/.zsh/zshrc/55_atuin.zsh
  }
  zvm_after_init_commands+=(zsh_vi_mode_after_init)
fi
