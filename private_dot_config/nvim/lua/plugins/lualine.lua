-- show lsp server name in statusline
local function lsp()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- local icons = require('icons').icons
    local utils = require 'lualine.utils.utils'
    local highlight = require 'lualine.highlight'

    local ui_icons = require('icons').icons
    local diagnostics_message = require('lualine.component'):extend()

    diagnostics_message.default = {
      colors = {
        error = utils.extract_color_from_hllist({ 'fg', 'sp' }, { 'DiagnosticError', 'LspDiagnosticsDefaultError', 'DiffDelete' }, '#e32636'),
        warning = utils.extract_color_from_hllist({ 'fg', 'sp' }, { 'DiagnosticWarn', 'LspDiagnosticsDefaultWarning', 'DiffText' }, '#ffa500'),
        info = utils.extract_color_from_hllist({ 'fg', 'sp' }, { 'DiagnosticInfo', 'LspDiagnosticsDefaultInformation', 'DiffChange' }, '#ffffff'),
        hint = utils.extract_color_from_hllist({ 'fg', 'sp' }, { 'DiagnosticHint', 'LspDiagnosticsDefaultHint', 'DiffAdd' }, '#273faf'),
      },
    }
    function diagnostics_message:init(options)
      diagnostics_message.super:init(options)
      self.options.colors = vim.tbl_extend('force', diagnostics_message.default.colors, self.options.colors or {})
      self.highlights = { error = '', warn = '', info = '', hint = '' }
      self.highlights.error = highlight.create_component_highlight_group({ fg = self.options.colors.error }, 'diagnostics_message_error', self.options)
      self.highlights.warn = highlight.create_component_highlight_group({ fg = self.options.colors.warn }, 'diagnostics_message_warn', self.options)
      self.highlights.info = highlight.create_component_highlight_group({ fg = self.options.colors.info }, 'diagnostics_message_info', self.options)
      self.highlights.hint = highlight.create_component_highlight_group({ fg = self.options.colors.hint }, 'diagnostics_message_hint', self.options)
    end

    function diagnostics_message:update_status(is_focused)
      local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
      local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
      if #diagnostics > 0 then
        local diag = diagnostics[1]
        for _, d in ipairs(diagnostics) do
          if d.severity < diag.severity then
            diagnostics = d
          end
        end
        local icons = { ui_icons.diagnostics.Error, ui_icons.diagnostics.Warn, ui_icons.diagnostics.Info, ui_icons.diagnostics.Hint }
        local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
        return highlight.component_format_highlight(hl[diag.severity]) .. icons[diag.severity] .. ' ' .. diag.message
      else
        return ''
      end
    end
    return {
      sections = {
        -- -- use default sections but overwrite some
        lualine_a = { { 'mode', separator = { left = '' } } },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = {
              added = ui_icons.git.added,
              modified = ui_icons.git.modified,
              removed = ui_icons.git.removed,
            },
            source = function()
              ---@diagnostic disable-next-line: undefined-field
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {
          diagnostics_message,
        },
        -- lualine_x = {
        --   {
        --     'diff',
        --     symbols = {
        --       added = ui_icons.git.added,
        --       modified = ui_icons.git.modified,
        --       removed = ui_icons.git.removed,
        --     },
        --     source = function()
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
        lualine_x = {
          'diagnostics',
          'filename',
        },
        lualine_y = { lsp },
        lualine_z = { 'progress', 'location' },
      },
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = '',
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
