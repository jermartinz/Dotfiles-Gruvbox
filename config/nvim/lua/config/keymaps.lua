-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<F5>", function()
  local ft = vim.bo.filetype
  local cmd

  if ft == "python" then
    cmd = "python3 " .. vim.fn.expand("%")
  elseif ft == "cpp" then
    cmd = "g++ " .. vim.fn.expand("%") .. " -o /tmp/a.out && /tmp/a.out"
  elseif ft == "c" then
    cmd = "gcc " .. vim.fn.expand("%") .. " -o /tmp/a.out && /tmp/a.out"
  elseif ft == "javascript" then
    cmd = "node " .. vim.fn.expand("%")
  elseif ft == "sh" then
    cmd = "bash " .. vim.fn.expand("%")
  else
    print("No run command configured for filetype: " .. ft)
    return
  end

  vim.cmd("split | terminal " .. cmd)
end, { desc = "Run file with F5" })
