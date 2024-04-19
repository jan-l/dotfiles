return {
  -- show preview on rename
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    config = true,
  },
  -- improved boolean management with increment/decrement
  {
    'nat-418/boole.nvim',
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
    },
  },
  -- peeks the line when entering line number
  {
    'nacro90/numb.nvim',
    opts = {},
  },
  -- better tabs
  { 'tpope/vim-sleuth' },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  -- create annotiations with one keybind, and jump your cusror in the inserted annotation (comment)
  {
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
  },
}
