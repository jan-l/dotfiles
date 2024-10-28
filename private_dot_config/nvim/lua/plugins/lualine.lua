-- show lsp server name in statusline
-- local function lsp()
--   local msg = 'No Active Lsp'
--   local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--   local clients = vim.lsp.get_active_clients()
--   if next(clients) == nil then
--     return msg
--   end
--   for _, client in ipairs(clients) do
--     local filetypes = client.config.filetypes
--     if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--       return client.name
--     end
--   end
--   return msg
-- end

return {
  {
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'meuter/lualine-so-fancy.nvim',
    },
    enabled = true,
    lazy = false,
    event = { 'VeryLazy', 'BufReadPost', 'BufNewFile' },
    config = function()
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand '%:t') ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        buffer_not_empty_and_hide_in_width = function()
          return vim.fn.empty(vim.fn.expand '%:t') ~= 1 or vim.fn.winwidth(0) > 80
        end,
      }
      -- local icons = require('icons').icons
      local colors = require('catppuccin.palettes').get_palette 'mocha'

      local config = {
        options = {
          component_separators = '',
          section_separators = '',
          theme = 'catppuccin',
          disabled_filetypes = {
            statusline = {
              'alfa',
              'help',
              'neo-tree',
              'Trouble',
              'spectre_panel',
              'toggleterm',
            },
          },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function()
                return ''
              end,
            },
          },
          lualine_b = {
            { 'branch', icon = '' },
          },
          lualine_c = {
            {
              'filename',
              cond = conditions.buffer_not_empty,
              color = { fg = colors.lavender, gui = 'bold', path = 1 },
            },
            { 'filesize', cond = conditions.buffer_not_empty_and_hide_in_width },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ' },
              -- diagnostics_color = {
              --   color_error = { fg = colors.red },
              --   color_warn = { fg = colors.yellow },
              --   color_info = { fg = colors.cyan },
              -- },
            },
            {
              function()
                return '%='
              end,
            },
            'harpoon2',
            -- 'progress',
          },
          -- -- use default sections but overwrite some
          -- lualine_a = { { 'mode', separator = { left = '' } } },
          -- lualine_b = {
          --   'branch',
          --   {
          --     'diff',
          --     symbols = {
          --       added = icons.git.added,
          --       modified = icons.git.modified,
          --       removed = icons.git.removed,
          --     },
          --     source = function()
          --       ---@diagnostic disable-next-line: undefined-field
          --       local gitsigns = vim.b.gitsigns_status_dict
          --       if gitsigns then
          --         return {
          --           added = gitsigns.added,
          --           modified = gitsigns.changed,
          --           removed = gitsigns.removed,
          --         }
          --       end
          --     end,
          --   },
          -- },
          -- lualine_c = {
          --   { 'filename', path = 1 },
          --   'harpoon2',
          -- },
          -- lualine_x = {
          --   'diagnostics',
          -- },
          -- lualine_y = { lsp },
          lualine_x = {
            'fancy_diff',
            'fancy_lsp_servers',
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }
      require('lualine').setup(config)
    end,
  },
}
