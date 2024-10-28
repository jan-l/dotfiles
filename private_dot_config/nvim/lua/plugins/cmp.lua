return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',

      -- Adds a number of snippets
      'rafamadriz/friendly-snippets',
      'mlaursen/vim-react-snippets',

      -- Adds vscode-like pictograms
      'onsails/lspkind-nvim',

      -- Adds autotags and pairs to completions
      'windwp/nvim-autopairs',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local lspkind = require 'lspkind'

      local kind_icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰂡',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰅲',
      }

      require('luasnip.loaders.from_vscode').lazy_load()
      require('vim-react-snippets').lazy_load()
      require('nvim-autopairs').setup()
      -- integrate nvim-autopairs with cmp
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          -- scroll docs up and down
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          -- { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip', max_item_count = 3 },
          { name = 'buffer', max_item_count = 5 },
          { name = 'path', max_item_count = 3 },
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, vim_item)
            local lspkind_ok, lspkind = pcall(require, 'lspkind')
            if not lspkind_ok then
              -- From kind_icons array
              vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
              -- Source
              vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[LaTeX]',
              })[entry.source.name]
              return vim_item
            else
              -- From lspkind
              return lspkind.cmp_format()(entry, vim_item)
            end
          end,
        },
        before = function(entry, vim_item) -- for tailwind css autocomplete
          if vim_item.kind == 'Color' and entry.completion_item.documentation then
            local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
            if r then
              local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
              local group = 'Tw_' .. color
              if vim.fn.hlID(group) < 1 then
                vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
              end
              vim_item.kind = '■' -- or "⬤" or anything
              vim_item.kind_hl_group = group
              return vim_item
            end
          end
          vim_item.kind = kind_icons[vim_item.kind] and (kind_icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
          -- or just show the icon
          -- vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
          -- return vim_item
        end,
      }
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' },
      --   }, {
      --     { name = 'cmdline' },
      --   }),
      -- })
    end,
  },
}
