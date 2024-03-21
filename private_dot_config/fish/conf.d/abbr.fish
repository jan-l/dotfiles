abbr l "lsd --group-dirs first -A"
abbr ll "lsd --group-dirs first -Al"
abbr lt "lsd --group-dirs last -A --tree"

abbr o "open ."

abbr p "pnpm run (jq -r '.scripts|to_entries[]|((.key))' package.json | fzf-tmux -p --border-label='pnpm run')"
abbr rmr "rm -rf"

abbr sf "source ~/.config/fish/config.fish"
abbr st "tmux source ~/.config/tmux/tmux.conf"
