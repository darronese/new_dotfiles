return {
  "mfussenegger/nvim-lint",
  lazy = true,
  config = function()
    require('lint').linters_by_ft = {
      python = { "pylint" },
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
    -- Set pylint to work in virtualenv
    require('lint').linters.pylint.cd = 'python'
    require('lint').linters.pylint.args = {'-m', 'pylint', '-f', 'json'}

  end,
}
