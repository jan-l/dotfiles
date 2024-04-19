return {
  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  -- library used by other plugins
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  -- Better tmux and vim pane navigation
  { 'christoomey/vim-tmux-navigator', lazy = false },
  -- measure startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
