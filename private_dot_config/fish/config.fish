eval (/opt/homebrew/bin/brew shellenv)
set -U fish_greeting

set -gx EDITOR nvim
set -gx VISUAL nvim
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

# nvm default node version
# set --universal nvm_default_version v18.16.1

#Artifactory tokens for ViewLinc
set -x ARTIFACTORY_ID_TOKEN "cmVmdGtuOjAxOjE3NDM3MDgzMzY6MFJtRWVsWTRNYWVGYm1acWJ1WW5LdTl3UXVs"
set -x ARTIFACTORY_USERNAME "ext-jan.lehtinen@vaisala.com"
set -x ARTIFACTORY_AUTH_KEY (curl -s -u $ARTIFACTORY_USERNAME:$ARTIFACTORY_ID_TOKEN https://vaisala.jfrog.io/artifactory/api/npm/auth | egrep "_auth = [a-zA-Z0-9=]+" | cut -f3 -d ' ')

fish_config theme choose "Catppuccin Mocha"
fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
fish_add_path $HOME/.config/bin
fish_add_path $(go env GOPATH)/bin

alias vim='nvim '
alias nvim-kickstarter="nvim"
alias dockeer='podman'

alias lvim='NVIM_APPNAME="nvim-lazyvim" nvim'
alias lazyvim='NVIM_APPNAME="nvim-lazyvim" nvim'

# pnpm
set -gx PNPM_HOME /Users/janlehtinen/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# opam configuration
source /Users/janlehtinen/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

zoxide init fish | source
starship init fish | source