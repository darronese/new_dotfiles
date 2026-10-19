return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.install({
      "lua",
      "python",
      "typescript",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "python",
        "typescript",
      },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
