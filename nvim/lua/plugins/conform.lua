return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt"},
        javascript = { "prettierd", "prettier", stop_after_first = true},
        javascriptreact = { "prettierd", "prettier", stop_after_first = true},
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        cmake = { "cmake_format" },
      },
    })


    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
