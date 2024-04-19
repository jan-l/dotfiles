-- create annotiations with one keybind, and jump your cusror in the inserted annotation (comment)
return {
  'danymat/neogen',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = true,
  opts = {
    snippet_engine = 'luasnip',
  },
  keys = {
    {
      '<leader>nc',
      function()
        require('neogen').generate { type = 'func' }
      end,
      desc = 'Neogen comment',
    },
  },
}
