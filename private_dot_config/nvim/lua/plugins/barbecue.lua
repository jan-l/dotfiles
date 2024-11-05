return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('barbecue').setup {
      -- prevent barbecue from automatically attaching nvim-navic
      -- this is so shared LSP attach handler can handle attaching only when LSP running
      attach_navic = false,
      kinds = {
        Array = '',
        Boolean = '◩', -- 
        Class = '𝓒', -- 
        Constant = '󰏿', --  
        Constructor = '', --  
        Enum = 'ℰ', -- 
        EnumMember = '', -- 
        Event = '',
        Field = '', --  
        File = '',
        Function = 'ƒ', -- 
        Interface = '',
        Key = '󰌋', -- 
        Method = '', -- 
        Module = '󰆧', -- 
        Namespace = '󰌗', --  󰅪
        Null = '',
        Number = '#', -- 
        Object = '',
        Operator = '󰆕', -- 
        Package = '',
        Property = '', -- 
        String = '𝓢', -- 
        Struct = '', -- 
        TypeParameter = '󰊄', --  𝙏
        Variable = '', --  
      },
    }
  end,
}
