return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      vim.cmd [[colorscheme catppuccin]]
    end,
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          color_indented_levels = false,
        },
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
          },
        },
        neotree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        symbols_outline = true,
        which_key = true,
      },
    },
  },
  {
    'xiyaowong/transparent.nvim',
  },
}
