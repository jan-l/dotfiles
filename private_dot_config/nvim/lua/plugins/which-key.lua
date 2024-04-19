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
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
      ['<leader>n'] = { name = '[N]ew', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>u'] = { name = '[U]tils', _ = 'which_key_ignore' },
      ['<leader>ut'] = { name = '[T]ypescript', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
      ['<leader>ld'] = { name = '[L]SP [D]ocument', _ = 'which_key_ignore' },
      ['<leader>X'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
    }
  end,
}
