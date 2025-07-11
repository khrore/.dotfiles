# Coloring Catppuccin theme
fish_config theme choose "Catppuccin Mocha"

# disable fish hello
set -g fish_greeting ""

# ghostty integration
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION no-rc
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

# Aliases
alias eza 'eza --icons auto --color auto --git'
alias l eza
alias ls eza
alias la 'eza -a'
alias ll 'eza -l'
alias lla 'eza -la'
alias lt 'eza --tree'

alias v nvim
alias vd 'nvim -d'

alias .. "cd .."
alias ... "cd ../.."

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Interactive shell initialisation
fzf --fish | source
zoxide init fish | source
atuin init fish | source
starship init fish | source

# enable vi mode
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end
