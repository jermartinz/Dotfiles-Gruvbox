return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Configurar antes de cargar el colorscheme
      vim.g.gruvbox_material_background = "soft" -- 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_foreground = "material" -- 'material', 'mix', 'original'
      vim.g.gruvbox_material_transparent_background = 2 -- 0=disabled, 1=partial, 2=all
      vim.g.gruvbox_material_enable_italic = true

      -- Cargar el colorscheme
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- Configurar LazyVim para usar gruvbox-material
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
