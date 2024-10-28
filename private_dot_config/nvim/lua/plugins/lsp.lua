return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      { 'hrsh7th/cmp-nvim-lsp' },
      -- Install neodev for better nvim configuration and plugin authoring via lsp configurations
      'folke/neodev.nvim',
    },
    config = function()
      require('mason').setup {
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
      require('mason-tool-installer').setup {
        ensure_installed = vim.tbl_keys(require 'plugins.lsp.tools'),
      }
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(require 'plugins.lsp.servers'),
      }

      require('neodev').setup()

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- easier mappings helper
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gy', require('telescope.builtin').lsp_type_definitions, 'T[y]pe Definition')
          map('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[L]SP [D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gl', vim.lsp.buf.declaration, '[G]oto Dec[L]aration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup_handlers {
        function(server_name)
          if server_name == 'tsserver' then
            server_name = 'ts_ls'
          end

          require('lspconfig')[server_name].setup {

            capabilities = capabilities,
            settings = require('plugins.lsp.servers')[server_name],
            filetypes = (require('plugins.lsp.servers')[server_name] or {}).filetypes,
          }
        end,
      }

      -- Configuration for css variables outside of Mason
      require('lspconfig').css_variables.setup {
        capabilities = capabilities,
      }

      vim.diagnostic.config {
        title = false,
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '',
        },
        float = {
          sourve = 'always',
          style = 'minimal',
          border = 'rounded',
          header = '',
          prefix = '',
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require('icons').icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require('icons').icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require('icons').icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require('icons').icons.diagnostics.Info,
          },
        },
      }
    end,
  },
}
