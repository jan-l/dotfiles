return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'css',
          'diff',
          'fish',
          'go',
          'html',
          'javascript',
          'jsdoc',
          'json',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'python',
          'scss',
          'sql',
          'tsx',
          'typescript',
          'toml',
          'vim',
          'vimdoc',
          'yaml',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { 'python' },
        },
        autopairs = { enable = true },
        autotag = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
            goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
            goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
            goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
          },
        },
      }
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'Wansmer/treesj',
    keys = { '<leader>m' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup {--[[ your config ]]
      }
    end,
  },
}
