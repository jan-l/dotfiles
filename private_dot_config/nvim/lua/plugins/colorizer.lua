return {
  'NvChad/nvim-colorizer.lua',
  enable = false,
  opts = {
    filetypes = {
      '*',
      cmp_docs = { always_update = true },
      cmp_menu = { always_update = true },
    },
    user_default_options = {
      hsl_fn = true,
    },
  },
}
