return {
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
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
      -- copilot in cmp suggestions
      {
        'zbirenbaum/copilot-cmp',
        dependencies = 'copilot.lua',
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require 'copilot_cmp'
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client.name == 'copilot' then
                copilot_cmp._on_insert_enter {}
              end
            end,
          })
        end,
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind-nvim',
      'windwp/nvim-autopairs',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local lspkind = require 'lspkind'

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
          { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip', max_item_count = 3 },
          { name = 'buffer', max_item_count = 5 },
          { name = 'path', max_item_count = 3 },
        },
        formatting = {
          expandable_indicator = true,
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          },
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
          -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
          -- or just show the icon
          vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
          return vim_item
        end,
      }
    end,
  },
}
