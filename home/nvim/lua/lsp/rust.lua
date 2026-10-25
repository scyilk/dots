vim.lsp.config("rust", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "with_block" },
        lifetimeElisionHints = { enable = "skip_trivial" },
      },
    },
  },
})

vim.lsp.enable("rust")
