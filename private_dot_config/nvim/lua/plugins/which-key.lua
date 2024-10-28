return {
  'folke/which-key.nvim',
  event = 'VeryLazy', --
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {

      { '<leader>b', group = '[B]uffer' },
      -- { '<leader>b_', hidden = true },
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]iagnostics' },
      { '<leader>d_', hidden = true },
      { '<leader>g', group = '[G]it' },
      { '<leader>g_', hidden = true },
      { '<leader>l', group = '[L]SP' },
      { '<leader>l_', hidden = true },
      { '<leader>n', group = '[N]ew' },
      { '<leader>n_', hidden = true },
      { '<leader>q', group = '[Q]uit / Sessions' },
      { '<leader>q_', hidden = true },
      { '<leader>s', group = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>u', group = '[U]tils' },
      { '<leader>u_', hidden = true },
      { '<leader>ut', group = '[T]ypescript' },
      { '<leader>ut_', hidden = true },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>w_', hidden = true },
      { '<leader>x', group = 'Trouble' },
      { '<leader>x_', hidden = true },
    }
  end,
}
