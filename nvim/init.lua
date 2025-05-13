vim.opt.rtp:prepend(vim.fn.expand("~/.dotfiles/nvim"))

-- Now load modules
local ok, err = pcall(require, "nathan.plugins")
if not ok then
  print("❌ Error loading nathan.plugins: " .. err)
end
