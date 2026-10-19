return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup ({
      options = {
        icons_enabled = true,
        theme = 'horizon'
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'searchcount'},
        lualine_z = {''},
      },
    })
  end,
}
