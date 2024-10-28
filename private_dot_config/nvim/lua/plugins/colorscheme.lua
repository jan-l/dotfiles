return {
  -- {
  --   'folke/tokyonight.nvim',
  --   name = 'tokyonight',
  --   enabled = false,
  --   priority = 1000,
  --   config = function()
  --     require('tokyonight').setup {
  --       on_highlights = function(hl, c)
  --         local prompt = '#2d3149'
  --         hl.TelescopeNormal = {
  --           bg = c.bg_dark,
  --           fg = c.fg_dark,
  --         }
  --         hl.TelescopeBorder = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --         hl.TelescopePromptNormal = {
  --           bg = prompt,
  --         }
  --         hl.TelescopePromptBorder = {
  --           bg = prompt,
  --           fg = prompt,
  --         }
  --         hl.TelescopePromptTitle = {
  --           bg = prompt,
  --           fg = prompt,
  --         }
  --         hl.TelescopePreviewTitle = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --         hl.TelescopeResultsTitle = {
  --           bg = c.bg_dark,
  --           fg = c.bg_dark,
  --         }
  --       end,
  --
  --       on_colors = function(colors)
  --         colors.bg_sidebar = colors.bg
  --         colors.border = colors.blue
  --       end,
  --     }
  --     vim.cmd.colorscheme 'tokyonight-night'
  --   end,
  -- },
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
          barbecue = { dim_dirname = true, bold_basename = true },
          cmp = true,
          gitsigns = true,
          native_lsp = { enabled = true, inlay_hints = { background = true } },
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
          fidget = true,
          treesitter = true,
          treesitter_context = true,
          symbols_outline = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            -- FloatBorder = { bg = colors.base, fg = colors.surface0 },
            -- Pmenu = { bg = '', fg = '' },
            -- PmenuSel = { bg = '', fg = '' },
            -- Comment = { fg = colors.flamingo },
            -- CmpBorder = { fg = colors.surface2 },
            -- WinSeparator = { fg = colors.overlay0, style = { 'bold' } },
          }
        end,
      }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = 'single',
        -- add the title in hover float window
        -- title = 'hover',
      })
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
        disable_float_background = true,
        styles = {
          transparency = true,
        },
        highlight_groups = {
          -- Blend colours against the "base" background
          CursorLine = { bg = 'foam', blend = 10 },
          Delimeter = { fg = 'iris' },
          IndentBlanklineContextChar = { fg = 'iris' },
          PMenu = { bg = 'base', blend = 10 },
        },
      }
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = 'none',
        -- add the title in hover float window
        -- title = 'hover',
      })
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  -- {
  --   'oxfist/night-owl.nvim',
  --   name = 'night-owl',
  --   lazy = false,
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.cmd.colorscheme 'night-owl'
  --   end,
  -- },
  -- {
  --   'xiyaowong/transparent.nvim',
  -- },
}
