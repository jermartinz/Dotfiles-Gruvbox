-- ~/.config/nvim/lua/plugins/indent-blankline.lua
return {
  { "nvim-mini/mini.indentscope", enabled = false }, -- evita guías duplicadas

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "⋅", -- alternativas: "·", "┊", "┆"
        tab_char = "⋅",
        highlight = "IblIndent",
        smart_indent_cap = true,
      },
      whitespace = { highlight = nil }, -- sin “background color guides”
      scope = { enabled = false }, -- sin resaltar scope
    },
    init = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Tonos Gruvbox (elige uno según tu contraste)
        -- local c = "#3c3836" -- bg1 (más oscuro)
        local c = "#504945" -- bg2 (tenue y legible)
        -- local c = "#7c6f64"  -- bg4 (más visible)
        vim.api.nvim_set_hl(0, "IblIndent", { fg = c, nocombine = true })
      end)
    end,
  },
}
