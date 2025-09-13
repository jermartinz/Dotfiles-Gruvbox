local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Otros linters/formatters que tengas
    null_ls.builtins.diagnostics.clippy.with({
      command = "cargo",
      args = { "clippy", "--message-format=json" },
    }),
  },
})
