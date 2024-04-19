return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        styles = {
          -- keywords = { 'bold' },
          -- functions = { 'italic' },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          indent_blankline = {
            enabled = true,
            color_indented_levels = false,
          },
          lsp_trouble = true,
          mason = true,
          mini = true,
          neotree = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          symbols_outline = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            -- Comment = { fg = colors.flamingo },
            -- CmpBorder = { fg = colors.surface2 },
            -- WinSeparator = { fg = colors.overlay0, style = { 'bold' } },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require('rose-pine').setup {
        variant = 'moon',
        highlight_groups = {
          TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
          TelescopeNormal = { bg = 'none' },
          TelescopePromptNormal = { bg = 'base' },
          TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
          TelescopeSelection = { fg = 'text', bg = 'base' },
          TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
  },
}
