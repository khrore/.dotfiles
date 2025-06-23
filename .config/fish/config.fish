# Coloring Catppuccin theme
fish_config theme choose "Catppuccin Mocha"

# disable fish hello
set -g fish_greeting ""

# ghostty integration
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

status is-interactive; and begin
    # Abbreviations

    # Aliases
    alias eza 'eza --icons auto --color auto --git'
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias v nvim
    alias vdiff 'nvim -d'

    # Interactive shell initialisation
    fzf --fish | source

    zoxide init fish | source

    atuin init fish | source

    if set -q KITTY_INSTALLATION_DIR
        set --global KITTY_SHELL_INTEGRATION no-rc
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    end
end
