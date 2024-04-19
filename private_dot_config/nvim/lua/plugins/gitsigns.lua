return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      ntracked = { text = '▎' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = '[G]it Preview [H]unk' })
      map('n', '<leader>gfb', function()
        gs.blame_line { full = true }
      end, { desc = '[G]it [F]ile [B]lame' })
      map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle current line [G]it [B]lame' })
    end,
  },
}
