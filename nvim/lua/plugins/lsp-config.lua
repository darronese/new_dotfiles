return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    -- (Optional) ensure servers via mason-lspconfig
    local mlsp = require("mason-lspconfig")
    mlsp.setup({
      ensure_installed = {
        "lua_ls", "clangd", "basedpyright", "vtsls",
      },
    })

    -- LSP-only keymaps via LspAttach (replaces on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
        end

        map("n", "gd", vim.lsp.buf.definition)
        map("n", "K",  vim.lsp.buf.hover)
      end,
    })

    local flags = { debounce_text_changes = 300 }
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    vim.lsp.config("lua_ls", {
      flags = flags,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("clangd",         { flags = flags, capabilities = capabilities })
    vim.lsp.config("basedpyright",        { flags = flags, capabilities = capabilities })

    vim.lsp.enable({
      "lua_ls",
      "clangd",
      "basedpyright",
    })
  end,
}
