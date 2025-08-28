bindkey -v

export HISTSIZE="10000"
export SAVEHIST="10000"

export EDITOR="nvim"

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

# Alias
alias -- ..='z ..'
alias -- ...='z ../..'
alias -- eza='eza --icons auto --color auto --git'
alias -- l='eza'
alias -- ls='eza'
alias -- la='eza -a'
alias -- ll='eza -l'
alias -- lla='eza -la'
alias -- lt='eza --tree'

alias -- gs='git status'
alias -- ga='git add'
alias -- gc='git commit'
alias -- gp='git push'
alias -- gl='git log'

alias -- c='clear'

alias -- microfetch='microfetch && echo'
alias -- se=sudoedit

alias -- sw='nh os switch'
alias -- upd='nh os switch --update'

alias -- v=nvim

# Save path when closing yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Plugins
fpath=(~/.config/zsh/completions/src $fpath)
source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/.config/zsh/vi-mode/zsh-vi-mode.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh )"
eval "$(fzf --zsh)"

# TODO: find how configure atuin in vi insert and cmd mode in zsh
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^R' atuin-search-viins -i atuin
bindkey '^R' atuin-search-vicmd -i atuin

. "$HOME/.atuin/bin/env"
