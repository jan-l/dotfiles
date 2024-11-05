return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
          auto_refresh = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<c-f>',
            accept_word = false,
            accept_line = false,
            next = '<c-l>',
            prev = '<c-h>',
            dismiss = '<C-e>',
          },
        },
      }
    end,
  },
}
