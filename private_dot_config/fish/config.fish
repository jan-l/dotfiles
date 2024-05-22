switch (uname)
    case Darwin
       # macos specifics
       eval (/opt/homebrew/bin/brew shellenv)

       # pnpm
       set -gx PNPM_HOME /Users/janlehtinen/Library/pnpm
       if not string match -q -- $PNPM_HOME $PATH
           set -gx PATH "$PNPM_HOME" $PATH
       end
       # pnpm end

       # opam configuration
       source /Users/janlehtinen/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

       fish_add_path $(go env GOPATH)/bin
    case Linux
        fish_add_path $PATH:/usr/local/go/bin 
        fzf --fish | source
end
set -U fish_greeting

set -gx EDITOR nvim
set -gx VISUAL nvim
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

fish_config theme choose "Catppuccin Mocha"
fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
fish_add_path $HOME/.config/bin

alias vim='nvim '
alias nvim-kickstarter="nvim"
alias dockeer='podman'

alias lvim='NVIM_APPNAME="nvim-lazyvim" nvim'
alias lazyvim='NVIM_APPNAME="nvim-lazyvim" nvim'

zoxide init fish | source
starship init fish | source
